from faker import Faker
import random
import uuid
import datetime

fake = Faker()

# Settings
n_lokasi = 5
n_pertunjukan = 10
n_vendor = 15
n_sponsor = 10
n_panitia = 10
n_artis = 10
n_penonton = 20
n_tiket = 30
n_merchandise = 10
n_transaksi = 15
n_terdapat_transaksi = 25

# 1. Lokasi
lokasi_data = [
    {
        "id_lokasi": i,
        "nama": fake.company(),
        "kapasitas": random.randint(100, 1000),
        "fasilitas": fake.text(max_nb_chars=50)
    }
    for i in range(1, n_lokasi + 1)
]

# 2. Pertunjukan
pertunjukan_data = [
    {
        "id_pertunjukan": i,
        "waktu": fake.date_time_this_year(),
        "nama": fake.catch_phrase(),
        "id_lokasi": random.randint(1, n_lokasi)
    }
    for i in range(1, n_pertunjukan + 1)
]

# 3. Vendor
vendor_data = [
    {
        "id_vendor": i,
        "nama": fake.company(),
        "jenis_layanan": random.choice(["Catering", "Sound", "Lighting", "Security"]),
        "id_pertunjukan": random.randint(1, n_pertunjukan)
    }
    for i in range(1, n_vendor + 1)
]

# 4. Sponsor
sponsor_data = [
    {
        "id_sponsor": i,
        "jenis_sponsor": random.choice(["Gold", "Silver", "Platinum"]),
        "nama_perusahaan": fake.company(),
        "kontribusi": round(random.uniform(1000, 10000), 2),
        "id_pertunjukan": random.randint(1, n_pertunjukan)
    }
    for i in range(1, n_sponsor + 1)
]

# 5. Panitia Pelaksana
panitia_data = [
    {
        "id_panitia": i,
        "nama": fake.name(),
        "kontribusi": random.choice(["Koordinator", "Anggota", "Pembina"]),
        "kontak": fake.phone_number(),
        "id_pertunjukan": random.randint(1, n_pertunjukan)
    }
    for i in range(1, n_panitia + 1)
]

# 6. Artis
artis_data = [
    {
        "id_artis": i,
        "nama": fake.name(),
        "genre": random.choice(["Pop", "Rock", "Jazz", "Hip-hop"]),
        "negara_asal": fake.country(),
        "kontak": fake.phone_number(),
        "biografi": fake.text(max_nb_chars=100)
    }
    for i in range(1, n_artis + 1)
]

# 7. Penampilan (Many-to-Many)
penampilan_data = [
    {
        "id_artis": random.randint(1, n_artis),
        "id_pertunjukan": random.randint(1, n_pertunjukan)
    }
    for _ in range(n_artis)
]

# 8. Penonton
penonton_data = [
    {
        "id_penonton": i,
        "nama": fake.name(),
        "email": fake.email(),
        "nomor_telepon": fake.phone_number(),
        "alamat": fake.address().replace("\n", ", ")
    }
    for i in range(1, n_penonton + 1)
]

# 9. Tiket
tiket_data = [
    {
        "id_tiket": i,
        "kategori": random.choice(["Reguler", "VIP"]),
        "harga": round(random.uniform(50, 200), 2),
        "status_pembayaran": random.choice(["Lunas", "Belum Lunas"]),
        "id_pertunjukan": random.randint(1, n_pertunjukan),
        "id_penonton": random.randint(1, n_penonton)
    }
    for i in range(1, n_tiket + 1)
]

# 10. Tiket Reguler & VIP
tiket_reguler_data = [ {"id_tiket": t["id_tiket"]} for t in tiket_data if t["kategori"] == "Reguler" ]
tiket_vip_data = [ {"id_tiket": t["id_tiket"], "kode_barang": str(uuid.uuid4())[:8]} for t in tiket_data if t["kategori"] == "VIP" ]

# 11. Merchandise
merchandise_data = [
    {
        "kode_barang": str(uuid.uuid4())[:8],
        "kategori": random.choice(["Kaos", "Topi", "Poster", "Stiker"]),
        "harga": round(random.uniform(5, 50), 2)
    }
    for _ in range(1, n_merchandise + 1)
]

# 12. Transaksi Pembelian
transaksi_data = [
    {
        "nomor_transaksi": str(uuid.uuid4())[:8],
        "total_harga": 0,  # will be filled based on merchandise
        "waktu_pembelian": fake.date_time_this_year(),
        "id_penonton": random.randint(1, n_penonton)
    }
    for _ in range(1, n_transaksi + 1)
]

# 13. Terdapat Transaksi (fill harga total also)
terdapat_transaksi_data = []
for t in transaksi_data:
    n_items = random.randint(1, 3)
    total = 0
    for _ in range(n_items):
        m = random.choice(merchandise_data)
        kuantitas = random.randint(1, 5)
        total += m["harga"] * kuantitas
        terdapat_transaksi_data.append({
            "nomor_transaksi": t["nomor_transaksi"],
            "kode_barang": m["kode_barang"],
            "kuantitas": kuantitas
        })
    t["total_harga"] = round(total, 2)

lokasi_data[:2], pertunjukan_data[:2], vendor_data[:2], sponsor_data[:2], panitia_data[:2], artis_data[:2], penonton_data[:2], tiket_data[:2], transaksi_data[:2], terdapat_transaksi_data[:2]
