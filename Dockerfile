# Giai đoạn 1: Xây dựng ứng dụng
FROM maven:3.8.5-openjdk-17 AS builder

# Đặt thư mục làm việc
WORKDIR /app

# Sao chép toàn bộ mã nguồn vào container
COPY . .

# Chạy lệnh Maven để xây dựng ứng dụng và tạo tệp JAR
RUN mvn clean package -DskipTests

# Giai đoạn 2: Tạo hình ảnh chạy ứng dụng
FROM openjdk:17-jdk-slim

# Đặt thư mục làm việc
WORKDIR /app

# Sao chép tệp JAR từ giai đoạn xây dựng
COPY --from=builder /app/target/*.jar api-service.jar

# Mở cổng 80
EXPOSE 80

# Lệnh khởi chạy ứng dụng
ENTRYPOINT ["java", "-jar", "api-service.jar"]
