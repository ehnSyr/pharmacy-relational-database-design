/*******************************************************************************************************************************************************************************************
*                                                                                                                                                                                          *
* Title        : Final Class Project - Up Down Script & Insert Statements                                                                                                                  *
* Group Name   :                                                                                                                                                                           *
* Group Members:                                                                                                                                                                           *
* Class        :                                                                                                                                                                           *
* Due Date     :                                                                                                                                                                           *
*                                                                                                                                                                                          *
*******************************************************************************************************************************************************************************************/



-- ----------------------------------------------------------------------------------- Drop Forign Keys ------------------------------------------------------------------------------------

-- Insurance ID Foreign Key
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE CONSTRAINT_NAME = 'fk_inventory_inventory_drug_id') 
    ALTER TABLE inventory DROP CONSTRAINT fk_inventory_inventory_drug_id;
GO


-- Pharmacy Foreign Key
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE CONSTRAINT_NAME = 'fk_inventory_inventory_pharmacy_id') 
    ALTER TABLE inventory DROP CONSTRAINT fk_inventory_inventory_pharmacy_id;
GO 

-- Drug ID Foreign Key
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE CONSTRAINT_NAME = 'fk_order_item_details_order_item_drug_id') 
    ALTER TABLE order_item_details DROP CONSTRAINT fk_order_item_details_order_item_drug_id;
GO 

-- Insurance ID Foreign Key
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE CONSTRAINT_NAME = 'fk_order_item_details_order_item_insurance_id') 
    ALTER TABLE order_item_details DROP CONSTRAINT fk_order_item_details_order_item_insurance_id;
GO 

-- Order ID Foreign Key
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE CONSTRAINT_NAME = 'fk_order_item_details_order_item_order_id')
    ALTER TABLE order_item_details DROP CONSTRAINT fk_order_item_details_order_item_order_id;
GO 

--Pharmacy ID Foreign Key
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE CONSTRAINT_NAME = 'fk_orders_order_patient_id')
    ALTER TABLE orders DROP CONSTRAINT fk_orders_order_patient_id;
GO

-- Patient ID Foreign Key
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE CONSTRAINT_NAME = 'fk_orders_order_pharmacy_id')
    ALTER TABLE orders DROP CONSTRAINT fk_orders_order_pharmacy_id;
GO   

-- Covereage Amount Insurance ID Foreign Key
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE CONSTRAINT_NAME = 'fk_coverage_amounts_coverage_amount_insurance_id')
    ALTER TABLE coverage_amounts DROP CONSTRAINT fk_coverage_amounts_coverage_amount_insurance_id;
GO 

-- Coverage Amounts Drug ID Foreign Key
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE CONSTRAINT_NAME = 'fk_coverage_amounts_coverage_amounts_drug_id')
    ALTER TABLE coverage_amounts DROP CONSTRAINT fk_coverage_amounts_coverage_amounts_drug_id;
GO 
 
-- Insurance ID Foreign Key
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE CONSTRAINT_NAME = 'fk_patient_insurance_insur_id')
    ALTER TABLE patient_insurance_lookup DROP CONSTRAINT fk_patient_insurance_insur_id;    
GO    

-- Patient ID Foreign Key
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE CONSTRAINT_NAME = 'fk_patient_insurance_pt_id')
    ALTER TABLE patient_insurance_lookup DROP CONSTRAINT fk_patient_insurance_pt_id;
GO 

-- Insurance Type ID Foreign Key
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE CONSTRAINT_NAME = 'fk_insurance_insurance_type_id')
    ALTER TABLE insurance DROP CONSTRAINT fk_insurance_insurance_type_id;
GO

-- State Foreign Key to the
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE CONSTRAINT_NAME = 'fk_apharmacy_address_address_state')
    ALTER TABLE pharmacy_address DROP CONSTRAINT fk_apharmacy_address_address_state;
GO

-- State Foreign Key to the
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE CONSTRAINT_NAME = 'fk_patient_address_address_state') 
    ALTER TABLE patient_address DROP CONSTRAINT fk_patient_address_address_state;
GO

-- Address ID Foreign Key 
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE CONSTRAINT_NAME = 'fk_patient_address_lookup_address_pt_id') 
    ALTER TABLE patient_address_lookup DROP CONSTRAINT fk_patient_address_lookup_address_pt_id;
GO

