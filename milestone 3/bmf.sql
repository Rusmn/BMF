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
    FOREIGN KEY (id_pertunjukan) REFERENCES pertunjukan(id_pertunjukan) ON DELETE RESTRICT,
    FOREIGN KEY (id_penonton) REFERENCES penonton(id_penonton) ON DELETE RESTRICT,
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
    FOREIGN KEY (id_artis) REFERENCES artis(id_artis) ON DELETE RESTRICT,
    FOREIGN KEY (id_pertunjukan) REFERENCES pertunjukan(id_pertunjukan) ON DELETE RESTRICT
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


DELIMITER //

CREATE TRIGGER check_artis_konflik_jadwal
BEFORE INSERT ON tampil
FOR EACH ROW
BEGIN
    DECLARE existing_id_pertunjukan INT;
    DECLARE new_pertunjukan_waktu DATETIME;
    DECLARE new_pertunjukan_lokasi INT;

    SELECT waktu, id_lokasi
    INTO new_pertunjukan_waktu, new_pertunjukan_lokasi
    FROM pertunjukan
    WHERE id_pertunjukan = NEW.id_pertunjukan;

    SELECT p.id_pertunjukan
    INTO existing_id_pertunjukan
    FROM tampil AS t
    JOIN pertunjukan AS p ON t.id_pertunjukan = p.id_pertunjukan
    WHERE t.id_artis = NEW.id_artis -- Artis yang sama
      AND p.waktu = new_pertunjukan_waktu -- Pada waktu yang sama
      AND p.id_lokasi <> new_pertunjukan_lokasi -- Di lokasi yang berbeda
      AND t.id_pertunjukan <> NEW.id_pertunjukan; -- Bukan pertunjukan yang sama yang sedang di-insert

    IF existing_id_pertunjukan IS NOT NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Konflik Jadwal: Artis ini sudah dijadwalkan di tempat lain pada waktu yang sama.';
    END IF;
END;
//
DELIMITER ;

ALTER TABLE transaksi_pembelian 
ADD CONSTRAINT uk_nomor_transaksi UNIQUE (nomor_transaksi);



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

-- ==============================================================
-- View
-- ==============================================================

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

-- fitur tambahan d : statistik penjualan

CREATE VIEW statistik_penjualan_harian AS
SELECT
    DATE(tp.waktu_pembelian) AS Tanggal,
    COUNT(t.id_tiket) AS Jumlah_Tiket_Terjual,
    SUM(t.harga) AS Total_Pendapatan,
    COUNT(CASE WHEN t.kategori = 'reguler' THEN 1 END) AS Tiket_Reguler,
    COUNT(CASE WHEN t.kategori = 'VIP' THEN 1 END) AS Tiket_VIP,
    COUNT(CASE WHEN t.status_pembayaran = 'lunas' THEN 1 END) AS Tiket_Lunas,
    COUNT(CASE WHEN t.status_pembayaran = 'belum lunas' THEN 1 END) AS Tiket_Belum_Lunas
FROM
    tiket t
    JOIN transaksi_pembelian tp ON t.id_penonton = tp.id_penonton
GROUP BY
    DATE(tp.waktu_pembelian)
ORDER BY
    Tanggal DESC;


-- fitur tambahan e
CREATE VIEW penonton_favorit_artis AS
SELECT
    p.id_penonton,
    p.nama AS Nama_Penonton,
    p.email AS Email_Penonton,
    a.id_artis,
    a.nama AS Nama_Artis,
    a.negara_asal AS Negara_Asal_Artis,
    COUNT(t.id_tiket) AS Jumlah_Tontonan,
    RANK() OVER (
        PARTITION BY p.id_penonton
        ORDER BY COUNT(t.id_tiket) DESC
    ) AS Ranking_Favorit
FROM penonton p
JOIN tiket t ON p.id_penonton = t.id_penonton
JOIN pertunjukan pt ON t.id_pertunjukan = pt.id_pertunjukan
JOIN tampil tp ON pt.id_pertunjukan = tp.id_pertunjukan
JOIN artis a ON tp.id_artis = a.id_artis
GROUP BY
    p.id_penonton,
    p.nama,
    p.email,
    a.id_artis,
    a.nama,
    a.negara_asal
