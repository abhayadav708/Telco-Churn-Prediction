CREATE TABLE customers (
    customer_id VARCHAR(20) PRIMARY KEY,
    gender VARCHAR(10),
    senior_citizen BIT,
    partner BIT,
    dependents BIT,
    tenure INT,
    churn BIT
);
CREATE TABLE transactions (
    transaction_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id VARCHAR(20),
    transaction_date DATE,
    amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE customer_support (
    ticket_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id VARCHAR(20),
    issue_type VARCHAR(50),
    resolution_time INT,
    resolved BIT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE plans (
    customer_id VARCHAR(20) PRIMARY KEY,
    contract_type VARCHAR(50),
    internet_service VARCHAR(50),
    monthly_charges DECIMAL(10,2),
    total_charges DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

SELECT * FROM customers WHERE churn = 1;  -- means TRUE
INSERT INTO customers VALUES ('C001', 'Male', 0, 1, 0, 12, 1);


BULK INSERT customer
FROM 'C:\Users\91708\Downloads\archive\WA_Fn-UseC_-Telco-Customer-Churn.csv'
WITH (
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '\n',
  FIRSTROW = 2
);


CREATE TABLE churn_raw (
    customerID VARCHAR(50),
    gender VARCHAR(10),
    SeniorCitizen VARCHAR(5),
    Partner VARCHAR(5),
    Dependents VARCHAR(5),
    tenure VARCHAR(10),
    PhoneService VARCHAR(10),
    MultipleLines VARCHAR(20),
    InternetService VARCHAR(20),
    OnlineSecurity VARCHAR(20),
    OnlineBackup VARCHAR(20),
    DeviceProtection VARCHAR(20),
    TechSupport VARCHAR(20),
    StreamingTV VARCHAR(20),
    StreamingMovies VARCHAR(20),
    Contract VARCHAR(20),
    PaperlessBilling VARCHAR(5),
    PaymentMethod VARCHAR(30),
    MonthlyCharges VARCHAR(20),
    TotalCharges VARCHAR(20),
    Churn VARCHAR(5)
);

BULK INSERT churn_raw
FROM 'C:\Users\91708\Downloads\archive\WA_Fn-UseC_-Telco-Customer-Churn.csv'
WITH (
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '\n',
  FIRSTROW = 2
);

INSERT INTO customers (
    customer_id, gender, senior_citizen, partner, dependents, tenure, churn
)
SELECT 
    customerID,
    gender,
    CAST(SeniorCitizen AS BIT),
    CASE WHEN Partner = 'Yes' THEN 1 ELSE 0 END,
    CASE WHEN Dependents = 'Yes' THEN 1 ELSE 0 END,
    CAST(tenure AS INT),
    CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END
FROM churn_raw;


SELECT 
  c.customer_id,
  p.contract_type,
  p.internet_service,
  p.monthly_charges,
  COUNT(s.ticket_id) AS support_tickets,
  c.churn
FROM customers c
LEFT JOIN plans p ON c.customer_id = p.customer_id
LEFT JOIN customer_support s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, p.contract_type, p.internet_service, p.monthly_charges, c.churn;

SELECT TOP 10 * FROM plans;

SELECT DISTINCT customer_id FROM customers
EXCEPT
SELECT DISTINCT customer_id FROM plans;


INSERT INTO plans (customer_id, contract_type, internet_service, monthly_charges, total_charges)
SELECT 
    customerID,
    Contract,
    InternetService,
    TRY_CAST(MonthlyCharges AS DECIMAL(10,2)),
    TRY_CAST(NULLIF(TotalCharges, '') AS DECIMAL(10,2))
FROM churn_raw;



SELECT 
    c.customer_id,
    p.contract_type,
    p.internet_service,
    p.monthly_charges,
    COUNT(s.ticket_id) AS support_tickets,
    c.churn
FROM customers c
LEFT JOIN plans p ON c.customer_id = p.customer_id
LEFT JOIN customer_support s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, p.contract_type, p.internet_service, p.monthly_charges, c.churn;


INSERT INTO customer_support (customer_id, issue_type, resolution_time, resolved)
SELECT 
  customer_id,
  'Billing Issue',
  FLOOR(RAND(CHECKSUM(NEWID())) * 72),  -- random 0–72 hrs
  CASE WHEN RAND(CHECKSUM(NEWID())) > 0.2 THEN 1 ELSE 0 END
FROM customers
WHERE churn = 1;  -- Add support issues only for churned customers


-- SELECT * FROM churn_features; -- Table does not exist, so this line is commented out or remove after creating the table/view.

GO

CREATE VIEW churn_features AS
SELECT 
  c.customer_id,
  p.contract_type,
  p.internet_service,
  p.monthly_charges,
  COUNT(s.ticket_id) AS support_tickets,
  c.churn
FROM customers c
LEFT JOIN plans p ON c.customer_id = p.customer_id
LEFT JOIN customer_support s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, p.contract_type, p.internet_service, p.monthly_charges, c.churn;

GO

SELECT * FROM churn_features;

SELECT * FROM churn_features;

