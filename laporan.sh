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
hledger bal -f "$JOURNAL_FILE" -o balance.html

# 2. Laporan Laba Rugi (Income Statement)
hledger is -f "$JOURNAL_FILE" -o income.html

# 3. Laporan Arus Kas (Cash Flow)
hledger cf -f "$JOURNAL_FILE" -o cashflow.html

# 4. Laporan Register (Semua Transaksi)
hledger reg -f "$JOURNAL_FILE" -o register.html

echo "Semua laporan telah berhasil dibuat."