ORDER BY
    p.id_penonton,
    Jumlah_Tontonan DESC;


-- =================================================================
-- Business Rule
-- =================================================================

-- Index
CREATE INDEX IF NOT EXISTS idx_terdaftar_nomor_transaksi ON terdaftar_transaksi(nomor_transaksi);
CREATE INDEX IF NOT EXISTS idx_tiket_pertunjukan_count ON tiket(id_pertunjukan);
CREATE INDEX IF NOT EXISTS idx_tiket_kategori_status ON tiket(kategori, status_pembayaran);

DELIMITER //

-- Business Rule 1: Total Harga

-- DROP FUNCTION IF EXISTS hitung_total_harga;
CREATE FUNCTION hitung_total_harga(p_nomor_transaksi INT) 
RETURNS DECIMAL(12,2)
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE v_total DECIMAL(12,2) DEFAULT 0;

    SELECT IFNULL(SUM(m.harga * tt.kuantitas), 0)
    INTO v_total
    FROM terdaftar_transaksi tt STRAIGHT_JOIN merchandise m 
    ON tt.kode_barang = m.kode_barang
    WHERE tt.nomor_transaksi = p_nomor_transaksi;
    
    RETURN v_total;
END;

-- DROP TRIGGER IF EXISTS validasi_kuantitas_insert;
CREATE TRIGGER validasi_kuantitas_insert
BEFORE INSERT ON terdaftar_transaksi
FOR EACH ROW
BEGIN
    IF NEW.kuantitas <= 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Kuantitas harus lebih dari 0';
    END IF;
END;

-- DROP TRIGGER IF EXISTS validasi_kuantitas_update;
CREATE TRIGGER validasi_kuantitas_update
BEFORE UPDATE ON terdaftar_transaksi
FOR EACH ROW
BEGIN
    IF NEW.kuantitas <= 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Kuantitas harus lebih dari 0';
    END IF;
END;

-- DROP TRIGGER IF EXISTS tambah_item;
CREATE TRIGGER tambah_item
AFTER INSERT ON terdaftar_transaksi
FOR EACH ROW
BEGIN
    DECLARE v_new_total DECIMAL(12,2);
    SET v_new_total = hitung_total_harga(NEW.nomor_transaksi);
    
    UPDATE transaksi_pembelian 
    SET total_harga = v_new_total
    WHERE nomor_transaksi = NEW.nomor_transaksi;
END;

-- DROP TRIGGER IF EXISTS update_item;
CREATE TRIGGER update_item
AFTER UPDATE ON terdaftar_transaksi
FOR EACH ROW
BEGIN
    DECLARE v_new_total DECIMAL(12,2);
    DECLARE v_old_total DECIMAL(12,2);
    
    SET v_new_total = hitung_total_harga(NEW.nomor_transaksi);
    
    UPDATE transaksi_pembelian 
    SET total_harga = v_new_total
    WHERE nomor_transaksi = NEW.nomor_transaksi;

    IF OLD.nomor_transaksi != NEW.nomor_transaksi THEN
        SET v_old_total = hitung_total_harga(OLD.nomor_transaksi);
        UPDATE transaksi_pembelian 
        SET total_harga = v_old_total
        WHERE nomor_transaksi = OLD.nomor_transaksi;
    END IF;
END;

-- DROP TRIGGER IF EXISTS hapus_item;
CREATE TRIGGER hapus_item
AFTER DELETE ON terdaftar_transaksi
FOR EACH ROW
BEGIN
    DECLARE v_total DECIMAL(12,2);
    SET v_total = hitung_total_harga(OLD.nomor_transaksi);
    
    UPDATE transaksi_pembelian 
    SET total_harga = v_total
    WHERE nomor_transaksi = OLD.nomor_transaksi;
END;

