CREATE DATABASE Bike_Store;
USE Bike_Store;

-- Create Brands Table
CREATE TABLE Brands (
	brand_id INT,
	brand_name VARCHAR(50)
);

-- Load data into Brands Table
SHOW VARIABLES LIKE 'secure_file_priv';
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/brands.csv'
INTO TABLE Brands
FIELDS TERMINATED BY ','
IGNORE 1 LINES;

-- Create Categories Table
CREATE TABLE Categories (
	category_id INT,
    category_name VARCHAR(50)
);

-- Load data into Categories Table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/categories.csv'
INTO TABLE Categories
FIELDS TERMINATED BY ','
IGNORE 1 LINES;

-- Create Customers Table
CREATE TABLE Customers (
	Customer_id INT,
    first_name VARCHAR(30),
    last_name VARCHAR(30),
    phone VARCHAR(20),
    email VARCHAR(50),
    street VARCHAR(50),
    city VARCHAR(30),
    state VARCHAR(5),
    zip_code INT
);

-- Load data into Customers Table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/customers.csv'
INTO TABLE Customers
FIELDS TERMINATED BY ','
IGNORE 1 LINES;

-- Create Order_items Table
CREATE TABLE Order_items (
	Order_id INT,
    item_id INT,
    product_id INT,
    quantity INT,
    list_price INT,
    discount INT
);

-- Load data into Order_items Table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/order_items.csv'
INTO TABLE Order_items
FIELDS TERMINATED BY ','
IGNORE 1 LINES;

-- Create Orders Table
CREATE TABLE Orders (
	Order_id INT,
    customer_id INT,
    order_status INT,
    order_date DATE,
    required_date DATE,
    shipped_date VARCHAR(10),
    store_id INT,
    staff_id INT
);

-- Load data into Order Table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/orders.csv'
INTO TABLE Orders
FIELDS TERMINATED BY ','
IGNORE 1 LINES;

-- Create Products Table
CREATE TABLE Products (
	product_id INT,
    product_name VARCHAR(100),
    brand_id INT,
    category_id INT,
    model_year YEAR,
    list_price INT
);

-- Load data into Products Table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/products.csv'
INTO TABLE Products
FIELDS TERMINATED BY ','
IGNORE 1 LINES;

-- Create Staffs Table
CREATE TABLE Staffs (
	staff_id INT,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    email VARCHAR(50),
    phone VARCHAR(20),
    active INT,
    store_id INT,
    manager_id VARCHAR(5)
);

-- Load data into Staffs Table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/staffs.csv'
INTO TABLE Staffs
FIELDS TERMINATED BY ','
IGNORE 1 LINES;

-- Create Stocks Table
CREATE TABLE Stocks (
	store_id INT,
    product_id INT,
    quantity INT
);

-- Load data into Stocks Table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/stocks.csv'
INTO TABLE Stocks
FIELDS TERMINATED BY ','
IGNORE 1 LINES;

-- Create Stores Table
CREATE TABLE Stores (
	store_id INT,
    store_name VARCHAR(20),
    phone VARCHAR(20),
    email VARCHAR(50),
    street VARCHAR(50),
    city VARCHAR(20),
    state VARCHAR(5),
    zip_code INT
);

-- Load data into Stores Table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/stores.csv'
INTO TABLE Stores
FIELDS TERMINATED BY ','
IGNORE 1 LINES;