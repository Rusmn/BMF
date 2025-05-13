-- Buat database
CREATE DATABASE IF NOT EXISTS BMF;
USE BMF;

-- Tabel utama
CREATE TABLE Lokasi (
    id_lokasi INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(255) NOT NULL,
    kapasitas INT NOT NULL
) ENGINE=InnoDB;

CREATE TABLE Fasilitas_Lokasi (
    id_lokasi INT,
    fasilitas VARCHAR(255),
    PRIMARY KEY (id_lokasi, fasilitas(100)),
    FOREIGN KEY (id_lokasi) REFERENCES Lokasi(id_lokasi) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Pertunjukan (
    id_pertunjukan INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(255) NOT NULL,
    waktu DATETIME NOT NULL,
    id_lokasi INT NOT NULL,
    FOREIGN KEY (id_lokasi) REFERENCES Lokasi(id_lokasi)
) ENGINE=InnoDB;

CREATE TABLE Sponsor (
    id_sponsor INT AUTO_INCREMENT PRIMARY KEY,
    id_pertunjukan INT NOT NULL,
    jenis_sponsorship VARCHAR(100) NOT NULL,
    nama_perusahaan VARCHAR(255) NOT NULL,
    kontribusi DECIMAL(15,2) NOT NULL,
    FOREIGN KEY (id_pertunjukan) REFERENCES Pertunjukan(id_pertunjukan)
) ENGINE=InnoDB;

CREATE TABLE Vendor (
    id_vendor INT AUTO_INCREMENT PRIMARY KEY,
    id_pertunjukan INT NOT NULL,
    nama VARCHAR(255) NOT NULL,
    jenis_layanan VARCHAR(100) NOT NULL,
    FOREIGN KEY (id_pertunjukan) REFERENCES Pertunjukan(id_pertunjukan)
) ENGINE=InnoDB;

CREATE TABLE Artis (
    id_artis INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(255) NOT NULL,
    negara_asal VARCHAR(100) NOT NULL,
    biografi TEXT
) ENGINE=InnoDB;

CREATE TABLE Genre_Artis (
    id_artis INT,
    genre VARCHAR(100),
    PRIMARY KEY (id_artis, genre),
    FOREIGN KEY (id_artis) REFERENCES Artis(id_artis) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Kontak_Artis (
    id_artis INT,
    kontak VARCHAR(255),
    PRIMARY KEY (id_artis, kontak),
    FOREIGN KEY (id_artis) REFERENCES Artis(id_artis) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Tampil (
    id_artis INT,
    id_pertunjukan INT,
    PRIMARY KEY (id_artis, id_pertunjukan),
    FOREIGN KEY (id_artis) REFERENCES Artis(id_artis),
    FOREIGN KEY (id_pertunjukan) REFERENCES Pertunjukan(id_pertunjukan)
) ENGINE=InnoDB;

CREATE TABLE Penonton (
    id_penonton INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(255) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE Panitia_Pelaksana (
    id_panitia INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(255) NOT NULL,
    kontribusi VARCHAR(255) NOT NULL,
    kontak VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE Tiket (
    id_tiket INT AUTO_INCREMENT PRIMARY KEY,
    kategori ENUM('reguler', 'VIP') NOT NULL,
    harga DECIMAL(10,2) NOT NULL,
    status_pembayaran ENUM('lunas', 'belum lunas') NOT NULL,
    id_pertunjukan INT NOT NULL,
    id_penonton INT,
    FOREIGN KEY (id_pertunjukan) REFERENCES Pertunjukan(id_pertunjukan),
    FOREIGN KEY (id_penonton) REFERENCES Penonton(id_penonton)
) ENGINE=InnoDB;

CREATE TABLE Merchandise (
    kode_barang INT AUTO_INCREMENT PRIMARY KEY,
    kategori VARCHAR(100) NOT NULL,
    harga DECIMAL(10,2) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE Nomor_Telepon_Penonton (
    id_penonton INT,
    nomor_telepon VARCHAR(20),
    PRIMARY KEY (id_penonton, nomor_telepon),
    FOREIGN KEY (id_penonton) REFERENCES Penonton(id_penonton) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Alamat_Penonton (
    id_penonton INT,
    alamat TEXT,
    PRIMARY KEY (id_penonton, alamat(100)),
    FOREIGN KEY (id_penonton) REFERENCES Penonton(id_penonton) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Transaksi_Pembelian (
    id_penonton INT,
    nomor_transaksi INT,
    waktu_pembelian DATETIME NOT NULL,
    PRIMARY KEY (id_penonton, nomor_transaksi),
    FOREIGN KEY (id_penonton) REFERENCES Penonton(id_penonton) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Tiket_Reguler (
    id_tiket INT PRIMARY KEY,
    FOREIGN KEY (id_tiket) REFERENCES Tiket(id_tiket) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Tiket_VIP (
    id_tiket INT PRIMARY KEY,
    FOREIGN KEY (id_tiket) REFERENCES Tiket(id_tiket) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Mendukung (
    id_sponsor INT,
    id_pertunjukan INT,
    PRIMARY KEY (id_sponsor, id_pertunjukan),
    FOREIGN KEY (id_sponsor) REFERENCES Sponsor(id_sponsor),
    FOREIGN KEY (id_pertunjukan) REFERENCES Pertunjukan(id_pertunjukan)
) ENGINE=InnoDB;

CREATE TABLE Diurus_Oleh (
    id_pertunjukan INT,
    id_panitia INT,
    PRIMARY KEY (id_pertunjukan, id_panitia),
    FOREIGN KEY (id_pertunjukan) REFERENCES Pertunjukan(id_pertunjukan),
    FOREIGN KEY (id_panitia) REFERENCES Panitia_Pelaksana(id_panitia)
) ENGINE=InnoDB;

CREATE TABLE Terdaftar_Transaksi (
    id_penonton INT,
    nomor_transaksi INT,
    kode_barang INT,
    kuantitas INT NOT NULL,
    PRIMARY KEY (id_penonton, nomor_transaksi, kode_barang),
    FOREIGN KEY (id_penonton, nomor_transaksi) REFERENCES Transaksi_Pembelian(id_penonton, nomor_transaksi),
    FOREIGN KEY (kode_barang) REFERENCES Merchandise(kode_barang)
) ENGINE=InnoDB;

CREATE TABLE Mendapatkan (
    id_tiket INT,
    kode_barang INT,
    PRIMARY KEY (id_tiket, kode_barang),
    FOREIGN KEY (id_tiket) REFERENCES Tiket_VIP(id_tiket),
    FOREIGN KEY (kode_barang) REFERENCES Merchandise(kode_barang)
) ENGINE=InnoDB;