-- Patient ID Foreign Key
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE CONSTRAINT_NAME = 'fk_patient_address_lookup_patient_id') 
    ALTER TABLE patient_address_lookup DROP CONSTRAINT fk_patient_address_lookup_patient_id;
GO


-- ----------------------------------------------------------------------------------- Drop Tables -----------------------------------------------------------------------------------------

-- Drop Patient Table
DROP TABLE IF EXISTS patients;

-- Drop Patient Address Table
DROP TABLE IF EXISTS patient_address;

-- Drop Pharmacy Table
DROP TABLE IF EXISTS pharmacies;

-- Drop Pharmacy Address Table
DROP TABLE IF EXISTS pharmacy_address;

-- Drop Insurance Table
DROP TABLE IF EXISTS insurance;

-- Drop Insurance Type Lookup Table
DROP TABLE IF EXISTS insurance_type;

-- Drop Order Table
DROP TABLE IF EXISTS orders;

-- Drop Order Detail Table 
DROP TABLE IF EXISTS order_item_details;

-- Drop Drug Table
DROP TABLE IF EXISTS drugs;

-- Drop Inventory Table 
DROP TABLE IF EXISTS inventory;

-- Drop Coverage Amounts Table
DROP TABLE IF EXISTS coverage_amounts;
GO 

-- Drop Patient Address Lookup
DROP TABLE IF EXISTS patient_address_lookup;
GO

-- Drop Patient Insurance Lookup
DROP TABLE IF EXISTS patient_insurance_lookup;
GO

-- Drop Pharmacy Address Lookup
DROP TABLE IF EXISTS pharmacy_address_lookup;
GO

-- Drop State Lookup
DROP TABLE IF EXISTS state_lookup;
GO

-- --------------------------------------------------------------------Create THE NEW DESIGNATED DATABASE----------------------------------------------------------------------------------

-- Use A different Database for the Drop to work
USE fudgemart_v3;
GO

-- Drop the Pharmacy Database if it Exists
DROP DATABASE IF EXISTS pharmacy;
GO

-- Create the Pharmacy Database to Host All of Our Project Data
CREATE DATABASE pharmacy;
GO

-- -----------------------------------------------------------------------USE THE NEW DESIGNATED DATABASE----------------------------------------------------------------------------------

USE pharmacy;
GO


-- -------------------------------------------------------------------------------Create Tables--------------------------------------------------------------------------------------------
-- Create Patient Table
CREATE TABLE patients(

    /* Table Attributes */
        
        patient_id           INT IDENTITY NOT NULL,   
        patient_first_name   VARCHAR(100) NOT NULL,   
        patient_last_name    VARCHAR(100) NOT NULL,   
        patient_dob          DATE NOT NULL,  
        patient_email        VARCHAR(50) NOT NULL,   
        patient_phone_number VARCHAR(13) NOT NULL, 
        patient_ssn          VARCHAR(11) NOT NULL, 

    /* CONSTRAINTS */

        -- Primary Key Constraint
        CONSTRAINT pk_patients_patient_id PRIMARY KEY (patient_id), 

        -- Unique Constraint 
        CONSTRAINT u_patients_patient_ssn UNIQUE (patient_ssn) 
);
GO


-- Create Patient Address Table
CREATE TABLE patient_address(

    /* Table Attributes */

        address_pt_id            INT IDENTITY NOT NULL,   
        address_primary_street   VARCHAR(100) NOT NULL,
        address_secondary_street VARCHAR(100) NOT NULL,
        address_city             VARCHAR(100) NOT NULL,
        address_state_id         INT NOT NULL,      
        address_zipcode          VARCHAR(5)   NOT NULL, 

    /* CONSTRAINTS */    

        --  Primary Key Constraint
        CONSTRAINT  pk_patient_address_address_pt_id PRIMARY KEY (address_pt_id)
);
GO


-- Create Patient Address Lookup table
CREATE TABLE patient_address_lookup(

    /* Table Attributes */
        
        patient_id    INT NOT NULL,
        address_pt_id INT NOT NULL,           

    /* CONSTRAINTS */

        -- Primary Key Constraint
        CONSTRAINT  pk_patient_address_lookup_patient_id PRIMARY KEY (patient_id, address_pt_id)
);
GO


