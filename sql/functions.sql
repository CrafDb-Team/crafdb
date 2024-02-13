--liquibase formatted sql

--changeset emokoena:create-count-unsold-kegs-of-
CREATE FUNCTION CountUnsoldKegsOfBeer(beer_id INT)
RETURNS INT
LANGUAGE plpgsql
AS
$$
DECLARE
    remaining_kegs_of_beer INTEGER;
BEGIN
    SELECT count(*) 
    INTO remaining_kegs_of_beer
    FROM Beer br
    INNER JOIN Batch bt on bt.BatchID = br.BatchID
    INNER JOIN KEG kg on bt.BatchID = kg.BatchID
    LEFT JOIN OrderItem oi on kg.KegID = oi.KegID
    WHERE bt.BatchID = batch_id
    AND oi.OrderID IS NULL;
    
    RETURN remaining_kegs_of_beer;
END;
$$;
-- rollback DROP FUNCTION IF EXISTS CountUnsoldKegsOfBeer(INTEGER);
