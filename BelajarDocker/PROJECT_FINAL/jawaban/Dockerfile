FROM node:18-alpine

WORKDIR /app

# Copy daftar dependensi
COPY src/package.json ./

# Install dependensi
RUN npm install

# Copy source code dari host (folder src) ke container (folder /app saat ini)
COPY src/ .

# Expose port sesuai dengan kode server.js (8080)
EXPOSE 8080

# Jalankan app
CMD ["node", "server.js"]
