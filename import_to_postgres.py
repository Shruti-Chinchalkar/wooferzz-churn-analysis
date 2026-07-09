import pandas as pd
from sqlalchemy import create_engine, text

# ================================================
# DATABASE CONNECTION
# ================================================
engine = create_engine(
    'postgresql://postgres:admin123@localhost:5432/pet_churn'
)

# Test connection
try:
    with engine.connect() as conn:
        conn.execute(text('SELECT 1'))
    print("✅ Connected to PostgreSQL successfully!")
except Exception as e:
    print(f"❌ Connection failed: {e}")
    exit()

# ================================================
# LOAD ALL 5 CSV FILES
# Change the base_path to your actual project path
# ================================================

base_path = r'C:\Users\DELL\Desktop\Data Analysis\Churn Prediction Analysis Project'

print("\n📂 Loading CSV files...")

customers = pd.read_csv(
    f'{base_path}\\data\\cleaned\\customers_cleaned.csv'
)
print(f"✅ customers     : {customers.shape}")

orders = pd.read_csv(
    f'{base_path}\\data\\cleaned\\orders_cleaned.csv'
)
print(f"✅ orders        : {orders.shape}")

products = pd.read_csv(
    f'{base_path}\\data\\raw\\Products.csv'
)
print(f"✅ products      : {products.shape}")

reviews = pd.read_csv(
    f'{base_path}\\data\\cleaned\\reviews_cleaned.csv'
)
print(f"✅ reviews       : {reviews.shape}")

user_activity = pd.read_csv(
    f'{base_path}\\data\\cleaned\\user_activity_cleaned.csv'
)
print(f"✅ user_activity : {user_activity.shape}")

# ================================================
# CLEAN COLUMN NAMES
# Remove spaces and lowercase everything
# ================================================

def clean_columns(df):
    df.columns = (df.columns
                  .str.strip()
                  .str.lower()
                  .str.replace(' ', '_'))
    return df

customers     = clean_columns(customers)
orders        = clean_columns(orders)
products      = clean_columns(products)
reviews       = clean_columns(reviews)
user_activity = clean_columns(user_activity)

print("\n🔧 Column names cleaned!")

# ================================================
# IMPORT ALL 5 TABLES TO POSTGRESQL
# if_exists='replace' drops and recreates the table
# This imports ALL columns automatically
# ================================================

print("\n📤 Importing tables to PostgreSQL...")

customers.to_sql(
    'customers',
    engine,
    if_exists='replace',
    index=False,
    method='multi',
    chunksize=500
)
print(f"✅ customers     imported — {len(customers)} rows")

orders.to_sql(
    'orders',
    engine,
    if_exists='replace',
    index=False,
    method='multi',
    chunksize=500
)
print(f"✅ orders        imported — {len(orders)} rows")

products.to_sql(
    'products',
    engine,
    if_exists='replace',
    index=False,
    method='multi',
    chunksize=500
)
print(f"✅ products      imported — {len(products)} rows")

reviews.to_sql(
    'reviews',
    engine,
    if_exists='replace',
    index=False,
    method='multi',
    chunksize=500
)
print(f"✅ reviews       imported — {len(reviews)} rows")

user_activity.to_sql(
    'user_activity',
    engine,
    if_exists='replace',
    index=False,
    method='multi',
    chunksize=500
)
print(f"✅ user_activity imported — {len(user_activity)} rows")

# ================================================
# VERIFY ALL TABLES
# ================================================

print("\n🔍 Verifying row counts in PostgreSQL...")

tables = ['customers', 'orders', 'products', 'reviews', 'user_activity']

with engine.connect() as conn:
    for table in tables:
        result = conn.execute(text(f'SELECT COUNT(*) FROM {table}'))
        count  = result.scalar()
        print(f"   {table:<20} : {count} rows")

print("\n🎉 All 5 tables imported successfully!")
print("   Open pgAdmin → pet_churn → Schemas → public → Tables")
print("   You will see all 5 tables with all columns")