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
    role VARCHAR(20) DEFAULT('USER') -- ADMIN hoặc USER
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
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES Users(id),
    -- Tùy chọn, không cascade goal để giữ lịch sử nếu cần thiết, nhưng dùng No Action nhé!
    FOREIGN KEY (goal_id) REFERENCES Goals(id)
);
GO

-- Cập nhật dữ liệu mẫu phong phú
-- Insert Users
INSERT INTO Users (username, password, fullName, email, job, location, role) VALUES 
('admin', 'admin123', N'Quản trị viên', 'admin@greenlife.vn', N'System Admin', N'TP.HCM', 'ADMIN'),
('minhkhoa', '123456', N'Nguyễn Minh Khoa', 'khoa@student.edu.vn', N'Kỹ sư Môi trường', N'TP. HCM', 'USER'),
('thilan', '123456', N'Trần Thị Lan', 'lan@student.edu.vn', N'Giáo viên', N'Hà Nội', 'USER'),
('vanhung', '123456', N'Lê Văn Hùng', 'hung@student.edu.vn', N'Kỹ sư phần mềm', N'TP. HCM', 'USER'),
('phuongthanh', '123456', N'Nguyễn Phương Thanh', 'thanh@student.edu.vn', N'Sinh viên Kiến trúc', N'Đà Nẵng', 'USER'),
('hoangminh', '123456', N'Phạm Hoàng Minh', 'minh@student.edu.vn', N'Sinh viên IT', N'Cần Thơ', 'USER');

-- Insert EcoTips
INSERT INTO EcoTips (title, content, category, points) VALUES
(N'Tắt thiết bị điện khi không dùng', N'Thói quen đơn giản này có thể giúp bạn tiết kiệm đến 10% hóa đơn điện mỗi tháng. Đừng để TV hay máy tính ở chế độ chờ.', N'Tiết kiệm điện', 15),
(N'Tắm nhanh dưới 5 phút', N'Mỗi phút tắm tiêu tốn khoảng 10 lít nước. Tắm nhanh hơn 5 phút mỗi ngày giúp tiết kiệm 50 lít nước sạch cho thế giới.', N'Tiết kiệm nước', 10),
(N'Mang túi vải khi đi mua sắm', N'Một túi nylon mất 400-1000 năm để phân hủy. Hãy mang theo túi vải tái sử dụng — một hành động nhỏ nhưng mang tính vĩ mô.', N'Giảm rác nhựa', 20),
(N'Đi xe đạp hoặc đi bộ', N'Thay thế xe máy bằng xe đạp cho những quãng đường ngắn dưới 3km. Vừa tốt cho sức khỏe, vừa giảm phát thải carbon.', N'Giao thông xanh', 25),
(N'Ăn chay ít nhất 1 ngày/tuần', N'Sản xuất 1kg thịt bò tạo ra 27kg CO2. Ăn chay 1 ngày/tuần có thể giảm lượng khí thải carbon cá nhân.', N'Ăn uống xanh', 15),
(N'Phân loại rác đúng cách', N'Phân loại rác thành 3 nhóm: hữu cơ, tái chế và rác thải thông thường. Điều này giúp tăng tỷ lệ tái chế.', N'Phân loại rác', 10),
(N'Tận dụng ánh sáng tự nhiên', N'Mở rèm cửa vào ban ngày để tận dụng ánh sáng mặt trời thay vì bật đèn. Điều này không chỉ tiết kiệm điện mà còn tốt cho mắt.', N'Tiết kiệm điện', 5),
(N'Thu gom nước mưa tưới cây', N'Đặt thùng chứa ngoài hiên để thu gom nước mưa. Dùng nước này tưới cây, lau nhà — cực kỳ tiết kiệm.', N'Tiết kiệm nước', 10);

