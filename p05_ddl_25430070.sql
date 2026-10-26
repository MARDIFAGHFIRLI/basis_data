USE kopma_vardx;

-- Hapus tabel dari anak ke induk jika sudah ada sebelumnya
DROP TABLE IF EXISTS detail_pesanan;
DROP TABLE IF EXISTS pesanan;
DROP TABLE IF EXISTS produk;
DROP TABLE IF EXISTS petugas;
DROP TABLE IF EXISTS pelanggan;

-- Skrip Pembuatan Tabel
CREATE TABLE pelanggan (
    id_pelanggan INT NOT NULL AUTO_INCREMENT,
    email_pelanggan VARCHAR(100) NOT NULL,
    nama_pelanggan VARCHAR(100) NOT NULL,
    password_pelanggan VARCHAR(255) NOT NULL,
    no_hp_pelanggan VARCHAR(15) NULL,
    alamat_pelanggan TEXT NULL,
    PRIMARY KEY (id_pelanggan),
    UNIQUE KEY uq_pelanggan_email (email_pelanggan)
) ENGINE=InnoDB;

CREATE TABLE produk (
    id_produk INT NOT NULL AUTO_INCREMENT,
    kode_produk VARCHAR(10) NOT NULL,
    nama_produk VARCHAR(100) NOT NULL,
    harga_produk DECIMAL(12,2) NOT NULL,
    stok_produk INT NOT NULL DEFAULT 0,
    PRIMARY KEY (id_produk),
    UNIQUE KEY uq_produk_kode (kode_produk),
    CONSTRAINT ck_produk_harga CHECK (harga_produk >= 0),
    CONSTRAINT ck_produk_stok CHECK (stok_produk >= 0)
) ENGINE=InnoDB;

CREATE TABLE petugas (
    id_petugas SMALLINT NOT NULL AUTO_INCREMENT,
    kode_petugas CHAR(3) NOT NULL,
    nama_petugas VARCHAR(100) NOT NULL,
    peran_petugas ENUM('kasir', 'gudang', 'ketua') NOT NULL,
    PRIMARY KEY (id_petugas),
    UNIQUE KEY uq_petugas_kode (kode_petugas)
) ENGINE=InnoDB;

CREATE TABLE pesanan (
    id_pesanan INT NOT NULL AUTO_INCREMENT,
    no_pesanan CHAR(12) NOT NULL,
    tgl_pesanan DATETIME NOT NULL,
    id_pelanggan INT NOT NULL,
    id_petugas SMALLINT NOT NULL,
    bayar_pesanan DECIMAL(12,2) NOT NULL,
    PRIMARY KEY (id_pesanan),
    UNIQUE KEY uq_pesanan_no (no_pesanan),
    CONSTRAINT fk_pesanan_pelanggan FOREIGN KEY (id_pelanggan) REFERENCES pelanggan (id_pelanggan),
    CONSTRAINT fk_pesanan_petugas FOREIGN KEY (id_petugas) REFERENCES petugas (id_petugas)
) ENGINE=InnoDB;

CREATE TABLE detail_pesanan (
    id_pesanan INT NOT NULL,
    id_produk INT NOT NULL,
    qty_detail_pesanan SMALLINT NOT NULL,
    harga_satuan_detail_pesanan DECIMAL(12,2) NOT NULL,
    PRIMARY KEY (id_pesanan, id_produk),
    CONSTRAINT fk_detail_pesanan FOREIGN KEY (id_pesanan) REFERENCES pesanan (id_pesanan) ON DELETE CASCADE,
    CONSTRAINT fk_detail_produk FOREIGN KEY (id_produk) REFERENCES produk (id_produk),
    CONSTRAINT ck_detail_qty CHECK (qty_detail_pesanan > 0)
) ENGINE=InnoDB;