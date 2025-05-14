-- SQL script to insert data into the database

USE BMF;

-- =============================================
-- Lokasi
-- =============================================
INSERT INTO Lokasi (id_lokasi, nama, kapasitas) VALUES (1, 'Stadion Gelora Bung Karno', 342138);
INSERT INTO Lokasi (id_lokasi, nama, kapasitas) VALUES (2, 'JCC Senayan', 305044);
INSERT INTO Lokasi (id_lokasi, nama, kapasitas) VALUES (3, 'Balai Kartini', 33401);
INSERT INTO Lokasi (id_lokasi, nama, kapasitas) VALUES (4, 'ICE BSD', 102407);
INSERT INTO Lokasi (id_lokasi, nama, kapasitas) VALUES (5, 'Stadion Pakansari', 271111);
INSERT INTO Lokasi (id_lokasi, nama, kapasitas) VALUES (6, 'Gedung Graha Manggala', 39317);
INSERT INTO Lokasi (id_lokasi, nama, kapasitas) VALUES (7, 'Sasana Budaya Ganesha', 22019);
INSERT INTO Lokasi (id_lokasi, nama, kapasitas) VALUES (8, 'Stadion Si Jalak Harupat', 351285);
INSERT INTO Lokasi (id_lokasi, nama, kapasitas) VALUES (9, 'Auditorium Telkom University', 131128);
INSERT INTO Lokasi (id_lokasi, nama, kapasitas) VALUES (10, 'Universitas Indonesia Convention Center', 12905);
INSERT INTO Lokasi (id_lokasi, nama, kapasitas) VALUES (11, 'Stadion Mandala Krida', 139855);
INSERT INTO Lokasi (id_lokasi, nama, kapasitas) VALUES (12, 'Ciputra Artpreneur', 108752);
INSERT INTO Lokasi (id_lokasi, nama, kapasitas) VALUES (13, 'Stadion Batakan', 106169);
INSERT INTO Lokasi (id_lokasi, nama, kapasitas) VALUES (14, 'Jakarta International Expo', 151654);
INSERT INTO Lokasi (id_lokasi, nama, kapasitas) VALUES (15, 'Stadion Manahan Solo', 399691);
INSERT INTO Lokasi (id_lokasi, nama, kapasitas) VALUES (16, 'Universitas Airlangga Hall', 153353);
INSERT INTO Lokasi (id_lokasi, nama, kapasitas) VALUES (17, 'Stadion Gajayana', 144056);
INSERT INTO Lokasi (id_lokasi, nama, kapasitas) VALUES (18, 'The Kasablanka Hall', 272824);
INSERT INTO Lokasi (id_lokasi, nama, kapasitas) VALUES (19, 'Stadion Kapten I Wayan Dipta', 459135);
INSERT INTO Lokasi (id_lokasi, nama, kapasitas) VALUES (20, 'Taman Budaya Jawa Barat', 93729);
INSERT INTO Lokasi (id_lokasi, nama, kapasitas) VALUES (21, 'Universitas Negeri Malang Dome', 254655);
INSERT INTO Lokasi (id_lokasi, nama, kapasitas) VALUES (22, 'Stadion Kanjuruhan', 477444);
INSERT INTO Lokasi (id_lokasi, nama, kapasitas) VALUES (23, 'Jogja Expo Center', 210128);
INSERT INTO Lokasi (id_lokasi, nama, kapasitas) VALUES (24, 'Stadion Sriwedari', 373587);
INSERT INTO Lokasi (id_lokasi, nama, kapasitas) VALUES (25, 'Gedung Pewayangan TMII', 344409);
INSERT INTO Lokasi (id_lokasi, nama, kapasitas) VALUES (26, 'Gedung Juang 45 Surabaya', 13968);
INSERT INTO Lokasi (id_lokasi, nama, kapasitas) VALUES (27, 'Universitas Padjadjaran Convention Hall', 26613);
INSERT INTO Lokasi (id_lokasi, nama, kapasitas) VALUES (28, 'Stadion Patriot Candrabhaga', 355107);
INSERT INTO Lokasi (id_lokasi, nama, kapasitas) VALUES (29, 'Sabuga ITB', 329446);
INSERT INTO Lokasi (id_lokasi, nama, kapasitas) VALUES (30, 'Stadion Brawijaya', 405053);
INSERT INTO Lokasi (id_lokasi, nama, kapasitas) VALUES (31, 'Taman Ismail Marzuki', 222354);
INSERT INTO Lokasi (id_lokasi, nama, kapasitas) VALUES (32, 'Balai Sarbini', 246709);
INSERT INTO Lokasi (id_lokasi, nama, kapasitas) VALUES (33, 'Gor Amongrogo', 291823);
INSERT INTO Lokasi (id_lokasi, nama, kapasitas) VALUES (34, 'Stadion Utama Riau', 487066);
INSERT INTO Lokasi (id_lokasi, nama, kapasitas) VALUES (35, 'Graha Saba Buana', 249221);
INSERT INTO Lokasi (id_lokasi, nama, kapasitas) VALUES (36, 'Universitas Diponegoro Convention Hall', 140177);
INSERT INTO Lokasi (id_lokasi, nama, kapasitas) VALUES (37, 'Gedung Soemardjo IPB', 80157);
INSERT INTO Lokasi (id_lokasi, nama, kapasitas) VALUES (38, 'Stadion Maguwoharjo', 422985);
INSERT INTO Lokasi (id_lokasi, nama, kapasitas) VALUES (39, 'Lapangan Gasibu', 342242);
INSERT INTO Lokasi (id_lokasi, nama, kapasitas) VALUES (40, 'The Trans Convention Center', 432553);
INSERT INTO Lokasi (id_lokasi, nama, kapasitas) VALUES (41, 'GOR Sritex Arena', 314148);
INSERT INTO Lokasi (id_lokasi, nama, kapasitas) VALUES (42, 'Gedung Pertunjukan Taman Budaya Bali', 435276);
INSERT INTO Lokasi (id_lokasi, nama, kapasitas) VALUES (43, 'Gedung Wanita Semarang', 260387);
INSERT INTO Lokasi (id_lokasi, nama, kapasitas) VALUES (44, 'Stadion Tri Dharma Gresik', 236810);
INSERT INTO Lokasi (id_lokasi, nama, kapasitas) VALUES (45, 'Gedung Kesenian Jakarta', 74337);
INSERT INTO Lokasi (id_lokasi, nama, kapasitas) VALUES (46, 'Bali Nusa Dua Convention Center', 408589);
INSERT INTO Lokasi (id_lokasi, nama, kapasitas) VALUES (47, 'Cendrawasih Hall Jakarta', 321731);
INSERT INTO Lokasi (id_lokasi, nama, kapasitas) VALUES (48, 'Stadion Mandala Papua', 122986);
INSERT INTO Lokasi (id_lokasi, nama, kapasitas) VALUES (49, 'Universitas Andalas Convention Hall', 220030);
INSERT INTO Lokasi (id_lokasi, nama, kapasitas) VALUES (50, 'Gedung Merdeka Bandung', 218573);

