select 
    products.productname, 
    suppliers.suppliername
from 
    products
cross join 
    suppliers;



select 
    departments.departmentname, 
    employees.employeename
from 
    departments
cross join 
    employees;


select 
    suppliers.suppliername, 
    products.productname
from 
    products
join 
    suppliers 
on 
    products.supplierid = suppliers.supplierid;


select 
    customers.customername, 
    orders.orderid
from 
    orders
join 
    customers 
on 
    orders.customerid = customers.customerid;

select 
    students.studentname, 
    courses.coursename
from 
    students
cross join 
    courses;



select 
    products.productname, 
    orders.orderid
from 
    orderdetails
join 
    products on orderdetails.productid = products.productid
join 
    orders on orderdetails.orderid = orders.orderid;  or   select 
    products.productname, 
    orders.orderid
from 
    products
join 
    orders 
on 
    products.productid = orders.productid;


select 
    employees.employeename, 
    departments.departmentname
from 
    employees
join 
    departments 
on 
    employees.departmentid = departments.departmentid;



select 
    students.studentname, 
    enrollments.courseid
from 
    enrollments
join 
    students 
on 
    enrollments.studentid = students.studentid;


select 
    orders.orderid, 
    payments.paymentid
from 
    orders
join 
    payments 
on 
    orders.orderid = payments.orderid;




select 
    orders.orderid, 
    products.productname, 
    products.price
from 
    orderdetails
join 
    orders on orderdetails.orderid = orders.orderid
join 
    products on orderdetails.productid = products.productid
where 
    products.price > 100;



Medium:
employee names and department names where department ids are not equal

select 
    employees.employeename, 
    departments.departmentname
from 
    employees
cross join 
    departments
where 
    employees.departmentid <> departments.departmentid;



select 
    orders.orderid, 
    products.productname, 
    orderdetails.quantity, 
    products.stock
from 
    orderdetails
join 
    orders on orderdetails.orderid = orders.orderid
join 
    products on orderdetails.productid = products.productid
where 
    orderdetails.quantity > products.stock;


select 
    customers.customername, 
    sales.productid
from 
    sales
join 
    customers on sales.customerid = customers.customerid
where 
    sales.amount >= 500;




select 
    students.studentname, 
    courses.coursename
from 
    enrollments
join 
    students on enrollments.studentid = students.studentid
join 
    courses on enrollments.courseid = courses.courseid;




select 
    products.productname, 
    suppliers.suppliername
from 
    products
join 
    suppliers on products.supplierid = suppliers.supplierid
where 
    suppliers.suppliername like '%tech%';



select 
    orders.orderid, 
    orders.totalamount, 
    payments.amount as paymentamount
from 
    payments
join 
    orders on payments.orderid = orders.orderid
where 
    payments.amount < orders.totalamount;



select 
    employees.employeename, 
    departments.departmentname
from 
    employees
join 
    departments on employees.departmentid = departments.departmentid;


select 
    products.productname, 
    categories.categoryname
from 
    products
join 
    categories on products.categoryid = categories.categoryid
where 
    categories.categoryname in ('electronics', 'furniture');


select 
    sales.*
from 
    sales
join 
    customers on sales.customerid = customers.customerid
where 
    customers.country = 'usa';



select 
    orders.orderid, 
    customers.customername, 
    orders.totalamount
from 
    orders
join 
    customers on orders.customerid = customers.customerid
where 
    customers.country = 'germany' 
    and orders.totalamount > 100;