-- Create Pharmacy Table
CREATE TABLE pharmacies(

    /* Table Attributes */
        
        pharmacy_id              INT IDENTITY NOT NULL,   
        pharmacy_name            VARCHAR(100) NOT NULL,   
        pharmacy_location_number INT NOT NULL, 

        
    /* CONSTRAINTS */

        -- Primary Key Constraint
        CONSTRAINT  pk_pharmacies_pharmacy_id PRIMARY KEY (pharmacy_id),
);
GO


-- Create Pharmacy Address Table
CREATE TABLE pharmacy_address(

    /* Table Attributes */

        address_ph_id            INT IDENTITY NOT NULL,   
        address_primary_street   VARCHAR(150) NOT NULL,   
        address_secondary_street VARCHAR(150) NOT NULL,   
        address_city             VARCHAR(100) NOT NULL,   
        address_state_id         INT NOT NULL,   
        address_zipcode          VARCHAR(5) NOT NULL,  

    /* CONSTRAINTS */  

        -- Primary Key Constraint
        CONSTRAINT  pk_addresses_ph_addresses_pt_id PRIMARY KEY (address_ph_id) 
);
GO


-- Create Patient Address Lookup table
CREATE TABLE pharmacy_address_lookup(

    /* Table Attributes */
        --
        pharmacy_id     INT NOT NULL,
        address_ph_id   INT NOT NULL,           

    /* CONSTRAINTS */

        -- Primary Key Constraint
        CONSTRAINT pk_patient_address_lookup_pharmacy_pt_address_id PRIMARY KEY (pharmacy_id, address_ph_id) 
);
GO


-- Create Insurance Table
CREATE TABLE insurance(

    /* Table Attributes */

        insurance_id                INT IDENTITY NOT NULL,   
        insurance_name              VARCHAR(100) NOT NULL,   
        insurance_type_id           INT NOT NULL,   
        insurance_copay             MONEY NOT NULL,
        insurance_coverage_amount   MONEY NOT NULL,
        insurance_prescription_code VARCHAR(11) NOT NULL,     

    /* CONSTRAINTS */

        -- Primary Key Constraint
        CONSTRAINT  pk_insurance_insurance_id PRIMARY KEY (insurance_id),  

        -- Unique Constraint 
        CONSTRAINT u_insurance_name UNIQUE (insurance_name) 
);
GO


-- Create Insurance Table
CREATE TABLE patient_insurance_lookup(

    /* Table Attributes */

        patient_id   INT NOT NULL, 
        insurance_id INT NOT NULL,       

    /* CONSTRAINTS */

        -- Primary Key Constraint
        CONSTRAINT  pk_patient_insurance_pt_insurance_id PRIMARY KEY (patient_id, insurance_id)
);
GO

-- Create Insurance Type Table
CREATE TABLE insurance_type(

    /* Table Attributes */
    
        insurance_type_id           INT IDENTITY NOT NULL,
        insurance_type_code         VARCHAR(50) NOT NULL,
        insurance_type_description  VARCHAR(250) NOT NULL,

    /* CONSTRAINTS */

        -- Primary Key Constraint
        CONSTRAINT  pk_insurance_type_insurance_type_id PRIMARY KEY (insurance_type_id)  
);
GO

-- Create Coverage Amount Table
CREATE TABLE coverage_amounts(

    /* Table Attributes */

    coverage_amounts_id          INT IDENTITY NOT NULL,
    coverage_amount              MONEY NOT NULL,
    coverage_amounts_drug_id     INT NOT NULL,
    coverage_amount_insurance_id INT NOT NULL,

    /* CONSTRAINTS */

        -- Primary Key Constraint
        CONSTRAINT  pk_coverage_amounts_coverage_amounts_id PRIMARY KEY (coverage_amounts_id)  
);
GO


-- Create Order Table
CREATE TABLE orders(

    /* Table Attributes */

        order_id            INT IDENTITY NOT NULL,   
        order_date_filled   DATE NOT NULL,  
        order_item_quantity INT NOT NULL, 
        order_patient_id    INT NOT NULL, 
        order_pharmacy_id   INT NOT NULL, 
        
    /* CONSTRAINTS */

        -- Primary Key Constraint
        CONSTRAINT  pk_orders_order_id PRIMARY KEY (order_id),  

        -- Check Constraint
        CONSTRAINT ck_order_item_count_non_negative CHECK (order_item_quantity >= 1)
);
GO