-- =============================================
-- Fasilitas_Lokasi
-- =============================================

-- =============================================
-- Pertunjukan
-- =============================================
INSERT INTO Pertunjukan (nama, waktu, id_lokasi) VALUES 
('Soundnesia Vibes', '2025-03-12 19:00:00', 1),
('Nusantara Beats Fest', '2025-04-20 17:30:00', 2),
('Dangdut On The Roof', '2025-05-05 20:00:00', 3),
('Jazzanesia', '2025-06-01 18:00:00', 4),
('Batik & Beats', '2025-02-14 10:00:00', 5),
('Merdeka Sound Clash', '2025-08-17 19:00:00', 6),
('IndoPop Parade', '2025-10-04 15:30:00', 7),
('Kampung EDM Fest', '2025-03-30 20:00:00', 8),
('Anak Negeri Live!', '2025-07-21 18:30:00', 9),
('Selatan Soundwave', '2025-09-08 19:45:00', 10),
('Legendary Rhythms', '2025-01-25 19:00:00', 11),
('Kampus Indie Night', '2025-04-15 16:00:00', 12),
('EtnicRock Live', '2025-05-10 20:00:00', 13),
('Tari x Trap Fusion', '2025-06-25 18:00:00', 14),
('Musik Lokal Anthem', '2025-03-17 20:30:00', 15),
('Sastra Sound Story', '2025-11-09 17:00:00', 16),
('Majapahit Rave', '2025-12-05 19:30:00', 17),
('Jazz di Rimba', '2025-04-27 20:00:00', 18),
('Folk & Fun Fest', '2025-08-09 10:00:00', 19),
('Reog on Stage', '2025-07-12 14:00:00', 20),
('CeritaRakyat Live', '2025-05-29 19:00:00', 21),
('PopReligi Glow Up', '2025-06-07 20:30:00', 22),
('KontempoBeats', '2025-02-02 17:00:00', 23),
('StudentSoundNation', '2025-01-30 15:00:00', 24),
('Nusantara Collab Show', '2025-03-20 19:45:00', 25),
('Tradisound Indonesia', '2025-09-27 18:30:00', 26),
('DramaWave Live', '2025-06-15 20:00:00', 27),
('Dangdut Millenials Night', '2025-08-01 19:00:00', 28),
('ArtVibe Gallery', '2025-11-15 11:00:00', 29),
('Gamelan Invasion', '2025-12-20 19:00:00', 30),
('Rindu Islami Fest', '2025-04-01 18:45:00', 31),
('Teater Gen-Z', '2025-07-04 20:00:00', 32),
('Komedifest: Ketawa Lokal', '2025-03-09 20:30:00', 33),
('Simfoni Rindu', '2025-05-23 19:15:00', 34),
('Sekolah Punya Panggung', '2025-06-18 10:00:00', 35),
('Anak Ceria Musik', '2025-02-25 13:30:00', 36),
('Tribute 90s Heroes', '2025-10-22 20:00:00', 37),
('CultureWave Expo', '2025-11-29 14:30:00', 38),
('Papua Vibes Show', '2025-12-01 17:00:00', 39),
('Street Sound Indie', '2025-07-18 19:00:00', 40),
('Borneo Bass Bash', '2025-08-26 20:30:00', 41),
('MonoDrama Vibe', '2025-01-05 18:00:00', 42),
('Royal Love Opera', '2025-09-11 19:00:00', 43),
('SilentFest (Pantomime Music)', '2025-05-16 16:30:00', 44),
('Kidung Chill Night', '2025-10-01 20:00:00', 45),
('Bali Bounce Show', '2025-02-11 18:00:00', 46),
('LOL Sitkom Stage', '2025-03-04 19:00:00', 47),
('Lo-Fi Akustik Night', '2025-06-20 21:00:00', 48),
('CampusWave Fest', '2025-09-15 20:00:00', 49),
('Seni & Suara Expo', '2025-07-28 14:00:00', 50);

