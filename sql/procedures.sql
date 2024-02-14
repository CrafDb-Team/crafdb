--liquibase formatted sql

--changeset emokoena:CreateOderItemsForCustomerOrder
CREATE PROCEDURE CreateOderItemsForCustomerOrder(
   customer_id int,
   beer_id int,  
   quantity int,
   order_id int
)
LANGUAGE plpgsql    
AS 
$$
BEGIN
    INSERT INTO OrderItem oi
    SELECT 
END;
$$;

-- rollback DROP PROCEDURE IF EXISTS CreateOderItemsForCustomerOrder(INTEGER,INTEGER,INTEGER,INTEGER);
