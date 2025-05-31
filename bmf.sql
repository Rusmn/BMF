-- Buat database
CREATE DATABASE IF NOT EXISTS BMF;
USE BMF;


-- =============================================================
-- Tabel
-- =============================================================

CREATE TABLE lokasi (
    id_lokasi INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(255) NOT NULL,
    kapasitas INT NOT NULL
) ENGINE=InnoDB;

CREATE TABLE penonton (
    id_penonton INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    CONSTRAINT check_email_format CHECK (email LIKE '%_@__%.__%')
) ENGINE=InnoDB;

CREATE TABLE pertunjukan (
    id_pertunjukan INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(255) NOT NULL,
    waktu DATETIME NOT NULL,
    id_lokasi INT NOT NULL,
    FOREIGN KEY (id_lokasi) REFERENCES lokasi(id_lokasi)
) ENGINE=InnoDB;

CREATE TABLE tiket (
    id_tiket INT AUTO_INCREMENT PRIMARY KEY,
    kategori ENUM('reguler', 'VIP') NOT NULL,
    harga DECIMAL(10,2) NOT NULL,
    status_pembayaran ENUM('lunas', 'belum lunas') NOT NULL,
    id_pertunjukan INT NOT NULL,
    id_penonton INT,
    FOREIGN KEY (id_pertunjukan) REFERENCES pertunjukan(id_pertunjukan),
    FOREIGN KEY (id_penonton) REFERENCES penonton(id_penonton),
    CONSTRAINT check_harga_nonnegatif CHECK (harga >= 0.0)
) ENGINE=InnoDB;

CREATE TABLE transaksi_pembelian (
    nomor_transaksi INT AUTO_INCREMENT PRIMARY KEY,
    id_penonton INT,
    waktu_pembelian DATETIME NOT NULL,
    total_harga DECIMAL(12,2) DEFAULT 0,
    FOREIGN KEY (id_penonton) REFERENCES penonton(id_penonton) ON DELETE CASCADE,
    CONSTRAINT check_harga_nonnegatif CHECK (total_harga >= 0.0)
) ENGINE=InnoDB;

CREATE TABLE merchandise (
    kode_barang INT AUTO_INCREMENT PRIMARY KEY,
    kategori VARCHAR(100) NOT NULL,
    harga DECIMAL(10,2) NOT NULL,
    CONSTRAINT check_harga_nonnegatif CHECK (harga >= 0.0)
) ENGINE=InnoDB;