-- =============================================
-- Sponsor
-- =============================================
INSERT INTO Sponsor (id_pertunjukan, jenis_sponsorship, nama_perusahaan, kontribusi) VALUES 
(1, 'Utama', 'Telkom Kreatif Nusantara', 150000000.00),
(1, 'Media Partner', 'GenZ SoundWave', 25000000.00),
(2, 'Utama', 'Indie Musik Indonesia', 120000000.00),
(3, 'Utama', 'Gudang Garam Musik', 170000000.00),
(3, 'Snack Partner', 'Cemilix', 35000000.00),
(4, 'Utama', 'Bank Harmoni Raya', 190000000.00),
(4, 'Streaming Partner', 'Vidku', 40000000.00),
(5, 'Utama', 'Sandal Swallow X', 110000000.00),
(6, 'Utama', 'AQUA Musik', 95000000.00),
(7, 'Utama', 'Spotify Nusantara', 140000000.00),
(8, 'Utama', 'Javabeat Co.', 115000000.00),
(8, 'Food Partner', 'Bakso Karakter', 27000000.00),
(9, 'Utama', 'Bank Pemuda Berkarya', 130000000.00),
(10, 'Utama', 'Shooz.id', 99000000.00),
(11, 'Utama', 'IndoTunes', 145000000.00),
(12, 'Utama', 'Jakarta Indie Sound', 138000000.00),
(13, 'Utama', 'Radio Remaja FM', 105000000.00),
(13, 'Fashion Partner', 'Gen-Z Wear', 18000000.00),
(14, 'Utama', 'Djarum Kreatif', 160000000.00),
(15, 'Utama', 'KopiSenja Group', 87000000.00),
(15, 'Media Partner', 'ReelBeat ID', 22000000.00),
(16, 'Utama', 'IndoNet Streaming', 125000000.00),
(17, 'Utama', 'Bank Mandiri Kreatif', 148000000.00),
(17, 'Snack Partner', 'Taro Youth Bites', 25000000.00),
(18, 'Utama', 'Musik Lokal Indo', 109000000.00),
(19, 'Utama', 'Cimory Live Fest', 102000000.00),
(20, 'Utama', 'Bank BNI Youth', 134000000.00),
(21, 'Utama', 'GenPi Indonesia', 96000000.00),
(21, 'Streaming Partner', 'Tontonin.id', 41000000.00),
(22, 'Utama', 'Gudeg Records', 127000000.00),
(23, 'Utama', 'Lo-Fi Society', 117000000.00),
(24, 'Utama', 'Pegadaian Musik', 143000000.00),
(25, 'Utama', 'Gopay Music Nation', 137000000.00),
(25, 'Media Partner', 'BuzzVibes', 28000000.00),
(26, 'Utama', 'Bank Indonesia Muda', 154000000.00),
(27, 'Utama', 'Viralindo Media', 98000000.00),
(28, 'Utama', 'Pocari Soundsation', 165000000.00),
(29, 'Utama', 'Oli DJ Night', 93000000.00),
(30, 'Utama', 'Mixue Musik Fest', 152000000.00),
(31, 'Utama', 'Akustik.id', 105000000.00),
(32, 'Utama', 'Milenial Kreatif', 124000000.00),
(33, 'Utama', 'TiketNow', 140000000.00),
(34, 'Utama', 'LokalHarmoni Records', 118000000.00),
(35, 'Utama', 'Aksara Musik', 102000000.00),
(36, 'Utama', 'Zenius Culture', 95000000.00),
(36, 'Snack Partner', 'NongkiNong', 29000000.00),
(37, 'Utama', 'Rumah Musik Pemuda', 112000000.00),
(38, 'Utama', 'Papua Go Fest', 168000000.00),
(39, 'Utama', 'Superior Sound Lab', 135000000.00),
(40, 'Utama', 'Bengkel Musik ID', 121000000.00),
(40, 'Fashion Partner', 'Swag Nusantara', 24000000.00),
(41, 'Utama', 'Java Jazz Youth', 134000000.00),
(42, 'Utama', 'Esch Harmony', 101000000.00),
(43, 'Utama', 'KreasiKita Fest', 98000000.00),
(44, 'Utama', 'Bali FM', 106000000.00),
(45, 'Utama', 'Kidung Production', 95000000.00),
(46, 'Utama', 'GenSatu Musik', 99000000.00),
(47, 'Utama', 'TiktokEvent ID', 108000000.00),
(48, 'Utama', 'Akselerasi Muda', 102000000.00),
(49, 'Utama', 'Mahasiswa Creative Lab', 120000000.00),
(50, 'Utama', 'Suara Anak Bangsa', 128000000.00);

