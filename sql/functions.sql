--liquibase formatted sql

--changeset emokoena:create-count-unsold-kegs-of-beer
CREATE FUNCTION CountUnsoldKegsOfBeer(beer_id integer)
RETURNS integer
LANGUAGE plpgsql
AS
$$
DECLARE
    remaining_kegs_of_beer integer;
BEGIN
    SELECT count(*) 
    INTO remaining_kegs_of_beer
    FROM Beer br
    INNER JOIN Batch bt on bt.BatchID = br.BatchID
    INNER JOIN KEG kg on bt.BatchID = kg.BatchID
    LEFT JOIN OrderItem oi on kg.KegID = oi.KegID
    WHERE bt.BeerID = beer_id
    AND oi.OrderID IS NULL;

    RETURN remaining_kegs_of_beer;
END;
$$;
-- rollback DROP FUNCTION IF EXISTS CountUnsoldKegsOfBeer(integer);