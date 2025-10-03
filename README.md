# Laporan Keuangan Pribadi dengan hledger

Proyek sederhana ini menggunakan [hledger](https://hledger.org/) untuk mengelola keuangan pribadi melalui akuntansi teks biasa.

## Struktur File

- `2025.journal`: File data utama yang berisi semua entri transaksi.
- `hledger.css`: Stylesheet untuk laporan HTML.
- `index.html`: Halaman utama dengan tautan ke semua laporan.
- `laporan.sh`: Skrip untuk menghasilkan semua laporan HTML dari file journal.
- `*.html` (lainnya): File laporan yang dihasilkan secara otomatis.

## Cara Penggunaan

1.  **Catat Transaksi**: Tambahkan entri transaksi baru ke file `2025.journal`.
2.  **Hasilkan Laporan**: Jalankan skrip `./laporan.sh` dari terminal.
    ```bash
    ./laporan.sh
    ```
3.  **Lihat Laporan**: Buka file `index.html` di browser Anda untuk melihat semua laporan yang tersedia.