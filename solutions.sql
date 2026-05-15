

-- ====================================================================
-- PROJECT: SQL Store Exercise Solutions
-- AUTHOR: Abi Kamal
-- DESCRIPTION: Solutions for 30 SQL queries ranging from Basic to Join
-- ====================================================================

-----------------------------------------------------------------------
-- BAGIAN II: SQL DASAR & MENENGAH (Soal 1-20)
-----------------------------------------------------------------------

1. Semua Produk  [SELECT *]
Tampilkan semua data dalam tabel product.

SELECT *
FROM product;

2. Nama dan Email Pelanggan  [SELECT, AS]
Tampilkan nama dan alamat email pelanggan. Ganti nama kolom contact_name menjadi name dan contact_email menjadi email.

SELECT contact_name AS name,
       contact_email AS email
FROM customer;

3. Pelanggan yang Melakukan Pembelian  [DISTINCT]
Tampilkan ID semua pelanggan yang melakukan setidaknya satu pembelian. Tidak boleh ada ID pelanggan yang duplikat.

SELECT DISTINCT customer_id
FROM purchase;

4. Pelanggan dengan ID 4  [WHERE]
Tampilkan semua data untuk pelanggan dengan ID 4.

SELECT *
FROM customer
WHERE customer_id = 4;

5. Pelanggan dari Dallas  [WHERE]
Tampilkan nama semua pelanggan yang tinggal di Dallas.

SELECT contact_name
FROM customer
WHERE city = 'Dallas';


6. Produk yang Diawali dengan "Beef"  [LIKE]
Tampilkan semua data untuk produk yang namanya diawali dengan kata 'Beef'.

SELECT *
FROM product
WHERE product_name LIKE 'Beef%';

7. Produk Non-Makanan  [WHERE, <>]
Tampilkan nama produk dan ID kategori terkait untuk kategori dengan ID selain 1 (Makanan).

SELECT product_name,
       category_id
FROM product
WHERE category_id <> 1;

8. Pelanggan dari Oloo atau Fliptune  [WHERE, OR]
Tampilkan nama semua pelanggan yang nama perusahaannya adalah Oloo atau Fliptune.

SELECT contact_name
FROM customer
WHERE company_name = 'Oloo'
   OR company_name = 'Fliptune';

9. Makanan dan Produk Buah & Sayur yang Mahal  [WHERE, AND, OR]
Tampilkan data untuk semua produk dalam kategori dengan ID 1 (Makanan) atau 5 (Buah dan sayur) dan dengan harga satuan di atas 3,5.

SELECT *
FROM product
WHERE (category_id = 1 OR category_id = 5)
  AND unit_price > 3.5;

10. Produk Aktif di Luar Kategori 3  [WHERE, NOT]
Tampilkan nama semua produk kecuali produk yang belum dihentikan produksinya yang termasuk dalam kategori ID 3.

SELECT product_name
FROM product
WHERE NOT (discontinued = FALSE AND category_id = 3);

11. Pembelian berdasarkan Tanggal Pengiriman  [ORDER BY DESC]
Tampilkan purchase_id, total_price, dan shipped_date untuk semua pembelian, diurutkan berdasarkan tanggal pengiriman dari yang paling baru.

SELECT purchase_id,
       total_price,
       shipped_date
FROM purchase
ORDER BY shipped_date DESC;

12. Pembelian Bernilai Tinggi  [WHERE, ORDER BY]
Tampilkan semua data untuk pembelian dengan total harga lebih besar dari atau sama dengan 10. Urutkan dari tanggal pengiriman terbaru.

SELECT *
FROM purchase
WHERE total_price >= 10
ORDER BY shipped_date DESC;

13. Jumlah Produk dalam Kategori  [GROUP BY, COUNT]
Tampilkan semua ID kategori beserta jumlah produk yang ada dalam kategori tersebut.

SELECT category_id,
       COUNT(*) AS product_count
FROM product
GROUP BY category_id;

14. Harga Pembelian Rata-Rata per Pelanggan  [GROUP BY, AVG]
Untuk semua pelanggan, tampilkan ID pelanggan dan harga rata-rata dari semua pembelian yang pernah mereka lakukan.

SELECT customer_id,
       AVG(total_price) AS avg_purchase_price
FROM purchase
GROUP BY customer_id;

15. Total Pembelian per Pasangan Pelanggan–Karyawan  [GROUP BY, SUM, AS]
Untuk setiap pasangan pelanggan-karyawan, temukan total harga pembelian. Tampilkan kolom customer_id, employee_id, dan total_purchases_price.