-- Insert Goals cho người dùng 2 (Minh Khoa)
INSERT INTO Goals (user_id, title, category, description, end_date, target_progress, current_progress, status) VALUES
(2, N'Tiết kiệm điện mỗi ngày', N'Tiết Kiệm Điện', N'Tắt đèn và thiết bị điện khi không sử dụng, hạn chế dùng điều hòa', DATEADD(day, 8, GETDATE()), 30, 22, 'IN_PROGRESS'),
(2, N'Giảm rác thải nhựa', N'Giảm Rác Nhựa', N'Mang túi vải, từ chối ống hút nhựa, dùng bình nước cá nhân', DATEADD(day, 2, GETDATE()), 30, 28, 'IN_PROGRESS'),
(2, N'Tiết kiệm nước', N'Tiết Kiệm Nước', N'Tắm nhanh dưới 5 phút, khóa vòi khi đánh răng', DATEADD(day, 12, GETDATE()), 30, 18, 'IN_PROGRESS'),
(2, N'Đi xe đạp đi làm', N'Giao Thông Xanh', N'Thay thế xe máy bằng xe đạp hoặc đi bộ khi có thể', DATEADD(day, -5, GETDATE()), 20, 20, 'COMPLETED'),
(2, N'Ăn chay 2 ngày/tuần', N'Ăn Uống Xanh', N'Giảm tiêu thụ thịt, tăng cường rau củ quả trong bữa ăn', DATEADD(day, 25, GETDATE()), 8, 5, 'IN_PROGRESS'),
(2, N'Phân loại rác tại nhà', N'Phân Loại Rác', N'Phân loại rác hữu cơ, vô cơ và tái chế đúng cách', DATEADD(day, 18, GETDATE()), 30, 12, 'IN_PROGRESS'),
(2, N'Trồng thêm 5 cây xanh', N'Khác', N'Mua chậu và Trồng thêm cây xanh để bàn làm việc', DATEADD(day, 7, GETDATE()), 5, 0, 'PENDING'),
(2, N'Hàng ngày chỉ dùng 1 chai nhựa', N'Giảm Rác Nhựa', N'Không mua nước đóng chai thêm', DATEADD(day, 5, GETDATE()), 15, 15, 'COMPLETED'),
(2, N'Sử dụng phương tiện công cộng', N'Giao Thông Xanh', N'Đi xe buýt thay vì đi xe máy cá nhân', DATEADD(day, 20, GETDATE()), 30, 5, 'IN_PROGRESS'),
(2, N'Nhịn ăn thịt cuối tuần', N'Ăn Uống Xanh', N'Ăn hoàn toàn thực vật vào T7 CN', DATEADD(day, 14, GETDATE()), 8, 8, 'COMPLETED'),
(2, N'Giặt đồ bằng nước lạnh', N'Tiết Kiệm Điện', N'Tránh mở bình nóng lạnh cho máy giặt', DATEADD(day, 30, GETDATE()), 30, 0, 'PENDING'),
(2, N'Không lãng phí đồ ăn', N'Ăn Uống Xanh', N'Gói đồ ăn dư mang về hoặc nấu đủ ăn', DATEADD(day, 20, GETDATE()), 30, 0, 'PENDING');

-- Goals cho các top người dùng khác để Leaderboard sinh động hơn
INSERT INTO Goals (user_id, title, category, description, end_date, target_progress, current_progress, status) VALUES
(3, N'Đạp xe marathon xanh', N'Giao Thông Xanh', N'Đạp xe dạo quanh thành phố cuối tuần', DATEADD(day, -10, GETDATE()), 30, 30, 'COMPLETED'),
(3, N'Sống không rác', N'Giảm Rác Nhựa', N'Thực hành lối sống Zero Waste', DATEADD(day, -2, GETDATE()), 30, 30, 'COMPLETED'),
(3, N'Ăn chay nguyên tháng', N'Ăn Uống Xanh', N'Không ăn thịt nguyên một tháng', DATEADD(day, 15, GETDATE()), 30, 28, 'IN_PROGRESS'),
(4, N'Hành trình tắt đèn', N'Tiết Kiệm Điện', N'Cài đặt giờ tắt tự động cho khu nhà', DATEADD(day, 5, GETDATE()), 30, 25, 'IN_PROGRESS'),
(4, N'Dùng sản phẩm hữu cơ', N'Ăn Uống Xanh', N'Mua đồ ăn organic 100%', DATEADD(day, 20, GETDATE()), 15, 0, 'PENDING');

-- Insert Progress (Lắp ráp cho biểu đồ của userID = 2) lấy lùi ngày
DECLARE @now DATETIME = GETDATE();

INSERT INTO Progress (user_id, goal_id, activity_name, points_earned, created_at) VALUES
(2, 1, N'Tắt điều hòa', 15, DATEADD(day, -6, @now)),
(2, 2, N'Dùng bình thân thiện', 15, DATEADD(day, -6, @now)),
(2, 1, N'Rút phích cắm TV', 15, DATEADD(day, -5, @now)),
(2, 3, N'Khóa vòi đánh răng', 20, DATEADD(day, -5, @now)),
(2, 4, N'Đạp xe đi học', 25, DATEADD(day, -5, @now)),
(2, 2, N'Dùng túi vải', 10, DATEADD(day, -4, @now)),
(2, 5, N'Bữa chay', 15, DATEADD(day, -4, @now)),
(2, 6, N'Phân hộp giấy', 10, DATEADD(day, -3, @now)),
(2, 1, N'Tắt điều hòa sớm', 10, DATEADD(day, -3, @now)),
(2, 4, N'Đạp xe 5km', 25, DATEADD(day, -2, @now)),
(2, 2, N'Mua hàng bulk', 20, DATEADD(day, -2, @now)),
(2, 3, N'Tắm 5 phút', 15, DATEADD(day, -2, @now)),
(2, 1, N'Xài quạt thay máy lạnh', 15, DATEADD(day, -1, @now)),
(2, 2, N'Từ chối ống hút', 10, DATEADD(day, -1, @now)),
(2, 6, N'Compost rác hữu cơ', 25, DATEADD(day, -1, @now)),
(2, 1, N'Rút sạc', 10, @now),
(2, 2, N'Mang theo hộp nhựa', 15, @now);

-- Progress cho người dùng khác
INSERT INTO Progress (user_id, goal_id, activity_name, points_earned, created_at) VALUES
(3, 7, N'Đạp xe xuyên quận', 50, @now),
(3, 8, N'Làm event nhặt rác', 100, @now),
(4, 10, N'Tắt đèn văn phòng', 80, @now);
GO

