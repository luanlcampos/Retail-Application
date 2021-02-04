# Retail Application

A simple retail application created with C++ and Oracle PL/SQL. 

Stored procedures were implemented in the database, nd then called in the C++ application.

## Stored Procedures List

### find_customer

This procedure receives an integer number in the parameter and returns a number.  It looks for a inputted customer ID in the database. If the customer is found, the procedure returns 0. Otherwise, it will return 1.

###  find_product

This procedure receives an integer in the parameter list and also returns a number.

find_product receives an product ID and it will search for this product in the database. If the product is found, the procedure will return the product price. If the product ID does not exist in the database, the procedure will return 0.

### add_order

This procedure receives a number in the parameter list and return a number.

add_order receives the customer ID and creates a new order with to the customer if it exists in the database.  For the purpose of this application, some properties are being hardcoded in the procedure. 

The procedure returns the new order id if everything works well.

### add_orderline

This procedure will add a new order line into the system. It receives 5 parameters and insert them into the database.

