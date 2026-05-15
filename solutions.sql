-- ====================================================================
-- PROJECT: SQL Store Exercise Solutions
-- AUTHOR: Abi Kamal
-- DESCRIPTION: Solutions for 30 SQL queries ranging from Basic to Join
-- ====================================================================

-----------------------------------------------------------------------
-- BAGIAN II: SQL DASAR & MENENGAH (Soal 1-20)
-----------------------------------------------------------------------

-- 1. Semua Produk: Tampilkan semua data dalam tabel product
SELECT * FROM product;

-- 2. Nama dan Email Pelanggan: Alias kolom untuk keterbacaan
SELECT contact_name AS name, contact_email AS email 
FROM customer;

-- 3. Pelanggan Unik: Tampilkan ID pelanggan tanpa duplikasi
SELECT DISTINCT customer_id FROM purchase;

-- 4. Pelanggan dengan ID 4: Filter berdasarkan Primary Key
SELECT * FROM customer WHERE customer_id = 4;

-- 5. Filter Lokasi: Pelanggan dari kota Dallas
SELECT contact_name FROM customer WHERE city = 'Dallas';

-- 6. Pattern Matching: Produk yang diawali dengan kata 'Beef'
SELECT * FROM product WHERE product_name LIKE 'Beef%';

-- 7. Produk Non-Makanan: Filter kategori selain ID 1
SELECT product_name, category_id FROM product WHERE category_id <> 1;

-- 8. Operator Logika: Pelanggan dari perusahaan Oloo atau Fliptune
SELECT contact_name FROM customer 
WHERE company_name = 'Oloo' OR company_name = 'Fliptune';

-- 9. Filter Kompleks: Produk kategori 1 atau 5 dengan harga > 3.5
SELECT * FROM product 
WHERE (category_id = 1 OR category_id = 5) AND unit_price > 3.5;

