USE master;
GO

IF EXISTS (SELECT * FROM sys.databases WHERE name = 'GreenLifeDB')
BEGIN
    ALTER DATABASE GreenLifeDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE GreenLifeDB;
END
GO

-- Táº¡o Database
CREATE DATABASE GreenLifeDB;
GO

USE GreenLifeDB;
GO

-- XÃ³a báº£ng náº¿u Ä‘Ã£ tá»“n táº¡i Ä‘á»ƒ trÃ¡nh lá»—i
IF OBJECT_ID('Progress', 'U') IS NOT NULL DROP TABLE Progress;
IF OBJECT_ID('Goals', 'U') IS NOT NULL DROP TABLE Goals;
IF OBJECT_ID('EcoTips', 'U') IS NOT NULL DROP TABLE EcoTips;
IF OBJECT_ID('Users', 'U') IS NOT NULL DROP TABLE Users;
GO

-- Báº£ng ngÆ°á»i dÃ¹ng
CREATE TABLE Users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    fullName NVARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    job NVARCHAR(100),
    location NVARCHAR(200),
    role VARCHAR(20) DEFAULT('USER'), -- ADMIN hoáº·c USER
    status VARCHAR(20) DEFAULT('ACTIVE'),
    created_at DATETIME DEFAULT GETDATE()
);
GO

-- Báº£ng máº¹o sá»‘ng xanh
CREATE TABLE EcoTips (
    id INT IDENTITY(1,1) PRIMARY KEY,
    title NVARCHAR(200) NOT NULL,
    content NVARCHAR(MAX) NOT NULL,
    category NVARCHAR(50),
    points INT DEFAULT(0)
);
GO

-- Báº£ng Má»¥c tiÃªu
CREATE TABLE Goals (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    title NVARCHAR(200) NOT NULL,
    category NVARCHAR(100) DEFAULT 'Tiáº¿t Kiá»‡m Äiá»‡n',
    description NVARCHAR(MAX),
    end_date DATETIME,
    target_progress INT NOT NULL,
    current_progress INT DEFAULT(0),
    status NVARCHAR(20) DEFAULT('PENDING'), -- PENDING, IN_PROGRESS, COMPLETED
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE
);
GO

-- Báº£ng Tiáº¿n trÃ¬nh theo dÃµi hÃ nh Ä‘á»™ng
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
    -- TÃ¹y chá»n, khÃ´ng cascade goal Ä‘á»ƒ giá»¯ lá»‹ch sá»­ náº¿u cáº§n thiáº¿t, nhÆ°ng dÃ¹ng No Action nhÃ©!
    FOREIGN KEY (goal_id) REFERENCES Goals(id)
);
GO

