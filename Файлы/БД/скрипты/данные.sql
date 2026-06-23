-- ============================================================
-- СКРИПТ ЗАПОЛНЕНИЯ ТЕСТОВЫМИ ДАННЫМИ
-- База данных: CityAppealsDB
-- Суммарное количество строк: > 2600
-- ============================================================

-- ============================================================
-- 1. Справочники (10 строк)
-- ============================================================
INSERT INTO Status (Name, IsFinal) VALUES 
(N'Новое', 0),
(N'В работе', 0),
(N'Выполнено', 1),
(N'Закрыто', 1),
(N'Отклонено', 1);
GO

INSERT INTO Category (Name, Description) VALUES 
(N'ЖКХ', N'Вопросы жилищно-коммунального хозяйства'),
(N'Благоустройство', N'Озеленение, уборка, освещение'),
(N'Социальная помощь', N'Выплаты, льготы, поддержка'),
(N'Дороги и транспорт', N'Ремонт дорог, общественный транспорт'),
(N'Образование', N'Школы, детсады, дополнительное образование');
GO

-- ============================================================
-- 2. Пользователи (308 строк: 1 админ, 2 оператора, 5 исполнителей, 300 граждан)
-- ============================================================

-- Администратор
INSERT INTO ApplicationUser (Login, PasswordHash, Email, Phone, FullName, Role, Department, Position, IsActive)
VALUES ('admin', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'admin@city.ru', '+7(000)000-00-01', N'Администраторов А.А.', N'Администратор', N'ИТ-отдел', N'Главный администратор', 1);

-- Операторы
INSERT INTO ApplicationUser (Login, PasswordHash, Email, Phone, FullName, Role, Department, Position, IsActive)
VALUES 
('operator1', 'e99a18c428cb38d5f260853678922e03abd833cba744db2e15e8b8b0f0c7c5c8', 'op1@city.ru', '+7(000)000-00-02', N'Петрова О.С.', N'Оператор', N'Приёмная', N'Старший оператор', 1),
('operator2', '8b7df143d91c716ecfa5fc1730022f6b421b05cedee8fd52b1fc65a96030ad52', 'op2@city.ru', '+7(000)000-00-03', N'Сидоров В.В.', N'Оператор', N'Приёмная', N'Оператор', 1);

-- Исполнители
INSERT INTO ApplicationUser (Login, PasswordHash, Email, Phone, FullName, Role, Department, Position, IsActive)
VALUES 
('isp1', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'isp1@city.ru', '+7(000)000-00-04', N'Смирнов И.П.', N'Исполнитель', N'Отдел ЖКХ', N'Главный специалист', 1),
('isp2', 'd82c8d1619ad8176d665453cfb2e55f0b0c4b91d4e6e06e7bf1504b7d4b7b7b7', 'isp2@city.ru', '+7(000)000-00-05', N'Кузнецова Е.А.', N'Исполнитель', N'Отдел благоустройства', N'Ведущий инженер', 1),
('isp3', 'e5e9fa1ba31ecd1ae84f75caaa474f3a663f05f4e9c5e4c4d4d4d4d4d4d4d4d4', 'isp3@city.ru', '+7(000)000-00-06', N'Васильев А.Н.', N'Исполнитель', N'Социальный отдел', N'Социальный работник', 1),
('isp4', 'e5e9fa1ba31ecd1ae84f75caaa474f3a663f05f4e9c5e4c4d4d4d4d4d4d4d4d4', 'isp4@city.ru', '+7(000)000-00-07', N'Николаев Д.С.', N'Исполнитель', N'Транспортный отдел', N'Инспектор', 1),
('isp5', 'e5e9fa1ba31ecd1ae84f75caaa474f3a663f05f4e9c5e4c4d4d4d4d4d4d4d4d4', 'isp5@city.ru', '+7(000)000-00-08', N'Морозов П.В.', N'Исполнитель', N'Отдел образования', N'Методист', 1);

-- Граждане (300 человек)
DECLARE @i INT = 1;
WHILE @i <= 300
BEGIN
    INSERT INTO ApplicationUser (Login, PasswordHash, Email, Phone, FullName, Role, Address, IsActive)
    VALUES (
        CONCAT('citizen', @i),
        CONVERT(NVARCHAR(128), HASHBYTES('SHA2_256', CONCAT('pass', @i)), 2),
        CONCAT('citizen', @i, '@mail.com'),
        CONCAT('+7(9', RIGHT('00'+CAST(@i AS NVARCHAR(3)),3), ')', 
               RIGHT('00'+CAST(ABS(CHECKSUM(NEWID())) % 100 AS NVARCHAR(2)),2), '-',
               RIGHT('00'+CAST(ABS(CHECKSUM(NEWID())) % 100 AS NVARCHAR(2)),2)),
        CONCAT(N'Гражданин ', @i, N' Тестовый'),
        N'Гражданин',
        CONCAT(N'г. (Город), ул. Примерная, д.', @i),
        1
    );
    SET @i = @i + 1;
END;
GO

-- ============================================================
-- 3. Обращения (~900 строк) + История + Вложения
-- ============================================================

