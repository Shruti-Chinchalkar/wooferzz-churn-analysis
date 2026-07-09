# 🐾 Wooferzz Customer Churn Analysis & Retention Intelligence

![Python](https://img.shields.io/badge/Python-3.11-blue)
![Power BI](https://img.shields.io/badge/PowerBI-Dashboard-yellow)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Database-blue)
![Status](https://img.shields.io/badge/Status-Completed-green)

## 📌 Project Overview

An end-to-end data analytics project analyzing customer churn for 
**Wooferzz** — a pet products e-commerce company. This project 
identifies key churn drivers, predicts at-risk customers using 
machine learning, and delivers actionable retention recommendations 
through an interactive Power BI dashboard.

---

## 🎯 Problem Statement

Wooferzz had a **14.99% customer churn rate**, resulting in 
**₹1,95,349 revenue loss**. The business needed to:
- Understand *who* is churning and *why*
- Predict which customers are at risk before they leave
- Take data-driven retention actions

---

## 📊 Key Findings

| Metric | Value |
|--------|-------|
| Total Customers | 1,201 |
| Churn Rate | 14.99% |
| Customers Churned | 180 |
| Revenue Lost | ₹1,95,349 |
| Highest Churn Plan | PAW ELITE (24.17%) |
| Strongest Churn Signal | Inactivity Days (534 vs 261) |
| Avg Customer Rating | 4.22 / 5 |

---

## 🔍 Project Workflow

```
Problem Statement → Python EDA → SQL Analysis → Power BI Dashboard → Report → Presentation
```

---

## 🛠️ Tech Stack

| Area | Tool |
|------|------|
| Language | Python 3.11 |
| Analysis | Pandas, NumPy, Matplotlib, Seaborn |
| Machine Learning | Scikit-learn (Logistic Regression) |
| Database | PostgreSQL + pgAdmin 4 |
| Dashboard | Power BI Desktop |
| IDE | VS Code + Jupyter Notebook |
| Version Control | Git + GitHub |

---

## 📁 Project Structure

```
├── data/
│   ├── raw/          # Original datasets
│   └── cleaned/      # Processed datasets
├── notebook/         # Python EDA + ML notebook
├── SQL/              # 10 business SQL queries
├── images/           # EDA charts
├── dashboard/        # Power BI dashboard
├── model/            # Trained ML model
├── reports/          # Project report PDF
├── presentation/     # Final presentation
└── README.md
```

---

## 📈 Dashboard Pages

| Page | Focus | Key Visual |
|------|-------|------------|
| Executive Overview | KPIs + Churn Overview | 5 KPI cards, Donut, Trend |
| Customer Segmentation | Who is churning | Age, Sentiment, Inactivity |
| Financial Impact | Revenue impact | Revenue Lost by Plan, Category |

---

## 🤖 Machine Learning Model

- **Algorithm:** Logistic Regression
- **Features:** 13 features including inactivity days, support tickets, rating
- **Top Churn Predictors:**
  1. Inactivity Days
  2. Support Tickets
  3. Days Since Last Order
  4. Rating
  5. Loyalty Points

---

## 💡 Business Recommendations

1. **Target PAW ELITE subscribers** with retention offers — 24.17% churn
2. **Re-engage inactive customers** after 30 days of inactivity
3. **Improve support response time** — high ticket volume predicts churn
4. **Launch loyalty rewards** for 26-35 age group — highest churn segment
5. **Win-back campaign** for 180 churned customers via email/discount

---

## 🗂️ Dataset

5 tables covering 1,201 customers:
- `customers` — Demographics, subscription, churn label
- `orders` — Purchase history, order value, returns
- `products` — Product catalog with pricing
- `reviews` — Ratings, sentiment, support tickets
- `user_activity` — App behavior, inactivity, cart data

---

## 👩‍💻 Author

**Shruti**
MCA (AI & ML) | Ramdeobaba University, Nagpur
Data Analyst Intern @ Wooferzz Innovations Pvt. Ltd.

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue)](your-linkedin-url)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-black)](your-github-url)