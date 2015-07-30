
SELECT Name
FROM Orders, Salesperson
WHERE Orders.salesperson_id = Salesperson.ID
GROUP BY salesperson_id, Name                  
HAVING COUNT( salesperson_id ) >1
