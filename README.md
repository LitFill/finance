# Laporan Keuangan Pribadi dengan hledger

Proyek ini adalah implementasi sederhana dari sistem akuntansi teks biasa untuk mengelola keuangan pribadi menggunakan [hledger](https://hledger.org/). Sistem ini memungkinkan pencatatan transaksi keuangan dan pembuatan laporan secara otomatis.

## Prasyarat

Pastikan Anda telah menginstal [hledger](https://hledger.org/download.html) di sistem Anda sebelum melanjutkan.

## Struktur File

-   `2025.journal`: File data utama yang berisi semua entri transaksi keuangan untuk tahun 2025.
-   `fmt-journal`: Skrip untuk memformat file `2025.journal` agar lebih rapi dan mudah dibaca.
-   `laporan.sh`: Skrip shell untuk menghasilkan semua laporan keuangan dalam format HTML.
-   `printed.journal`: Versi file journal yang telah diformat dan siap untuk dicetak.
-   `README.md`: File ini, berisi dokumentasi proyek.
-   `docs/`: Direktori yang berisi semua laporan keuangan dalam format HTML.
    -   `index.html`: Halaman utama yang berfungsi sebagai dasbor dengan tautan ke semua laporan.
    -   `hledger.css`: Stylesheet kustom untuk mempercantik tampilan laporan HTML.
    -   `*.html`: Berbagai file laporan HTML yang dihasilkan oleh skrip `laporan.sh`.

## Cara Penggunaan

1.  **Catat Transaksi**: Tambahkan entri transaksi baru ke dalam file `2025.journal`. Pastikan untuk mengikuti format standar hledger.

2.  **Format Jurnal (Opsional)**: Untuk merapikan file jurnal, jalankan skrip `fmt-journal`.
    ```bash
    ./fmt-journal
    ```

3.  **Hasilkan Laporan**: Jalankan skrip `laporan.sh` dari terminal untuk membuat atau memperbarui semua laporan keuangan.
    ```bash
    ./laporan.sh
    ```

4.  **Lihat Laporan**: Buka file `docs/index.html` di peramban web Anda untuk melihat dasbor laporan. Dari sana, Anda dapat menavigasi ke setiap laporan yang tersedia.

## Laporan yang Dihasilkan

Skrip `laporan.sh` akan menghasilkan laporan-laporan berikut di dalam direktori `docs/`:

-   **Neraca (Balance Sheet)**: `balance.html` - Menunjukkan posisi aset, kewajiban, dan ekuitas.
-   **Laba Rugi (Income Statement)**: `income.html` - Meringkas pendapatan dan pengeluaran selama periode tertentu.
-   **Arus Kas (Cash Flow)**: `cashflow.html` - Melacak pergerakan uang tunai.
-   **Register Transaksi**: `register.html` - Daftar lengkap semua transaksi yang tercatat.
-   **Neraca Aset**: `balance-assets.html` - Rincian semua akun aset.
-   **Neraca Kewajiban**: `balance-liabilities.html` - Rincian semua akun kewajiban.
-   **Neraca Ekuitas**: `balance-equity.html` - Rincian semua akun ekuitas.
-   **Pendapatan Bulanan**: `income-monthly.html` - Laporan pendapatan yang dikelompokkan per bulan.
-   **Pengeluaran Bulanan**: `expenses-monthly.html` - Laporan pengeluaran yang dikelompokkan per bulan.

## Kontribusi

Kontribusi dalam bentuk apapun sangat kami hargai. Jika Anda menemukan masalah atau memiliki ide untuk perbaikan, silakan buka *issue* atau ajukan *pull request*.

## Lisensi

Proyek ini dilisensikan di bawah [Lisensi MIT](LICENSE).