-- Business Rule 2: Kapasitas Maksimum

-- DROP TRIGGER IF EXISTS validasi_kapasitas;
CREATE TRIGGER validasi_kapasitas
BEFORE INSERT ON tiket
FOR EACH ROW
BEGIN
    DECLARE kapasitas_lokasi INT;
    DECLARE tiket_terjual INT;
    
    SELECT l.kapasitas, COUNT(t.id_tiket)
    INTO kapasitas_lokasi, tiket_terjual
    FROM pertunjukan p 
    JOIN lokasi l ON p.id_lokasi = l.id_lokasi
    LEFT JOIN tiket t ON t.id_pertunjukan = p.id_pertunjukan
    WHERE p.id_pertunjukan = NEW.id_pertunjukan
    GROUP BY l.kapasitas;
    
    SET tiket_terjual = IFNULL(tiket_terjual, 0);
    
    IF tiket_terjual >= kapasitas_lokasi THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Kapasitas lokasi sudah penuh. Tidak dapat menambah tiket baru.';
    END IF;
END;

-- DROP TRIGGER IF EXISTS validasi_kapasitas_update;
CREATE TRIGGER validasi_kapasitas_update
BEFORE UPDATE ON tiket
FOR EACH ROW
BEGIN
    DECLARE kapasitas_lokasi INT;
    DECLARE tiket_terjual INT;
    
    IF OLD.id_pertunjukan != NEW.id_pertunjukan THEN
        SELECT l.kapasitas, COUNT(t.id_tiket)
        INTO kapasitas_lokasi, tiket_terjual
        FROM pertunjukan p 
        JOIN lokasi l ON p.id_lokasi = l.id_lokasi
        LEFT JOIN tiket t ON t.id_pertunjukan = p.id_pertunjukan
        WHERE p.id_pertunjukan = NEW.id_pertunjukan 
        AND t.id_tiket != NEW.id_tiket
        GROUP BY l.kapasitas;
        
        SET tiket_terjual = IFNULL(tiket_terjual, 0);
        
        IF tiket_terjual >= kapasitas_lokasi THEN
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Kapasitas lokasi sudah penuh. Tidak dapat memindahkan tiket ke pertunjukan ini.';
        END IF;
    END IF;
END;

-- Business Rule 3: Validasi Kategori

-- DROP TRIGGER IF EXISTS validasi_kategori_insert;
CREATE TRIGGER validasi_kategori_insert
BEFORE INSERT ON tiket
FOR EACH ROW
BEGIN
    IF NEW.harga <= 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Harga tiket harus lebih dari 0';
    END IF;
    
    IF NEW.kategori NOT IN ('reguler', 'VIP') THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Kategori tiket harus reguler atau VIP';
    END IF;
    
    IF NEW.status_pembayaran NOT IN ('lunas', 'belum lunas') THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Status pembayaran harus lunas atau belum lunas';
    END IF;
END;

-- DROP TRIGGER IF EXISTS validasi_kategori_update;
CREATE TRIGGER validasi_kategori_update
BEFORE UPDATE ON tiket
FOR EACH ROW
BEGIN
    IF NOT (OLD.kategori = NEW.kategori 
           AND OLD.status_pembayaran = NEW.status_pembayaran 
           AND OLD.harga = NEW.harga) THEN
        
        IF NEW.harga <= 0 THEN
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Harga tiket harus lebih dari 0';
        END IF;
        
        IF NEW.kategori NOT IN ('reguler', 'VIP') THEN
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Kategori tiket harus reguler atau VIP';
        END IF;
        
        IF NEW.status_pembayaran NOT IN ('lunas', 'belum lunas') THEN
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Status pembayaran harus lunas atau belum lunas';
        END IF;
        
        IF OLD.kategori = 'VIP' AND NEW.kategori = 'reguler' AND OLD.status_pembayaran = 'lunas' THEN
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Tidak dapat mengubah tiket VIP yang sudah lunas menjadi reguler';
        END IF;
    END IF;
END; 

//
DELIMITER ;