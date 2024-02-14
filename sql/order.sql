-- liquibase formatted sql

-- changeset batandwa:create-orders-table
CREATE TABLE "Order" (
  "OrderID" serial PRIMARY KEY,
  "CustomerID" integer NOT NULL,
  "CreatedOn" timestamp NOT NULL
);
-- rollback DROP TABLE "Order";