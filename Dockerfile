FROM openjdk:8-jdk-alpine

# Set working directory in the container
WORKDIR /app

# Copy built jar file (Assuming you use Maven or Gradle)
COPY target/*.jar app.jar

# Expose the port (match your Spring Boot `server.port`)
EXPOSE 9090

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]