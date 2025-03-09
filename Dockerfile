# Gunakan base image OpenJDK 8 yang ringan
FROM openjdk:8-jdk-alpine

# Set working directory
WORKDIR /app

# Salin file pom.xml dan unduh dependencies terlebih dahulu (agar cache tetap terjaga)
COPY pom.xml .
RUN apk add --no-cache maven && mvn dependency:go-offline

# Salin semua kode sumber ke dalam container
COPY src ./src

# Build aplikasi dalam container (membuat file JAR)
RUN mvn clean package -DskipTests

# Copy hasil build ke dalam container
COPY target/*.jar app.jar

# Perintah untuk menjalankan aplikasi
CMD ["java", "-jar", "app.jar"]
