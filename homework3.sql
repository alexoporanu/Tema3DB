create table customers(
	id int auto_increment, 
    username varchar(50),
    last_name varchar(50),
    first_name varchar(50),
    phone varchar(50),
    address varchar(50),
    city varchar(50),
    postalCode varchar(15),
    country varchar(50),
    constraint pk primary key (id)
);

create table products(
	code varchar(15),
    name varchar(70),
    description text,
    stock smallint,
    price decimal(10, 2),
    constraint pk2 primary key (code)
);

create table orders (
	id int,
    order_date date,
    shipped_date date,
    status varchar(15),
    comments text,
    customer_id int,
    constraint fk foreign key (customer_id) references customers(id),
    constraint pk3 primary key (id)
);

create table orderdetails(
	id int,
    product_code varchar(15),
    quantity int, 
    priceEach decimal(10, 2),
    constraint fk4 foreign key (product_code) references products(code) 
	,
    constraint fk5 foreign key (id) references orders(id)
);


create table payments (
	customer_id int,
	payment_date date,
    amount decimal(10, 2),
    constraint fk6 foreign key (customer_id) references customers(id)
);

select * from customers;

insert into customers (username, last_name, first_name, phone, address, city, postalCode, country)
	values ('alex', 'Oporanu', 'Alexandru', '03123131', 'la lal a', 'Craiova', '312312', 'Romania');
insert into customers (username, last_name, first_name, phone, address, city, postalCode, country)
	values ('aaalex', 'Popescu', 'Alexandru', '231312', 'la lal a', 'Buc', '0001', 'Romania');
insert into customers (username, last_name, first_name, phone, address, city, postalCode, country)
	values ('alex', 'Oporanu', 'Ion', '123213', 'la lal a', 'Buc', '11', 'Romania');
insert into customers (username, last_name, first_name, phone, address, city, postalCode, country)
	values ('aalex', 'Ionescu', 'Alexandru', '123312', 'la lal a', 'Craiova', '333', 'Romania');
insert into customers (username, last_name, first_name, phone, address, city, postalCode, country)
	values ('adasalex', 'Georgescu', 'Alexandru', '3123', 'la lal a', 'Craiova', '31231212', 'Romania');
    
delete  from customers;
select * from customers;


/*
	update the status of one order
*/

update orders 
set status = 'not finished'
where id = 32;

/*
	add comments to one order
*/

update orders 
set comments = 'not finished'
where id = 32;

/*
View all customers from the city "Buc"
*/
select * from customers where city = 'Buc';

insert into orders(id, order_date, shipped_date, status, comments, customer_id)
	values(32, NOW(), NOW(), 'finished', 'very good', 3);
    
    
select * from orders where customer_id = 3;


/*
When placing an order update the stock for the products – try to implement with a small number of queries and explain your choice

Ok, so I will insert a new line in the orders table, and using joining I will decrease the stock of a given product with 1
*/

select * from orders;

insert into orders (id, order_date, shipped_date, status, comments, customer_id)
	values(1031321, NOW(), NOW(), 'xaxsaxas', 'xacadadsa', 1);
    
    
select * from orders;

select * from orderdetails;

select * from products;

/* This is where I literally solve the task */

insert into products(code, name, description, stock, price)
	values(100, 'Milk', 'Milk very good', 100, 10);

insert into orderdetails(id, product_code, quantity, priceEach)
	values(1031321,  100, 2, 3);
    
/* am facut un simplu join, m am uitat ce produs are product coded
		ul ca cel din ultima comanda adaugata, si pentru acel
        produs am micsorat stock-ul cu cantitatea comandata
*/
update products 
left join orderdetails on products.code = orderdetails.product_code
left join orders on orderdetails.id = orders.id
set products.stock = products.stock - orderdetails.quantity
where orders.id = 1031321;

select * from products;

    

