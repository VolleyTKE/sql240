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
