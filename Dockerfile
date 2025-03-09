# **Stage 1: Build aplikasi dengan Maven**
FROM maven:3.8.8-openjdk-8 AS builder

WORKDIR /app

# Salin file pom.xml dan download dependencies terlebih dahulu
COPY pom.xml .
RUN mvn dependency:go-offline

# Salin semua kode sumber
COPY src ./src

# Build aplikasi untuk menghasilkan JAR
RUN mvn clean package -DskipTests

# **Stage 2: Jalankan aplikasi di container yang lebih ringan**
FROM openjdk:8-jdk-alpine
WORKDIR /app

# Copy file JAR hasil build dari stage pertama
COPY --from=builder /app/target/*.jar app.jar

# Perintah untuk menjalankan aplikasi
CMD ["java", "-jar", "app.jar"]
