-- The E-Commerce Database Management Project is a comprehensive solution designed to streamline and optimize the operations of an e-commerce business.
-- This project focuses on creating a robust database management system that facilitates efficient handling of various aspects of an online store,
-- from product inventory to customer orders.

-- Create the database for the e-commerce project
CREATE SCHEMA e_commerceproject;

-- Use the e_commerceproject schema
USE e_commerceproject;

-- Create the 'customer' table
CREATE TABLE e_commerceproject.customer (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    date_of_birth DATE,
    phone INT
);

-- Create the 'category' table
CREATE TABLE e_commerceproject.category (
  category_id INT PRIMARY KEY,
  category_name VARCHAR(255),
  description VARCHAR(255)
);

-- Create the 'seller' table
CREATE TABLE e_commerceproject.seller (
  seller_id INT PRIMARY KEY,
  seller_name VARCHAR(255),
  seller_phone VARCHAR(10),
  total_sales DECIMAL(15,2)
);

-- Create the 'address' table
CREATE TABLE e_commerceproject.address (
  address_id INT PRIMARY KEY,
  apart_no VARCHAR(50),
  apart_name VARCHAR(255),
  street_name VARCHAR(255),
  state VARCHAR(255),
  city VARCHAR(255),
  pincode INT,
  customer_id INT,
  FOREIGN KEY (customer_id) REFERENCES e_commerceproject.customer(customer_id) ON DELETE SET NULL ON UPDATE NO ACTION
);

-- Create the 'product' table
CREATE TABLE e_commerceproject.product (
  product_id INT PRIMARY KEY,
  product_name VARCHAR(50),
  price FLOAT,
  stock INT,
  brand VARCHAR(255),
  category_id INT,
  seller_id INT,
  FOREIGN KEY (category_id) REFERENCES e_commerceproject.category(category_id) ON DELETE SET NULL ON UPDATE NO ACTION,
  FOREIGN KEY (seller_id) REFERENCES e_commerceproject.seller(seller_id) ON DELETE SET NULL ON UPDATE NO ACTION
);

-- Create the 'cart' table
CREATE TABLE e_commerceproject.cart (
  cart_id INT PRIMARY KEY,
  grand_total FLOAT,
  item_total INT,
  customer_id INT,
  FOREIGN KEY (customer_id) REFERENCES e_commerceproject.customer(customer_id) ON DELETE SET NULL ON UPDATE NO ACTION
);

-- Create the 'cart_item' table (to store products in the cart)
CREATE TABLE e_commerceproject.cart_item (
  cart_item_id INT PRIMARY KEY,
  cart_id INT,
  product_id INT,
  quantity INT,
  FOREIGN KEY (cart_id) REFERENCES e_commerceproject.cart(cart_id) ON DELETE SET NULL ON UPDATE NO ACTION,
  FOREIGN KEY (product_id) REFERENCES e_commerceproject.product(product_id)  ON DELETE SET NULL ON UPDATE NO ACTION
);

-- Create the 'order_table' table
CREATE TABLE e_commerceproject.order_table (
  order_id INT PRIMARY KEY,
  order_date DATETIME,
  order_amount FLOAT,
  order_status ENUM('delivery', 'not delivery'),
  shipping_date DATETIME,
  customer_id INT,
  FOREIGN KEY (customer_id) REFERENCES e_commerceproject.customer(customer_id) ON DELETE SET NULL ON UPDATE NO ACTION,
  cart_id INT,
  FOREIGN KEY (cart_id) REFERENCES e_commerceproject.cart(cart_id) ON DELETE SET NULL ON UPDATE NO ACTION
);

-- Create the 'orderitem' table
CREATE TABLE e_commerceproject.orderitem (
  order_id INT,
  product_id INT,
  FOREIGN KEY (order_id) REFERENCES e_commerceproject.order_table(order_id) ON DELETE SET NULL ON UPDATE NO ACTION,
  FOREIGN KEY (product_id) REFERENCES e_commerceproject.product(product_id) ON DELETE SET NULL ON UPDATE NO ACTION,
  price FLOAT,
  quantity INT
);

-- Create the 'payment' table
CREATE TABLE e_commerceproject.payment (
  payment_mode ENUM('online', 'offline'),
  date_of_payment DATETIME,
  order_id INT,
  FOREIGN KEY (order_id) REFERENCES e_commerceproject.order_table(order_id) ON DELETE SET NULL ON UPDATE NO ACTION,
  customer_id INT,
  FOREIGN KEY (customer_id) REFERENCES e_commerceproject.customer(customer_id) ON DELETE SET NULL ON UPDATE NO ACTION
);

