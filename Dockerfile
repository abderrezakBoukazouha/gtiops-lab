# Stage 1: Build the application
FROM eclipse-temurin:21-jdk-alpine AS builder
WORKDIR /workspace
COPY . .
RUN ./mvnw clean package -DskipTests

# Stage 2: Create the final, small image
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
# Copy the built .jar file from the 'builder' stage
COPY --from=builder /workspace/target/*.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]