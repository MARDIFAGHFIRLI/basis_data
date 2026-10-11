# Dokumen Kebutuhan Data: Toko Daring (Toko Vardx)

**Nama:** M Ardi Faghfirli  
**NIM:** 25430070 (Akhiran 70 - Tema Toko Daring)[cite: 16, 29]  
**Kelas:** Praktikum Basis Data  
**Tanggal:** 11 Oktober 2026  

---

## 1. Latar belakang dan aktivitas organisasi
Toko Daring (**Toko Vardx**) adalah sistem perdagangan elektronik berbasis web yang melayani pelanggan dalam melakukan pencarian produk, pengelolaan keranjang belanja, pembuatan pesanan (checkout), hingga pencatatan pembayaran dan pengiriman barang secara digital.

---

## 2. Aktor dan proses bisnis
Berikut adalah tabel proses bisnis (PB) utama yang berjalan pada sistem:

| Kode | Proses Bisnis | Aktor | Pemicu |
| :--- | :--- | :--- | :--- |
| PB-01 | Registrasi & Login Pelanggan | Pelanggan | Pengguna ingin mendaftar akun baru |
| PB-02 | Pencatatan Pesanan (Checkout)| Pelanggan | Pelanggan memesan produk di keranjang |
| PB-03 | Verifikasi Pembayaran | Kasir / Admin | Pelanggan mengunggah bukti bayar |
| PB-04 | Pengiriman Barang | Bagian Pengiriman | Admin memproses pesanan lunas |

---

## 3. Dokumen sumber yang dianalisis
- **Halaman Keranjang & Checkout:** Memuat daftar produk yang dibeli, kuantitas (qty), harga satuan, subtotal, dan total biaya.
- **Bukti Pembayaran / Struk Transfer:** Memuat nomor pesanan, tanggal bayar, jumlah transfer, dan metode pembayaran.
- **Resi Pengiriman:** Memuat alamat tujuan, kurir, dan status pengiriman.

---

## 4. Entitas kandidat dan elemen data
1. **Pelanggan:** `id_pelanggan`, `email_pelanggan`, `nama_pelanggan`, `password_pelanggan`, `no_hp_pelanggan`, `alamat_pelanggan`
2. **Kategori:** `id_kategori`, `nama_kategori`
3. **Produk:** `id_produk`, `kode_produk`, `nama_produk`, `harga_produk`, `stok_produk`, `stok_min_produk`
4. **Pesanan:** `id_pesanan`, `no_pesanan`, `tgl_pesanan`, `id_pelanggan`, `status_pesanan`
5. **Detail Pesanan:** `id_pesanan`, `id_produk`, `qty_detail_pesanan`, `harga_satuan_detail_pesanan`
6. **Pembayaran:** `id_pembayaran`, `id_pesanan`, `tgl_pembayaran`, `jumlah_pembayaran`, `metode_pembayaran`

---

## 5. Aturan bisnis
- **AB-01:** Setiap pesanan wajib memiliki nomor pesanan (*no_pesanan*) yang unik.
- **AB-02:** Stok produk akan berkurang secara otomatis ketika pesanan berhasil dicatat.
- **AB-03:** Stok produk di dalam sistem tidak boleh bernilai negatif ($\ge 0$).
- **AB-04:** Harga produk pada detail pesanan disimpan tetap sesuai harga saat transaksi terjadi (mengantisipasi perubahan harga di masa mendatang).
- **AB-05:** Email pelanggan bersifat unik dan wajib diisi sebagai identitas login.
- **AB-06:** Status pesanan melewati alur: *Pending* $\rightarrow$ *Dibayar* $\rightarrow$ *Dikirim* $\rightarrow$ *Selesai*.

---

## 6. Kebutuhan informasi
- **KI-01:** Laporan omzet penjualan harian dan bulanan bagi admin.
- **KI-02:** Laporan 5 produk terlaris berdasarkan total kuantitas terjual per bulan.
- **KI-03:** Laporan daftar produk yang stoknya berada di bawah batas minimum (*stok_min_produk*).
- **KI-04:** Laporan daftar pelanggan dengan total nominal belanja terbesar.
- **KI-05:** Laporan daftar pesanan yang status pembayarannya masih tertunda (*pending*).

---

## 7. Matriks CRUD
| Proses Bisnis | Pelanggan | Kategori | Produk | Pesanan | Detail Pesanan | Pembayaran |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **PB-01 Registrasi** | C | - | - | - | - | - |
| **PB-02 Checkout** | R | - | R, U | C | C | - |
| **PB-03 Bayar** | - | - | - | U | - | C |
| **PB-04 Kirim** | - | - | - | U | - | - |

---

## 8. Kamus data awal
| Elemen Data | Arti | Contoh Nilai | Aturan | Penanggung Jawab |
| :--- | :--- | :--- | :--- | :--- |
| `no_pesanan` | Nomor unik transaksi | PS-202610-001 | Unik, format tetap | Admin Toko |
| `email_pelanggan`| Email akun pelanggan | ardi@gmail.com | Unik, format email | Pelanggan |
| `stok_produk` | Jumlah stok tersedia| 50 | Bilangan bulat $\ge 0$ | Admin Gudang |
| `harga_satuan` | Harga saat transaksi| 15000 | Nilai rupiah $\ge 0$ | Sistem |

---

## 9. Kebutuhan non-fungsional data & Parameter $P$
- **Perhitungan Parameter $P$ (NIM Berakhiran 70):**
  $$P = (70 \bmod 9) + 1 = 7 + 1 = 8$$
  * Batas maksimal item per transaksi = $P + 2 = 8 + 2 = 10$ item[cite: 61].
  * Perkiraan volume transaksi harian = $40 + (5 \times 8) = 80$ transaksi/hari[cite: 61].
- **Retensi Data:** Catatan transaksi pesanan disimpan sekurang-kurangnya selama 5 tahun.
- **Privasi Data:** Data pribadi seperti nomor HP dan alamat pelanggan bersifat rahasia dan hanya dapat diakses oleh pihak admin/pengelola toko (mengikuti UU Pelindungan Data Pribadi)[cite: 60, 85].

---

## 10. Isu kualitas data yang diantisipasi
- **Duplikasi Akun:** Diantisipasi dengan memberi batasan *UNIQUE* pada kolom email pelanggan.
- **Kesalahan Ketik Stok:** Diantisipasi dengan memberikan batasan *CHECK* agar stok tidak bisa bernilai minus.

---

## Checklist
- [x] Berkas `p02_kebutuhan_data_25430070.md` dibuat di repositori `basis_data`
- [x] Parameter $P$ dihitung berdasarkan NIM ($P = 8$)[cite: 61]
- [x] Meliputi 4 proses bisnis, 6 entitas, 6 aturan bisnis, dan 5 kebutuhan informasi[cite: 60]
- [x] Matriks CRUD dan kamus data lengkap dengan penanggung jawab[cite: 60]