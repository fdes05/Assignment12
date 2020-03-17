create database pizza_restaurant;

use pizza_restaurant;
create table customers(
customer_id int not null auto_increment,
first_name varchar(25),
last_name varchar(50),
address varchar(100),
phone_nbr varchar(20),
primary key (`customer_id`)
);

create table orders(
order_id int not null auto_increment,
date_time datetime,
customer_id int,
primary key (order_id),
foreign key (customer_id) references customers(customer_id)
);

create table pizzas(
pizza_id int not null auto_increment,
`name` varchar(50),
price decimal(4, 2),
primary key (pizza_id)
);

create table pizza_orders(
order_id int,
pizza_id int,
foreign key(order_id) references orders(order_id),
foreign key(pizza_id) references pizzas(pizza_id)
);

insert into customers(first_name, last_name, address, phone_nbr)
values('Trevor', 'Page', '5 Musketeer Way, Los Angeles', '226-555-4982');
insert into customers(first_name, last_name, address, phone_nbr)
values('John', 'Doe', '55 Tesla Road, San Francisco', '555-555-9498');

insert into orders(date_time, customer_id)
values('2014-09-10 9:47:00', 1);
insert into orders(date_time, customer_id)
values('2014-09-10 13:20:00', 2);
insert into orders(date_time, customer_id)
values('2014-09-10 9:47:00', 1);
insert into orders(date_time, customer_id)
values('2014-09-11 19:47:00', 1);

insert into pizzas(`name`, price)
values('Pepperoni & Cheese', 7.99);
insert into pizzas(`name`, price)
values('Vegetarian', 9.99);
insert into pizzas(`name`, price)
values('Meat Lovers', 14.99);
insert into pizzas(`name`, price)
values('Hawaiian', 12.99);

insert into pizza_orders(order_id, pizza_id)
values(1, 1);
insert into pizza_orders(order_id, pizza_id)
values(1, 3);
insert into pizza_orders(order_id, pizza_id)
values(2, 2);
insert into pizza_orders(order_id, pizza_id)
values(2, 3);
insert into pizza_orders(order_id, pizza_id)
values(3, 3);
insert into pizza_orders(order_id, pizza_id)
values(3, 4);
insert into pizza_orders(order_id, pizza_id)
values(4, 2);

-- Q4 How much did each customer spend at restaurant --
SELECT first_name, last_name, sum(price) FROM pizza_restaurant.customers c
join orders o on o.customer_id = c.customer_id
join pizza_orders po on po.order_id = o.order_id
join pizzas p on p.pizza_id = po.pizza_id
group by c.customer_id;

-- Q5 Modify Q4 to separate orders by customer and date --
-- Trevor, had to add another order (order_id 4) to this as your instructions --
-- had three orders all on the same date --

SELECT first_name, last_name, date_time, sum(price)
FROM pizza_restaurant.customers c 
join orders o on o.customer_id = c.customer_id
join pizza_orders po on po.order_id = o.order_id
join pizzas p on p.pizza_id = po.pizza_id
group by date_time;