SELECT customer_id,
       employee_id,
       SUM(total_price) AS total_purchases_price
FROM purchase
GROUP BY customer_id, employee_id;

16. Pembelian Minimum per Pasangan Pelanggan–Karyawan  [GROUP BY, MIN, HAVING]
Temukan jumlah pembelian terkecil untuk setiap pasangan pelanggan-karyawan. Tampilkan hanya pasangan yang memiliki setidaknya dua pembelian. Kolom: customer_id, employee_id, minimum_price.

SELECT customer_id,
       employee_id,
       MIN(total_price) AS minimum_price
FROM purchase
GROUP BY customer_id, employee_id
HAVING COUNT(*) >= 2;

17. Nama Karyawan beserta Tanggal Pengiriman  [JOIN (INNER JOIN)]
Tampilkan nama belakang dan nama depan karyawan yang menangani setiap pembelian, beserta tanggal pengiriman (shipped_date) pembelian tersebut.

SELECT e.last_name,
       e.first_name,
       p.shipped_date
FROM purchase p
INNER JOIN employee e ON p.employee_id = e.employee_id;

18. Detail Pelanggan dengan Riwayat Pembelian  [LEFT JOIN, Multi-tabel]
Tampilkan nama dan email semua pelanggan, serta nama produk yang mereka beli dan harga produk saat pembelian. Sertakan pelanggan yang belum pernah melakukan pembelian apapun (tampilkan NULL untuk kolom produk).

SELECT c.contact_name,
       c.contact_email,
       pr.product_name,
       pi.unit_price
FROM customer c
LEFT JOIN purchase p       ON c.customer_id  = p.customer_id
LEFT JOIN purchase_item pi ON p.purchase_id  = pi.purchase_id
LEFT JOIN product pr       ON pi.product_id  = pr.product_id;

19. Kategori dengan Produk yang Dihentikan  [JOIN, GROUP BY, HAVING, ORDER BY]
Untuk setiap kategori, temukan jumlah produk yang dihentikan produksinya. Tampilkan hanya kategori yang memiliki setidaknya 3 produk dihentikan. Urutkan dari jumlah terbanyak. Kolom: name, discontinued_products_number.

SELECT c.name,
       COUNT(*) AS discontinued_products_number
FROM product p
INNER JOIN category c ON p.category_id = c.category_id
WHERE p.discontinued = TRUE
GROUP BY c.category_id, c.name
HAVING COUNT(*) >= 3
ORDER BY discontinued_products_number DESC;

20. Pelanggan dengan Total Pembelian Tinggi  [JOIN, WHERE, GROUP BY, HAVING, ORDER BY]
Untuk setiap pelanggan, tampilkan jumlah pembelian yang telah mereka lakukan. Sertakan hanya pembelian dengan ship_city yang tidak NULL, dan hanya pelanggan yang total biaya semua pembeliannya lebih dari 14. Kolom: contact_name, purchase_quantity. Urutkan berdasarkan contact_name.

SELECT c.contact_name,
       COUNT(p.purchase_id) AS purchase_quantity
FROM customer c
INNER JOIN purchase p ON c.customer_id = p.customer_id
WHERE p.ship_city IS NOT NULL
GROUP BY c.customer_id, c.contact_name
HAVING SUM(p.total_price) > 14
ORDER BY c.contact_name;


-- BAGIAN III: SOAL LATIHAN JOIN TABLE (Soal 21-30)
-----------------------------------------------------------------------


21. INNER JOIN – Produk beserta Nama Kategorinya  [INNER JOIN: product ↔ category]
Tampilkan nama produk (product_name) dan nama kategori (name) untuk setiap produk. Hanya tampilkan produk yang memiliki kategori terkait. Urutkan berdasarkan nama produk.

SELECT p.product_name,
       c.name
FROM product p
INNER JOIN category c ON p.category_id = c.category_id
ORDER BY p.product_name;

22. LEFT JOIN – Semua Pelanggan dengan Data Pembelian  [LEFT JOIN: customer ↔ purchase]
Tampilkan semua pelanggan beserta nilai total pembelian mereka (total_price). Sertakan pelanggan yang belum pernah melakukan pembelian – tampilkan NULL untuk total_price mereka. Kolom yang ditampilkan: contact_name, total_price.

SELECT c.contact_name,
       p.total_price
FROM customer c
LEFT JOIN purchase p ON c.customer_id = p.customer_id;

23. RIGHT JOIN – Semua Pembelian dengan Data Karyawan  [RIGHT JOIN: employee ↔ purchase]
Tampilkan semua data pembelian beserta nama belakang karyawan (last_name) yang menanganinya. Sertakan pembelian yang tidak memiliki karyawan terkait. Urutkan berdasarkan purchase_date.

