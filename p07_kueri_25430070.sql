-- Nama: M. Ardi Faghfirli
-- NIM: 25430070
-- Kelas: C
-- Modul 7: SELECT dan Fungsi Skalar (Toko Daring)

-- 1. KI-03: Menampilkan produk yang stoknya menipis (di bawah 10)
SELECT kode_produk, nama_produk, stok_produk,
       (10 - stok_produk) AS kekurangan_stok
FROM produk
WHERE stok_produk < 10
ORDER BY kekurangan_stok DESC;

-- 2. KI-05: Menyaring produk berdasarkan rentang harga (Menggunakan BETWEEN)
SELECT kode_produk, nama_produk, harga_produk, stok_produk
FROM produk
WHERE harga_produk BETWEEN 10000 AND 100000
ORDER BY harga_produk ASC;

-- 3. KI-06: Pencarian produk menggunakan pola teks (Menggunakan LIKE)
SELECT kode_produk, nama_produk, harga_produk, stok_produk
FROM produk
WHERE nama_produk LIKE '%Baju%' OR nama_produk LIKE '%Sepatu%';

-- 4. KI-08: Memeriksa data pelanggan yang tidak memiliki nomor HP (Menggunakan IS NULL)
SELECT email_pelanggan, nama_pelanggan, alamat_pelanggan
FROM pelanggan
WHERE no_hp_pelanggan IS NULL;

-- 5. KI-09: Klasifikasi status harga menggunakan fungsi kondisional (Menggunakan CASE)
SELECT kode_produk, nama_produk, harga_produk,
       CASE 
           WHEN harga_produk >= 200000 THEN 'Kelas Premium'
           ELSE 'Kelas Reguler'
       END AS kelas_harga
FROM produk;

-- 6. KI-10: Memformat string dan penanganan nilai kosong (Menggunakan CONCAT & IFNULL)
SELECT CONCAT(nama_pelanggan, ' (', email_pelanggan, ')') AS info_pelanggan,
       IFNULL(no_hp_pelanggan, 'Tidak ada nomor') AS kontak,
       alamat_pelanggan
FROM pelanggan
LIMIT 5;