-- =============================================
-- Mendukung
-- =============================================

-- =============================================
-- Vendor
-- =============================================
INSERT INTO Vendor (id_pertunjukan, nama, jenis_layanan) VALUES 
(1, 'SonicBoom Audio', 'Sound System'),
(1, 'TwinkleLights', 'Lighting'),
(1, 'RasaRia Bites', 'Catering'),

(2, 'ZenithStage', 'Dekorasi'),
(2, 'ChillByte', 'Multimedia'),

(3, 'TasteTribe', 'Catering'),
(3, 'LitLux Lighting', 'Lighting'),
(3, 'SafeZone', 'Keamanan'),

(4, 'BeatFlow Crew', 'Sound System'),
(4, 'Moodify', 'Lighting'),

(5, 'GrubNGo', 'Catering'),
(5, 'GrooveSecure', 'Keamanan'),
(5, 'VisualVibe', 'Multimedia'),

(6, 'PixelDrop', 'Multimedia'),
(6, 'SnackRush', 'Catering'),

(7, 'EchoWave', 'Sound System'),
(7, 'AuraLights', 'Lighting'),

(8, 'SafeZone', 'Keamanan'),
(8, 'FlashFlex', 'Lighting'),

(9, 'KopiKeren', 'Catering'),
(9, 'Luminix', 'Lighting'),
(9, 'Guardrilla', 'Keamanan'),

(10, 'SnackBar.id', 'Catering'),
(10, 'RaveWave', 'Sound System'),

(11, 'StageShine', 'Dekorasi'),
(11, 'TeraTunes', 'Sound System'),

(12, 'IndoGlow', 'Lighting'),
(12, 'NgemilYuk', 'Catering'),

(13, 'DigiBeats', 'Multimedia'),
(13, 'SnackSpace', 'Catering'),
(13, 'CrowdSafe', 'Keamanan'),

(14, 'LiteLife', 'Lighting'),
(14, 'SukaCita Foods', 'Catering'),

(15, 'EpicEcho', 'Sound System'),
(15, 'GlitzSecure', 'Keamanan'),

(16, 'TeraLight', 'Lighting'),
(16, 'WartegXpress', 'Catering'),

(17, 'RiotRoom', 'Sound System'),
(17, 'Guardify', 'Keamanan'),

(18, 'VibeNosh', 'Catering'),
(18, 'BeamBox', 'Lighting'),

(19, 'GlowSquad', 'Lighting'),
(19, 'Snackzilla', 'Catering'),

(20, 'StageGuard', 'Keamanan'),
(20, 'EchoLite', 'Sound System'),

(21, 'CitraSound', 'Sound System'),
(21, 'LumaTech', 'Lighting'),
(21, 'DapoerBoom', 'Catering'),

(22, 'NextGen Food', 'Catering'),
(22, 'HaloSecure', 'Keamanan'),

(23, 'LEDGeeks', 'Lighting'),
(23, 'AudioTrix', 'Sound System'),

(24, 'SnapCater', 'Catering'),
(24, 'BuzzBeat', 'Sound System'),

(25, 'EventEats', 'Catering'),
(25, 'LightItUp', 'Lighting'),
(25, 'Watchtower', 'Keamanan'),

(26, 'BoomBox Pro', 'Sound System'),
(26, 'VisualX', 'Multimedia'),

(27, 'BiteHub', 'Catering'),
(27, 'NightGlow', 'Lighting'),

(28, 'ResoSound', 'Sound System'),
(28, 'SecureNova', 'Keamanan'),

(29, 'SnackVerse', 'Catering'),
(29, 'LEDLux', 'Lighting'),

(30, 'SoundHive', 'Sound System'),
(30, 'FlashGuard', 'Keamanan'),

(31, 'KulinaFest', 'Catering'),
(31, 'GlowRun', 'Lighting'),

(32, 'XpressStage', 'Dekorasi'),
(32, 'GrooveByte', 'Sound System'),

(33, 'TastyTrip', 'Catering'),
(33, 'IllumiPro', 'Lighting'),

(34, 'SafeJaga', 'Keamanan'),
(34, 'AudioNova', 'Sound System'),

(35, 'GigByte', 'Multimedia'),
(35, 'BitesNChill', 'Catering'),

(36, 'LumaLite', 'Lighting'),
(36, 'SnackRush', 'Catering'),

(37, 'BassBoys', 'Sound System'),
(37, 'NightLite', 'Lighting'),

(38, 'TendaKu', 'Dekorasi'),
(38, 'QuickSnack', 'Catering'),

(39, 'EliteSound', 'Sound System'),
(39, 'AuraSafe', 'Keamanan'),

(40, 'Foodzies', 'Catering'),
(40, 'Lumez', 'Lighting'),

(41, 'SonicBrew', 'Sound System'),
(41, 'CineFlash', 'Multimedia'),

(42, 'ChillnBite', 'Catering'),
(42, 'VibeSecure', 'Keamanan'),