CREATE TABLE tiket_reguler (
    id_tiket INT PRIMARY KEY,
    FOREIGN KEY (id_tiket) REFERENCES tiket(id_tiket) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE tiket_vip (
    id_tiket INT NOT NULL,
    kode_barang INT NOT NULL,
    PRIMARY KEY (id_tiket, kode_barang),
    FOREIGN KEY (id_tiket) REFERENCES tiket(id_tiket) ON DELETE CASCADE,
    FOREIGN KEY (kode_barang) REFERENCES merchandise(kode_barang)
) ENGINE=InnoDB;

CREATE TABLE fasilitas (
    id_lokasi INT,
    fasilitas VARCHAR(255),
    PRIMARY KEY (id_lokasi, fasilitas),
    FOREIGN KEY (id_lokasi) REFERENCES lokasi(id_lokasi) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE sponsor (
    id_sponsor INT AUTO_INCREMENT PRIMARY KEY,
    id_pertunjukan INT NOT NULL,
    jenis_sponsorship VARCHAR(100) NOT NULL,
    nama_perusahaan VARCHAR(255) NOT NULL,
    kontribusi DECIMAL(15,2) NOT NULL,
    FOREIGN KEY (id_pertunjukan) REFERENCES pertunjukan(id_pertunjukan)
) ENGINE=InnoDB;

CREATE TABLE vendor (
    id_vendor INT AUTO_INCREMENT PRIMARY KEY,
    id_pertunjukan INT NOT NULL,
    nama VARCHAR(255) NOT NULL,
    jenis_layanan VARCHAR(100) NOT NULL,
    FOREIGN KEY (id_pertunjukan) REFERENCES pertunjukan(id_pertunjukan)
) ENGINE=InnoDB;

CREATE TABLE artis (
    id_artis INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(255) NOT NULL,
    negara_asal VARCHAR(100) NOT NULL,
    biografi TEXT
) ENGINE=InnoDB;

CREATE TABLE genre_artis (
    id_artis INT,
    genre VARCHAR(100),
    PRIMARY KEY (id_artis, genre),
    FOREIGN KEY (id_artis) REFERENCES artis(id_artis) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE kontak_artis (
    id_artis INT,
    kontak VARCHAR(255),
    PRIMARY KEY (id_artis, kontak),
    FOREIGN KEY (id_artis) REFERENCES artis(id_artis) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE tampil (
    id_artis INT,
    id_pertunjukan INT,
    PRIMARY KEY (id_artis, id_pertunjukan),
    FOREIGN KEY (id_artis) REFERENCES artis(id_artis),
    FOREIGN KEY (id_pertunjukan) REFERENCES pertunjukan(id_pertunjukan)
) ENGINE=InnoDB;

CREATE TABLE panitia_pelaksana (
    id_panitia INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(255) NOT NULL,
    kontribusi VARCHAR(255) NOT NULL,
    kontak VARCHAR(100) NOT NULL,
    id_pertunjukan INT NOT NULL,
    FOREIGN KEY (id_pertunjukan) REFERENCES pertunjukan(id_pertunjukan)
) ENGINE=InnoDB;

CREATE TABLE nomor_telepon_penonton (
    id_penonton INT,
    nomor_telepon VARCHAR(20),
    PRIMARY KEY (id_penonton, nomor_telepon),
    FOREIGN KEY (id_penonton) REFERENCES penonton(id_penonton) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE alamat_penonton (
    id_penonton INT,
    alamat VARCHAR(255),
    PRIMARY KEY (id_penonton, alamat),
    FOREIGN KEY (id_penonton) REFERENCES penonton(id_penonton) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE terdaftar_transaksi (
    nomor_transaksi INT,
    kode_barang INT,
    kuantitas INT NOT NULL,
    PRIMARY KEY (nomor_transaksi, kode_barang),
    FOREIGN KEY (nomor_transaksi) REFERENCES transaksi_pembelian(nomor_transaksi),
    FOREIGN KEY (kode_barang) REFERENCES merchandise(kode_barang)
) ENGINE=InnoDB;


-- =============================================================
-- Trigger
-- =============================================================

DELIMITER //

CREATE TRIGGER trigger_bmf_update_tiket
BEFORE UPDATE ON tiket
FOR EACH ROW
BEGIN
    -- Jika tiket sudah lunas atau memiliki id_penonton, tidak boleh ada perubahan apapun
    IF OLD.status_pembayaran = 'lunas' OR OLD.id_penonton IS NOT NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tiket yang sudah lunas atau memiliki pemilik tidak dapat diubah';
    END IF;
    
    -- Validasi untuk update ke status lunas harus memiliki id_penonton
    IF NEW.status_pembayaran = 'lunas' AND NEW.id_penonton IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tiket lunas harus memiliki id_penonton';
    END IF;
END//

CREATE TRIGGER trigger_bmf_insert_tiket
BEFORE INSERT ON tiket
FOR EACH ROW
BEGIN
    -- Tiket baru tidak boleh memiliki status pembayaran 'lunas' tanpa id_penonton
    IF NEW.status_pembayaran = 'lunas' AND NEW.id_penonton IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tiket baru dengan status lunas harus memiliki id_penonton';
    END IF;
    
END//

DELIMITER ;

DELIMITER //

CREATE TRIGGER trigger_bmf_transaksi_pembelian_prevent_delete
BEFORE DELETE ON transaksi_pembelian
FOR EACH ROW
BEGIN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Transaksi pembelian tidak dapat dihapus';
END//

CREATE TRIGGER trigger_bmf_terdaftar_transaksi_prevent_delete
BEFORE DELETE ON terdaftar_transaksi
FOR EACH ROW
BEGIN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Rincian transaksi tidak dapat dihapus';
END//

DELIMITER ;