-- Create the 'review' table
CREATE TABLE e_commerceproject.review (
  review_id INT PRIMARY KEY,
  description VARCHAR(255),
  rating ENUM('1', '2', '3', '4', '5'),
  customer_id INT,
  FOREIGN KEY (customer_id) REFERENCES e_commerceproject.customer(customer_id) ON DELETE SET NULL ON UPDATE NO ACTION,
  product_id INT,
  FOREIGN KEY (product_id) REFERENCES e_commerceproject.product(product_id) ON DELETE SET NULL ON UPDATE NO ACTION
);

--
-- Dumping data into 'customer' table

INSERT INTO e_commerceproject.customer VALUES (1, 'vivek', 'wadher', 'wadhervivek6904@gmail.com', '1999-09-06', 2147483647);
INSERT INTO e_commerceproject.customer VALUES (2, 'devansh', 'makawana', 'devansh@gmail.com', '1998-05-23', 2147483647);
INSERT INTO e_commerceproject.customer VALUES (3, 'jay', 'chauhan', 'jay@gmail.com', '1992-05-02', 2147483647);
INSERT INTO e_commerceproject.customer VALUES (4, 'rahul', 'patel', 'rahulpatel@gmail.com', '1995-10-12', 2147483647);
INSERT INTO e_commerceproject.customer VALUES (5, 'anita', 'sharma', 'anitasharma@gmail.com', '1993-03-25', 2147483647);
INSERT INTO e_commerceproject.customer VALUES (6, 'sunil', 'verma', 'sunilraj@gmail.com', '1996-06-18', 2147483647);
INSERT INTO e_commerceproject.customer VALUES (7, 'priya', 'gupta', 'priyagupta@gmail.com', '1993-01-15', 2147483647);
INSERT INTO e_commerceproject.customer VALUES (8, 'neha', 'thakur', 'neha_thakur@gmail.com', '1996-08-23', 2147483647);
INSERT INTO e_commerceproject.customer VALUES (9, 'arvind', 'patel', 'arvindmanoj@gmail.com', '1992-04-10', 2147483647);
INSERT INTO e_commerceproject.customer VALUES (10, 'shreyash', 'yadav', 'shreyashyadav@gmail.com', '1994-11-29', 2147483647);
INSERT INTO e_commerceproject.customer VALUES (11, 'rohit', 'agarwal', 'rohitagarwal@gmail.com', '1991-12-30', 2147483647);
INSERT INTO e_commerceproject.customer VALUES (12, 'mohit', 'singh', 'moitsingh@gmail.com', '1997-03-14', 2147483647);
INSERT INTO e_commerceproject.customer VALUES (13, 'pooja', 'panchal', 'pooja.panchal@gmail.com', '1993-09-22', 2147483647);
INSERT INTO e_commerceproject.customer VALUES (14, 'karan', 'kumawat', 'karankumawat@gmail.com', '1991-07-07', 2147483647);
INSERT INTO e_commerceproject.customer VALUES (15, 'sara', 'saini', 'sarasaini@gmail.com', '1998-02-28', 2147483647);
INSERT INTO e_commerceproject.customer VALUES (16, 'parth', 'gandhi', 'parthgandhi@gmail.com', '1994-05-04', 2147483647);
INSERT INTO e_commerceproject.customer VALUES (17, 'vikram', 'gupta', 'vikramgupta@gmail.com', '1990-08-12', 2147483647);
INSERT INTO e_commerceproject.customer VALUES (18, 'monika', 'kumar', 'monikakumar@gmail.com', '1995-11-09', 2147483647);
INSERT INTO e_commerceproject.customer VALUES (19, 'kiran', 'mishra', 'kiran.mishra@gmail.com', '1990-12-19', 2147483647);
INSERT INTO e_commerceproject.customer VALUES (20, 'samrath', 'bhagat', 'samrathbhagat@gmail.com', '1995-06-05', 2147483647);

--
-- Dumping data into 'category' table

INSERT INTO e_commerceproject.category VALUES (1,'Mobiles & Computer','all the brands are there like phone, tablets, PC, Desktop ');
INSERT INTO e_commerceproject.category VALUES (2,'TV & Aplliances & Electronics','all the brands are there like tv smart, tv oled, mixer and many more');
INSERT INTO e_commerceproject.category VALUES (3,'Men`s Fashion','all the brands are there like t-Shirts, jeans, shirts,etc');
INSERT INTO e_commerceproject.category VALUES (4,'Women`s Fashion','all the brands are there like shorts,one pic, kurti, t-shirt,jeans,etc');

