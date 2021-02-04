-- Procedures
SET SERVEROUTPUT ON 
-- find customer and output 1 if it's found and 0 if it's not
CREATE OR REPLACE PROCEDURE find_customer(customer_id IN NUMBER, found OUT NUMBER) AS
temp_cust_no customers.cust_no%type;
BEGIN
    SELECT customers.cust_no /*INTO temp_cust_no*/ FROM customers 
    WHERE customers.cust_no = find_employee.customer_id;
    IF sql%rowcount > 0 THEN
        found:= 1;
    END IF;
    EXCEPTION
        WHEN no_data_found THEN
            found := 0;
END;
/
DECLARE
    found NUMBER;
BEGIN
    
    find_employee(1002, found);
     DBMS_OUTPUT.PUT_LINE(found);
END;
/

/***********************************************************************************************/

-- find_product by its id and output its price
CREATE OR REPLACE PROCEDURE find_product(product_id IN NUMBER, price OUT products.prod_sell%type) AS

BEGIN
    SELECT products.prod_sell INTO find_product.price
    FROM products
    WHERE products.prod_no = product_id;
    EXCEPTION
        WHEN no_data_found THEN
            price := 0;  
END;
/
DECLARE price products.prod_sell%type;
BEGIN
    find_product(60500, price);
    DBMS_OUTPUT.PUT_LINE('The price for this product is: ' || price);
END;
/

/***********************************************************************************************/
-- Procedure 3
-- Add a new order with the customer_no (passed by the user), new order_no (max(order_id)+1), 
-- hard coded: status = 'Shipped', rep_no = 56, order_dt = sysdate
-- output the new_order_id
CREATE OR REPLACE PROCEDURE add_order(customer_id IN NUMBER, new_order_id OUT NUMBER)AS
BEGIN
    SELECT MAX(orders.order_no) INTO new_order_id 
    FROM orders;
    new_order_id := new_order_id +1;
    
    INSERT INTO orders
    (order_no, rep_no, cust_no, order_dt, status)
    VALUES
    (new_order_id, customer_id, 'C', 36, to_char(sysdate,'dd-Mon-yyyy'));
END;
/

DECLARE morder NUMBER;
BEGIN
    add_order(1107, morder);
    DBMS_OUTPUT.PUT_LINE('The order [' || morder || '] was added.');
END;
/
rollback;

/***********************************************************************************************/
-- Procedure 4
-- Add an order in the ORDERLINES table with the procedure parameters
CREATE OR REPLACE PROCEDURE add_order_item (orderID IN orderlines.order_no%type,
                                  lineID IN orderlines.line_no%type,
                                  productID IN orderlines.prod_no%type,
                                  quant IN orderlines.qty%type,
                                  m_price IN orderlines.price%type) AS
BEGIN
    INSERT INTO orderlines 
    (order_no, line_no, prod_no, price, qty)
    VALUES 
    (orderID, lineID, productID, m_price, quant);

EXCEPTION
    WHEN others THEN
    DBMS_OUTPUT.PUT_LINE('Error: Trying to insert a wrong value!');
END;
/
exec add_order_item(1, 7, 60401, 1000, 40);
/
rollback;