-- Báº£ng ThÃ´ng bÃ¡o
CREATE TABLE Notifications (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    title NVARCHAR(200) NOT NULL,
    content NVARCHAR(MAX) NOT NULL,
    type VARCHAR(50) DEFAULT 'INFO', -- INFO, SUCCESS, WARNING, POINTS
    is_read BIT DEFAULT 0,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES User-- Insert Users
INSERT INTO Users (username, password, fullName, email, job, location, role, status, created_at) VALUES 
('admin', 'admin123', N'Quáº£n trá»‹ viÃªn', 'admin@greenlife.vn', N'System Admin', N'TP.HCM', 'ADMIN', 'ACTIVE', GETDATE()),
('myha', '123456', N'Há»“ Thá»‹ Má»¹ HÃ ', 'myha@gmail.com', N'Ká»¹ sÆ° MÃ´i trÆ°á»ng', N'TP. HCM', 'USER', 'ACTIVE', DATEADD(day, -28, GETDATE())),
('minhkhoa', '123456', N'LÃª Minh Khoa', 'khoa@gmail.com', N'Sinh viÃªn IT', N'Cáº§n ThÆ¡', 'USER', 'ACTIVE', DATEADD(day, -14, GETDATE())),
('yun', '123456', N'Nguyá»…n VÃ¢n Anh (Yun)', 'yun@gmail.com', N'Thiáº¿t káº¿ Ä‘á»“ há»a', N'ÄÃ  Náºµng', 'USER', 'ACTIVE', DATEADD(day, -7, GETDATE()));

-- Insert EcoTips
INSERT INTO EcoTips (title, content, category, points) VALUES
(N'Táº¯t thiáº¿t bá»‹ Ä‘iá»‡n khi khÃ´ng dÃ¹ng', N'ThÃ³i quen Ä‘Æ¡n giáº£n nÃ y cÃ³ thá»ƒ giÃºp báº¡n tiáº¿t kiá»‡m Ä‘áº¿n 10% hÃ³a Ä‘Æ¡n Ä‘iá»‡n má»—i thÃ¡ng.', N'Tiáº¿t kiá»‡m Ä‘iá»‡n', 15),
(N'Táº¯m nhanh dÆ°á»›i 5 phÃºt', N'Má»—i phÃºt táº¯m tiÃªu tá»‘n khoáº£ng 10 lÃ­t nÆ°á»›c sáº¡ch.', N'Tiáº¿t kiá»‡m nÆ°á»›c', 10),
(N'Mang tÃºi váº£i khi Ä‘i mua sáº¯m', N'Má»™t tÃºi váº£i cÃ³ thá»ƒ thay tháº¿ hÃ ng ngÃ n tÃºi nilon.', N'Giáº£m rÃ¡c nhá»±a', 20),
(N'Äi xe Ä‘áº¡p hoáº·c Ä‘i bá»™', N'Giáº£m phÃ¡t tháº£i carbon vÃ  rÃ¨n luyá»‡n sá»©c khá»e.', N'Giao thÃ´ng xanh', 25),
(N'Ä‚n chay Ã­t nháº¥t 1 ngÃ y/tuáº§n', N'Giáº£m lÆ°á»£ng khÃ­ tháº£i carbon cÃ¡ nhÃ¢n hiá»‡u quáº£.', N'Ä‚n uá»‘ng xanh', 15),
(N'PhÃ¢n loáº¡i rÃ¡c Ä‘Ãºng cÃ¡ch', N'GiÃºp tÄƒng tá»· lá»‡ tÃ¡i cháº¿ vÃ  giáº£m gÃ¡nh náº·ng bÃ£i rÃ¡c.', N'PhÃ¢n loáº¡i rÃ¡c', 10);

-- Insert Goals
-- myha (ID 2)
INSERT INTO Goals (user_id, title, category, description, end_date, target_progress, current_progress, status) VALUES
(2, N'Tiáº¿t kiá»‡m Ä‘iá»‡n má»—i ngÃ y', N'Tiáº¿t Kiá»‡m Äiá»‡n', N'Táº¯t Ä‘Ã¨n vÃ  thiáº¿t bá»‹ Ä‘iá»‡n khi khÃ´ng sá»­ dá»¥ng', DATEADD(day, 8, GETDATE()), 30, 22, 'IN_PROGRESS'),
(2, N'Giáº£m rÃ¡c tháº£i nhá»±a', N'Giáº£m RÃ¡c Nhá»±a', N'Mang tÃºi váº£i, tá»« chá»‘i á»‘ng hÃºt nhá»±a', DATEADD(day, 2, GETDATE()), 30, 28, 'IN_PROGRESS'),
(2, N'Äi xe Ä‘áº¡p Ä‘i lÃ m', N'Giao ThÃ´ng Xanh', N'Thay tháº¿ xe mÃ¡y báº±ng xe Ä‘áº¡p', DATEADD(day, -5, GETDATE()), 20, 20, 'COMPLETED');

-- minhkhoa (ID 3)
INSERT INTO Goals (user_id, title, category, description, end_date, target_progress, current_progress, status) VALUES
(3, N'HÃ nh trÃ¬nh táº¯t Ä‘Ã¨n', N'Tiáº¿t Kiá»‡m Äiá»‡n', N'CÃ i Ä‘áº·t giá» táº¯t tá»± Ä‘á»™ng cho khu nhÃ ', DATEADD(day, 5, GETDATE()), 30, 25, 'IN_PROGRESS'),
(3, N'Äáº¡p xe marathon xanh', N'Giao ThÃ´ng Xanh', N'Äáº¡p xe dáº¡o quanh thÃ nh phá»‘ cuá»‘i tuáº§n', DATEADD(day, -10, GETDATE()), 30, 30, 'COMPLETED');

-- yun (ID 4)
INSERT INTO Goals (user_id, title, category, description, end_date, target_progress, current_progress, status) VALUES
(4, N'Sá»‘ng khÃ´ng rÃ¡c', N'Giáº£m RÃ¡c Nhá»±a', N'Thá»±c hÃ nh lá»‘i sá»‘ng Zero Waste', DATEADD(day, -2, GETDATE()), 30, 30, 'COMPLETED'),
(4, N'Ä‚n chay nguyÃªn thÃ¡ng', N'Ä‚n Uá»‘ng Xanh', N'KhÃ´ng Äƒn thá»‹t nguyÃªn má»™t thÃ¡ng', DATEADD(day, 15, GETDATE()), 30, 28, 'IN_PROGRESS');

-- Insert Progress
DECLARE @now DATETIME = GETDATE();

INSERT INTO Progress (user_id, goal_id, activity_name, points_earned, notes, created_at) VALUES
(2, 1, N'Táº¯t Ä‘iá»u hÃ²a', 15, N'HÃ´m nay trá»i mÃ¡t nÃªn táº¯t sá»›m', DATEADD(day, -5, @now)),
(2, 2, N'DÃ¹ng bÃ¬nh thÃ¢n thiá»‡n', 15, N'KhÃ´ng mua nÆ°á»›c Ä‘Ã³ng chai', DATEADD(day, -4, @now)),
(3, 4, N'Táº¯t Ä‘Ã¨n vÄƒn phÃ²ng', 30, N'Check thiáº¿t bá»‹ trÆ°á»›c khi vá»', DATEADD(day, -3, @now)),
(4, 6, N'Bá»¯a chay', 15, N'Ä‚n Ä‘áº­u phá»¥ vÃ  rau cá»§', DATEADD(day, -2, @now)),
(2, 1, N'RÃºt sáº¡c', 10, N'ThÃ³i quen tá»‘t', @now),
(3, 4, N'Má»Ÿ cá»­a láº¥y sÃ¡ng', 25, N'Táº­n dá»¥ng náº¯ng sá»›m', @now);

-- Insert Notifications
INSERT INTO Notifications (user_id, title, content, type, is_read, created_at) VALUES
(2, N'ChÃ o má»«ng trá»Ÿ láº¡i!', N'CÃ¹ng GreenLife tiáº¿p tá»¥c hÃ nh trÃ¬nh sá»‘ng xanh nhÃ©.', 'INFO', 0, GETDATE()),
(3, N'Má»¥c tiÃªu hoÃ n thÃ nh', N'Báº¡n Ä‘Ã£ hoÃ n thÃ nh má»¥c tiÃªu "Äáº¡p xe marathon xanh".', 'SUCCESS', 0, DATEADD(hour, -2, GETDATE())),
(4, N'Äiá»ƒm thÆ°á»Ÿng', N'Báº¡n vá»«a nháº­n Ä‘Æ°á»£c 50 Ä‘iá»ƒm xanh.', 'POINTS', 1, DATEADD(day, -1, GETDATE()));
£i', 10, DATEADD(day, -4, @now)),
(4, 10, N'Bá»¯a chay', 15, DATEADD(day, -4, @now)),
(2, 6, N'PhÃ¢n há»™p giáº¥y', 10, DATEADD(day, -3, @now)),
(2, 1, N'Táº¯t Ä‘iá»u hÃ²a sá»›m', 10, DATEADD(day, -3, @now)),
(3, 8, N'Äáº¡p xe 5km', 25, DATEADD(day, -2, @now)),
(2, 2, N'Mua hÃ ng bulk', 20, DATEADD(day, -2, @now)),
(2, 3, N'Táº¯m 5 phÃºt', 15, DATEADD(day, -2, @now)),
(4, 9, N'XÃ i quáº¡t thay mÃ¡y láº¡nh', 15, DATEADD(day, -1, @now)),
(2, 2, N'Tá»« chá»‘i á»‘ng hÃºt', 10, DATEADD(day, -1, @now)),
(2, 6, N'Compost rÃ¡c há»¯u cÆ¡', 25, DATEADD(day, -1, @now)),
(2, 1, N'RÃºt sáº¡c', 10, @now),
(3, 7, N'Mang theo há»™p nhá»±a', 15, @now),
(4, 10, N'Táº¯t Ä‘iá»‡n phÃ²ng ban', 35, @now);
GO

-- Insert Notifications
INSERT INTO Notifications (user_id, title, content, type, is_read, created_at) VALUES
(2, N'ChÃ o má»«ng trá»Ÿ láº¡i!', N'CÃ¹ng GreenLife tiáº¿p tá»¥c hÃ nh trÃ¬nh sá»‘ng xanh cá»§a báº¡n hÃ´m nay nhÃ©.', 'INFO', 0, GETDATE()),
(2, N'Má»¥c tiÃªu hoÃ n thÃ nh', N'ChÃºc má»«ng! Báº¡n Ä‘Ã£ hoÃ n thÃ nh má»¥c tiÃªu "Äáº¡p xe Ä‘i lÃ m".', 'SUCCESS', 0, DATEADD(hour, -2, GETDATE())),
(2, N'Äiá»ƒm thÆ°á»Ÿng', N'Báº¡n vá»«a nháº­n Ä‘Æ°á»£c 50 Ä‘iá»ƒm xanh tá»« hoáº¡t Ä‘á»™ng "TÃ¡i cháº¿ nhá»±a".', 'POINTS', 1, DATEADD(day, -1, GETDATE()));
GO

