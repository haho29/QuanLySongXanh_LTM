USE master;
GO

IF EXISTS (SELECT * FROM sys.databases WHERE name = 'GreenLifeDB')
BEGIN
    ALTER DATABASE GreenLifeDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE GreenLifeDB;
END
GO

-- Tạo Database
CREATE DATABASE GreenLifeDB;
GO

USE GreenLifeDB;
GO

-- Xóa bảng nếu đã tồn tại để tránh lỗi
IF OBJECT_ID('Notifications', 'U') IS NOT NULL DROP TABLE Notifications;
IF OBJECT_ID('Progress', 'U') IS NOT NULL DROP TABLE Progress;
IF OBJECT_ID('Goals', 'U') IS NOT NULL DROP TABLE Goals;
IF OBJECT_ID('EcoTips', 'U') IS NOT NULL DROP TABLE EcoTips;
IF OBJECT_ID('Users', 'U') IS NOT NULL DROP TABLE Users;
GO

-- Bảng người dùng
CREATE TABLE Users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    fullName NVARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    job NVARCHAR(100),
    location NVARCHAR(200),
    role VARCHAR(20) DEFAULT('USER'), -- ADMIN hoặc USER
    status VARCHAR(20) DEFAULT('ACTIVE'),
    created_at DATETIME DEFAULT GETDATE()
);
GO

-- Bảng mẹo sống xanh
CREATE TABLE EcoTips (
    id INT IDENTITY(1,1) PRIMARY KEY,
    title NVARCHAR(200) NOT NULL,
    content NVARCHAR(MAX) NOT NULL,
    category NVARCHAR(50),
    points INT DEFAULT(0)
);
GO

-- Bảng Mục tiêu
CREATE TABLE Goals (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    title NVARCHAR(200) NOT NULL,
    category NVARCHAR(100) DEFAULT 'Tiết Kiệm Điện',
    description NVARCHAR(MAX),
    end_date DATETIME,
    target_progress INT NOT NULL,
    current_progress INT DEFAULT(0),
    status NVARCHAR(20) DEFAULT('PENDING'), -- PENDING, IN_PROGRESS, COMPLETED
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE
);
GO

-- Bảng Tiến trình theo dõi hành động
CREATE TABLE Progress (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    goal_id INT NOT NULL,
    activity_name NVARCHAR(200) NOT NULL,
    points_earned INT NOT NULL,
    notes NVARCHAR(MAX),
    image_url NVARCHAR(500),
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES Users(id),
    FOREIGN KEY (goal_id) REFERENCES Goals(id)
);
GO

-- Bảng Thông báo
CREATE TABLE Notifications (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    title NVARCHAR(200) NOT NULL,
    content NVARCHAR(MAX) NOT NULL,
    type VARCHAR(50) DEFAULT 'INFO', -- INFO, SUCCESS, WARNING, POINTS
    is_read BIT DEFAULT 0,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES Users(id)
);
GO

-- Insert Initial Data
INSERT INTO Users (username, password, fullName, email, job, location, role, status, created_at) VALUES 
('admin', 'admin123', N'Quản trị viên', 'admin@greenlife.vn', N'System Admin', N'TP.HCM', 'ADMIN', 'ACTIVE', GETDATE()),
('myha', '123456', N'Hồ Thị Mỹ Hà', 'myha@gmail.com', N'Kỹ sư Môi trường', N'TP. HCM', 'USER', 'ACTIVE', DATEADD(day, -28, GETDATE())),
('minhkhoa', '123456', N'Lê Minh Khoa', 'khoa@gmail.com', N'Sinh viên IT', N'Cần Thơ', 'USER', 'ACTIVE', DATEADD(day, -14, GETDATE())),
('yun', '123456', N'Nguyễn Văn Anh (Yun)', 'yun@gmail.com', N'Thiết kế đồ họa', N'Đà Nẵng', 'USER', 'ACTIVE', DATEADD(day, -7, GETDATE()));

-- Insert EcoTips
INSERT INTO EcoTips (title, content, category, points) VALUES
(N'Tắt thiết bị điện khi không dùng', N'Thói quen đơn giản này có thể giúp bạn tiết kiệm đến 10% hóa đơn điện mỗi tháng.', N'Tiết kiệm điện', 15),
(N'Tắm nhanh dưới 5 phút', N'Mỗi phút tắm tiêu tốn khoảng 10 lít nước sạch.', N'Tiết kiệm nước', 10),
(N'Mang túi vải khi đi mua sắm', N'Một túi vải có thể thay thế hàng ngàn túi nilon.', N'Giảm rác nhựa', 20),
(N'Đi xe đạp hoặc đi bộ', N'Giảm phát thải carbon và rèn luyện sức khỏe.', N'Giao thông xanh', 25),
(N'Ăn chay ít nhất 1 ngày/tuần', N'Giảm lượng khí thải carbon cá nhân hiệu quả.', N'Ăn uống xanh', 15),
(N'Phân loại rác đúng cách', N'Giúp tăng tỷ lệ tái chế và giảm gánh nặng bãi rác.', N'Phân loại rác', 10);

-- Insert Goals
INSERT INTO Goals (user_id, title, category, description, end_date, target_progress, current_progress, status) VALUES
(2, N'Tiết kiệm điện mỗi ngày', N'Tiết Kiệm Điện', N'Tắt đèn và thiết bị điện khi không sử dụng', DATEADD(day, 10, GETDATE()), 30, 22, 'IN_PROGRESS'),
(2, N'Giảm rác thải nhựa', N'Giảm Rác Nhựa', N'Mang túi vải, từ chối ống hút nhựa', DATEADD(day, 5, GETDATE()), 30, 28, 'IN_PROGRESS'),
(2, N'Đi xe đạp đi làm', N'Giao Thông Xanh', N'Thay thế xe máy bằng xe đạp', DATEADD(day, -5, GETDATE()), 20, 20, 'COMPLETED'),
(3, N'Hành trình tắt đèn', N'Tiết Kiệm Điện', N'Cài đặt giờ tắt tự động', DATEADD(day, 7, GETDATE()), 30, 25, 'IN_PROGRESS'),
(4, N'Sống không rác', N'Giảm Rác Nhựa', N'Thực hành lối sống Zero Waste', DATEADD(day, -2, GETDATE()), 30, 30, 'COMPLETED');
GO

-- Insert Progress
DECLARE @now DATETIME = GETDATE();
INSERT INTO Progress (user_id, goal_id, activity_name, points_earned, notes, created_at) VALUES
(2, 1, N'Tắt điều hòa', 15, N'Hôm nay trời mát', DATEADD(day, -5, @now)),
(2, 2, N'Dùng túi vải', 10, N'Đi siêu thị', DATEADD(day, -4, @now));
GO

-- Insert Notifications
INSERT INTO Notifications (user_id, title, content, type, is_read, created_at) VALUES
(2, N'Chào mừng trở lại!', N'Cùng GreenLife tiếp tục hành trình sống xanh.', 'INFO', 0, GETDATE()),
(2, N'Mục tiêu hoàn thành', N'Chúc mừng bạn đã hoàn thành mục tiêu!', 'SUCCESS', 0, DATEADD(hour, -2, GETDATE()));
GO
