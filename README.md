## Tables
| Nama Table | Check |
|---------------------| ---- |
| lokasi | v |
| fasilitas_lokasi | x | 
| pertunjukan | v |
| sponsor | v |
| vendor | v |
| artis | v |
| genre_artis | v |
| kontak_artis | v |
| tampil | v |
| penonton | x |
| panitia_pelaksana | x |
| tiket | x |
| tiket_reguler | x | 
| tiket_vip | x | 
| merchandise | v | 
| nomor_telepon_penonton | v | 
| alamat_penonton | v | 
| transaksi_pembelian | v | 
| terdaftar_transaksi | v | 

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