-- Create Order Detail Table 
CREATE TABLE order_item_details(

    /* Table Attributes */

        order_item_id           INT IDENTITY NOT NULL,   
        order_item_number       VARCHAR(8) NOT NULL,   
        order_item_code         INT NOT NULL,   
        order_item_quantity     INT NOT NULL,  
        order_item_cost         MONEY not null,  
        order_item_order_id     INT NOT NULL,  
        order_item_insurace_id  INT NOT NULL,  
        order_item_drug_id      INT NOT NULL,  

    /* CONSTRAINTS */

        -- Primary Key Constraint
        CONSTRAINT  pk_order_item_order_item_id PRIMARY KEY (order_item_id),  

        -- Check Constraint
        CONSTRAINT ck_order_item__detailscount           CHECK (order_item_quantity >= 1),
        CONSTRAINT ck_order_item_details_order_item_cost CHECK (order_item_quantity >= 1) 
);
GO
drop table if exists drugs

-- Create Drug Table
CREATE TABLE drugs(
    
    /* Table Attributes */
        
        drug_id                INT IDENTITY NOT NULL,   
        drug_name              VARCHAR(100) NOT NULL,   
        drug_code              INT NOT NULL,   
        drug_type              VARCHAR(50) NOT NULL,   
        drug_dosage_qty        INT NOT NULL,  
        drug_dosage_uom        VARCHAR(25)  NOT NULL,   
        drug_pack_qty          INT NOT NULL,  
        drug_generic_indicator INT NOT NULL, 
        drug_otc_indicator     INT NOT NULL,  
        drug_price             MONEY NOT NULL,  
        drug_primary_use       VARCHAR(100) NOT NULL,  

    /* CONSTRAINTS */

        -- Primary Key Constraint
        CONSTRAINT  pk_drugs_drug_id PRIMARY KEY (drug_id),  

        -- Unique Constraint 
        CONSTRAINT u_drugs_drug_code UNIQUE (drug_code), 

        -- Check Constraint
        CONSTRAINT ck_drugs_drug_dosage_non_negative   CHECK (drug_dosage_qty >= 0), 
        CONSTRAINT ck_drugs_drug_price_non_negative    CHECK (drug_price >= 0), 
        CONSTRAINT ck_drugs_drug_pack_qty_non_negative CHECK (drug_pack_qty >= 0) 
);
GO


-- Create Inventory Table
CREATE TABLE inventory(

    /* Table Attributes */

        inventory_id            INT IDENTITY NOT NULL,   
        inventory_qty           INT NOT NULL,   
        inventory_pharmacy_id   INT NOT NULL,   
        inventory_drug_id       INT NOT NULL,    

    /* CONSTRAINTS */ 

        -- Primary Key Constraint
        CONSTRAINT  pk_inventory_inventory_id PRIMARY key (inventory_id), 
);
GO


CREATE TABLE state_lookup(

    /* Table Attributes */

        state_id int identity not null,
        state_code VARCHAR(2) NOT NULL,   
        state_name varchar(100) not null,

    /* CONSTRAINTS */

        -- Primary Key Constraint
        CONSTRAINT pk_state_lookup_state_id PRIMARY KEY (state_id),

        -- Unique Constraint 
        CONSTRAINT u_state_lookup_state_name UNIQUE (state_name)
);
GO

-- -------------------------------------------------------------------------------Create Forign Keys---------------------------------------------------------------------------------------

/* Add Foreign Key to the Patient Address Bridge Table */
    -- Patient ID Foreign Key
    ALTER TABLE patient_address_lookup
        ADD CONSTRAINT  fk_patient_address_lookup_patient_id FOREIGN KEY (patient_id)
        REFERENCES patients(patient_id);
    GO

    -- Address ID Foreign Key 
    ALTER TABLE patient_address_lookup
        ADD CONSTRAINT  fk_patient_address_lookup_address_pt_id FOREIGN KEY (address_pt_id)
        REFERENCES patient_address(address_pt_id);
    GO

/* Add Foreign Key to the Patient Address & Pharmacy Address */
    -- State Foreign Key to the 
    ALTER TABLE patient_address 
        ADD CONSTRAINT fk_patient_address_address_state FOREIGN KEY (address_state_id) 
        REFERENCES state_lookup(state_id);
    GO

    -- State Foreign Key to the
    ALTER TABLE pharmacy_address
        ADD  CONSTRAINT fk_apharmacy_address_address_state FOREIGN KEY (address_state_id) 
        REFERENCES state_lookup(state_id); 
    GO

