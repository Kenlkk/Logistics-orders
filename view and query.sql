-- View: ShipmentDetails
CREATE VIEW ShipmentDetails AS
SELECT
    Shipments.shipment_id,
    Customers.customer_name AS customer,
	STRING_AGG(Purchase_orders.Purchase_orders_id::TEXT, ', ') AS orders,
    Carriers.carrier_name AS carrier,
	Shipments.bill_of_lading_no,
    Shipments.shipment_date,
    Shipments.delivery_date,
    Shipments.status,
    Shipments.weight_kg,
    Shipments.cost
FROM Shipments
JOIN Customers ON Shipments.customer_id = Customers.customer_id
JOIN Carriers ON Shipments.carrier_id = Carriers.carrier_id
JOIN Junction ON Shipments.shipment_id = Junction.shipment_id
JOIN Purchase_orders ON Junction.Purchase_orders_id = Purchase_orders.Purchase_orders_id
GROUP BY Shipments.shipment_id, Customers.customer_name, Carriers.carrier_name;

-- Query 1: Get all shipments with details
SELECT * 
FROM ShipmentDetails;

-- Query 2: Get pending shipments
SELECT * 
FROM ShipmentDetails
WHERE status = 'Pending';

-- Query 3: Calculate Total Cost for Each Customer
SELECT
    Customers.customer_name,
    SUM(Shipments.cost) AS total_cost
FROM Shipments
JOIN Customers ON Shipments.customer_id = Customers.customer_id
GROUP BY Customers.customer_name;

-- Query 4: Find Carriers with the Most Shipments
SELECT
    Carriers.carrier_name,
    COUNT(Shipments.carrier_id) AS shipment_count,
	RANK() over (order by COUNT(Shipments.carrier_id) DESC) AS rank
FROM Carriers
LEFT JOIN Shipments ON Carriers.carrier_id = Shipments.carrier_id
GROUP BY Carriers.carrier_name;

-- Adding a new column named 'contact_email' with VARCHAR(255) data type to the 'Carriers' table
ALTER TABLE Carriers
ADD COLUMN contact_email VARCHAR(255);

-- Inserting data into Customers table
INSERT INTO Customers (customer_id, customer_name, contact_person, contact_number, contact_email)
VALUES
    (1, 'ABC Limited', 'Ada Brown', '+1234567890', 'ada.brown@abclimited.com'),
    (2, 'CCC Corporate', 'Chris Smith', '+9876543210', 'chris.smith@ccccorporate.com');

-- Inserting data into Carriers table
INSERT INTO Carriers (carrier_id, carrier_name, carrier_SCAC_Code, contact_person, contact_number, pricing_rate, contact_email)
VALUES
    (1, 'Fast Shipping Ltd.', 'FSC', 'Mike Jenson', '+1112223333', 20.1, 'mike.jenson@fastshipping.com'),
    (2, 'Quick Logistics', 'RELO', 'Karen White', '+4445556666', 12.2, 'karen.white@quicklogistics.com');

-- Inserting data into Shipments table
INSERT INTO Shipments (shipment_id, customer_id, carrier_id, shipment_date, delivery_date, status, weight_kg, cost)
VALUES
    (101, 1, 1, '2023-01-15', '2023-01-20', 'Delivered', 500.25, 1200.50),
    (102, 2, 2, '2023-02-01', '2023-02-10', 'Pending', 750.75, 1800.25);

-- Verify the data in the tables
SELECT * FROM Customers;
SELECT * FROM Carriers;
SELECT * FROM Shipments;