--
-- Dumping data into 'seller' table

INSERT INTO e_commerceproject.seller VALUES (1, 'manish agarwal', '1295874636', 220500.75);
INSERT INTO e_commerceproject.seller VALUES (2, 'jay kumar', '7896541230', 585000.20);
INSERT INTO e_commerceproject.seller VALUES (3, 'varun shetty', '7465456456', 452900.25);
INSERT INTO e_commerceproject.seller VALUES (4, 'vikram kumar', '9823654789', 123000.50);
INSERT INTO e_commerceproject.seller VALUES (5, 'alok yadav', '9812345678', 26000.50);

--
-- Dumping data into 'address' table

INSERT INTO e_commerceproject.address VALUES (1, '25', 'sai krishna apt', 'vijay nagar', 'maharashtra', 'mumbai', '400058', 1);
INSERT INTO e_commerceproject.address VALUES (2, '100', 'shree niwas', 'vijay nagar', 'maharashtra', 'mumbai', '400046', 2);
INSERT INTO e_commerceproject.address VALUES (3, '52', 'oberoi sky city', 'thakur complex malad east', 'maharashtra', 'mumbai', '400526', 3);
INSERT INTO e_commerceproject.address VALUES (4, '12', 'sai krishna apt', 'vijay nagar', 'maharashtra', 'mumbai', '400058', 4);
INSERT INTO e_commerceproject.address VALUES (5, '101', 'siddhivinayak chs', 'shivaji park', 'maharashtra', 'mumbai', '421202', 5);
INSERT INTO e_commerceproject.address VALUES (6, '204', 'shree siddhi vinayak apt', 'citi center, thane', 'maharashtra', 'thane', '400601', 6);
INSERT INTO e_commerceproject.address VALUES (7, '88', 'ashoka niwas', 'pali hill', 'maharashtra', 'mumbai', '400050', 7);
INSERT INTO e_commerceproject.address VALUES (8, '55', 'prakash chs', 'vile parle east', 'maharashtra', 'mumbai', '400057', 8);
INSERT INTO e_commerceproject.address VALUES (9, '302', 'shree ram krupa', 'andheri east', 'maharashtra', 'mumbai', '400069', 9);
INSERT INTO e_commerceproject.address VALUES (10, '210', 'ganesh garden', 'mulund east', 'maharashtra', 'mumbai', '400081', 10);
INSERT INTO e_commerceproject.address VALUES (11, '95', 'shree apartment', 'santacruz east', 'maharashtra', 'mumbai', '400056', 11);
INSERT INTO e_commerceproject.address VALUES (12, '130', 'manish nagar', 'lokhandwala complex', 'maharashtra', 'mumbai', '400053', 12);
INSERT INTO e_commerceproject.address VALUES (13, '77', 'krishna villa', 'borivali west', 'maharashtra', 'mumbai', '400092', 13);
INSERT INTO e_commerceproject.address VALUES (14, '221', 'manohar chs', 'dadar west', 'maharashtra', 'mumbai', '400028', 14);
INSERT INTO e_commerceproject.address VALUES (15, '190', 'shubham shree', 'kandivali west', 'maharashtra', 'mumbai', '400067', 15);
INSERT INTO e_commerceproject.address VALUES (16, '78', 'jalaram park', 'goregaon west', 'maharashtra', 'mumbai', '400104', 16);
INSERT INTO e_commerceproject.address VALUES (17, '300', 'anand garden', 'mulund west', 'maharashtra', 'mumbai', '400080', 17);
INSERT INTO e_commerceproject.address VALUES (18, '115', 'chandresh apt', 'mira road east', 'maharashtra', 'mumbai', '401107', 18);
INSERT INTO e_commerceproject.address VALUES (19, '5', 'shree ram villa', 'thane west', 'maharashtra', 'thane', '400602', 19);
INSERT INTO e_commerceproject.address VALUES (20, '68', 'shivkrupa apartment', 'kalyan west', 'maharashtra', 'thane', '421301', 20);

--
-- Dumping data into 'product' table