/* Add Foreign Key to Insurance Table */
   -- Insurance Type ID Foreign Key
    ALTER TABLE insurance 
        ADD CONSTRAINT  fk_insurance_insurance_type_id FOREIGN KEY (insurance_type_id)
        REFERENCES insurance_type(insurance_type_id);
GO

/* Add Foreign Key to the Patient Insurance Bridge Table */
    -- Patient ID Foreign Key
    ALTER TABLE patient_insurance_lookup 
        ADD CONSTRAINT  fk_patient_insurance_pt_id FOREIGN KEY (patient_id)
        REFERENCES patients(patient_id);
    GO 

    -- Insurance ID Foreign Key
    ALTER TABLE patient_insurance_lookup 
        ADD CONSTRAINT  fk_patient_insurance_insur_id FOREIGN KEY (insurance_id)
        REFERENCES insurance(insurance_id);
    GO    

/* Add Foreign Keys to the Coverage Amounts Table */
    -- Coverage Amounts Drug ID Foreign Key
    ALTER TABLE coverage_amounts 
        ADD CONSTRAINT  fk_coverage_amounts_coverage_amounts_drug_id FOREIGN KEY (coverage_amounts_drug_id)
        REFERENCES drugs(drug_id);
    GO 

    -- Covereage Amount Insurance ID Foreign Key
    ALTER TABLE coverage_amounts 
        ADD CONSTRAINT  fk_coverage_amounts_coverage_amount_insurance_id FOREIGN KEY (coverage_amount_insurance_id)
        REFERENCES insurance(insurance_id);
    GO 

/* Add Foreign Keys to the Orders Table */
    -- Patient ID Foreign Key
    ALTER TABLE orders 
        ADD CONSTRAINT  fk_orders_order_patient_id FOREIGN KEY (order_patient_id)
        REFERENCES patients(patient_id);
    GO    

    --Pharmacy ID Foreign Key
    ALTER TABLE orders 
        ADD CONSTRAINT  fk_orders_order_pharmacy_id FOREIGN KEY (order_pharmacy_id)
        REFERENCES pharmacies(pharmacy_id);
    GO 

/* Add Foreign Keys to the Order Item Details Table */ 
    -- Order ID Foreign Key
    ALTER TABLE order_item_details 
        ADD CONSTRAINT  fk_order_item_details_order_item_order_id FOREIGN KEY (order_item_order_id)
        REFERENCES orders(order_id);
    GO 

    -- Insurance ID Foreign Key
    ALTER TABLE order_item_details 
        ADD CONSTRAINT  fk_order_item_details_order_item_insurance_id FOREIGN KEY (order_item_insurace_id)
        REFERENCES insurance(insurance_id);
    GO 

    -- Drug ID Foreign Key
    ALTER TABLE order_item_details 
        ADD CONSTRAINT  fk_order_item_details_order_item_drug_id FOREIGN KEY (order_item_drug_id)
        REFERENCES drugs(drug_id);
    GO 

 /* Add Foreign Keys to the Inventory Table */
    -- Pharmacy Foreign Key
    ALTER TABLE inventory  
        ADD CONSTRAINT  fk_inventory_inventory_pharmacy_id FOREIGN KEY (inventory_pharmacy_id)
        REFERENCES pharmacies(pharmacy_id);
    GO 

    -- Insurance ID Foreign Key
    ALTER TABLE inventory 
        ADD CONSTRAINT  fk_inventory_inventory_drug_id FOREIGN KEY (inventory_drug_id)
        REFERENCES drugs(drug_id);
    GO 

-- --------------------------------------------------------------------------INSERT STATEMENTS---------------------------------------------------------------------------------------------

-- Insert Into the State Lookup Table
INSERT INTO state_lookup (state_code, state_name)
VALUES
('NY', 'New York'),
('NJ', 'New Jersey'),
('CA', 'California'),
('AZ', 'Arizona'),
('AK', 'Alaska'),
('AR', 'Arkansas');
GO

-- Select All From state Lookup Table
SELECT * FROM state_lookup;

-- Insert into Insurance Type Table
INSERT INTO insurance_type(insurance_type_description, insurance_type_code)
VALUES
('medicare a',	            'mda'),
('medicare b',	            'mdb'),
('medicare c', 	            'mdc'),
('medicare d',	            'mdd'),
('medicaid a',	            'mca'),
('medicaid b',	            'mcb'),
('medicaid c',	            'mcc'),
('medicaid d',	            'mcd'),
('private ppo',	            'pppo'),
('private hmo',	            'phmo'),
('private pos',	            'ppos'),
('private epo', 	        'pepo'),
('employer provided ppo',	'eppo'),
('employer provided hmo',	'ehmo');
GO

