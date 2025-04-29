# Resmi bir Python image'ını temel al
FROM python:3.10-slim

# Çalışma dizinini ayarla
WORKDIR /app

# Bağımlılıkları yükle
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Uygulama dosyalarını kopyala
COPY app/ .

# Uygulamayı çalıştır
CMD ["python", "app.py"]