DECLARE @authorID INT, @catID INT, @statID INT, @assigneeID INT;
DECLARE @appealID INT, @dueDate DATE;
DECLARE @j INT, @k INT;
DECLARE @numAppealsForCitizen INT;
DECLARE @citizenCursor CURSOR;
SET @citizenCursor = CURSOR FOR 
    SELECT UserID FROM ApplicationUser WHERE Role = N'Гражданин';

OPEN @citizenCursor;
FETCH NEXT FROM @citizenCursor INTO @authorID;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Каждый гражданин создаёт 2-4 обращения
    SET @numAppealsForCitizen = 2 + ABS(CHECKSUM(NEWID())) % 3;
    SET @j = 1;
    WHILE @j <= @numAppealsForCitizen
    BEGIN
        -- Случайная категория (1-5)
        SET @catID = 1 + ABS(CHECKSUM(NEWID())) % 5;
        -- Начальный статус "Новое" (1) или "В работе" (2) с разной вероятностью
        SET @statID = CASE WHEN (ABS(CHECKSUM(NEWID())) % 10) < 7 THEN 1 ELSE 2 END;
        -- Случайный исполнитель (4-8) или NULL
        IF @statID = 2
            SET @assigneeID = 4 + ABS(CHECKSUM(NEWID())) % 5;
        ELSE
            SET @assigneeID = NULL;
        
        -- Генерация дат в пределах последнего года
        DECLARE @created DATETIME = DATEADD(day, -ABS(CHECKSUM(NEWID())) % 365, GETDATE());
        DECLARE @updated DATETIME = DATEADD(hour, ABS(CHECKSUM(NEWID())) % 720, @created); -- до 30 дней позже
        
        -- Крайний срок ±10 дней от создания (не всегда)
        IF (ABS(CHECKSUM(NEWID())) % 3) = 0
            SET @dueDate = CAST(DATEADD(day, 10, @created) AS DATE);
        ELSE
            SET @dueDate = NULL;
        
        INSERT INTO Appeal (AuthorID, Title, Description, CategoryID, StatusID, AssignedToID, CreatedAt, UpdatedAt, DueDate)
        VALUES (
            @authorID,
            CONCAT(N'Обращение №', @j, N' от гражданина ', @authorID),
            CONCAT(N'Текст обращения от гражданина ', @authorID, N' по вопросу категории ', @catID, N'. Просьба принять меры.'),
            @catID,
            @statID,
            @assigneeID,
            @created,
            @updated,
            @dueDate
        );
        
        SET @appealID = SCOPE_IDENTITY();
        
        -- История: запись о создании
        INSERT INTO AppealHistory (AppealID, UserID, Action, Comment, ActionDate)
        VALUES (@appealID, @authorID, N'Создано', N'Обращение подано через портал', @created);
        
        -- Если статус "В работе" и есть исполнитель, добавляем запись о назначении
        IF @statID = 2 AND @assigneeID IS NOT NULL
        BEGIN
            INSERT INTO AppealHistory (AppealID, UserID, Action, Comment, ActionDate)
            VALUES (@appealID, 2, N'Назначен исполнитель', CONCAT(N'Назначен сотрудник ID=', @assigneeID), DATEADD(minute, 5, @created));
        END
        
        -- Иногда добавляем вложение (примерно в 10% обращений)
        IF (ABS(CHECKSUM(NEWID())) % 10) = 0
        BEGIN
            INSERT INTO Attachment (AppealID, FileName, FilePath, UploadedAt)
            VALUES (@appealID, 
                    CONCAT('file_', @appealID, '.pdf'), 
                    CONCAT('/uploads/appeals/', @appealID, '/file.pdf'),
                    @created);
        END
        
        SET @j = @j + 1;
    END
    
    FETCH NEXT FROM @citizenCursor INTO @authorID;
END

CLOSE @citizenCursor;
DEALLOCATE @citizenCursor;
GO

-- ============================================================
-- Дополнительно: добавим немного записей в историю смены статусов
-- для обращений, которые "В работе", чтобы превысить 1000 строк
-- ============================================================
INSERT INTO AppealHistory (AppealID, UserID, Action, Comment, ActionDate)
SELECT 
    a.AppealID,
    CASE WHEN (ABS(CHECKSUM(NEWID())) % 2) = 0 THEN a.AuthorID ELSE ISNULL(a.AssignedToID, 2) END,
    N'Изменён статус',
    N'Промежуточное действие',
    DATEADD(day, 1, a.CreatedAt)
FROM Appeal a
WHERE a.StatusID = 2
  AND a.AppealID % 3 = 0; -- выборочно
GO

-- Итоговый подсчёт (для проверки, можно выполнить отдельно)
SELECT 'ApplicationUser' AS Таблица, COUNT(*) AS Строк FROM ApplicationUser
UNION ALL
SELECT 'Appeal', COUNT(*) FROM Appeal
UNION ALL
SELECT 'AppealHistory', COUNT(*) FROM AppealHistory
UNION ALL
SELECT 'Attachment', COUNT(*) FROM Attachment
UNION ALL
SELECT 'Status', COUNT(*) FROM Status
UNION ALL
SELECT 'Category', COUNT(*) FROM Category;