-- Select All from Insurance Type Values for Testing
SELECT * FROM insurance_type;


-- Insert into the Patients Table
INSERT INTO patients(patient_first_name, patient_last_name, patient_dob, patient_email, patient_phone_number, patient_ssn)
VALUES
('Lisa',    'Vanderpump', '4/11/1999',	'lisa@gmail.com',	 '505-444-3333',	'501-11-1234'),
('Taylor',  'Armstrong',  '5/12/1977',	'taylor@gmail.com',	 '505-555-3333',	'501-12-1234'),
('Kim',	    'Richards',	  '6/13/2002',	'kim@gmail.com',	 '505-666-3333',	'501-13-1234'),
('Camille',	'Grammer',    '7/14/1991',	'camille@gmail.com', '505-777-3333',	'501-14-1234');
GO

-- Select All from patients Values for Testing
SELECT * FROM patients;

-- Insert into the Patient Address Table
INSERT INTO patient_address(address_primary_street, address_secondary_street, address_city, address_state_id, address_zipcode)
VALUES
('444 Deaths Door Lane',  '',	'Beverly Hills',	3,	'90210'),
('555 Feeling Good Way',  '',	'Beverly Hills',	3,	'90210'),
('666 Stay Strong Ave',	  '',	'Beverly Hills',	3,	'90210'),
('777 Ambulance Road',	  '',	'Beverly Hills',	3,	'90210');
GO

-- Select All from patient_address Values for Testing
SELECT * FROM patient_address;

-- Insert into the Patient Address Lookup Table
INSERT INTO patient_address_lookup (patient_id, address_pt_id)
VALUES
(1, 4),
(2, 3),
(3, 2),
(4, 1);
GO

-- Select All from Patient Address Lookup Values for Testing
SELECT * FROM patient_address_lookup;

-- Insert into the Pharmacy Table
INSERT INTO pharmacies(pharmacy_location_number, pharmacy_name)
VALUES
(1,	'Never Generic'),
(2,	'No Refills');
GO

-- Select All from Pharmacy Values for Testing
SELECT * FROM pharmacies;

-- Insert into Pharmacy Address Table
INSERT INTO pharmacy_address (address_primary_street, address_secondary_street, address_city, address_state_id, address_zipcode)
VALUES
('777 Pharm Way',	 '', 'Beverly Hills', 3, '90210'),
('888 Get Well Way', '', 'Beverly Hills', 3, '90210');
GO

-- Select All from Pharmacy Values for Testing
SELECT * FROM pharmacy_address;

-- Insert into Pharmacy Address Lookup Table
INSERT INTO pharmacy_address_lookup (pharmacy_id, address_ph_id)
VALUES
(1, 2),
(2, 1);
GO

-- Select All from Pharmacy Address Lookup Values for Testing
SELECT * FROM pharmacy_address_lookup

-- Insert into Drugs Table
INSERT INTO drugs(drug_name, drug_code, drug_type, drug_dosage_qty, drug_dosage_uom, drug_pack_qty, drug_generic_indicator, 
                  drug_otc_indicator, drug_price, drug_primary_use)
VALUES
('Chill Pill',	            555,	'ibuprofen',  100,	'mg',	20,	0,	1, 20,	'Anxiety'),
('Anti-Anxiety Medication',	556,	'ibuprofen',  100,	'mg',	20,	1,	1, 18,	'Anxiety'),
('You Cant Stop The Beat',	557,	'Heart',	   20,	'mg',	30,	0,	0, 55,	  'Heart'),
('Heart Medication',	    558,	'Heart',	   20,	'mg',	30,	1,	0, 35,	  'Heart'),
('NoMore Sneezes',	        559,	'Allergy',	  100,	'mg',	12,	0,	1, 12,	'Allergy'),
('Allergy Tablets',	        560,	'Allergy',	  100,	'mg',	12,	1,	1,	9,	'Allergy'),
('Tums Up',	                561,	'Stomach',	   75,	'mg',	60,	0,	1, 22,	'Stomach'),
('Anti-Acid',	            562,	'Stomach',	   75,	'mg',	60,	1,	1, 18,	'Stomach');
GO

