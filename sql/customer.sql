-- liquibase formatted sql

-- changeset lbradford:table-customer-creation
CREATE TABLE "Customer" (
  "CustomerID" serial PRIMARY KEY,
  "Name" varchar NOT NULL,
  "Email" varchar NOT NULL,
  "ContactNumber" varchar NOT NULL
);
-- rollback DROP TABLE Customer;