INSERT INTO e_commerceproject.product VALUES (1, 'Pen Drive', 250, 110, 'HP', 2, 1);
INSERT INTO e_commerceproject.product VALUES (2, 'Monitor', 25000, 50, 'Dell', 1, 3);
INSERT INTO e_commerceproject.product VALUES (3, 'Keyboard', 765, 70, 'Lenovo', 2, 2);
INSERT INTO e_commerceproject.product VALUES (4, 'iPhone 15', 75000, 25, 'Apple', 1, 2);
INSERT INTO e_commerceproject.product VALUES (5, 'Mens T-shirts', 350, 220, 'H&M', 3, 1);
INSERT INTO e_commerceproject.product VALUES (6, 'Mens Kurta', 766, 200, 'ZARA', 3, 3);
INSERT INTO e_commerceproject.product VALUES (7, 'Womens Shorts', 360, 300, 'Pantaloons', 4, 2);
INSERT INTO e_commerceproject.product VALUES (8, 'Womens Jeans', 699, 280, 'Zudio', 4, 1);
INSERT INTO e_commerceproject.product VALUES (9, 'Mouse', 299, 40, 'Lenovo', 2, 3);
INSERT INTO e_commerceproject.product VALUES (10, 'Desktop', 25000, 40, 'Dell', 1, 2);
INSERT INTO e_commerceproject.product VALUES (11, 'Bluetooth Speaker', 1500, 100, 'JBL', 1, 3);
INSERT INTO e_commerceproject.product VALUES (12, 'Smartwatch', 3500, 50, 'Noise', 1, 4);
INSERT INTO e_commerceproject.product VALUES (13, 'Womens T-shirt', 500, 150, 'H&M', 4, 2); 
INSERT INTO e_commerceproject.product VALUES (14, 'Laptop Stand', 800, 40, 'Amazon Basics', 1, 5);
INSERT INTO e_commerceproject.product VALUES (15, 'Wireless Earbuds', 2000, 70, 'Boat', 2, 1);

--
-- Dumping data into 'cart' table

INSERT INTO e_commerceproject.cart VALUES (1, 51250, 7, 1);
INSERT INTO e_commerceproject.cart VALUES (2, 75000, 3, 2);
INSERT INTO e_commerceproject.cart VALUES (3, 5025, 12, 3);
INSERT INTO e_commerceproject.cart VALUES (4, 150000, 2, 4);
INSERT INTO e_commerceproject.cart VALUES (5, 1050, 3, 5);
INSERT INTO e_commerceproject.cart VALUES (6, 766, 1, 6);
INSERT INTO e_commerceproject.cart VALUES (7, 1059, 2, 7);
INSERT INTO e_commerceproject.cart VALUES (8, 699, 1, 8);
INSERT INTO e_commerceproject.cart VALUES (9, 1495, 5, 9);
INSERT INTO e_commerceproject.cart VALUES (10, 50000, 2, 10);
INSERT INTO e_commerceproject.cart VALUES (11, 1500, 1, 11);
INSERT INTO e_commerceproject.cart VALUES (12, 7000, 2, 2);
INSERT INTO e_commerceproject.cart VALUES (13, 1000, 3, 13);
INSERT INTO e_commerceproject.cart VALUES (14, 3200, 4, 6);
INSERT INTO e_commerceproject.cart VALUES (15, 2000, 1, 15);
INSERT INTO e_commerceproject.cart VALUES (16, 25750, 4, 16);
INSERT INTO e_commerceproject.cart VALUES (17, 25000, 1, 17);
INSERT INTO e_commerceproject.cart VALUES (18, 765, 1, 20);
INSERT INTO e_commerceproject.cart VALUES (19, 75000, 1, 19);
INSERT INTO e_commerceproject.cart VALUES (20, 700, 2, 20);
INSERT INTO e_commerceproject.cart VALUES (21, 25800, 2, 3);
INSERT INTO e_commerceproject.cart VALUES (22, 2796, 4, 10);
INSERT INTO e_commerceproject.cart VALUES (23, 1750, 5, 1);
INSERT INTO e_commerceproject.cart VALUES (24, 2838, 6, 15);
INSERT INTO e_commerceproject.cart VALUES (25, 11250, 10, 19);
INSERT INTO e_commerceproject.cart VALUES (26, 225000, 3, 15);
INSERT INTO e_commerceproject.cart VALUES (27, 75000, 3, 10);
INSERT INTO e_commerceproject.cart VALUES (28, 2250, 2, 7);
INSERT INTO e_commerceproject.cart VALUES (29, 25000, 1, 1);
INSERT INTO e_commerceproject.cart VALUES (30, 5000, 4, 9);

--
-- Dumping data into 'cart_item' table

