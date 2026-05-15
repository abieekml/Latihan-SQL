-- ====================================================================
-- PROJECT: SQL Store Exercise Solutions
-- AUTHOR: Abi Kamal
-- DESCRIPTION: Solutions for 30 SQL queries ranging from Basic to Join
-- ====================================================================

-----------------------------------------------------------------------
-- BAGIAN II: SQL DASAR (Soal 1-12)
-----------------------------------------------------------------------

-- 1. Semua Produk: Tampilkan semua data dalam tabel product
SELECT * FROM product;

-- 2. Nama dan Email Pelanggan: Alias kolom untuk keterbacaan
SELECT contact_name AS name, contact_email AS email 
FROM customer;

-- 3. Pelanggan Unik: Tampilkan ID pelanggan tanpa duplikasi
SELECT DISTINCT customer_id FROM purchase;

-- 5. Filter Lokasi: Pelanggan dari kota Dallas
SELECT contact_name FROM customer 
WHERE city = 'Dallas';

-- 6. Pattern Matching: Produk yang diawali dengan kata 'Beef'
SELECT * FROM product 
WHERE product_name LIKE 'Beef%';

-- 8. Operator Logika: Pelanggan dari perusahaan Oloo atau Fliptune
SELECT contact_name FROM customer 
WHERE company_name = 'Oloo' OR company_name = 'Fliptune';

-- 11. Sorting: Pembelian berdasarkan tanggal pengiriman terbaru
SELECT purchase_id, total_price, shipped_date 
FROM purchase 
ORDER BY shipped_date DESC;

-----------------------------------------------------------------------
-- BAGIAN III: AGREGASI & GROUPING (Soal 13-16)
-----------------------------------------------------------------------

-- 13. Count: Jumlah produk per kategori
SELECT category_id, COUNT(*) AS product_count 
FROM product 
GROUP BY category_id;

-- 14. Average: Harga rata-rata pembelian per pelanggan
SELECT customer_id, AVG(total_price) AS avg_purchase_price 
FROM purchase 
GROUP BY customer_id;

-- 16. Having: Pasangan pelanggan-karyawan dengan minimal 2 transaksi
SELECT customer_id, employee_id, MIN(total_price) AS minimum_price
FROM purchase
GROUP BY customer_id, employee_id
HAVING COUNT(*) >= 2;

-----------------------------------------------------------------------
-- BAGIAN IV: JOIN OPERATIONS (Soal 17-30)
-----------------------------------------------------------------------

-- 17. Inner Join: Nama karyawan dan tanggal pengiriman pembelian
SELECT e.last_name, e.first_name, p.shipped_date
FROM purchase p
INNER JOIN employee e ON p.employee_id = e.employee_id;

-- 20. Kompleks: Total pembelian tinggi dengan filter kota
SELECT c.contact_name, COUNT(p.purchase_id) AS purchase_quantity
FROM customer c
INNER JOIN purchase p ON c.customer_id = p.customer_id
WHERE p.ship_city IS NOT NULL
GROUP BY c.customer_id, c.contact_name
HAVING SUM(p.total_price) > 14
ORDER BY c.contact_name;

-- 22. Left Join: Semua pelanggan termasuk yang belum pernah membeli
SELECT c.contact_name, p.total_price
FROM customer c
LEFT JOIN purchase p ON c.customer_id = p.customer_id;

-- 24. Join Detail Produk: ID pembelian dan detail item
SELECT pi.purchase_id, pr.product_name, pi.quantity, pi.unit_price
FROM purchase_item pi
INNER JOIN product pr ON pi.product_id = pr.product_id
ORDER BY pi.purchase_id;

-- 26. Multi-table Join: Detail lengkap transaksi (4 tabel)
SELECT pu.purchase_id, c.contact_name, pr.product_name, pi.quantity, pi.unit_price
FROM purchase pu
INNER JOIN customer c ON pu.customer_id = c.customer_id
INNER JOIN purchase_item pi ON pu.purchase_id = pi.purchase_id
INNER JOIN product pr ON pi.product_id = pr.product_id
ORDER BY pu.purchase_id;

-- 30. Natural Join: Produk dan Kategorinya secara otomatis
SELECT product_name, name 
FROM product 
NATURAL JOIN category 
ORDER BY name, product_name;