-- Select All from Drugs Values for Testing
SELECT * FROM drugs;

-- Insert into Insurance Table
INSERT INTO insurance(insurance_name, insurance_type_id, insurance_copay, insurance_coverage_amount, insurance_prescription_code)
VALUES
('BCBS',	             '1',	'10',  '500', 'RxBin'),
('Molina',	            '12',	'50',  '250',    'ID'),
('Fidelis',	             '8',	'15',  '714', 'RxGrp'),
('Aetna',	            '10',	'30', '1500', 'RxPCN'),
('Untited Healthcare',	 '4',	'10', '1900',    'ID'),
('MVP',	                '11',	'15', '1550', 'RxBin'),
('Cigna',	            '14',	'20', '2225', 'RxPCN'),
('Aflac',	             '3',	'30', '5500', 'RxGrp'),
('ObamaCare',	        '13',	'10', '3247', 'RxPCN'),
('Excellus',	         '2',	'15',  '900', 'RxGrp'),
('Medicare',	         '9',	'20',  '150', 'RxBin'),
('Medicaid',	         '6',	'50',  '850',    'ID'),
('Affordabale',	         '7',	'10',  '250', 'RxGrp'),
('Humana',	             '5',	'20', '5000', 'RxBin');
GO

-- Select All from Insurance Values for Testing
SELECT * FROM insurance;

-- Insert into Patient Insurance Lookup Table
INSERT INTO patient_insurance_lookup(patient_id, insurance_id)
VALUES 
(1, 7),
(2, 5),
(3, 9),
(4, 2);

-- Select All from Patient Insurance Values for Testing
SELECT * FROM patient_insurance_lookup;
select * from drugs
-- Insert into Coverage Amount Table
INSERT INTO coverage_amounts(coverage_amount, coverage_amounts_drug_id, coverage_amount_insurance_id)
VALUES
(18, 1,  7),
(18, 2,  5), 
(35, 3,  9),
(12, 4,  2),
(9,  5,  3),
(7, 6,  4),
(18, 7, 13), 
(18, 8, 7), 
(10, 5, 5), 
(7, 6, 5), 
(18, 7, 3);

--delete from coverage_amounts where coverage_amounts_drug_id <> 13
-- Select All from Coverage Amount Values for Testing
SELECT * FROM coverage_amounts;

-- Insert into Inventory Table
INSERT INTO inventory(inventory_qty, inventory_pharmacy_id, inventory_drug_id)
VALUES
(10, 1, 1),
(19, 2, 2),
( 5, 1, 3),
(21, 2, 4),
( 9, 1, 5),
(14, 2, 6),
(20, 1, 7),
( 5, 2, 1),
(41, 1, 2),
(20, 2, 3),
( 7, 1, 4),
(37, 2, 5),
(49, 1, 6),
(23, 2, 7),
(11, 1, 8),
(10, 2, 8);


-- Select All from Inventory Values for Testing
SELECT * FROM inventory;

-- Insert into Orders Table
INSERT INTO orders(order_date_filled, order_item_quantity, order_patient_id, order_pharmacy_id)
VALUES
('5/15/2024',	'3',	'1',	'1'),
('5/15/2024',	'1',	'2',	'2'),
('5/15/2024',	'1',	'3',	'1'),
('5/15/2024',	'1',	'4',	'2'),
('5/16/2024',	'4',	'1',	'1');
GO

-- Select All from Orders Values for Testing
SELECT * FROM orders;

-- Insert into Orders Detail Table
INSERT INTO order_item_details(order_item_number, order_item_code, order_item_quantity, order_item_cost, order_item_order_id, 
                               order_item_insurace_id, order_item_drug_id)
VALUES
(1,	12345, 1,	20,	1,	7,	1),
(2,	12354, 1,	18,	2,	5,	2),
(3,	12387, 1,	55,	3,	9,	3),
(1,	12398, 1,	35,	4,	2,	4),
(1,	98712, 1,	12,	1,	3,	5),
(1,	76523, 1,	9,	2,	4,	6),
(1,	96392, 1,	22,	3,	13,	7),
(2,	67392, 1,	18,	4,	7,	8),
(3,	19386, 1,	12,	5,	5,	5),
(4,	10975, 1,	22,	1,	3,	7);
GO

