# Use official JDK image
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy JAR file from target folder (after Maven build)
COPY target/*.jar app.jar

# Run the jar file
ENTRYPOINT ["java", "-jar", "app.jar"]
