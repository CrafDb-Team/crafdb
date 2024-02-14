--liquibase formatted sql

--changeset ljordaan:create-beer-type-table
CREATE TABLE "BeerType" (
  "BeerTypeID" serial PRIMARY KEY,
  "BeerType" varchar NOT NULL
);
-- rollback DROP TABLE "BeerType";

--changeset ljordaan:create-beer-table
CREATE TABLE "Beer" (
  "BeerID" serial PRIMARY KEY,
  "BeerName" varchar NOT NULL,
  "BeerDesc" varchar NOT NULL,
  "BeerTypeID" integer NOT NULL,
  "PricePerKeg" numeric NOT NULL
);
-- rollback DROP TABLE "Beer";