INSERT INTO e_commerceproject.cart_item VALUES (1, 1, 1, 5);
INSERT INTO e_commerceproject.cart_item VALUES (2, 1, 2, 2);
INSERT INTO e_commerceproject.cart_item VALUES (3, 2, 2, 3);
INSERT INTO e_commerceproject.cart_item VALUES (4, 3, 3, 2);
INSERT INTO e_commerceproject.cart_item VALUES (5, 3, 8, 5);
INSERT INTO e_commerceproject.cart_item VALUES (6, 3, 5, 5);
INSERT INTO e_commerceproject.cart_item VALUES (7, 4, 4, 2);
INSERT INTO e_commerceproject.cart_item VALUES (8, 5, 5, 3);
INSERT INTO e_commerceproject.cart_item VALUES (9, 6, 6, 1);
INSERT INTO e_commerceproject.cart_item VALUES (10, 7, 7, 1);
INSERT INTO e_commerceproject.cart_item VALUES (11, 7, 8, 1);
INSERT INTO e_commerceproject.cart_item VALUES (12, 8, 8, 1);
INSERT INTO e_commerceproject.cart_item VALUES (13, 9, 9, 5);
INSERT INTO e_commerceproject.cart_item VALUES (14, 10, 10, 1);
INSERT INTO e_commerceproject.cart_item VALUES (15, 10, 2, 1);
INSERT INTO e_commerceproject.cart_item VALUES (16, 11, 11, 1);
INSERT INTO e_commerceproject.cart_item VALUES (17, 12, 12, 2);
INSERT INTO e_commerceproject.cart_item VALUES (18, 13, 13, 1);
INSERT INTO e_commerceproject.cart_item VALUES (19, 13, 1, 2);
INSERT INTO e_commerceproject.cart_item VALUES (20, 14, 14, 4);
INSERT INTO e_commerceproject.cart_item VALUES (21, 15, 15, 1);
INSERT INTO e_commerceproject.cart_item VALUES (22, 16, 1, 3);
INSERT INTO e_commerceproject.cart_item VALUES (23, 16, 2, 1);
INSERT INTO e_commerceproject.cart_item VALUES (24, 17, 2, 1);
INSERT INTO e_commerceproject.cart_item VALUES (25, 18, 3, 1);
INSERT INTO e_commerceproject.cart_item VALUES (26, 19, 4, 1);
INSERT INTO e_commerceproject.cart_item VALUES (27, 20, 5, 2);
INSERT INTO e_commerceproject.cart_item VALUES (28, 21, 10, 1);
INSERT INTO e_commerceproject.cart_item VALUES (29, 21, 14, 1);
INSERT INTO e_commerceproject.cart_item VALUES (30, 22, 8, 4);
INSERT INTO e_commerceproject.cart_item VALUES (31, 23, 5, 5);
INSERT INTO e_commerceproject.cart_item VALUES (32, 24, 7, 4);
INSERT INTO e_commerceproject.cart_item VALUES (33, 24, 8, 2);
INSERT INTO e_commerceproject.cart_item VALUES (34, 25, 15, 5);
INSERT INTO e_commerceproject.cart_item VALUES (35, 25, 1, 5);
INSERT INTO e_commerceproject.cart_item VALUES (36, 26, 4, 3);
INSERT INTO e_commerceproject.cart_item VALUES (37, 27, 2, 3);
INSERT INTO e_commerceproject.cart_item VALUES (38, 28, 1, 1);
INSERT INTO e_commerceproject.cart_item VALUES (39, 28, 15, 1);
INSERT INTO e_commerceproject.cart_item VALUES (40, 29, 10, 1);
INSERT INTO e_commerceproject.cart_item VALUES (41, 30, 5, 2);
INSERT INTO e_commerceproject.cart_item VALUES (42, 30, 14, 1);
INSERT INTO e_commerceproject.cart_item VALUES (43, 30, 12, 1);

--
-- Dumping data into 'order_table' table

