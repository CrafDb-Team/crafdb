-- liquibase formatted sql

-- changeset lbradford:table-customer-creation
CREATE TABLE "Customer" (
  "CustomerID" serial PRIMARY KEY,
  "Name" varchar NON NULL,
  "Email" varchar NON NULL,
  "ContactNumber" varchar NON NULL
);
-- rollback DROP TABLE Customer;