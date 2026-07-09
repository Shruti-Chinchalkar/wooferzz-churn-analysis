-- ================================================
-- QUERY 1: Overall Churn Rate
-- Purpose : Calculate what % of customers churned
-- ================================================

SELECT
    COUNT(*)                                        AS total_customers,
    SUM(churn)                                      AS churned_customers,
    COUNT(*) - SUM(churn)                           AS retained_customers,
    ROUND(SUM(churn) * 100.0 / COUNT(*), 2)        AS churn_rate_pct,
    ROUND((COUNT(*) - SUM(churn)) * 100.0 
          / COUNT(*), 2)                            AS retention_rate_pct
FROM customers;


-- ================================================
-- QUERY 2: Churn Rate by Subscription Plan
-- Purpose : Find which plan loses most customers
-- ================================================

SELECT
    subscription_plan,
    COUNT(*)                                        AS total_customers,
    SUM(churn)                                      AS churned,
    ROUND(SUM(churn) * 100.0 / COUNT(*), 2)        AS churn_rate_pct
FROM customers
GROUP BY subscription_plan
ORDER BY churn_rate_pct DESC;

-- ================================================
-- QUERY 3: Customer Lifetime Value (CLV)
-- Purpose : Calculate total revenue per customer
--           and flag their churn status
-- ================================================

SELECT
    o.customer_id,
    c.subscription_plan,
    c.churn,
    COUNT(o.order_id)                               AS total_orders,
    ROUND(SUM(o.order_value), 2)                    AS lifetime_value,
    ROUND(AVG(o.order_value), 2)                    AS avg_order_value
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY o.customer_id, c.subscription_plan, c.churn
ORDER BY lifetime_value DESC
LIMIT 20;

-- ================================================
-- QUERY 3: Customer Lifetime Value (CLV)
-- Purpose : Calculate total revenue per customer
--           and flag their churn status
-- ================================================

SELECT
    o.customer_id,
    c.subscription_plan,
    c.churn,
    COUNT(o.order_id)                               AS total_orders,
    ROUND(SUM(o.order_value), 2)                    AS lifetime_value,
    ROUND(AVG(o.order_value), 2)                    AS avg_order_value
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY o.customer_id, c.subscription_plan, c.churn
ORDER BY lifetime_value DESC
LIMIT 20;

-- ================================================
-- QUERY 4: Revenue Lost Due to Churn
-- Purpose : Quantify financial impact of churn
-- ================================================

SELECT
    c.churn,
    CASE WHEN c.churn = 1 
         THEN 'Churned' 
         ELSE 'Retained' END                        AS customer_status,
    COUNT(DISTINCT o.customer_id)                   AS customers,
    ROUND(SUM(o.order_value), 2)                    AS total_revenue,
    ROUND(AVG(o.order_value), 2)                    AS avg_order_value,
    ROUND(SUM(o.order_value) * 100.0 / 
          (SELECT SUM(order_value) FROM orders), 
          2)                                        AS revenue_share_pct
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.churn
ORDER BY c.churn;

-- ================================================
-- QUERY 5: Churn Rate by City
-- Purpose : Identify which locations have
--           highest customer dropout
-- ================================================

SELECT
    city,
    COUNT(*)                                        AS total_customers,
    SUM(churn)                                      AS churned,
    ROUND(SUM(churn) * 100.0 / COUNT(*), 2)        AS churn_rate_pct
FROM customers
GROUP BY city
ORDER BY churn_rate_pct DESC
LIMIT 10;

-- ================================================
-- QUERY 6: Support Tickets vs Churn
-- Purpose : Test if poor support experience
--           drives customers to leave
-- ================================================

SELECT
    CASE WHEN c.churn = 1 
         THEN 'Churned' 
         ELSE 'Retained' END                        AS customer_status,
    ROUND(AVG(r.support_tickets), 2)                AS avg_support_tickets,
    ROUND(AVG(r.resolution_time_hours), 2)          AS avg_resolution_hours,
    ROUND(AVG(r.rating), 2)                         AS avg_rating,
    ROUND(AVG(r.csat_score), 2)                     AS avg_csat_score
FROM reviews r
JOIN customers c ON r.customer_id = c.customer_id
GROUP BY c.churn
ORDER BY c.churn;

-- ================================================
-- QUERY 7: Inactivity vs Churn
-- Purpose : Measure how inactivity predicts churn
-- ================================================

SELECT
    CASE WHEN c.churn = 1 
         THEN 'Churned' 
         ELSE 'Retained' END                        AS customer_status,
    ROUND(AVG(u.inactivity_days), 1)                AS avg_inactivity_days,
    ROUND(AVG(u.pages_viewed), 1)                   AS avg_pages_viewed,
    ROUND(AVG(u.time_spent_minutes), 1)             AS avg_time_spent_mins,
    ROUND(AVG(u.cart_additions), 1)                 AS avg_cart_additions,
    SUM(u.abandoned_cart)                           AS total_abandoned_carts
FROM user_activity u
JOIN customers c ON u.customer_id = c.customer_id
GROUP BY c.churn
ORDER BY c.churn;

-- ================================================
-- QUERY 8: Monthly Churn Trend
-- Purpose : Track churn rate over time to spot
--           if problem is improving or worsening
-- ================================================

SELECT
    STRFTIME('%Y-%m', signup_date)                  AS signup_month,
    COUNT(*)                                        AS total_customers,
    SUM(churn)                                      AS churned,
    ROUND(SUM(churn) * 100.0 / COUNT(*), 2)        AS churn_rate_pct
FROM customers
GROUP BY signup_month
ORDER BY signup_month;

-- ================================================
-- QUERY 9: High Risk Customers
-- Purpose : Identify specific customers at highest
--           risk so business can target them
-- ================================================

SELECT
    c.customer_id,
    c.customer_name,
    c.subscription_plan,
    c.city,
    u.inactivity_days,
    r.support_tickets,
    r.rating,
    ROUND(SUM(o.order_value), 2)                    AS total_spent,
    c.churn
FROM customers c
JOIN user_activity u ON c.customer_id = u.customer_id
JOIN reviews r       ON c.customer_id = r.customer_id
JOIN orders o        ON c.customer_id = o.customer_id
WHERE c.churn = 0                   -- retained customers only
GROUP BY c.customer_id
HAVING u.inactivity_days > 30       -- inactive for over 30 days
   AND r.support_tickets >= 3       -- raised multiple complaints
   AND r.rating <= 2                -- gave low rating
ORDER BY u.inactivity_days DESC
LIMIT 10;

-- ================================================
-- QUERY 10: Product Category vs Churn
-- Purpose : Find which product categories are
--           bought by loyal vs churning customers
-- ================================================

SELECT
    o.category,
    COUNT(DISTINCT o.customer_id)                   AS total_customers,
    SUM(c.churn)                                    AS churned_customers,
    ROUND(SUM(c.churn) * 100.0 / 
          COUNT(DISTINCT o.customer_id), 2)         AS churn_rate_pct,
    ROUND(AVG(o.order_value), 2)                    AS avg_order_value,
    ROUND(SUM(o.order_value), 2)                    AS total_revenue
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY o.category
ORDER BY churn_rate_pct DESC;