(43, 'EventGlow', 'Lighting'),
(43, 'SoundPilot', 'Sound System'),

(44, 'SnackMates', 'Catering'),
(44, 'Lumixx', 'Lighting'),

(45, 'SafeNetra', 'Keamanan'),
(45, 'AudioGaze', 'Sound System'),

(46, 'DapurJamanNow', 'Catering'),
(46, 'FlashMobs', 'Lighting'),

(47, 'SecureLink', 'Keamanan'),
(47, 'BoomWave', 'Sound System'),

(48, 'MakanMania', 'Catering'),
(48, 'LiteOn', 'Lighting'),

(49, 'BassStorm', 'Sound System'),
(49, 'Glimmer', 'Lighting'),

(50, 'FoodRush', 'Catering'),
(50, 'LightUp Crew', 'Lighting');

-- =============================================
-- Artis
-- =============================================
INSERT INTO Artis (id_artis, nama, negara_asal, biografi) VALUES
(1, 'Lunar Echo', 'Indonesia', 'Grup elektronik-pop asal Jakarta yang dikenal dengan beat dreamy dan lirik puitis.'),
(2, 'NeonDrift', 'Amerika Serikat', 'DJ dan produser musik EDM dari LA dengan gaya futuristik.'),
(3, 'Soulstice', 'Inggris', 'Band indie soul dengan nuansa lo-fi dan vokal mellow.'),
(4, 'Aurora Haze', 'Australia', 'Penyanyi solo yang memadukan pop dan ambient dengan lirik introspektif.'),
(5, 'Funkzilla', 'Brazil', 'Band funk rock yang energik dan sering tampil dengan koreografi unik.'),
(6, 'Midnight Mango', 'Indonesia', 'Duo elektronik-akustik dari Bandung yang viral di TikTok.'),
(7, 'TrapKoala', 'Korea Selatan', 'Rapper Gen Z dengan trap beat yang eksperimental.'),
(8, 'ZynthWave', 'Jerman', 'Grup synthwave yang mengusung nuansa retro 80an.'),
(9, 'Cloudberry', 'Swedia', 'Solois bergenre dream pop dengan suara lembut dan estetika visual artsy.'),
(10, 'KopiLoops', 'Indonesia', 'Produser lo-fi beats yang sering muncul di playlist belajar dan ngopi.'),
(11, 'RAVE++', 'Belanda', 'Grup tekno underground yang dikenal di festival rave Eropa.'),
(12, 'ChocoTrap', 'Jepang', 'Trio hyperpop dengan visual kawaii dan musik over-the-top.'),
(13, 'Serenade.exe', 'Singapura', 'Duo elektronik dengan sentuhan cyberpunk dan glitch.'),
(14, 'NusaNova', 'Indonesia', 'Grup world music dengan elemen etnik Bali dan jazz modern.'),
(15, 'Glitchbloom', 'Prancis', 'Band rock elektronik dengan vokal auto-tune artistik.'),
(16, 'PixelMuse', 'Kanada', 'Produser yang memadukan chip tune dan musik klasik.'),
(17, 'RimbaNoise', 'Indonesia', 'Grup eksperimental yang menggunakan suara hutan dan suara manusia.'),
(18, 'VelvetFire', 'Italia', 'Vokalis pop-rock dengan performa panggung teatrikal.'),
(19, 'NeoRasa', 'Indonesia', 'Kolaborasi musisi jazz dan RnB dengan gaya Gen Z.'),
(20, 'EchoRush', 'India', 'Band alternative rock dengan elemen sitar dan synth.');

-- =============================================
-- Genre_Artis
-- =============================================
INSERT INTO Genre_Artis (id_artis, genre) VALUES
(1, 'Electronic Pop'),
(1, 'Dream Pop'),

(2, 'EDM'),
(2, 'Future Bass'),

(3, 'Indie Soul'),
(3, 'Lo-fi'),

(4, 'Pop'),
(4, 'Ambient'),

(5, 'Funk'),
(5, 'Rock'),

(6, 'Electronic'),
(6, 'Acoustic'),

(7, 'Trap'),
(7, 'Hip Hop'),

(8, 'Synthwave'),
(8, 'Retro'),

(9, 'Dream Pop'),
(9, 'Indie'),

(10, 'Lo-fi'),
(10, 'Instrumental'),

(11, 'Techno'),
(11, 'Electronic'),

(12, 'Hyperpop'),
(12, 'Pop'),

(13, 'Electronic'),
(13, 'Glitch'),

(14, 'World'),
(14, 'Jazz'),

(15, 'Electronic Rock'),
(15, 'Glitch Pop'),

(16, 'Chiptune'),
(16, 'Classical'),

(17, 'Experimental'),
(17, 'Ambient'),

(18, 'Pop Rock'),
(18, 'Theatrical Pop'),

(19, 'Jazz'),
(19, 'R&B'),

(20, 'Alternative Rock'),
(20, 'Synth Rock');

-- =============================================
-- Kontak_Artis
-- =============================================
INSERT INTO Kontak_Artis (id_artis, kontak) VALUES
(1, 'lunarecho@artistmail.com'),
(1, '@lunarecho_official'),

