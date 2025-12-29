# Laporan Keuangan Pribadi dengan hledger

[![MIT License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

Repositori ini berisi implementasi sistem akuntansi pribadi berbasis teks menggunakan [hledger](https://hledger.org/). Dengan memanfaatkan skrip otomatis, Anda dapat dengan mudah mencatat transaksi harian dan menghasilkan laporan keuangan interaktif dalam format HTML.

## Daftar Isi

- [Laporan Keuangan Pribadi dengan hledger](#laporan-keuangan-pribadi-dengan-hledger)
  - [Daftar Isi](#daftar-isi)
  - [Prasyarat](#prasyarat)
  - [Struktur Direktori](#struktur-direktori)
  - [Cara Penggunaan](#cara-penggunaan)
  - [Laporan yang Dihasilkan](#laporan-yang-dihasilkan)
  - [Kontribusi](#kontribusi)
  - [Lisensi](#lisensi)

## Prasyarat

Pastikan Anda telah menginstal [hledger](https://hledger.org/download.html) di sistem operasi Anda.

## Struktur Direktori

-   `2025.journal`: Berkas data utama yang berisi semua entri transaksi keuangan untuk tahun 2025.
-   `fmt-journal`: Skrip untuk memformat berkas `2025.journal` agar lebih rapi dan mudah dibaca.
-   `laporan.sh`: Skrip shell untuk menghasilkan semua laporan keuangan dalam format HTML.
-   `README.md`: Berkas dokumentasi yang sedang Anda baca.
-   `docs/`: Direktori berisi semua laporan keuangan dalam format HTML.
    -   `index.html`: Halaman utama yang berfungsi sebagai dasbor dengan tautan ke semua laporan.
    -   `hledger.css`: Lembar gaya kustom untuk mempercantik tampilan laporan.
    -   `*.html`: Berbagai berkas laporan HTML yang dihasilkan oleh `laporan.sh`.
    -   `data/`: Direktori yang berisi data mentah dalam format JSON untuk grafik.
        -   `*.json`: Berkas data dalam format JSON yang digunakan oleh `charts.html` untuk membuat visualisasi.

## Cara Penggunaan

1.  **Catat Transaksi**: Tambahkan entri transaksi baru ke dalam berkas `2025.journal`. Pastikan untuk mengikuti format standar hledger.

2.  **Format Jurnal (Opsional)**: Untuk merapikan berkas jurnal, jalankan skrip `fmt-journal`.
    ```bash
    ./fmt-journal
    ```

3.  **Hasilkan Laporan**: Jalankan skrip `laporan.sh` dari terminal untuk membuat atau memperbarui semua laporan keuangan.
    ```bash
    ./laporan.sh
    ```

4.  **Lihat Laporan**: Buka berkas `docs/index.html` di peramban web untuk melihat dasbor laporan. Dari sana, Anda dapat menavigasi ke setiap laporan yang tersedia.

## Laporan yang Dihasilkan

Skrip `laporan.sh` akan menghasilkan laporan-laporan berikut di dalam direktori `docs/`:

-   **Neraca (Balance Sheet)**: `balance.html` - Menunjukkan posisi aset, kewajiban, dan ekuitas.
-   **Laba Rugi (Income Statement)**: `income.html` - Meringkas pendapatan dan pengeluaran.
-   **Arus Kas (Cash Flow)**: `cashflow.html` - Melacak pergerakan uang tunai.
-   **Register Transaksi**: `register.html` - Daftar lengkap semua transaksi.
-   **Neraca Aset**: `balance-assets.html` - Rincian semua akun aset.
-   **Neraca Kewajiban**: `balance-liabilities.html` - Rincian semua akun kewajiban.
-   **Neraca Ekuitas**: `balance-equity.html` - Rincian semua akun ekuitas.
-   **Pendapatan Bulanan**: `income-monthly.html` - Laporan pendapatan per bulan.
-   **Pengeluaran Bulanan**: `expenses-monthly.html` - Laporan pengeluaran per bulan.
-   **Grafik Keuangan**: `charts.html` - Visualisasi data keuangan.

## Kontribusi

Bantuan dalam bentuk apapun sangat kami hargai. Jika Anda menemukan masalah atau memiliki ide untuk perbaikan, silakan buka *issue* atau ajukan *pull request*.

## Lisensi

Proyek ini dilisensikan di bawah [Lisensi MIT](LICENSE).
