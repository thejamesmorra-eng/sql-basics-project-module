-- Выборка полного описания продукта, цена которого выше или равна 300.
-- Вывод данных по возрастанию цены.
SELECT * FROM products
WHERE price >= 300
ORDER BY price;

-- Выборка полного описания продукта, цена которого находится в заданном диапазоне.
-- Вывод данных по убыванию цены.
SELECT * FROM products
WHERE price BETWEEN 10 AND 90
ORDER BY price DESC;

-- Выборка заказов за указанный промежуток.
SELECT users.first_name, users.last_name, orders.id, orders.order_date
FROM users
JOIN orders ON users.id = orders.user_id
WHERE order_date BETWEEN now() - INTERVAL '14 days' AND now()
ORDER BY order_date;

-- Выборка полного описания продукта, категория которого находится в указанном списке.
-- Вывод данных в лексикографическом порядке.
SELECT * FROM products
WHERE category IN ('Electronics', 'Furniture')
ORDER BY category;

-- Выборка всех фамилий пользователей, заканчивающихся на указанный шаблон.
SELECT last_name FROM users
WHERE last_name LIKE '%ov';

-- Выборка категорий и вывод суммарной стоимости их продуктов
-- вывод данных в лексикографическом порядке
-- в данном примере предполагается, что каждого продукта по одной единице.
SELECT category,
       SUM(price) as total
FROM products
GROUP BY category;

-- Выборка категорий и максимальной цены продукта в данной категории
-- вывод данных по возрастанию цены.
SELECT category,
       MAX(price) as max_price
FROM products
GROUP BY category
ORDER BY max_price;

-- Выборка категорий и минимальной цены продукта в данной категории
-- вывод данных по возрастанию цены.
SELECT category,
       MIN(price) as min_price
FROM products
GROUP BY category
ORDER BY min_price;

-- Выборка категорий и средней цены продукта в данной категории
-- вывод данных по возрастанию средней цены.
SELECT category,
       floor(AVG(price))::INT as avg_price
FROM products
GROUP BY category
ORDER BY avg_price;

-- Выборка order_id с несколькими разными товарами в заказе.
SELECT order_id,
       COUNT(*) as products_in_order
FROM order_items
GROUP BY order_id
HAVING COUNT(*) > 1
ORDER BY products_in_order;

-- Выборка продуктов, заказов в которых они находятся и их количества.
SELECT product_name, order_id, quantity
FROM products
         JOIN order_items ON products.id = order_items.product_id;

-- Вывод всех пользователей и их заказов
-- у пользователей без заказов order_id = null
SELECT users.first_name, users.last_name, orders.id as order_id
FROM users
         LEFT JOIN orders ON users.id = orders.user_id;

-- Выборка данных пользователей, номеров их заказов, состав их заказа и дату заказа
-- вывод данных в порядке возрастания даты заказа.
SELECT users.first_name,
       users.last_name,
       orders.id as order_id,
       products.product_name,
       order_items.quantity,
       orders.order_date
FROM users
         JOIN orders ON users.id = orders.user_id
         JOIN order_items ON orders.id = order_items.order_id
         JOIN products ON order_items.product_id = products.id
ORDER BY order_date;

-- Выборка данных пользователей и суммарной стоимости их заказов.
-- Подсчет стоимость верный.
SELECT users.id,
       users.first_name,
       users.last_name,
       SUM(products.price * order_items.quantity) as total_order_sum
FROM users
         JOIN orders ON users.id = orders.user_id
         JOIN order_items ON orders.id = order_items.order_id
         JOIN products ON order_items.product_id = products.id
GROUP BY users.id;

-- Изменение имени пользователя с указанным id.
UPDATE users
SET first_name = 'IvanIvan'
WHERE first_name = 'Ivan';

-- Ожидается ошибка violates foreign key constraint в таблице orders.
DELETE FROM users
WHERE id = 1;

-- Ожидается ошибка violates foreign key constraint в таблице orders,
-- так как такого id нет в таблице users.
INSERT INTO orders (user_id)
VALUES (999);