-- 10. Produk Aktif di Luar Kategori 3: Menggunakan operator NOT
SELECT product_name FROM product 
WHERE NOT (discontinued = FALSE AND category_id = - 11. Sorting: Pembelian berdasarkan tanggal pengiriman terbaru[span_10](end_span)[span_11](end_span)
SELECT purchase_id, total_price, shipped_date 
FROM purchase 
ORDER BY shipped_date DESC;

-[span_12](start_span)- 12. Pembelian Bernilai Tinggi: Total harga >= 10 diurutkan dari yang terbaru[span_12](end_span)
SELECT * FROM purchase 
WHERE total_price >= 10 
ORDER BY shipped_date DESC;

-[span_13](start_span)- 13. Count: Jumlah produk per kategori[span_13](end_span)
SELECT category_id, COUNT(*) AS product_count 
FROM product 
GROUP BY category_id;

-[span_14](start_span)- 14. Average: Harga rata-rata pembelian per pelanggan[span_14](end_span)
SELECT customer_id, AVG(total_price) AS avg_purchase_price 
FROM purchase 
GROUP BY customer_id;

-[span_15](start_span)- 15. Multi-Column Group By: Total pembelian per pasangan pelanggan-karyawan[span_15](end_span)
SELECT customer_id, employee_id, SUM(total_price) AS total_purchases_price 
FROM purchase 
GROUP BY customer_id, employee_id;

-[span_16](start_span)[span_17](start_span)- 16. Having: Pasangan pelanggan-karyawan dengan minimal 2 transaksi[span_16](end_span)[span_17](end_span)
SELECT customer_id, employee_id, MIN(total_price) AS minimum_price
FROM purchase
GROUP BY customer_id, employee_id
HAVING COUNT(*) >= 2;

-[span_18](start_span)[span_19](start_span)- 17. Inner Join: Nama karyawan dan tanggal pengiriman pembelian[span_18](end_span)[span_19](end_span)
SELECT e.last_name, e.first_name, p.shipped_date
FROM purchase p
INNER JOIN employee e ON p.employee_id = e.employee_id;

-[span_20](start_span)- 18. Left Join Multi-tabel: Riwayat pembelian lengkap termasuk yang belum transaksi[span_20](end_span)
SELECT c.contact_name, c.contact_email, pr.product_name, pi.unit_price 
FROM customer c 
LEFT JOIN purchase p ON c.customer_id = p.customer_id 
LEFT JOIN purchase_item pi ON p.purchase_id = pi.purchase_id 
LEFT JOIN product pr ON pi.product_id = pr.product_id;

-[span_21](start_span)- 19. Aggregation with Join: Kategori dengan minimal 3 produk yang dihentikan[span_21](end_span)
SELECT c.name, COUNT(*) AS discontinued_products_number 
FROM product p 
INNER JOIN category c ON p.category_id = c.category_id 
WHERE p.discontinued = TRUE 
GROUP BY c.category_id, c.name 
HAVING COUNT(*) >= 3 
ORDER BY discontinued_products_number DESC;

-[span_22](start_span)[span_23](start_span)- 20. Kompleks: Total pembelian tinggi dengan filter kota[span_22](end_span)[span_23](end_span)
SELECT c.contact_name, COUNT(p.purchase_id) AS purchase_quantity
FROM customer c
INNER JOIN purchase p ON c.customer_id = p.customer_id
WHERE p.ship_city IS NOT NULL
GROUP BY c.customer_id, c.contact_name
HAVING SUM(p.total_price) > 14
ORDER BY c.contact_name;

-----------------------------------------------------------------------
-- BAGIAN III: SOAL LATIHAN JOIN TABLE (Soal 21-30)
-----------------------------------------------------------------------

-[span_24](start_span)[span_25](start_span)- 21. Inner Join: Nama produk dan nama kategorinya[span_24](end_span)[span_25](end_span)
SELECT p.product_name, c.name 
FROM product p 
INNER JOIN category c ON p.category_id = c.category_id 
ORDER BY p.product_name;

-[span_26](start_span)- 22. Left Join: Semua pelanggan termasuk yang belum pernah membeli[span_26](end_span)
SELECT c.contact_name, p.total_price
FROM customer c
LEFT JOIN purchase p ON c.customer_id = p.customer_id;

-[span_27](start_span)[span_28](start_span)- 23. Right Join: Semua pembelian dengan data karyawan[span_27](end_span)[span_28](end_span)
SELECT p.*, e.last_name 
FROM employee e 
RIGHT JOIN purchase p ON e.employee_id = p.employee_id 
ORDER BY p.purchase_date;

-[span_29](start_span)- 24. Join Detail Produk: ID pembelian dan detail item produk[span_29](end_span)
SELECT pi.purchase_id, pr.product_name, pi.quantity, pi.unit_price
FROM purchase_item pi
INNER JOIN product pr ON pi.product_id = pr.product_id
ORDER BY pi.purchase_id;

-[span_30](start_span)[span_31](start_span)- 25. Left Join & Count: Semua kategori dan jumlah produknya[span_30](end_span)[span_31](end_span)
SELECT c.name AS category_name, COUNT(p.product_id) AS product_count 
FROM category c 
LEFT JOIN product p ON c.category_id = p.category_id 
GROUP BY c.category_id, c.name 
ORDER BY product_count DESC;

-[span_32](start_span)- 26. Multi-table Join: Detail lengkap transaksi (4 tabel)[span_32](end_span)
SELECT pu.purchase_id, c.contact_name, pr.product_name, pi.quantity, pi.unit_price
FROM purchase pu
INNER JOIN customer c ON pu.customer_id = c.customer_id 
INNER JOIN purchase_item pi ON pu.purchase_id = pi.purchase_id 
INNER JOIN product pr ON pi.product_id = pr.product_id 
ORDER BY pu.purchase_id;

-[span_33](start_span)- 27. Right Join: Semua produk beserta riwayat pembeliannya[span_33](end_span)
SELECT pr.product_name, pi.purchase_id, pi.quantity 
FROM purchase_item pi 
RIGHT JOIN product pr ON pi.product_id = pr.product_id 
ORDER BY pr.product_name;

-[span_34](start_span)[span_35](start_span)- 28. Left Join: Jumlah pembelian yang ditangani setiap karyawan[span_34](end_span)[span_35](end_span)
SELECT e.last_name, e.first_name, COUNT(p.purchase_id) AS purchase_count 
FROM employee e 
LEFT JOIN purchase p ON e.employee_id = p.employee_id 
GROUP BY e.employee_id, e.last_name, e.first_name 
ORDER BY purchase_count DESC;

-[span_36](start_span)[span_37](start_span)- 29. Triple Join with Filter: Pembelian > 50 dengan nama pelanggan & karyawan[span_36](end_span)[span_37](end_span)
SELECT p.purchase_id, c.contact_name, e.last_name, p.total_price 
FROM purchase p 
INNER JOIN customer c ON p.customer_id = c.customer_id 
INNER JOIN employee e ON p.employee_id = e.employee_id 
WHERE p.total_price > 50 
ORDER BY p.total_price DESC;

-[span_38](start_span)- 30. Natural Join: Produk dan Kategorinya secara otomatis[span_38](end_span)
SELECT product_name, name 
FROM product 
NATURAL JOIN category 
ORDER BY name, product_name;