INSERT INTO e_commerceproject.order_table VALUES (1, '2025-05-01 10:00:00', 51250, 'delivery', '2025-05-02 12:00:00', 1, 1);
INSERT INTO e_commerceproject.order_table VALUES (2, '2025-05-01 10:05:00', 75000, 'delivery', NULL, 2, 2);
INSERT INTO e_commerceproject.order_table VALUES (3, '2025-05-02 10:10:00', 5025, 'delivery', '2025-05-03 10:00:00', 3, 3);
INSERT INTO e_commerceproject.order_table VALUES (4, '2025-05-02 10:15:00', 150000, 'delivery', '2025-05-03 10:00:00', 4, 4);
INSERT INTO e_commerceproject.order_table VALUES (5, '2025-05-03 10:20:00', 1050, 'not delivery', NULL, 5, 5);
INSERT INTO e_commerceproject.order_table VALUES (6, '2025-05-04 10:25:00', 766, 'delivery', '2025-05-05 10:00:00', 6, 6);
INSERT INTO e_commerceproject.order_table VALUES (7, '2025-05-04 10:30:00', 1059, 'not delivery', NULL, 7, 7);
INSERT INTO e_commerceproject.order_table VALUES (8, '2025-05-04 10:35:00', 699, 'delivery', '2025-05-05 10:00:00', 8, 8);
INSERT INTO e_commerceproject.order_table VALUES (9, '2025-05-04 10:40:00', 1495, 'not delivery', NULL, 9, 9);
INSERT INTO e_commerceproject.order_table VALUES (10, '2025-05-05 10:45:00', 50000, 'not delivery', '2025-05-06 10:00:00', 10, 10);
INSERT INTO e_commerceproject.order_table VALUES (11, '2025-05-05 10:50:00', 1500, 'not delivery', NULL, 11, 11);
INSERT INTO e_commerceproject.order_table VALUES (12, '2025-05-06 10:55:00', 7000, 'delivery', '2025-05-07 10:00:00', 2, 12);
INSERT INTO e_commerceproject.order_table VALUES (13, '2025-05-07 11:00:00', 1000, 'delivery', NULL, 13, 13);
INSERT INTO e_commerceproject.order_table VALUES (14, '2025-05-08 11:05:00', 3200, 'delivery', '2025-05-09 10:00:00', 6, 14);
INSERT INTO e_commerceproject.order_table VALUES (15, '2025-05-09 11:10:00', 2000, 'not delivery', NULL, 15, 15);
INSERT INTO e_commerceproject.order_table VALUES (16, '2025-05-09 11:15:00', 25750, 'delivery', '2025-05-10 10:00:00', 16, 16);
INSERT INTO e_commerceproject.order_table VALUES (17, '2025-05-10 11:20:00', 25000, 'not delivery', NULL, 17, 17);
INSERT INTO e_commerceproject.order_table VALUES (18, '2025-05-10 11:25:00', 765, 'delivery', '2025-05-11 10:00:00', 20, 18);
INSERT INTO e_commerceproject.order_table VALUES (19, '2025-05-11 11:30:00', 75000, 'not delivery', NULL, 19, 19);
INSERT INTO e_commerceproject.order_table VALUES (20, '2025-05-11 11:35:00', 700, 'delivery', '2025-05-12 10:00:00', 20, 20);
INSERT INTO e_commerceproject.order_table VALUES (21, '2025-05-16 12:45:00', 25800, 'delivery', '2025-05-17 10:00:00', 3, 21);
INSERT INTO e_commerceproject.order_table VALUES (22, '2025-05-17 13:05:00', 2796, 'delivery', '2025-05-18 10:00:00', 10, 22);
INSERT INTO e_commerceproject.order_table VALUES (23, '2025-05-18 13:25:00', 1750, 'delivery', '2025-05-19 10:00:00', 1, 23);
INSERT INTO e_commerceproject.order_table VALUES (24, '2025-05-18 14:00:00', 2838, 'delivery', '2025-05-19 10:00:00', 15, 24);
INSERT INTO e_commerceproject.order_table VALUES (25, '2025-05-19 14:25:00', 11250, 'not delivery', NULL, 19, 25);
INSERT INTO e_commerceproject.order_table VALUES (26, '2025-05-20 14:35:00', 225000, 'delivery', '2025-05-21 10:00:00', 15, 26);
INSERT INTO e_commerceproject.order_table VALUES (27, '2025-05-20 15:25:00', 75000, 'delivery', '2025-05-21 10:00:00', 10, 27);
INSERT INTO e_commerceproject.order_table VALUES (28, '2025-05-21 16:30:00', 2250, 'not delivery', NULL, 7, 28);
INSERT INTO e_commerceproject.order_table VALUES (29, '2025-05-21 17:25:00', 25000, 'delivery', '2025-05-22 10:00:00', 1, 29);
INSERT INTO e_commerceproject.order_table VALUES (30, '2025-05-22 17:35:00', 5000, 'not delivery', '2025-05-23 10:00:00', 9, 30);

--
-- Dumping data into 'orderitem' table