-- Select All from Orders Detail Values for Testing
SELECT * FROM order_item_details;

 /* Views */

 DROP VIEW IF EXISTS v_drugs
GO

CREATE VIEW  v_drugs 
AS SELECT
drug_id,
drug_name, 
drug_code, 
drug_type, 
drug_dosage_qty, 
drug_dosage_uom, 
drug_pack_qty, 
drug_generic_indicator, 
drug_otc_indicator, 
drug_price, 
drug_primary_use
from drugs

GO


 DROP VIEW IF EXISTS v_patients
GO

CREATE VIEW  v_patients
AS SELECT
patient_id,   
patient_first_name,
patient_last_name,
CONCAT(patient_first_name, ' ',patient_last_name) as patient_full_name,
patient_dob, 
patient_email,
patient_phone_number,
patient_ssn
from patients

GO

 DROP VIEW IF EXISTS v_patient_address

GO

CREATE VIEW  v_patient_address 
AS 
SELECT
address_pt_id,   
address_primary_street,
address_secondary_street,
address_city,
s.state_code,
address_zipcode, 
CONCAT (address_primary_street,' ' , address_city, ', ', s.state_code, ' ',address_zipcode ) as patient_full_address
from patient_address pa
left join state_lookup s on pa.address_state_id= s.state_id
GO

select * from v_patient_address
DROP VIEW IF EXISTS v_patient_address_lookup

GO

CREATE VIEW  v_patient_address_lookup
AS 
SELECT
patient_id,
address_pt_id      

from patient_address_lookup

GO

DROP VIEW IF EXISTS v_insurance

GO

CREATE VIEW  v_insurance
AS 
SELECT
insurance_id,   
insurance_name,   
insurance_type_id,   
insurance_copay,
insurance_coverage_amount,
insurance_prescription_code

from insurance

GO



DROP VIEW IF EXISTS v_patient_insurance_lookup

GO

CREATE VIEW  v_patient_insurance_lookup
AS 
SELECT
patient_id, 
insurance_id 

from patient_insurance_lookup

GO


DROP VIEW IF EXISTS v_insurance_type

GO

CREATE VIEW  v_insurance_type
AS 
SELECT
insurance_type_id,
insurance_type_code,
insurance_type_description

from insurance_type

GO

DROP VIEW IF EXISTS v_inventory

GO

CREATE VIEW  v_inventory
AS 
SELECT
inventory_id,   
inventory_qty,   
inventory_pharmacy_id,   
inventory_drug_id

from inventory

GO




DROP VIEW IF EXISTS v_orders

GO

CREATE VIEW  v_orders
AS 
SELECT
order_id,   
order_date_filled,  
order_item_quantity, 
order_patient_id, 
order_pharmacy_id

from orders

GO

DROP VIEW IF EXISTS v_order_item_details

GO

CREATE VIEW  v_order_item_details
AS 
SELECT
order_item_id,   
order_item_number,   
order_item_code,   
order_item_quantity,  
order_item_cost,  
order_item_order_id,  
order_item_insurace_id,  
order_item_drug_id, 
ca.coverage_amount

from order_item_details oid
left join coverage_amounts ca on oid.order_item_drug_id=ca.coverage_amounts_drug_id  AND oid.order_item_insurace_id=ca.coverage_amount_insurance_id

GO

DROP VIEW IF EXISTS v_pharmacies  

GO
 
CREATE VIEW v_pharmacies
AS SELECT 
pharmacy_id, 
pharmacy_name,
pharmacy_location_number,
CONCAT(pharmacy_location_number, ' ', pharmacy_name) as pharmacy_full_name

from pharmacies 

GO


DROP VIEW IF EXISTS v_pharmacy_address

GO
 
CREATE VIEW v_pharmacy_address
AS SELECT 
address_ph_id,   
address_primary_street,   
address_secondary_street,   
address_city,   
s.state_code,   
address_zipcode, 
CONCAT (address_primary_street,' ' , address_city, ', ', s.state_code, ' ',address_zipcode ) as pharmacy_full_address   
from pharmacy_address pa
left join state_lookup s on pa.address_state_id= s.state_id


GO
select * from v_pharmacy_address

DROP VIEW IF EXISTS v_pharmacy_address_lookup 

GO
 
CREATE VIEW v_pharmacy_address_lookup
AS SELECT 
pharmacy_id,
address_ph_id 

from pharmacy_address_lookup

GO



