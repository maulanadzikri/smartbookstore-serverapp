#!/bin/bash

JAR_FILE="target/Smart-Bookstore-0.0.1-SNAPSHOT.jar"  # Ganti dengan path file .jar kamu jika berbeda

if [ ! -f "$JAR_FILE" ]; then
  echo "❌ File $JAR_FILE tidak ditemukan. Pastikan sudah di-build."
  exit 1
fi

# Daftar heap size yang ingin diuji
HEAP_SIZES=("128m" "256m" "512m")

for HEAP in "${HEAP_SIZES[@]}"; do
  echo -e "\n🔍 Menguji dengan -Xmx$HEAP -Xms$HEAP ..."
  java -Xmx$HEAP -Xms$HEAP -jar "$JAR_FILE" &
  PID=$!

  echo "⏳ Menunggu 15 detik untuk startup..."
  sleep 15

  # Cek apakah aplikasi masih hidup
  if ps -p $PID > /dev/null; then
    echo "✅ Berhasil dijalankan pada -Xmx$HEAP"
    kill $PID
  else
    echo "❌ Gagal dijalankan pada -Xmx$HEAP"
  fi

  sleep 3
done
