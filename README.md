# Logistics-orders database
This repository contains SQL scripts for creating a logistcs tracking database in PostgreSQL. The database schema includes tables for customers, carriers, suppliers, purchase orders, shipments and junction and, views and queries for tracking shipment and performance.

Files
database_table.sql: This script defines the entire database schema, creating tables with primary and foreign keys, ensuring data integrity across entities.

view_and_query.sql: Contains SQL code for creating a view, namely "ShipmentDetails," and various queries aimed at extracting valuable insights into the logistics operations. Queries cover aspects such as all shipment details, pending shipments, total costs for each customer, and carrier rankings based on shipment counts.

Usage
Execute database_table.sql to create the necessary tables, ensuring a well-organized structure for logistics data.
Execute view_and_query.sql to create the "ShipmentDetails" view and sample queries that provide actionable information on logistics operations.
Leverage the provided queries to gain insights into shipment details, pending shipments, total costs per customer, and carrier rankings.

Database Schema
Customers Table
customer_id: Unique identifier for each customer.
customer_name: Name of the customer.
contact_person: Contact person associated with the customer.
contact_number: Contact number for the customer.
contact_email: Unique email address of the customer.
Carriers Table
carrier_id: Unique identifier for each carrier.
carrier_name: Name of the carrier.
carrier_SCAC_Code: Standard Carrier Alpha Code for the carrier.
contact_person: Contact person associated with the carrier.
contact_number: Contact number for the carrier.
pricing_rate: Pricing rate for the carrier's services.
contact_email: Email address of the carrier.
Suppliers Table
supplier_id: Unique identifier for each supplier.
supplier_name: Name of the supplier.
supplier_address: Address of the supplier.
contact_person: Contact person associated with the supplier.
contact_number: Contact number for the supplier.
Purchase Orders Table
Purchase_orders_id: Unique identifier for each purchase order.
orders_description: Description of the purchase orders.
piece_per_carton: Number of pieces per carton in the purchase order.
weight_kg: Total weight of the purchase order in kilograms.
cost: Cost associated with the purchase order.
supplier_id: Foreign key referencing the supplier_id in the Suppliers table.
Shipments Table
shipment_id: Unique identifier for each shipment.
customer_id: Foreign key referencing the customer_id in the Customers table.
carrier_id: Foreign key referencing the carrier_id in the Carriers table.
bill_of_lading_no: Bill of lading number associated with the shipment.
ETD: Estimate time of departure for the shipment.
shipment_date: Actual date of the shipment.
ETA: Estimate time of arrival for the shipment.
delivery_date: Actual date of delivery for the shipment.
status: Status of the shipment, checked against values 'In Transit', 'Delivered', or 'Pending'.
weight_kg: Total weight of the shipment in kilograms.
cost: Cost associated with the shipment.
Junction Table
junction_id: Unique identifier for each junction entry.
shipment_id: Foreign key referencing the shipment_id in the Shipments table.
Purchase_orders_id: Foreign key referencing the Purchase_orders_id in the Purchase Orders table.

View
ShipmentDetails View
This view aggregates crucial shipment details, providing a comprehensive overview of each shipment. It includes customer information, associated orders, carrier details, bill of lading number, shipment dates, status, weight, and cost.

Queries
Get All Shipments with Details: Retrieve detailed information about all shipments.

Get Pending Shipments: Retrieve details about shipments with a status of 'Pending'.

Calculate Total Cost for Each Customer: Obtain the total cost of shipments for each customer.

Find Carriers with the Most Shipments: Identify carriers with the highest shipment counts, ranked in descending order.

Add a New Column 'contact_email' to the Carriers Table: Extend the Carriers table with a new column for contact email.

Feel free to customize and extend the provided SQL scripts to adapt the logistics database to your specific operational requirements.
