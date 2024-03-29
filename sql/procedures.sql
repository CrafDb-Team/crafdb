--liquibase formatted sql

--changeset emokoena:proc-create-order-items-for-customer-order runOnChange:true
CREATE OR REPLACE PROCEDURE "procCreateOrderItemsForCustomerOrder"(
   beer_id integer,  
   order_id integer,
   inout quantity integer
)
LANGUAGE plpgsql    
AS 
'
BEGIN
    IF quantity < 0 THEN
        RAISE EXCEPTION ''Quantity % is invalid, value cannot be negative'', quantity;
    END IF;

    INSERT INTO "OrderItem"("OrderID", "KegID", "OrderItemStateID", "PriceAtSale")
    SELECT 
        order_id,
        kg."KegID",
        1,
        br."PricePerKeg"
    FROM "Keg" kg
    INNER JOIN "Batch" bt on bt."BatchID" = kg."BatchID"
	INNER JOIN "Beer" br on br."BeerID" = bt."BeerID"
    WHERE NOT EXISTS (
        SELECT 
            oi."KegID", 
            oi."OrderItemStateID" 
        FROM "OrderItem" oi 
        WHERE oi."KegID" = kg."KegID"
        AND oi."OrderItemStateID" IN (1, 2, 3, 4)
    )
    AND br."BeerID" = beer_id
    AND kg."ExpiryDate" > CURRENT_DATE
    LIMIT quantity;

    GET DIAGNOSTICS quantity := ROW_COUNT;
    COMMIT;
END;
';

-- rollback DROP PROCEDURE IF EXISTS "procCreateOrderItemsForCustomerOrder"(INTEGER,INTEGER,INTEGER);