INSERT INTO e_commerceproject.orderitem VALUES (1, 1, 250, 5);
INSERT INTO e_commerceproject.orderitem VALUES (1, 2, 25000, 2);
INSERT INTO e_commerceproject.orderitem VALUES (2, 2, 25000, 3);
INSERT INTO e_commerceproject.orderitem VALUES (3, 3, 765, 2);
INSERT INTO e_commerceproject.orderitem VALUES (3, 8, 699, 5);
INSERT INTO e_commerceproject.orderitem VALUES (3, 5, 350, 5);
INSERT INTO e_commerceproject.orderitem VALUES (4, 4, 75000, 2);
INSERT INTO e_commerceproject.orderitem VALUES (5, 5, 350, 3);
INSERT INTO e_commerceproject.orderitem VALUES (6, 6, 766, 1);
INSERT INTO e_commerceproject.orderitem VALUES (7, 7, 360, 1);
INSERT INTO e_commerceproject.orderitem VALUES (7, 8, 699, 1);
INSERT INTO e_commerceproject.orderitem VALUES (8, 8, 699, 1);
INSERT INTO e_commerceproject.orderitem VALUES (9, 9, 299, 5);
INSERT INTO e_commerceproject.orderitem VALUES (10, 10, 25000, 1);
INSERT INTO e_commerceproject.orderitem VALUES (10, 2, 25000, 1);
INSERT INTO e_commerceproject.orderitem VALUES (11, 11, 1500, 1);
INSERT INTO e_commerceproject.orderitem VALUES (12, 12, 3500, 2);
INSERT INTO e_commerceproject.orderitem VALUES (13, 13, 500, 1);
INSERT INTO e_commerceproject.orderitem VALUES (13, 1, 250, 2);
INSERT INTO e_commerceproject.orderitem VALUES (14, 14, 800, 4);
INSERT INTO e_commerceproject.orderitem VALUES (15, 15, 2000, 1);
INSERT INTO e_commerceproject.orderitem VALUES (16, 1, 250, 3);
INSERT INTO e_commerceproject.orderitem VALUES (16, 2, 25000, 1);
INSERT INTO e_commerceproject.orderitem VALUES (17, 2, 25000, 1);
INSERT INTO e_commerceproject.orderitem VALUES (18, 3, 765, 1);
INSERT INTO e_commerceproject.orderitem VALUES (19, 4, 75000, 1);
INSERT INTO e_commerceproject.orderitem VALUES (20, 5, 350, 2);
INSERT INTO e_commerceproject.orderitem VALUES (21, 10, 25000, 1);
INSERT INTO e_commerceproject.orderitem VALUES (21, 14, 800, 1);
INSERT INTO e_commerceproject.orderitem VALUES (22, 8, 699, 4);
INSERT INTO e_commerceproject.orderitem VALUES (23, 5, 350, 5);
INSERT INTO e_commerceproject.orderitem VALUES (24, 7, 360, 4);
INSERT INTO e_commerceproject.orderitem VALUES (24, 8, 699, 2);
INSERT INTO e_commerceproject.orderitem VALUES (25, 15, 2000, 5);
INSERT INTO e_commerceproject.orderitem VALUES (25, 1, 250, 5);
INSERT INTO e_commerceproject.orderitem VALUES (26, 4, 75000, 3);
INSERT INTO e_commerceproject.orderitem VALUES (27, 2, 25000, 3);
INSERT INTO e_commerceproject.orderitem VALUES (28, 1, 250, 1);
INSERT INTO e_commerceproject.orderitem VALUES (28, 15, 2000, 1);
INSERT INTO e_commerceproject.orderitem VALUES (29, 10, 25000, 1);
INSERT INTO e_commerceproject.orderitem VALUES (30, 5, 350, 2);
INSERT INTO e_commerceproject.orderitem VALUES (30, 14, 800, 1);
INSERT INTO e_commerceproject.orderitem VALUES (30, 12, 3500, 1);

--
-- Dumping data into 'payment' table