(2, 'neondrift.music@gmail.com'),
(2, '@neondrift'),

(3, 'soulstice_band@ukmail.com'),
(3, '@soulsticeband'),

(4, 'aurorahaze@ozmusic.au'),
(4, '@aurorahaze_'),

(5, 'funkzilla@braziltunes.com'),
(5, '@funkzilla'),

(6, 'midnightmango@beatmail.id'),
(6, '@midnightmango'),

(7, 'trapkoala@khiphop.kr'),
(7, '@trapkoala_kr'),

(8, 'zynthwave@musicmail.de'),
(8, '@zynthwave808'),

(9, 'cloudberry@swemusic.se'),
(9, '@cloudberry.music'),

(10, 'kopiloops@lofi.id'),
(10, '@kopiloops'),

(11, 'raveplusplus@underground.nl'),
(11, '@raveplusplus'),

(12, 'chocotrap@jpopmail.jp'),
(12, '@chocotrap_official'),

(13, 'serenade.exe@cybermail.sg'),
(13, '@serenade.exe'),

(14, 'nusanova@worldbeat.id'),
(14, '@nusanova'),

(15, 'glitchbloom@frsound.fr'),
(15, '@glitchbloom'),

(16, 'pixelmuse@canadatunes.ca'),
(16, '@pixelmuse_music'),

(17, 'rimbanoise@eksperimen.id'),
(17, '@rimbanoise'),

(18, 'velvetfire@theatropop.it'),
(18, '@velvetfire_official'),

(19, 'neorasa@indojazz.id'),
(19, '@neorasa.music'),

(20, 'echorush@indierock.in'),
(20, '@echorush_band');

-- =============================================
-- Tampil
-- =============================================
INSERT INTO Tampil (id_artis, id_pertunjukan) VALUES
-- Pertunjukan 1–10
(1, 1), (2, 1), (3, 1), (4, 1), (5, 1),
(1, 2), (6, 2), (7, 2), (8, 2), (9, 2),
(10, 3), (2, 3), (5, 3), (11, 3), (12, 3),
(13, 4), (6, 4), (3, 4), (14, 4), (15, 4),
(16, 5), (4, 5), (7, 5), (17, 5), (18, 5),
(19, 6), (8, 6), (9, 6), (12, 6), (10, 6),
(20, 7), (15, 7), (14, 7), (2, 7), (1, 7),
(3, 8), (16, 8), (11, 8), (13, 8), (17, 8),
(4, 9), (18, 9), (5, 9), (7, 9), (19, 9),
(6, 10), (8, 10), (20, 10), (10, 10), (12, 10),

-- Pertunjukan 11–20
(13, 11), (14, 11), (1, 11), (5, 11), (6, 11),
(7, 12), (2, 12), (9, 12), (10, 12), (3, 12),
(15, 13), (16, 13), (11, 13), (12, 13), (4, 13),
(17, 14), (18, 14), (19, 14), (8, 14), (1, 14),
(20, 15), (5, 15), (7, 15), (6, 15), (2, 15),
(3, 16), (4, 16), (13, 16), (14, 16), (9, 16),
(10, 17), (15, 17), (16, 17), (1, 17), (17, 17),
(11, 18), (12, 18), (18, 18), (19, 18), (2, 18),
(20, 19), (3, 19), (4, 19), (5, 19), (6, 19),
(7, 20), (8, 20), (9, 20), (10, 20), (11, 20);

-- =============================================
-- Penonton
-- =============================================

-- =============================================
-- Panitia_Pelaksana
-- =============================================

-- =============================================
-- Diurus_Oleh
-- =============================================

-- =============================================
-- Tiket
-- =============================================

-- =============================================
-- Tiker_Reguler
-- =============================================

-- =============================================
-- Tiker_VIP
-- =============================================

-- =============================================
-- Mendapatkan
-- =============================================

-- =============================================
-- Merchandise
-- =============================================
INSERT INTO merchandise (kategori, harga) VALUES
('Concert T-Shirt', 200000.00),
('Official Poster', 50000.00),
('Lightstick', 350000.00),
('Physical Album', 150000.00),
('Band Cap', 120000.00),
('Tote Bag', 100000.00),
('Keychain', 30000.00),
('Lanyard Exclusive', 25000.00),
('Sticker Pack', 20000.00),
('Hoodie Limited Edition', 275000.00),
('Photocard Set', 60000.00),
('Band-Themed Notebook', 45000.00),
('CD Boxset', 250000.00),
('Glow Wristband', 40000.00),
('Mini Banner', 35000.00),
('Band Face Mask', 25000.00),
('Folding Fan', 30000.00),
('Necklace - Band Logo', 85000.00),
('Rubber Wristband', 20000.00),
('Enamel Pin Set', 30000.00);

