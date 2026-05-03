# ────────────────────────────────────────────
# Stage 1 — Build the JAR
# ────────────────────────────────────────────
FROM maven:3.9-eclipse-temurin-21 AS builder

WORKDIR /app

# Copy pom first — lets Docker cache the dependency layer
# so re-builds are fast when only source code changes
COPY pom.xml .
RUN mvn dependency:go-offline -q

# Copy source and build — skip tests (they need a DB)
COPY src ./src
RUN mvn package -DskipTests -q

# ────────────────────────────────────────────
# Stage 2 — Runtime image (much smaller)
# ────────────────────────────────────────────
FROM eclipse-temurin:21-jre

WORKDIR /app

# Create uploads directory
RUN mkdir -p /app/uploads

# Copy only the built JAR from the builder stage
COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]