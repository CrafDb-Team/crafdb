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
    FROM Beer br
    INNER JOIN "Batch" bt on bt."BatchID" = br."BatchID"
    INNER JOIN "KEG" kg on bt."BatchID" = kg."BatchID"
    LEFT JOIN "OrderItem" oi on kg."KegID" = oi."KegID"
    WHERE bt."BeerID" = beer_id
    AND oi."OrderID" IS NULL
    OR oi."OrderItemStateID" NOT IN (1, 2, 3, 4);

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
    SELECT br."BeerId"
    INTO beer_id
    FROM "Beer" br
    LEFT JOIN "BeerType" bt ON br."BeerTypeID" = bt."BeerTypeID"
    WHERE br."BeerName" = beer_name
    AND bt."BeerType" = beer_type;

EXCEPTION
    WHEN no_data_found THEN
        RAISE EXCEPTION ''No beer with name % found'', beer_name;

RETURN beer_id;

END;
';
-- rollback DROP FUNCTION IF EXISTS "funcBeerNameToID"(varchar);
