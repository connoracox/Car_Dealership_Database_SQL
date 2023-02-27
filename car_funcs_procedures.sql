
-- FUNCTION TO ADJUST CAR'S INVENTORY --

CREATE OR REPLACE FUNCTION carQuant(
	carsId INT,
	newQuant INT
)
RETURNS INT 
LANGUAGE plpgsql AS $$
BEGIN 
	UPDATE cars
	SET inventory = newQuant
	WHERE cars_id = carsId;
	RETURN carsId;
END;
$$

SELECT carQuant(1, 123);
SELECT carQuant(2, 456);
SELECT carQuant(3, 789);
SELECT carQuant(4, 1000);

SELECT *
FROM cars;


-- PROCEDURE FOR CREATING SERVICE TICKET --


CREATE OR REPLACE PROCEDURE insertService(
	customerId INT,
	assignmentId INT,
	dateIn VARCHAR(25),
	dateOut VARCHAR(25),
	totalCost FLOAT
)
LANGUAGE plpgsql AS $$
BEGIN 
	INSERT INTO service_ticket(
		customer_id,
		mechanic_assignment_id,
		date_in,
		date_out,
		total_cost
	)VALUES(
		customerId,
		assignmentId,
		dateIn,
		dateOut,
		totalCost
	);
	COMMIT;
END;
$$

CALL insertService('6', '1', '2/24/2023', '3/10/2023', 4000);
CALL insertService('2', '2', '2/26/2023', '3/10/2023', 1200);
CALL insertService('1', '3', '10/31/2022', '1/1/2023', 15000);

SELECT *
FROM service_ticket;


-- PROCEDURE FOR ASSIGNING MECHANIC TO SERVICE --


CREATE OR REPLACE PROCEDURE assignMechanic(
	mechanicId INT,
	carId INT
)
LANGUAGE plpgsql AS $$
BEGIN 
	INSERT INTO mechanic_assignment(
		mechanic_id,
		cars_id
	)VALUES(
		mechanicId,
		carId
	);
	COMMIT;
END;
$$

CALL assignMechanic('4', '1');
CALL assignMechanic('3', '2');

SELECT *
FROM mechanic_assignment;


-- PROCEDURE FOR CREATING INVOICES --


CREATE OR REPLACE PROCEDURE insertInvoice(
	salesId INT,
	customerId INT,
	carId INT,
	saleDate VARCHAR(25),
	salePrice FLOAT
)
LANGUAGE plpgsql AS $$
BEGIN 
	INSERT INTO invoices(
		salesperson_id,
		customer_id,
		cars_id,
		sale_date,
		sale_price 
	)VALUES(
		salesId,
		customerId,
		carId,
		TO_DATE(saleDate, 'MM/DD/YYYY'),
		salePrice
	);
	COMMIT;
END;
$$

CALL insertInvoice(4, 6, 3, '2/29/2000', 50000);
CALL insertInvoice(4, 6, 4, '6/03/2022', 90000);

SELECT *
FROM invoices;

-- Find out which car Ted Lasso bought --

SELECT first_name, last_name, make, model
FROM customer c
JOIN dealership d 
ON c.customer_id = d.customer_id
JOIN cars c2
ON c2.cars_id = d.cars_id
WHERE last_name = 'Lasso';
