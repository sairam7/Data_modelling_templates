CREATE TABLE customer_dimension (
    customer_id BINARY(16) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    phone VARCHAR(20),
    address VARCHAR(255),
    city VARCHAR(100),
    zipcode VARCHAR(20)
);

CREATE TABLE item_dimension (
    item_id BINARY(16) PRIMARY KEY,
    item_name VARCHAR(255) NOT NULL,
    item_price DECIMAL(10, 2),
    item_type VARCHAR(100)
);

CREATE TABLE payments_dimension (
    payment_id BINARY(16) PRIMARY KEY,
    transaction_date DATE,
    amount DECIMAL(10, 2),
    payment_method VARCHAR(50),
    customer_id BINARY(16),
    FOREIGN KEY (customer_id) REFERENCES customer_dimension(customer_id)
);

CREATE TABLE location_dimension (
    location_id BINARY(16) PRIMARY KEY,
    country VARCHAR(100),
    city VARCHAR(100),
    zip VARCHAR(20)
);

CREATE TABLE item_location (
    item_id BINARY(16),
    location_id BINARY(16),
    PRIMARY KEY (item_id, location_id),
    FOREIGN KEY (item_id) REFERENCES item_dimension(item_id),
    FOREIGN KEY (location_id) REFERENCES location_dimension(location_id)
);

CREATE TABLE orders_fact (
    order_id BINARY(16) PRIMARY KEY,
    customer_id BINARY(16),
    item_id BINARY(16),
    payment_id BINARY(16),
    location_id BINARY(16),
    date DATE,
    total_cost DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customer_dimension(customer_id),
    FOREIGN KEY (item_id) REFERENCES item_dimension(item_id),
    FOREIGN KEY (payment_id) REFERENCES payments_dimension(payment_id),
    FOREIGN KEY (location_id) REFERENCES location_dimension(location_id)
);

