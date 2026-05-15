-- Membuat database baru
CREATE DATABASE db_store;

-- Memilih database tersebut untuk digunakan
USE db_store;

-- 1. Membuat Tabel customer
CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    contact_name VARCHAR(30) NOT NULL,
    company_name VARCHAR(40),
    contact_email VARCHAR(128) NOT NULL,
    address VARCHAR(120),
    city VARCHAR(30),
    country VARCHAR(30)
);

-- 2. Membuat Tabel employee (memiliki relasi ke dirinya sendiri)
CREATE TABLE employee (
    employee_id INTEGER PRIMARY KEY,
    last_name VARCHAR(40) NOT NULL,
    first_name VARCHAR(20) NOT NULL,
    birth_date DATE,
    hire_date DATE,
    address VARCHAR(128),
    city VARCHAR(30),
    country VARCHAR(30),
    reports_to INT,
    CONSTRAINT fk_employee_reports_to FOREIGN KEY (reports_to) REFERENCES employee(employee_id)
);

-- 3. Membuat Tabel category (memiliki relasi ke dirinya sendiri)
CREATE TABLE category (
    category_id INTEGER PRIMARY KEY,
    name VARCHAR(60) NOT NULL,
    description TEXT,
    parent_category_id INTEGER,
    CONSTRAINT fk_category_parent FOREIGN KEY (parent_category_id) REFERENCES category(category_id)
);

-- 4. Membuat Tabel product (bergantung pada category)
CREATE TABLE product (
    product_id INTEGER PRIMARY KEY,
    product_name VARCHAR(40) NOT NULL,
    category_id INT NOT NULL,
    quantity_per_unit VARCHAR(20),
    unit_price DECIMAL(10,2),
    units_in_stock INT,
    discontinued BOOLEAN,
    CONSTRAINT fk_product_category FOREIGN KEY (category_id) REFERENCES category(category_id)
);

-- 5. Membuat Tabel purchase 
CREATE TABLE purchase (
    purchase_id INTEGER PRIMARY KEY,
    customer_id INT NOT NULL,
    employee_id INT NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    purchase_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Mengisi otomatis waktu saat ini
    shipped_date TIMESTAMP NULL DEFAULT NULL,         -- Diizinkan kosong sampai barang dikirim
    ship_address VARCHAR(60),
    ship_city VARCHAR(15),
    ship_country VARCHAR(15),
    CONSTRAINT fk_purchase_customer FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    CONSTRAINT fk_purchase_employee FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
);

-- 6. Membuat Tabel purchase_item (bergantung pada purchase dan product)
CREATE TABLE purchase_item (
    purchase_id INT,
    product_id INT,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (purchase_id, product_id), -- Composite Primary Key
    CONSTRAINT fk_item_purchase FOREIGN KEY (purchase_id) REFERENCES purchase(purchase_id),
    CONSTRAINT fk_item_product FOREIGN KEY (product_id) REFERENCES product(product_id)
); 