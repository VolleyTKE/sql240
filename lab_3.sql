--lab 3 chapter q #1
select vendor_id, sum(invoice_total) as sum_invoice_total
from invoices
group by vendor_id;

--Lab 3 q #2
select vendor_name,sum(payment_total) as sum_payment_total
from vendors join invoices
on vendors.vendor_id=invoices.vendor_id
group by vendor_name
order by sum_payment_total desc;

--lab 3 q #3
select vendor_name, count(*) as invoice_count,
  sum(invoice_total) as sum_invoice_total
  from vendors v join invoices i
  on v.vendor_id=i.vendor_id
  group by vendor_name
  order by invoice_count desc;
  
--lab 3 q #4
select account_description, count(*) as line_item_count,
  sum(line_item_amt) as sum_line_item_amt
from general_ledger_accounts gl join invoice_line_items li
  on gl.account_number=li.account_number
group by gl.account_description
having count(*)>1
order by sum_line_item_amt desc;

--lab 3 q #5
select account_description, count(*) as line_item_count,
  sum(line_item_amt) as sum_line_item_amt
from general_ledger_accounts gl join invoice_line_items li
  on gl.account_number=li.account_number
  join invoices i
  on li.invoice_id=i.invoice_id
where invoice_date between '01-Apr-2008' and '30-June-2008'
group by gl.account_description
having count(*)>1
order by sum_line_item_amt desc;

--lab 3 q #6
select account_number, sum(line_item_amt) as sum_line_item
from invoice_line_items
group by rollup(account_number);

--lab 3 q #7
select vendor_name,
count(distinct li.account_number) as "Number of Accounts"
from vendors v join invoices i
on v.vendor_id=i.vendor_id
join invoice_line_items li
on i.invoice_id=li.invoice_id
group by vendor_name
having count(distinct li.account_number)>1
order by vendor_name;

--lab 3 ch6 q #1
select vendor_name
from vendors
where vendor_id in
    (select vendor_id from invoices)
order by vendor_name;

--lab 3 ch6 q #2
SELECT invoice_number, invoice_total
FROM invoices
WHERE PAYMENT_TOTAL > (select avg(PAYMENT_TOTAL)
                      from invoices
                      where payment_total > 0);
                      
--lab 3 ch6 q#3
SELECT account_number, account_description
FROM GENERAL_LEDGER_ACCOUNTS
WHERE NOT EXISTS(select * from invoice_line_items
                  where invoice_line_items.account_number=
                  general_ledger_accounts.account_number)
order by account_number;

--lab 4 ch6 q#4
SELECT vendor_name, i.invoice_id,invoice_sequence,
      line_item_amt
FROM vendors v join invoices i
on v.vendor_id=i.vendor_id
join invoice_line_items li
on i.invoice_id=li.invoice_id
WHERE i.invoice_id in
        (select invoice_id from invoice_line_items
        where invoice_sequence>1)
order by vendor_name, i.invoice_id, invoice_sequence;

--lab 4 ch6 q#5
select sum(invoice_max) as sum_of_maximums
from (select vendor_id, max(invoice_total) as invoice_max
      from invoices
      where invoice_total-credit_total-payment_total>0
      group by vendor_id);
      
--lab 4 ch6 q#6
with invoice_max as
    (select vendor_id, max(invoice_total) as invoice_max
    from invoices
    where invoice_total-credit_total-payment_total>0
    group by vendor_id)
select sum(invoice_max) as sum_of_maximums
from invoice_max;

--lab 4 ch6 q#7
