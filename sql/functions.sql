--liquibase formatted sql

--changeset emokoena:func-create-count-unsold-kegs-of-beer runOnChange:true
CREATE OR REPLACE FUNCTION "funcCountUnsoldKegsOfBeer"(beer_id integer)
RETURNS integer
LANGUAGE plpgsql
AS
'
DECLARE
    remaining_kegs_of_beer integer;
BEGIN
    SELECT count(*) 
    INTO remaining_kegs_of_beer
    FROM "Beer" br
    INNER JOIN "Batch" bt on bt."BeerID" = br."BeerID"
    INNER JOIN "Keg" kg on bt."BatchID" = kg."BatchID"
    LEFT JOIN "OrderItem" oi on kg."KegID" = oi."KegID"
    WHERE bt."BeerID" = beer_id
    AND "ExpiryDate" > CURRENT_DATE 
	AND (oi."OrderID" IS NULL
    OR oi."OrderItemStateID" NOT IN (1, 2, 3, 4));

    RETURN remaining_kegs_of_beer;
END;
';

-- rollback DROP FUNCTION IF EXISTS "funcCountUnsoldKegsOfBeer"(integer);


--changeset emokoena:func-beer-name-to-id runOnChange:true
CREATE OR REPLACE FUNCTION "funcBeerNameToID"(beer_name varchar, beer_type varchar)
RETURNS integer
LANGUAGE plpgsql
AS
'
DECLARE
    beer_id integer;
BEGIN
    SELECT br."BeerID"
    INTO beer_id
    FROM "Beer" br
    LEFT JOIN "BeerType" bt ON br."BeerTypeID" = bt."BeerTypeID"
    WHERE br."BeerName" = beer_name
    AND bt."BeerType" = beer_type;

	RETURN beer_id;
END;
';
-- rollback DROP FUNCTION IF EXISTS "funcBeerNameToID"(varchar);

--changeset batandwa:func-order-item-state-name-to-id runOnChange:true
CREATE OR REPLACE FUNCTION "funcOrderItemStateNameToID" (statusName varchar)
RETURNS INT
LANGUAGE plpgsql
AS '
DECLARE statusID INT;
BEGIN
	SELECT "OrderItemStateID"
	INTO statusID
		FROM "OrderItemState"
			WHERE "OrderState" = statusName;

    RETURN statusID;
END;
';

-- rollback DROP FUNCTION IF EXISTS "funcOrderItemStateNameToID"(varchar);

--changeset batandwa:func-beer-type-id-to-name runOnChange:true
CREATE OR REPLACE FUNCTION "funcBeerTypeIDToName" (typeId INT)
RETURNS varchar
LANGUAGE plpgsql
AS '
DECLARE outName varchar;
BEGIN
	SELECT "BeerType"
	INTO outName
		FROM "BeerType"
			WHERE "BeerTypeID" = typeId;

    RETURN outName;
END;
';

-- rollback DROP FUNCTION IF EXISTS "funcBeerTypeNameToID"(varchar);

--changeset batandwa:func-compute-sales runOnChange:true
CREATE OR REPLACE FUNCTION "funcComputeSales" (startDate timestamp, endDate timestamp)
RETURNS TABLE("beerName" varchar, "beerType" varchar, "beerID" INT, "soldQuantity" INT)
LANGUAGE plpgsql
AS '
BEGIN
	RETURN QUERY
		SELECT "Beer"."BeerName", "funcBeerTypeIDToName"("Beer"."BeerTypeID") AS "BeerType", "Beer"."BeerID", COUNT(*) AS "SoldQuantity"
			FROM "OrderItem"
				INNER JOIN "Order" ON "OrderItem"."OrderID" = "Order"."OrderID"
				INNER JOIN "Keg" ON "Keg"."KegID" = "OrderItem"."KegID"
				INNER JOIN "Batch" ON "Batch"."BatchID" = "Keg"."BatchID"
				RIGHT JOIN "Beer" ON "Beer"."BeerID" = "Batch"."BeerID"
			WHERE "Order"."CreatedOn" >= startDate
				AND "Order"."CreatedOn" < endDate
				AND "OrderItem"."OrderItemStateID" != "funcOrderItemStateNameToID"("Canceled")
				AND "OrderItem"."OrderItemStateID" != "funcOrderItemStateNameToID"("Returned with Defect")
				AND "OrderItem"."OrderItemStateID" != "funcOrderItemStateNameToID"("Returned without Defect")
		GROUP BY "Beer"."BeerID";
END;
';

-- rollback DROP FUNCTION IF EXISTS "funcComputeSales"(timestamp, timestamp);
