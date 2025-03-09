# Gunakan image base OpenJDK 8 (karena di pom.xml menggunakan Java 1.8)
FROM openjdk:8-jdk-alpine

# Set working directory dalam container
WORKDIR /app

# Copy file pom.xml dan source code ke dalam container
COPY pom.xml .
COPY src ./src

# Download dependencies dan build project (agar cache tetap terjaga)
RUN apk add --no-cache maven && mvn clean package -DskipTests

# Copy hasil build ke dalam container
COPY target/Smart-Bookstore-0.0.1-SNAPSHOT.jar app.jar

# Perintah untuk menjalankan aplikasi
CMD ["java", "-jar", "app.jar"]