-- =============================================
-- Nomor_Telepon_Penonton
-- =============================================
INSERT INTO nomor_telepon_penonton (id_penonton, nomor_telepon) VALUES
(1, '081234567890'),
(1, '082112345678'),
(1, '089998877665'),
(2, '089876543210'),
(2, '087712341234'),
(2, '081212344321'),
(3, '081223344556'),
(3, '082165432187'),
(4, '082298765432'),
(4, '085698741236'),
(5, '085612341234'),
(5, '081298765432'),
(5, '082176543210'),
(6, '089912345678'),
(6, '081223456789'),
(7, '081234123412'),
(7, '082199998877'),
(8, '085723412341'),
(8, '089912387654'),
(9, '082198761234'),
(9, '087823456789'),
(9, '081276543210'),
(10, '083812345678'),
(10, '083812312312'),
(11, '081287654321'),
(11, '085612398765'),
(12, '081234567891'),
(12, '081276543234'),
(13, '082122334455'),
(13, '089912341234'),
(13, '081298761234'),
(14, '085698765432'),
(14, '087812376543'),
(15, '087712398765'),
(15, '083812398765'),
(16, '081223345566'),
(16, '082199887766'),
(16, '081234876543'),
(17, '089976543210'),
(17, '081298745612'),
(17, '089987654321'),
(18, '087812341234'),
(18, '082187654321'),
(18, '083898765432'),
(19, '085623412345'),
(19, '089912398765'),
(19, '087756789012'),
(20, '081212345678'),
(20, '082112398765'),
(20, '083812345123');

-- =============================================
-- Alamat_Penonton
-- =============================================
INSERT INTO alamat_penonton (id_penonton, alamat) VALUES
(1, 'Jl. Melati No. 12, Bandung'),
(1, 'Jl. Cempaka 45, Jakarta Selatan'),
(1, 'Jl. Sabang No. 14, Jakarta Pusat'),
(2, 'Jl. Merdeka No. 5, Surabaya'),
(2, 'Jl. Anggrek Raya No. 17, Bandung'),
(2, 'Jl. Mangga Dua No. 18, Jakarta Utara'),
(3, 'Jl. Sudirman No. 101, Yogyakarta'),
(3, 'Jl. Mawar No. 33, Tangerang'),
(3, 'Jl. Sultan Agung No. 29, Bekasi'),
(4, 'Jl. Kenanga No. 23, Jakarta Utara'),
(4, 'Jl. Dr. Sutomo No. 6, Medan'),
(5, 'Jl. Ahmad Yani No. 88, Bekasi'),
(5, 'Jl. Rawa Belong No. 9, Jakarta Barat'),
(6, 'Jl. Cemara No. 4, Depok'),
(6, 'Jl. Gatot Subroto No. 40, Jakarta Selatan'),
(7, 'Jl. Imam Bonjol No. 21, Bogor'),
(7, 'Jl. Ciledug Raya No. 23, Tangerang'),
(8, 'Jl. Gajah Mada No. 30, Semarang'),
(8, 'Jl. Pemuda No. 77, Semarang'),
(9, 'Jl. Siliwangi No. 12, Bandung'),
(9, 'Jl. Kaliurang Km 6, Sleman'),
(9, 'Jl. Pahlawan No. 3, Malang'),
(10, 'Jl. Rajawali No. 56, Surabaya'),
(10, 'Jl. Pandanaran No. 2, Semarang'),
(11, 'Jl. Diponegoro No. 78, Denpasar'),
(11, 'Jl. Cikini No. 2, Jakarta Pusat'),
(12, 'Jl. Cendana No. 9, Medan'),
(12, 'Jl. Veteran No. 21, Surakarta'),
(13, 'Jl. Kalibata No. 77, Jakarta Selatan'),
(13, 'Jl. Raya Bogor Km 27, Depok'),
(13, 'Jl. Gading Serpong No. 66, Tangerang'),
(14, 'Jl. Raya Margonda No. 99, Depok'),
(14, 'Jl. Raden Saleh No. 18, Jakarta Pusat'),
(15, 'Jl. Pondok Indah No. 12, Jakarta Selatan'),
(15, 'Jl. Margasatwa No. 88, Jakarta Selatan'),
(16, 'Jl. Letjen Suprapto No. 8, Palembang'),
(16, 'Jl. Teuku Umar No. 10, Banda Aceh'),
(16, 'Jl. Pajajaran No. 30, Bogor'),
(17, 'Jl. Gatsu Barat No. 45, Denpasar'),
(17, 'Jl. Gunung Sari No. 20, Bali'),
(17, 'Jl. Ahmad Dahlan No. 15, Yogyakarta');
(18, 'Jl. Rungkut Industri No. 5, Surabaya'),
(18, 'Jl. Raya Darmo No. 15, Surabaya'),
(18, 'Jl. Manyar No. 77, Surabaya'),
(19, 'Jl. Tunjungan No. 1, Surabaya'),
(19, 'Jl. Kebon Jeruk No. 17, Jakarta Barat'),
(19, 'Jl. Kebayoran Baru No. 3, Jakarta Selatan'),
(20, 'Jl. Asia Afrika No. 123, Bandung'),
(20, 'Jl. Dago Atas No. 55, Bandung'),
(20, 'Jl. Setiabudi No. 19, Bandung'),

