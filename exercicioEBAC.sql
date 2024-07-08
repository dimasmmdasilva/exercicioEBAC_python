CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone_number VARCHAR(15)
);

CREATE TABLE product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    description TEXT
);

CREATE TABLE inventory (
    inventory_id INT PRIMARY KEY,
    product_id INT,
    quantity INT,
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10, 2),
    FOREING KEY (order_id) REFERENCES orders(order_id),
    FOREING KEY (product_id) REFERENCES product(product_id)
);

INSERT INTO customer (customer_id, first_name, last_name, email, phone_number) VALUES
(1, 'Ana', 'Silva', 'ana.silva@email.com', '123-456-7890'),
(2, 'João', 'Costa', 'joao.costa@email.com', '234-567-8901'),
(3, 'Maria', 'Fernandes', 'maria.fernandes@email.com', '345-678-9012');

INSERT INTO product (product_id, product_name, price, description) VALUES
(1, 'Smartphone', 1200.00, 'Smartphone com 128GB de memória e câmera de 12MP'),
(2, 'Tablet', 600.00, 'Tablet 10 polegadas, ideal para leitura e navegação na internet'),
(3, 'Laptop', 4500.00, 'Notebook com 16GB RAM, processador i7 de última geração, 500GB memória e placa de vídeo Nvidia RTX 3050');

INSERT INTO inventory (inventory_id, product_id, quantity) VALUES
(1, 1, 150),
(2, 2, 300),
(3, 3, 50);

INSERT INTO orders (order_id, customer_id, order_date) VALUES
(1, 1, '2024-06-01'),
(2, 2, '2024-06-02'),
(3, 3, '2024-06-03');

INSERT INTO order_items (order_item_id, order_id, product_id, quantity, price) VALUES
(1, 1, 1, 1, 1200.00),
(2, 1, 2, 1, 600.00),
(3, 2, 3, 1, 4500.00),
(4, 3, 1, 1, 1200.00),
(5, 3, 3, 1, 4500.00);

SELECT product.product_name, SUM(inventory.quantity) AS total_quantity
FROM product
INNER JOIN inventory ON product.product_id = inventory.product_id
GROUP BY product.product_name;

SELECT orders.order_id, customer.first_name, customer.last_name, product.product_name, order_items.quantity, order_items.price
FROM orders
INNER JOIN customer ON orders.customer_id = customer.customer_id
INNER JOIN order_items ON orders.order_id = order_items.order_id
INNER JOIN product ON order_items.product_id = product.product_id;

SELECT customer.first_name, customer.last_name, SUM(order_items.quantity * order_items.price) AS total_spent
FROM customer
INNER JOIN orders ON customer.customer_id = orders.customer_id
INNER JOIN order_items ON orders.order_id = order_items.order_id
GROUP BY customer.first_name, customer.last_name;
