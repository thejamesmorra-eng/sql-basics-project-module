INSERT INTO Users (first_name, last_name, email)
VALUES ('Ivan', 'Ivanov', 'ivanov@mail.ru'),
       ('Petr', 'Petrov', 'petrov@mail.ru'),
       ('Anton', 'Sidorov', 'sidorov@mail.ru'),
       ('Pasha', 'Ivanov', 'pIvanov@mail.ru'),
       ('Ilya', 'Demin', 'demin@mail.ru');

INSERT INTO products (product_name, category, price)
VALUES ('Mouse', 'Electronics', '20'),
       ('Keyboard', 'Electronics', '30'),
       ('Headphones', 'Electronics', '50'),
       ('Chair', 'Furniture', '600'),
       ('Tires', 'Automotive products', '120'),
       ('Wipers', 'Automotive products', '10'),
       ('Table', 'Furniture', '300'),
       ('Side mirror', 'Automotive products', '90'),
       ('Sofa', 'Furniture', '2000'),
       ('SSD', 'Electronics', '70');

INSERT INTO orders (user_id, order_date)
SELECT
    floor(random() * 5 + 1)::INT,
    now() - (random() * interval '30 days')
FROM generate_series(1, 13);

INSERT INTO order_items (order_id, product_id, quantity)
SELECT
    floor(random() * 13 + 1)::INT,
    floor(random() * 10 + 1)::INT,
    floor(random() * 7 + 1)::INT
FROM generate_series(1, 13);