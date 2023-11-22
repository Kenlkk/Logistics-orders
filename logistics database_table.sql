-- logistics_database.sql

-- Table: Customers
CREATE TABLE Customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(255) NOT NULL,
    contact_person VARCHAR(255),
    contact_number VARCHAR(15),
	contact_email VARCHAR(255)
);

-- Table: Carriers
CREATE TABLE Carriers (
    carrier_id SERIAL PRIMARY KEY,
    carrier_name VARCHAR(255) NOT NULL,
	carrier_SCAC_Code VARCHAR(4) NOT NULL,
    contact_person VARCHAR(255),
    contact_number VARCHAR(15),
	pricing_rate DECIMAL(10, 2)
);

-- Table: Suppliers
CREATE TABLE Suppliers (
	supplier_id SERIAL PRIMARY KEY,
    supplier_name VARCHAR(255) NOT NULL,
	supplier_address VARCHAR(255),
    contact_person VARCHAR(255),
    contact_number VARCHAR(15)
);	

-- Table: Purchase orders
CREATE TABLE Purchase_orders (
	Purchase_orders_id SERIAL PRIMARY KEY,
	orders_description VARCHAR(255),
	piece_per_carton INT,
	weight_kg DECIMAL(10, 2),
	cost DECIMAL(10, 2),
	supplier_id INT REFERENCES Suppliers(supplier_id)
);

-- Table: Shipments
CREATE TABLE Shipments (
    shipment_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES Customers(customer_id),
    carrier_id INT REFERENCES Carriers(carrier_id),
	bill_of_lading_no VARCHAR(20),
	ETD DATE, -- Estimate time of departure
    shipment_date DATE,
	ETA DATE, -- Estimate time of arrival
    delivery_date DATE, 
    status VARCHAR(20) CHECK (status IN ('In Transit', 'Delivered', 'Pending')),
    weight_kg DECIMAL(10, 2),
    cost DECIMAL(10, 2)
);

-- Junction Table (since there maybe many orders in 1 shipment or many shipments to ship same order)
CREATE TABLE Junction (
	junction_id SERIAL PRIMARY KEY,
	shipment_id INT REFERENCES Shipments(shipment_id),
	Purchase_orders_id INT REFERENCES Purchase_orders(Purchase_orders_id)
);