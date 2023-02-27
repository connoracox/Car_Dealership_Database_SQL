
CREATE TABLE customer(
	customer_id SERIAL PRIMARY KEY,
	first_name VARCHAR(45) NOT NULL,
	last_name VARCHAR(45) NOT NULL,
	phone VARCHAR(20),
	email VARCHAR(45)
);

INSERT INTO customer(
	first_name,
	last_name,
	phone,
	email
)VALUES(
	'Abe',
	'Choi',
	'123-123-4321',
	'abe@example.com'
),(
	'Amanda',
	'Kibbel',
	'321-321-4321',
	'amanda@example.com'
);
INSERT INTO customer(
	first_name,
	last_name,
	phone,
	email
)VALUES(
	'Sarah',
	'Sandberg',
	'321-654-0987',
	'sarah@example.com'
),(
	'Ted',
	'Lasso',
	'333-333-3333',
	'ted@example.com'
);


DELETE FROM customer WHERE last_name = 'Mechanic';

SELECT *
FROM customer;

CREATE TABLE salesperson(
	salesperson_id SERIAL PRIMARY KEY,
	first_name VARCHAR(45) NOT NULL,
	last_name VARCHAR(45) NOT NULL,
	phone VARCHAR(20),
	email VARCHAR(45)
);

INSERT INTO salesperson(
	first_name,
	last_name,
	phone,
	email
)VALUES(
	'Albert',
	'Sales',
	'123-123-4321',
	'albert@sales.com'
),(
	'Tim',
	'Sales',
	'321-321-4321',
	'tim@sales.com'
);

INSERT INTO salesperson(
	first_name,
	last_name,
	phone,
	email
)VALUES(
	'Dylan',
	'Sales',
	'777-777-7777',
	'dylan@sales.com'
),(
	'Lucas',
	'Sales',
	'666-666-6666',
	'lucas@sales.com'
);

SELECT *
FROM salesperson;

CREATE TABLE mechanic(
	mechanic_id SERIAL PRIMARY KEY,
	first_name VARCHAR(45) NOT NULL,
	last_name VARCHAR(45) NOT NULL,
	phone VARCHAR(20),
	email VARCHAR(45)
);
INSERT INTO mechanic(
	first_name,
	last_name,
	phone,
	email
)VALUES(
	'Connor',
	'Mechanic',
	'111-111-111',
	'connor@mechanic.com'
),(
	'Jim',
	'Mechanic',
	'999-999-9999',
	'jim@mechanic.com'
);

INSERT INTO mechanic(
	first_name,
	last_name,
	phone,
	email
)VALUES(
	'Andrew',
	'Mechanic',
	'111-111-111',
	'andrew@mechanic.com'
),(
	'Carl',
	'Mechanic',
	'999-999-9999',
	'carl@mechanic.com'
);

SELECT *
FROM mechanic;

CREATE TABLE cars(
	cars_id SERIAL PRIMARY KEY,
	make VARCHAR(45) NOT NULL,
	model VARCHAR(45) NOT NULL,
	year_made INT NOT NULL,
	inventory INT
);

INSERT INTO cars(
	make,
	model,
	year_made,
	inventory
)values(
	'Toyota',
	'Prius',
	'2023',
	25
),(
	'Aston Martin',
	'Vanquish',
	2001,
	75	
);

INSERT INTO cars(
	make,
	model,
	year_made,
	inventory
)values(
	'Nissan',
	'leaf',
	'2023',
	500
),(
	'Tesla',
	'Model S',
	2023,
	250	
);

SELECT *
FROM cars;

CREATE TABLE dealership(
	dealership_id SERIAL PRIMARY KEY,
	customer_id INT NOT NULL,
	salesperson_id INT NOT NULL,
	mechanic_id INT NOT NULL,
	cars_id INT NOT NULL,
	dealership_name VARCHAR(45) NOT NULL,
	address VARCHAR(45) NOT NULL,
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
	FOREIGN KEY(salesperson_id) REFERENCES salesperson(salesperson_id),
	FOREIGN KEY(mechanic_id) REFERENCES mechanic(mechanic_id),
	FOREIGN KEY(cars_id) REFERENCES cars(cars_id)
);

INSERT INTO dealership(
	customer_id,
	salesperson_id,
	mechanic_id,
	cars_id,
	dealership_name,
	address
)VALUES(
	1,
	2,
	2,
	2,
	'Connor''s Cars',
	'140 Woodside Green Stamford, CT'
),(
	2,
	1,
	1,
	1,
	'Connor''s Cars',
	'140 Woodside Green Stamford, CT'
);

INSERT INTO dealership(
	customer_id,
	salesperson_id,
	mechanic_id,
	cars_id,
	dealership_name,
	address
)VALUES(
	6,
	3,
	3,
	3,
	'Connor''s Cars',
	'140 Woodside Green Stamford, CT'
),(
	5,
	4,
	4,
	4,
	'Connor''s Cars',
	'140 Woodside Green Stamford, CT'
);

SELECT * 
FROM dealership;

DROP TABLE IF EXISTS invoices;
CREATE TABLE invoices(
	invoices_id SERIAL PRIMARY KEY,
	customer_id INT NOT NULL,
	salesperson_id INT NOT NULL,
	cars_id INT NOT NULL,
	sale_date VARCHAR,
	sale_price FLOAT,
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
	FOREIGN KEY(salesperson_id) REFERENCES salesperson(salesperson_id),
	FOREIGN KEY(cars_id) REFERENCES cars(cars_id)
);

INSERT INTO invoices(
	customer_id,
	salesperson_id,
	cars_id,
	sale_date,
	sale_price
)VALUES(
	1,
	2,
	2,
	'02/21/2023',
	'25000.00'
),(
	2,
	1,
	1,
	'02/14/2023',
	'15000.00'
);

INSERT INTO invoices(
	customer_id,
	salesperson_id,
	cars_id,
	sale_date,
	sale_price
)VALUES(
	6,
	3,
	3,
	'02/26/2023',
	'50000.00'
),(
	5,
	4,
	4,
	'02/26/2023',
	'52000.00'
);

SELECT * 
FROM invoices;

CREATE TABLE mechanic_assignment(
	mechanic_assignment_id SERIAL PRIMARY KEY,
	mechanic_id INT NOT NULL,
	cars_id INT NOT NULL,
	FOREIGN KEY(mechanic_id) REFERENCES mechanic(mechanic_id),
	FOREIGN KEY(cars_id) REFERENCES cars(cars_id)
);

INSERT INTO mechanic_assignment(
	mechanic_id,
	cars_id
)Values(
	2,
	2
),(
	1,
	1
);

INSERT INTO mechanic_assignment(
	mechanic_id,
	cars_id
)Values(
	3,
	3
),(
	4,
	4
);

SELECT * 
FROM mechanic_assignment;


CREATE TABLE service_ticket(
	service_ticket_id SERIAL PRIMARY KEY,
	customer_id INT NOT NULL,
	mechanic_assignment_id INT NOT NULL,
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
	FOREIGN KEY(mechanic_assignment_id) REFERENCES mechanic_assignment(mechanic_assignment_id)
);

INSERT INTO service_ticket(
	customer_id,
	mechanic_assignment_id
)Values(
	1,
	1
),(
	2,
	2
);

INSERT INTO service_ticket(
	customer_id,
	mechanic_assignment_id
)Values(
	5,
	3
),(
	6,
	4
);

ALTER TABLE service_ticket 
ADD date_in VARCHAR,
ADD date_out VARCHAR,
ADD total_cost VARCHAR;

SELECT * 
FROM cars;
