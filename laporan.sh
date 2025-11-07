#!/bin/bash

# Script untuk menghasilkan laporan keuangan dari file journal hledger.

# File sumber data
JOURNAL_FILE="2025.journal"

# Periksa apakah file journal ada
if [ ! -f "$JOURNAL_FILE" ]; then
    echo "Error: File journal '$JOURNAL_FILE' tidak ditemukan."
    exit 1
fi

echo "Membuat laporan dari $JOURNAL_FILE..."

# 1. Laporan Neraca (Balance Sheet)
hledger bal -f "$JOURNAL_FILE" -o docs/balance.html

# 2. Laporan Laba Rugi (Income Statement)
hledger is -f "$JOURNAL_FILE" -o docs/income.html

# 3. Laporan Arus Kas (Cash Flow)
hledger cf -f "$JOURNAL_FILE" -o docs/cashflow.html

# 4. Laporan Register (Semua Transaksi)
hledger reg -f "$JOURNAL_FILE" -o docs/register.html

# 5. Laporan Neraca Aset
hledger bal assets -f "$JOURNAL_FILE" -o docs/balance-assets.html

# 6. Laporan Neraca Kewajiban
hledger bal liabilities -f "$JOURNAL_FILE" -o docs/balance-liabilities.html

# 7. Laporan Neraca Aset - Kewajiban
hledger bal assets liabilities -f "$JOURNAL_FILE" -o docs/balance-ass-lia.html

# 7. Laporan Neraca Ekuitas
hledger bal equity -f "$JOURNAL_FILE" -o docs/balance-equity.html

# 8. Laporan Pendapatan Bulanan
hledger bal income --monthly --row-total --average -f "$JOURNAL_FILE" -o docs/income-monthly.html

# 8. Laporan Pendapatan Bulanan
hledger bal --monthly --row-total --average -f "$JOURNAL_FILE" -o docs/balance-monthly.html

# 8. Laporan Pendapatan Bulanan
hledger bal assets --monthly --row-total --average -f "$JOURNAL_FILE" -o docs/assets-monthly.html

# 9. Laporan Pengeluaran Bulanan
hledger bal expenses --monthly --row-total --average -f "$JOURNAL_FILE" -o docs/expenses-monthly.html

# 7. Laporan Neraca Aset - Kewajiban Bulanan
hledger bal assets liabilities --monthly --row-total --average -f "$JOURNAL_FILE" -o docs/balance-ass-lia-monthly.html

# 10. Laporan Balance Sheet bulanan
hledger bs --monthly --row-total --average -f "$JOURNAL_FILE" -o docs/balancesheet-monthly.html

# 11. Laporan Income Statement bulanan
hledger is --monthly --row-total --average -f "$JOURNAL_FILE" -o docs/income-statement-monthly.html

# Generate JSON data
echo "Membuat file data JSON..."
hledger bal assets      -f "$JOURNAL_FILE" -o docs/data/balance-assets.json
hledger bal liabilities -f "$JOURNAL_FILE" -o docs/data/balance-liabilities.json
hledger bal income      -f "$JOURNAL_FILE" -o docs/data/income.json
hledger bal expenses    -f "$JOURNAL_FILE" -o docs/data/expenses.json


echo "Semua laporan dan file data telah berhasil dibuat."
