-- ============================================================
-- 2. Таблицы прикладного уровня
-- ============================================================

-- Пользователи приложения (граждане, операторы, исполнители, админы)
CREATE TABLE ApplicationUser (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    Login NVARCHAR(50) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(128) NOT NULL,  -- SHA-256 hash
    Email NVARCHAR(100) NULL,
    Phone NVARCHAR(20) NULL,
    FullName NVARCHAR(100) NOT NULL,
    Role NVARCHAR(20) NOT NULL CHECK (Role IN (N'Гражданин', N'Оператор', N'Исполнитель', N'Администратор')),
    Address NVARCHAR(200) NULL,
    Department NVARCHAR(100) NULL,
    Position NVARCHAR(100) NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    IsActive BIT NOT NULL DEFAULT 1
);
GO

-- Категории обращений
CREATE TABLE Category (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500) NULL
);
GO

-- Статусы обращений
CREATE TABLE Status (
    StatusID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL,
    IsFinal BIT NOT NULL DEFAULT 0
);
GO

-- Обращения
CREATE TABLE Appeal (
    AppealID INT IDENTITY(1,1) PRIMARY KEY,
    AuthorID INT NOT NULL,
    Title NVARCHAR(200) NOT NULL,
    Description NVARCHAR(MAX) NULL,
    CategoryID INT NOT NULL,
    StatusID INT NOT NULL DEFAULT 1,
    AssignedToID INT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    DueDate DATE NULL,
    CONSTRAINT FK_Appeal_Author FOREIGN KEY (AuthorID) REFERENCES ApplicationUser(UserID),
    CONSTRAINT FK_Appeal_Category FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID),
    CONSTRAINT FK_Appeal_Status FOREIGN KEY (StatusID) REFERENCES Status(StatusID),
    CONSTRAINT FK_Appeal_AssignedTo FOREIGN KEY (AssignedToID) REFERENCES ApplicationUser(UserID)
);
GO

-- История обработки
CREATE TABLE AppealHistory (
    HistoryID INT IDENTITY(1,1) PRIMARY KEY,
    AppealID INT NOT NULL,
    UserID INT NOT NULL,
    Action NVARCHAR(100) NOT NULL,
    Comment NVARCHAR(MAX) NULL,
    ActionDate DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_History_Appeal FOREIGN KEY (AppealID) REFERENCES Appeal(AppealID) ON DELETE CASCADE,
    CONSTRAINT FK_History_User FOREIGN KEY (UserID) REFERENCES ApplicationUser(UserID)
);
GO

-- Вложения
CREATE TABLE Attachment (
    AttachmentID INT IDENTITY(1,1) PRIMARY KEY,
    AppealID INT NOT NULL,
    FileName NVARCHAR(255) NOT NULL,
    FilePath NVARCHAR(500) NOT NULL,
    UploadedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Attachment_Appeal FOREIGN KEY (AppealID) REFERENCES Appeal(AppealID) ON DELETE CASCADE
);
GO

-- ============================================================
-- 4. Создание пользователей БД и ролей
-- ============================================================

-- Создание ролей базы данных
CREATE ROLE db_operator;
CREATE ROLE db_analyst;
-- роль db_admin будет представлена членством в db_owner

-- Права для роли db_operator
GRANT SELECT, INSERT, UPDATE ON dbo.Appeal TO db_operator;
GRANT SELECT, INSERT, UPDATE ON dbo.AppealHistory TO db_operator;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Attachment TO db_operator;
GRANT SELECT ON dbo.ApplicationUser TO db_operator;
GRANT SELECT ON dbo.Category TO db_operator;
GRANT SELECT ON dbo.Status TO db_operator;

-- Права для роли db_analyst
GRANT SELECT ON dbo.Appeal TO db_analyst;
GRANT SELECT ON dbo.AppealHistory TO db_analyst;
GRANT SELECT ON dbo.Attachment TO db_analyst;
GRANT SELECT ON dbo.ApplicationUser TO db_analyst;
GRANT SELECT ON dbo.Category TO db_analyst;
GRANT SELECT ON dbo.Status TO db_analyst;

-- Создание логинов (учётных записей SQL Server)
CREATE LOGIN city_admin WITH PASSWORD = 'SuperSecureAdmin123!';
CREATE LOGIN city_operator WITH PASSWORD = 'StrongOperator456!';
CREATE LOGIN city_analyst WITH PASSWORD = 'AnalystReadOnly789!';

-- Создание пользователей в базе данных и привязка к логинам
CREATE USER city_admin FOR LOGIN city_admin;
CREATE USER city_operator FOR LOGIN city_operator;
CREATE USER city_analyst FOR LOGIN city_analyst;

-- Назначение ролей
EXEC sp_addrolemember 'db_owner', 'city_admin';
EXEC sp_addrolemember 'db_operator', 'city_operator';
EXEC sp_addrolemember 'db_analyst', 'city_analyst';
GO