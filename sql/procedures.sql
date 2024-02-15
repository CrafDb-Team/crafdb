--liquibase formatted sql

--changeset emokoena:proc-create-order-items-for-customer-order runOnChange:true
CREATE OR REPLACE PROCEDURE ProcCreateOderItemsForCustomerOrder(
   beer_id integer,  
   order_id integer,
   inout quantity integer
)
AS 
$$
BEGIN
    INSERT INTO OrderItem("OrderID", "KegID", "OrderItemStateID", "PriceAtSale")
    SELECT 
        "order_id",
        kg."KegID",
        0,
        br."PricePerKeg"
    FROM "Keg" kg
    INNER JOIN "Beer" br on br."BeerID" = kg."BeerID"
    WHERE NOT EXISTS (
        SELECT 
            oi."KegID", 
            oi."OrderItemStateID" 
        FROM "OrderItem" oi 
        WHERE oi."KegID" = kg."KegID"
        AND oi."OrderItemStateID" IN (1, 2, 3, 4)
    )
    AND kg."BeerID" = "beer_id"
    AND kg."ExpiryDate" > CURRENT_DATE
    LIMIT "quantity";

    GET DIAGNOSTICS "quantity" := ROW_COUNT;
    COMMIT;
END;
$$ LANGUAGE plpgsql;   

-- rollback DROP PROCEDURE IF EXISTS ProcCreateOderItemsForCustomerOrder(INTEGER,INTEGER,INTEGER);