SELECT p.*,
       e.last_name
FROM employee e
RIGHT JOIN purchase p ON e.employee_id = p.employee_id
ORDER BY p.purchase_date;

24. INNER JOIN – Item Pembelian dengan Detail Produk  [INNER JOIN: purchase_item ↔ product]
Tampilkan purchase_id, nama produk (product_name), jumlah yang dibeli (quantity), dan harga satuan (unit_price) dari tabel purchase_item. Urutkan berdasarkan purchase_id.

SELECT pi.purchase_id,
       pr.product_name,
       pi.quantity,
       pi.unit_price
FROM purchase_item pi
INNER JOIN product pr ON pi.product_id = pr.product_id
ORDER BY pi.purchase_id;

25. LEFT JOIN – Semua Kategori dengan Jumlah Produk  [LEFT JOIN: category ↔ product, COUNT]
Tampilkan semua nama kategori beserta jumlah produk yang dimilikinya. Sertakan kategori yang tidak memiliki produk apapun (jumlah = 0). Kolom: category_name, product_count. Urutkan dari yang terbanyak.

SELECT c.name AS category_name,
       COUNT(p.product_id) AS product_count
FROM category c
LEFT JOIN product p ON c.category_id = p.category_id
GROUP BY c.category_id, c.name
ORDER BY product_count DESC;

26. INNER JOIN 3 Tabel – Detail Transaksi Lengkap  [INNER JOIN: purchase ↔ customer ↔ purchase_item ↔ product]
Tampilkan purchase_id, contact_name pelanggan, nama produk (product_name), quantity, dan unit_price untuk setiap item dalam transaksi pembelian. Urutkan berdasarkan purchase_id.

SELECT pu.purchase_id,
       c.contact_name,
       pr.product_name,
       pi.quantity,
       pi.unit_price
FROM purchase pu
INNER JOIN customer c       ON pu.customer_id = c.customer_id
INNER JOIN purchase_item pi ON pu.purchase_id = pi.purchase_id
INNER JOIN product pr        ON pi.product_id  = pr.product_id
ORDER BY pu.purchase_id;

27. RIGHT JOIN – Semua Produk dengan Riwayat Pembelian  [RIGHT JOIN: purchase_item ↔ product]
Tampilkan semua produk beserta informasi pembeliannya (purchase_id dan quantity). Sertakan produk yang belum pernah dibeli – tampilkan NULL untuk purchase_id dan quantity. Urutkan berdasarkan nama produk.

SELECT pr.product_name,
       pi.purchase_id,
       pi.quantity
FROM purchase_item pi
RIGHT JOIN product pr ON pi.product_id = pr.product_id
ORDER BY pr.product_name;

28. LEFT JOIN – Karyawan dengan Jumlah Pembelian Ditangani  [LEFT JOIN: employee ↔ purchase, COUNT, GROUP BY]
Tampilkan semua karyawan beserta jumlah pembelian yang pernah mereka tangani. Sertakan karyawan yang belum pernah menangani pembelian apapun (jumlah = 0). Kolom: last_name, first_name, purchase_count. Urutkan dari terbanyak.

SELECT e.last_name,
       e.first_name,
       COUNT(p.purchase_id) AS purchase_count
FROM employee e
LEFT JOIN purchase p ON e.employee_id = p.employee_id
GROUP BY e.employee_id, e.last_name, e.first_name
ORDER BY purchase_count DESC;

29. INNER JOIN + WHERE – Pembelian Mahal dengan Nama Pelanggan dan Karyawan  [INNER JOIN 3 tabel + WHERE + ORDER BY]
Tampilkan purchase_id, contact_name pelanggan, last_name karyawan, dan total_price untuk pembelian dengan total_price lebih dari 50. Urutkan dari yang termahal.

SELECT p.purchase_id,
       c.contact_name,
       e.last_name,
       p.total_price
FROM purchase p
INNER JOIN customer c ON p.customer_id = c.customer_id
INNER JOIN employee e ON p.employee_id = e.employee_id
WHERE p.total_price > 50
ORDER BY p.total_price DESC;

30. NATURAL JOIN – Produk dan Kategori  [NATURAL JOIN: product ↔ category]
Tampilkan nama produk (product_name) dan nama kategori (name) menggunakan NATURAL JOIN antara tabel product dan category. Urutkan berdasarkan category name, kemudian product name.

SELECT product_name,
       name
FROM product
NATURAL JOIN category
ORDER BY name, product_name;

