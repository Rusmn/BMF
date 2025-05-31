-- Buat database
CREATE DATABASE IF NOT EXISTS BMF;
USE BMF;

-- Tabel utama
CREATE TABLE lokasi (
    id_lokasi INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(255) NOT NULL,
    kapasitas INT NOT NULL
) ENGINE=InnoDB;

CREATE TABLE penonton (
    id_penonton INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL
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
    FOREIGN KEY (id_penonton) REFERENCES penonton(id_penonton)
) ENGINE=InnoDB;

CREATE TABLE transaksi_pembelian (
    nomor_transaksi INT AUTO_INCREMENT PRIMARY KEY,
    id_penonton INT,
    waktu_pembelian DATETIME NOT NULL,
    total_harga DECIMAL(12,2) DEFAULT 0,
    FOREIGN KEY (id_penonton) REFERENCES penonton(id_penonton) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE merchandise (
    kode_barang INT AUTO_INCREMENT PRIMARY KEY,
    kategori VARCHAR(100) NOT NULL,
    harga DECIMAL(10,2) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE tiket_reguler (
    id_tiket INT PRIMARY KEY,
    FOREIGN KEY (id_tiket) REFERENCES tiket(id_tiket) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE tiket_vip (
    id_tiket INT NOT NULL,
    kode_barang INT NOT NULL,
    statusFreebies BOOLEAN DEFAULT FALSE,
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
    FOREIGN KEY (id_penonton) REFERENCES penonton(id_penonton) ON DELETE CASCADE,
    CONSTRAINT VALIDASI_NOMOR_TELEPON
    CHECK(NOT nomor_telepon RLIKE '[^0-9]'
        AND CHAR_LENGTH(nomor_telepon) >= 10 
        AND CHAR_LENGTH(nomor_telepon) <= 13 
        AND SUBSTRING(nomor_telepon FROM 1 FOR 2) LIKE "08")
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

-- Trigger transition constraint sehingga TRUE tidak bisa berubah menjadi FALSE
DELIMITER //
CREATE TRIGGER Prevent_statusFreebies_Downgrade AFTER UPDATE ON tiket_vip
FOR EACH ROW
BEGIN
    IF OLD.statusFreebies = TRUE AND NEW.statusFreebies = FALSE THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tidak boleh mengubah statusFreebies dari TRUE menjadi FALSE.';
    END IF;
END;
//

DELIMITER ;

-- Prosedur ambil freebies
DELIMITER //
CREATE PROCEDURE ambil_freebies(IN id_tiket INT)
BEGIN
	DECLARE curStatus BOOLEAN;
	DECLARE invalid_id BOOL DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET invalid_id = TRUE;
	
	SELECT statusFreebies INTO curStatus
	FROM tiket_vip tv
	WHERE tv.id_tiket = id_tiket;

	IF invalid_id THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tiket ID tidak ditemukan.';
	ELSEIF curStatus THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Freebies sudah diambil sebelumnya.';
	ELSE
		UPDATE tiket_vip tv
		SET tv.statusFreebies = TRUE
		WHERE tv.id_tiket = id_tiket;
	END IF;
END;
//

DELIMITER ;

-- View melihat aktivitas konsumen
CREATE VIEW aktivitas_konsumen AS
SELECT R1.nama AS Nama, R1.email AS Email, R1.id_tiket AS ID_Tiket, R1.kategori AS Jenis_Tiket, R1.status_pembayaran AS Status_Pembayaran, COALESCE(R2.tHarga, 0) AS Total_Nilai_Pembelian, COALESCE(R2.tKuantitas, 0) AS Jumlah_Item
FROM (
	SELECT pn.id_penonton, pn.nama, pn.email, t.kategori, t.status_pembayaran, t.id_tiket
	FROM penonton pn INNER JOIN tiket t ON pn.id_penonton = t.id_penonton
	WHERE t.kategori LIKE "VIP") AS R1
LEFT JOIN (
	SELECT tp.id_penonton, SUM(m.harga * tt.kuantitas) AS tHarga, SUM(tt.kuantitas) tKuantitas
	FROM transaksi_pembelian tp INNER JOIN terdaftar_transaksi tt ON tp.nomor_transaksi = tt.nomor_transaksi
	INNER JOIN merchandise m ON tt.kode_barang = m.kode_barang
	GROUP BY tp.id_penonton) AS R2
ON R1.id_penonton = R2.id_penonton
ORDER BY R1.id_penonton;
