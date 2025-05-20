
-- 1. Ciudades (id y nombre) y tiendas por ciudad, usando RIGHT JOIN para mostrar todas las ciudades
SELECT c.city_id, c.city, s.store_id
FROM store s
RIGHT JOIN address a ON s.address_id = a.address_id
RIGHT JOIN city c ON a.city_id = c.city_id;

-- 2. Países (id y nombre) y ciudades por país, usando RIGHT JOIN para mostrar todos los países
SELECT co.country_id, co.country, ci.city
FROM city ci
RIGHT JOIN country co ON ci.country_id = co.country_id;

-- 3. Ciudades (id y nombre) y clientes por ciudad, usando RIGHT JOIN para mostrar todas las ciudades
SELECT c.city_id, c.city, cu.customer_id
FROM customer cu
RIGHT JOIN address a ON cu.address_id = a.address_id
RIGHT JOIN city c ON a.city_id = c.city_id;

-- 4. Películas que NO han sido rentadas en la tienda 1
SELECT f.film_id, f.title
FROM film f
JOIN inventory i ON f.film_id = i.film_id
WHERE i.store_id = 1
AND i.inventory_id NOT IN (
    SELECT r.inventory_id
    FROM rental r
);

-- 5. Nombres de los actores y en cuántas películas del catálogo participan
SELECT a.first_name, a.last_name, COUNT(fa.film_id) AS cantidad_peliculas
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id;

-- 6. Nombres de las películas y en cuántas tiendas están registradas
SELECT f.title, COUNT(DISTINCT i.store_id) AS tiendas
FROM film f
JOIN inventory i ON f.film_id = i.film_id
GROUP BY f.film_id;

-- 7. Idiomas y cuántas películas están habladas en ese idioma
SELECT l.name AS idioma, COUNT(f.film_id) AS cantidad_peliculas
FROM language l
LEFT JOIN film f ON l.language_id = f.language_id
GROUP BY l.language_id;

-- 8. Cuántas veces ha sido rentada cada película del catálogo
SELECT f.title, COUNT(r.rental_id) AS veces_rentada
FROM film f
JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id;

-- 9. Cuántos pagos se realizaron en cada renta
SELECT r.rental_id, COUNT(p.payment_id) AS cantidad_pagos
FROM rental r
LEFT JOIN payment p ON r.rental_id = p.rental_id
GROUP BY r.rental_id;

-- 10. Cuántas películas ha rentado cada cliente
SELECT c.customer_id, COUNT(r.rental_id) AS cantidad_rentas
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id;

-- 11. Cuántas películas ha rentado cada miembro del staff
SELECT s.staff_id, COUNT(r.rental_id) AS cantidad_rentas
FROM staff s
LEFT JOIN rental r ON s.staff_id = r.staff_id
GROUP BY s.staff_id;

-- 12. Clientes que han generado pagos con un monto total mayor a $10
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS nombre_cliente, SUM(p.amount) AS total_pago
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id
HAVING total_pago > 10;

-- 13. Empleados que han generado pagos con un monto total mayor a $100
SELECT s.staff_id, CONCAT(s.first_name, ' ', s.last_name) AS nombre_empleado, SUM(p.amount) AS total_pago
FROM staff s
JOIN payment p ON s.staff_id = p.staff_id
GROUP BY s.staff_id
HAVING total_pago > 100;

-- 14. Número de pagos realizados por cliente en el mes de junio
SELECT c.customer_id, COUNT(p.payment_id) AS pagos_junio
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
WHERE MONTH(p.payment_date) = 6
GROUP BY c.customer_id;

-- 15. Cantidad de películas por duración de renta (rental_duration)
SELECT rental_duration, COUNT(*) AS cantidad
FROM film
GROUP BY rental_duration;

-- 16. Cantidad total de pagos recibidos cada año
SELECT YEAR(payment_date) AS año, SUM(amount) AS total_pagos
FROM payment
GROUP BY año;

-- 17. Monto total de pagos por cada día de la semana
SELECT DAYNAME(payment_date) AS dia_semana, SUM(amount) AS total_pagos
FROM payment
GROUP BY dia_semana;

-- 18. Días donde el total de pagos fue mayor a $50
SELECT DATE(payment_date) AS fecha, SUM(amount) AS total_pagos
FROM payment
GROUP BY fecha
HAVING total_pagos > 50;

-- 19. Cuántas películas hay en cada duración (length)
SELECT length, COUNT(*) AS cantidad
FROM film
GROUP BY length;

-- 20. Cantidad de pagos realizados en cada tienda
SELECT s.store_id, COUNT(p.payment_id) AS cantidad_pagos
FROM store s
JOIN staff st ON s.store_id = st.store_id
JOIN payment p ON st.staff_id = p.staff_id
GROUP BY s.store_id;

-- 21. Monto total de pagos por cliente (solo los que tienen más de 5 pagos)
SELECT c.customer_id, COUNT(p.payment_id) AS cantidad_pagos, SUM(p.amount) AS total_pago
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id
HAVING cantidad_pagos > 5;

-- 22. Número de películas según su clasificación (rating)
SELECT rating, COUNT(*) AS cantidad_peliculas
FROM film
GROUP BY rating;

-- 23. Clientes que han hecho pagos con monto promedio mayor a $5
SELECT c.customer_id, AVG(p.amount) AS promedio_pago
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id
HAVING promedio_pago > 5;

-- 24. Cantidad de títulos de películas con duración de renta mayor a 5 días
SELECT rental_duration, COUNT(title) AS cantidad_titulos
FROM film
WHERE rental_duration > 5
GROUP BY rental_duration;

-- 25. Total de pagos recibidos por cada mes, pero solo los meses con más de 100 pagos
SELECT MONTH(payment_date) AS mes, COUNT(*) AS cantidad_pagos, SUM(amount) AS total_pagado
FROM payment
GROUP BY mes
HAVING cantidad_pagos > 100;

-- 26. Clasificaciones de películas (rating) que tienen más de 50 películas registradas
SELECT rating, COUNT(*) AS cantidad
FROM film
GROUP BY rating
HAVING cantidad > 50;


