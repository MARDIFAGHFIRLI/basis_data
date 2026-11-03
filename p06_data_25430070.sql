USE toko_vardx;

-- Aktivasi Mode Aman Sesi SQL
SET SESSION sql_safe_updates = 1;

-- 1. Pengisian Data Tabel pelanggan (Master / Induk - Min 5 Baris) [AB-01]
INSERT INTO pelanggan (email_pelanggan, nama_pelanggan, password_pelanggan, no_hp_pelanggan, alamat_pelanggan) VALUES
('budi@example.com', 'Budi Santoso', 'hashed_pass1', '081234567890', 'Metro'),
('siti@example.com', 'Siti Aminah', 'hashed_pass2', '081298765432', 'Bandar Lampung'),
('ani@example.com', 'Ani Yulianti', 'hashed_pass3', '081345678901', 'Metro'),
('eko@example.com', 'Eko Prasetyo', 'hashed_pass4', '081567890123', 'Pringsewu'),
('dewi@example.com', 'Dewi Lestari', 'hashed_pass5', '081789012345', 'Metro');

-- 2. Pengisian Data Tabel produk (Master / Induk - Min 5 Baris) [AB-02]
INSERT INTO produk (kode_produk, nama_produk, harga_produk, stok_produk) VALUES
('P001', 'Kemeja Flanel Pria', 150000.00, 25),
('P002', 'Celana Jeans Slim Fit', 220000.00, 18),
('P003', 'Kaos Polos Cotton Combed', 65000.00, 50),
('P004', 'Jaket Hoodie Fleece', 185000.00, 15),
('P005', 'Tas Ransel Laptop', 275000.00, 10);

-- 3. Pengisian Data Tabel petugas (Master / Induk - Min 5 Baris) [AB-03]
INSERT INTO petugas (kode_petugas, nama_petugas, peran_petugas) VALUES
('T01', 'Admin Toko', 'ketua'),
('T02', 'Kasir Satu', 'kasir'),
('T03', 'Staff Gudang A', 'gudang'),
('T04', 'Kasir Dua', 'kasir'),
('T05', 'Staff Gudang B', 'gudang');

-- 4. Pengisian Data Tabel pesanan (Transaksi Utama - Tersebar 5 Tanggal Berbeda) [AB-04]
INSERT INTO pesanan (no_pesanan, tgl_pesanan, id_pelanggan, id_petugas, bayar_pesanan) VALUES
('TRX001', '2026-10-01 10:30:00', 1, 1, 370000.00),
('TRX002', '2026-10-02 14:15:00', 2, 2, 220000.00),
('TRX003', '2026-10-03 09:00:00', 3, 1, 250000.00),
('TRX004', '2026-10-04 16:45:00', 4, 2, 185000.00),
('TRX005', '2026-10-05 11:20:00', 5, 3, 275000.00);

-- 5. Pengisian Data Tabel detail_pesanan (Transaksi Anak) [AB-05]
INSERT INTO detail_pesanan (id_pesanan, id_produk, qty_detail_pesanan, harga_satuan_detail_pesanan) VALUES
(1, 1, 1, 150000.00),
(1, 2, 1, 220000.00),
(2, 2, 1, 220000.00),
(3, 3, 2, 65000.00),
(3, 1, 1, 120000.00),
(4, 4, 1, 185000.00),
(5, 5, 1, 275000.00);