-- =============================================
-- Transaksi_Pembelian
-- =============================================
INSERT INTO transaksi_pembelian (id_penonton, waktu_pembelian) VALUES
(1, '2025-04-10 14:23:45'),
(2, '2025-04-11 15:12:34'),
(3, '2025-04-12 16:45:00'),
(4, '2025-04-13 11:30:15'),
(5, '2025-04-14 18:20:00'),
(6, '2025-04-15 19:05:45'),
(7, '2025-04-16 13:55:00'),
(8, '2025-04-17 10:12:12'),
(9, '2025-04-17 21:33:33'),
(10, '2025-04-18 20:00:00'),
(11, '2025-04-19 09:45:30'),
(12, '2025-04-19 10:20:00'),
(13, '2025-04-20 14:30:00'),
(14, '2025-04-21 15:15:15'),
(15, '2025-04-21 17:17:17'),
(16, '2025-04-22 19:45:00'),
(17, '2025-04-23 12:00:00'),
(18, '2025-04-23 14:22:00'),
(19, '2025-04-24 11:11:11'),
(20, '2025-04-24 16:16:16'),
(1, '2025-04-25 13:00:00'),
(2, '2025-04-25 14:00:00'),
(3, '2025-04-26 15:00:00'),
(4, '2025-04-26 16:00:00'),
(5, '2025-04-27 17:00:00'),
(6, '2025-04-27 18:00:00'),
(7, '2025-04-28 10:30:00'),
(8, '2025-04-28 11:45:00'),
(9, '2025-04-29 12:15:00'),
(10, '2025-04-29 13:30:00'),
(11, '2025-04-30 14:45:00'),
(12, '2025-05-01 15:00:00'),
(13, '2025-05-01 16:30:00'),
(14, '2025-05-02 17:45:00'),
(15, '2025-05-02 19:00:00'),
(16, '2025-05-03 20:15:00'),
(17, '2025-05-03 21:30:00'),
(18, '2025-05-04 08:00:00'),
(19, '2025-05-04 09:15:00'),
(20, '2025-05-05 10:30:00'),
(1, '2025-05-05 11:45:00'),
(2, '2025-05-06 13:00:00'),
(3, '2025-05-06 14:15:00'),
(4, '2025-05-07 15:30:00'),
(5, '2025-05-07 16:45:00'),
(6, '2025-05-08 18:00:00'),
(7, '2025-05-08 19:15:00'),
(8, '2025-05-09 20:30:00'),
(9, '2025-05-09 21:45:00'),
(10, '2025-05-10 22:00:00');

-- =============================================
-- Terdaftar_Transaksi
-- =============================================
INSERT INTO terdaftar_transaksi (nomor_transaksi, kode_barang, kuantitas) VALUES
(1, 5, 2),
(1, 12, 1),
(2, 3, 1),
(2, 14, 2),
(3, 8, 3),
(3, 18, 1),
(4, 1, 2),
(5, 6, 1),
(6, 2, 1),
(6, 11, 2),
(7, 7, 3),
(8, 20, 1),
(9, 9, 2),
(10, 4, 1),
(11, 17, 1),
(12, 5, 3),
(13, 16, 1),
(14, 13, 1),
(15, 10, 2),
(16, 6, 1),
(17, 3, 1),
(18, 19, 1),
(19, 2, 2),
(20, 1, 1),
(21, 8, 2),
(22, 14, 1),
(23, 11, 2),
(24, 18, 3),
(25, 4, 1),
(26, 20, 1),
(27, 9, 2),
(28, 7, 1),
(29, 15, 2),
(30, 13, 1),
(31, 1, 3),
(32, 6, 1),
(33, 10, 1),
(34, 3, 2),
(35, 8, 1),
(36, 12, 2),
(37, 17, 1),
(38, 14, 1),
(39, 11, 2),
(40, 16, 1),
(41, 2, 3),
(42, 5, 1),
(43, 7, 1),
(44, 4, 2),
(45, 13, 2),
(46, 9, 1),
(47, 18, 1),
(48, 19, 2),
(49, 20, 1),
(50, 10, 1),
(1, 2, 1),
(2, 7, 1),
(3, 6, 2),
(4, 12, 2),
(5, 15, 1),
(6, 4, 2),
(7, 13, 1),
(8, 3, 1),
(9, 10, 3),
(10, 1, 2),
(11, 14, 1),
(12, 16, 1),
(13, 11, 2),
(14, 9, 2),
(15, 20, 1),
(16, 5, 1),
(17, 18, 1),
(18, 8, 2),
(19, 6, 2),
(20, 17, 1),
(21, 2, 1),
(22, 19, 1),
(23, 3, 1),
(24, 14, 2),
(25, 7, 3),
(26, 1, 1),
(27, 10, 2),
(28, 12, 1),
(29, 5, 2),
(30, 16, 1),
(31, 8, 1),
(32, 18, 1),
(33, 9, 1),
(34, 20, 1),
(35, 2, 2),
(36, 6, 1),
(37, 11, 1),
(38, 13, 1),
(39, 4, 2),
(40, 17, 1),
(41, 14, 1),
(42, 3, 1),
(43, 7, 1),
(44, 15, 2),
(45, 19, 1),
(46, 10, 2),
(47, 1, 1),
(48, 12, 2),
(49, 8, 2),
(50, 5, 1);