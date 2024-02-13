--liquibase formatted sql

--changeset emokoena:create-count-unsold-kegs-from-batch
CREATE FUNCTION CountUnsoldKegsFromBatch(batch_id INT)
RETURNS INT
LANGUAGE plpgsql
AS
$$
DECLARE
    remaining_kegs_from_batch INTEGER;
BEGIN
    SELECT count(*) 
    INTO remaining_kegs_from_batch
    FROM Batch bt
    INNER JOIN KEG kg on bt.BatchID = kg.BatchID
    LEFT JOIN OrderItem oi on kg.KegID = oi.KegID
    WHERE bt.BatchID = batch_id
    AND oi.OrderID IS NULL;
    
    RETURN remaining_kegs_from_batch;
END;
$$;
-- rollback DROP FUNCTION IF EXISTS remaining_kegs_from_batch(INTEGER);
