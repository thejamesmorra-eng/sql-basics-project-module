CREATE TABLE Users (
                       id SERIAL PRIMARY KEY,
                       first_name VARCHAR(50) NOT NULL,
                       last_name VARCHAR(50) NOT NULL,
                       email VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE Products (
                          id SERIAL PRIMARY KEY,
                          product_name VARCHAR(50) UNIQUE NOT NULL,
                          category VARCHAR(50) NOT NULL,
                          price NUMERIC(10, 2) NOT NULL CHECK (price > 0)
);

CREATE TABLE Orders (
                        id SERIAL PRIMARY KEY,
                        user_id INT NOT NULL REFERENCES Users(id),
                        order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Order_items (
                             order_id INT NOT NULL REFERENCES Orders(id),
                             product_id INT NOT NULL REFERENCES Products(id),
                             quantity INT NOT NULL CHECK (quantity > 0) DEFAULT 1,
                             PRIMARY KEY (order_id, product_id)
);