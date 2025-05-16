## Tables
| Nama Table | Check |
|---------------------| ---- |
| Lokasi | v |
| Fasilitas_Lokasi | x | 
| Pertunjukan | v |
| Sponsor | v |
| Mendukung | x |
| Vendor | v |
| Artis | v |
| Genre_Artis | v |
| Kontak_Artis | v |
| Tampil | v |
| Penonton | x |
| Panitia_Pelaksana | x |
| Diurus_Oleh | x |
| Tiket | x |
| Tiket_Reguler | x | 
| Tiket_VIP | x | 
| Mendapatkan | x | 
| Merchandise | v | 
| Nomor_Telepon_Penonton | v | 
| Alamat_Penonton | v | 
| Transaksi_Pembelian | v | 
| Terdaftar_Transaksi | v | 

## Inisialisasi
### Linux
```bash
sudo mysql -u root -p < bmf.sql
```
### Windows
```bash
mysql -u root -p < bmf.sql
```


## Seed
### Linux
```bash
sudo mysql -u root -p < seed.sql
```

### Windows
```bash
mysql -u root -p < seed.sql
```
## Penghapusan Database
### Linux
```bash
sudo mysql -u root -p < drop.sql
```

### Windows
```bash
mysql -u root -p < drop.sql
```