-- liquibase formatted sql

-- changeset batandwa:order-items-table
CREATE TABLE "OrderItem" (
  "OrderItemID" serial PRIMARY KEY,
  "OrderID" integer NOT NULL,
  "KegID" integer NOT NULL,
  "OrderItemStateID" integer NOT NULL,
  "PriceAtSale" numeric NOT NULL
);
-- rollback DROP TABLE "OrderItem";

-- changeset batandwa:create-order-items-status-table
CREATE TABLE "OrderItemState" (
  "OrderItemStateID" serial PRIMARY KEY,
  "OrderState" varchar(32) NOT NULL
);
-- rollback DROP TABLE "OrderItemState";
