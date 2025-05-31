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