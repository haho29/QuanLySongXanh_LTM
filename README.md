# Dự án GreenLife (Java Web version)

Đây là phiên bản **Java Web Application** (JSP/Servlet theo mô hình MVC) của dự án Quản lý lối sống xanh (GreenLife). Dự án sử dụng **Apache Tomcat 11** và **SQL Server** làm database. Giao diện được giữ nguyên bản bằng việc tích hợp thư viện **Tailwind CSS** (thông qua CDN) vào hệ thống JSP.

## 🛠 Môi trường Yêu cầu
- **Java JDK**: 17+ (Khuyến nghị JDK 25)
- **Web Server**: Apache Tomcat 11.x (Sử dụng chuẩn Jakarta EE 10/11)
- **Database**: Microsoft SQL Server
- **IDE**: IntelliJ IDEA 2023+ hoặc Eclipse (Bản Enterprise)

## 🗄️ Cấu hình Database

1. Mở **SQL Server Management Studio (SSMS)**.
2. Chạy toàn bộ lệnh trong thư mục Gốc ở file `database.sql` để tạo Database `GreenLifeDB`, tạo các bảng cần thiết, và chèn dữ liệu người dùng (Admin, User demo).
3. Đảm bảo SQL Server đang bật tính năng **TCP/IP** bằng *SQL Server Configuration Manager*, mặc định chạy port `1433`.

> **LƯU Ý:** 
> Trong file code `src/main/java/com/greenlife/dao/DBConnection.java`, bạn cần điều chỉnh các thông số đăng nhập (USER và PASS) cho phù hợp với SQL Server trên máy của bạn.
> VD: `USER = "sa"`, `PASS = "Admin@123"`

## 📂 Kiến trúc Dự Án (MVC)
Mô hình chuẩn cho Java Dynamic Web Project:
```
/src/main
├── java/com/greenlife
│   ├── model/         => Lớp Model đại diện cho Database (User, Goal, EcoTip, Progress)
│   ├── dao/           => Lớp Data Access Object (Kết nối Database, thực thi truy vấn SQL)
│   └── controller/    => Lớp Servlets của Jakarta (Nhận Request, goi DAO, trả về Request cho View xử lý)
└── webapp
    ├── META-INF
    ├── WEB-INF
    │   ├── lib/       => (Bỏ file SQL Server JDBC Driver mssql-jdbc-xx.jrexx.jar vào đây nếu không xài Maven)
    │   └── web.xml    => File config Servlet, Session 
    ├── assets/        => CSS tĩnh, JS, images
    ├── views/         => File .jsp của ứng dụng chứa HTML + TailwindCSS
    └── index.jsp      => File route mặc định đầu tiên
```

## 🚀 Hướng Dẫn Chạy Bằng NetBeans (Cách nhanh nhất)

Vì mình đã bổ sung tệp cấu hình Maven (`pom.xml`), bạn có thể mở dự án trên **NetBeans** vô cùng tiện lợi chỉ với vài cú click chuột:

1. **Thêm Server Tomcat vào NetBeans**: 
    - Vào tab **Services** (ở lề trái) -> Nhấn chuột phải vào **Servers** -> Chọn **Add Server**.
    - Chọn **Apache Tomcat or TomEE**, Next, và trỏ đường dẫn tới thư mục giải nén Tomcat 11 của bạn.
2. **Mở Dự án**:
    - Vào **File** -> **Open Project**.
    - Chọn tới thư mục gốc `sống-xanh---greenlife`. NetBeans sẽ tự động nhận diện đây là một **Maven Web Application** (nhờ biểu tượng `[m]`). Bấm Open.
3. **Cài đặt Dependency (JDBC) tự động**:
    - Chuột phải vào tên Project trong thẻ *Projects*, chọn **Build** (Mặc định Maven sẽ tự đi tải SQL JDBC Driver từ mạng về, bạn không cần phải copy tay file vào thư mục nữa).
4. **Chạy Project**:
    - Chuột phải vào tên Project -> Chọn **Run**.
    - NetBeans sẽ tự động build file `.war`, khởi động máy chủ Tomcat và tự động mở trình duyệt `http://localhost:8080/greenlife-web/` với giao diện Đăng Nhập.

## 🔐 Thông tin Đăng Nhập Demo
Sau khi chạy thành công `database.sql`, hệ thống sẽ có các tài khoản sau:
- **Admin**: `admin` / Password: `admin123`
- **User**: `demo@greenlife.vn` / Password: `demo123`

Chúc bạn làm việc và học tập hiệu quả!