INSERT INTO e_commerceproject.payment VALUES ('online', '2025-05-01 11:00:00', 1, 1);
INSERT INTO e_commerceproject.payment VALUES ('online', '2025-05-01 11:00:00', 2, 2);
INSERT INTO e_commerceproject.payment VALUES ('online', '2025-05-02 17:00:00', 3, 3);
INSERT INTO e_commerceproject.payment VALUES ('online', '2025-05-02 10:00:00', 4, 4);
INSERT INTO e_commerceproject.payment VALUES ('offline', '2025-05-03 12:00:00', 5, 5);
INSERT INTO e_commerceproject.payment VALUES ('offline', '2025-05-04 14:00:00', 6, 6);
INSERT INTO e_commerceproject.payment VALUES ('offline', '2025-05-04 10:00:00', 7, 7);
INSERT INTO e_commerceproject.payment VALUES ('online', '2025-05-04 12:00:00', 8, 8);
INSERT INTO e_commerceproject.payment VALUES ('online', '2025-05-04 14:00:00', 9, 9);
INSERT INTO e_commerceproject.payment VALUES ('online', '2025-05-05 16:00:00', 10, 10);
INSERT INTO e_commerceproject.payment VALUES ('online', '2025-05-05 18:00:00', 11, 11);
INSERT INTO e_commerceproject.payment VALUES ('offline', '2025-05-06 19:00:00', 12, 2);
INSERT INTO e_commerceproject.payment VALUES ('online', '2025-05-07 21:00:00', 13, 13);
INSERT INTO e_commerceproject.payment VALUES ('offline', '2025-05-08 22:00:00', 14, 6);
INSERT INTO e_commerceproject.payment VALUES ('online', '2025-05-09 23:00:00', 15, 15);
INSERT INTO e_commerceproject.payment VALUES ('online', '2025-05-09 10:30:00', 16, 16);
INSERT INTO e_commerceproject.payment VALUES ('online', '2025-05-10 11:30:00', 17, 17);
INSERT INTO e_commerceproject.payment VALUES ('online', '2025-05-10 12:30:00', 18, 20);
INSERT INTO e_commerceproject.payment VALUES ('online', '2025-05-11 13:30:00', 19, 19);
INSERT INTO e_commerceproject.payment VALUES ('offline', '2025-05-11 14:30:00', 20, 20);
INSERT INTO e_commerceproject.payment VALUES ('online', '2025-05-16 14:30:00', 21, 3);
INSERT INTO e_commerceproject.payment VALUES ('online', '2025-05-17 13:30:00', 22, 10); 
INSERT INTO e_commerceproject.payment VALUES ('offline', '2025-05-18 13:30:00', 23, 1); 
INSERT INTO e_commerceproject.payment VALUES ('offline', '2025-05-18 14:30:00', 24, 15); 
INSERT INTO e_commerceproject.payment VALUES ('online', '2025-05-19 14:30:00', 25, 19); 
INSERT INTO e_commerceproject.payment VALUES ('offline', '2025-05-20 15:30:00', 26, 15); 
INSERT INTO e_commerceproject.payment VALUES ('offline', '2025-05-20 16:30:00', 27, 10); 
INSERT INTO e_commerceproject.payment VALUES ('offline', '2025-05-21 17:00:00', 28, 7);
INSERT INTO e_commerceproject.payment VALUES ('online', '2025-05-21 17:30:00', 29, 1); 
INSERT INTO e_commerceproject.payment VALUES ('online', '2025-05-20 18:30:00', 30, 9);

--
-- Dumping data into 'review' table

INSERT INTO e_commerceproject.review VALUES (1, 'good quality and reliable.', '4', 1, 1);
INSERT INTO e_commerceproject.review VALUES (2, 'great resolution, perfect for work.', '5', 2, 2);
INSERT INTO e_commerceproject.review VALUES (3, 'nice and smooth, worth the price.', '4', 3, 3);
INSERT INTO e_commerceproject.review VALUES (4, 'excellent performance, love the camera!', '5', 4, 4);
INSERT INTO e_commerceproject.review VALUES (5, 'comfortable and trendy.', '4', 3, 5);
INSERT INTO e_commerceproject.review VALUES (6, 'very soft fabric, loved it!', '5', 6, 6);
INSERT INTO e_commerceproject.review VALUES (7, 'perfect for casual outings.', '4', 15, 7);
INSERT INTO e_commerceproject.review VALUES (8, 'good fit and durable.', '5', 10, 8);
INSERT INTO e_commerceproject.review VALUES (9, 'very smooth and easy to use.', '4', 9, 9);
INSERT INTO e_commerceproject.review VALUES (10, 'fast and reliable.', '5', 1, 10);
INSERT INTO e_commerceproject.review VALUES (11, 'nice sound quality.', '4', 11, 11);
INSERT INTO e_commerceproject.review VALUES (12, 'great features, definitely worth it!', '5', 2, 12);
INSERT INTO e_commerceproject.review VALUES (13, 'comfortable and stylish.', '4', 13, 13);
INSERT INTO e_commerceproject.review VALUES (14, 'sturdy and easy to assemble.', '4', 14, 14);
INSERT INTO e_commerceproject.review VALUES (15, 'amazing sound, great for workouts.', '5', 15, 15);