-- JTI Analytics Dashboard Schema
-- Production database structure for tobacco industry analytics

-- Enable extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "postgis";

-- Stores table
CREATE TABLE IF NOT EXISTS stores (
    store_id SERIAL PRIMARY KEY,
    store_name VARCHAR(255) NOT NULL,
    region VARCHAR(100) NOT NULL,
    city_municipality VARCHAR(100),
    barangay VARCHAR(100),
    latitude DECIMAL(10, 8),
    longitude DECIMAL(11, 8),
    store_type VARCHAR(50) CHECK (store_type IN ('sari-sari', 'grocery', 'convenience', 'supermarket', 'mini-mart')),
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Brands table (JTI and competitors)
CREATE TABLE IF NOT EXISTS brands (
    brand_id SERIAL PRIMARY KEY,
    brand_name VARCHAR(100) NOT NULL UNIQUE,
    company_name VARCHAR(100),
    is_jti BOOLEAN DEFAULT false,
    is_competitor BOOLEAN DEFAULT false,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert JTI brands
INSERT INTO brands (brand_name, company_name, is_jti) VALUES
('Winston', 'JTI Philippines', true),
('Mevius', 'JTI Philippines', true),
('Camel', 'JTI Philippines', true),
('Mighty', 'JTI Philippines', true),
('Marvels', 'JTI Philippines', true);

-- Insert competitor brands
INSERT INTO brands (brand_name, company_name, is_competitor) VALUES
('Marlboro', 'Philip Morris', true),
('Fortune', 'Philip Morris', true),
('Hope', 'Hope Luxury', true),
('More', 'Associated Anglo American', true);

-- Products table with JTI SKUs
CREATE TABLE IF NOT EXISTS products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    brand_id INTEGER REFERENCES brands(brand_id),
    category_name VARCHAR(100) DEFAULT 'Tobacco',
    sku VARCHAR(100) UNIQUE,
    unit_price DECIMAL(10, 2),
    package_size VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Transactions table
CREATE TABLE IF NOT EXISTS transactions (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    store_id INTEGER REFERENCES stores(store_id),
    transaction_datetime TIMESTAMP NOT NULL,
    customer_id INTEGER,
    payment_method VARCHAR(50),
    total_amount DECIMAL(10, 2) NOT NULL,
    discount_amount DECIMAL(10, 2) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Transaction items
CREATE TABLE IF NOT EXISTS transaction_items (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    transaction_id UUID REFERENCES transactions(id) ON DELETE CASCADE,
    product_id INTEGER REFERENCES products(product_id),
    quantity INTEGER NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    subtotal DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for performance
CREATE INDEX idx_transactions_datetime ON transactions(transaction_datetime);
CREATE INDEX idx_transactions_store ON transactions(store_id);
CREATE INDEX idx_transaction_items_transaction ON transaction_items(transaction_id);
CREATE INDEX idx_transaction_items_product ON transaction_items(product_id);
CREATE INDEX idx_stores_region ON stores(region);
CREATE INDEX idx_products_brand ON products(brand_id);

-- Enable RLS
ALTER TABLE stores ENABLE ROW LEVEL SECURITY;
ALTER TABLE brands ENABLE ROW LEVEL SECURITY;
ALTER TABLE products ENABLE ROW LEVEL SECURITY;
ALTER TABLE transactions ENABLE ROW LEVEL SECURITY;
ALTER TABLE transaction_items ENABLE ROW LEVEL SECURITY;

-- Public read policies
CREATE POLICY "Public read" ON stores FOR SELECT USING (true);
CREATE POLICY "Public read" ON brands FOR SELECT USING (true);
CREATE POLICY "Public read" ON products FOR SELECT USING (true);
CREATE POLICY "Public read" ON transactions FOR SELECT USING (true);
CREATE POLICY "Public read" ON transaction_items FOR SELECT USING (true);
