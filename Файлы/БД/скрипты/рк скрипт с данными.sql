USE [master]
GO
/****** Object:  Database [PM11_FACTORY]    Script Date: 24.05.2026 14:14:03 ******/
CREATE DATABASE [PM11_FACTORY]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PM11_FACTORY', FILENAME = N'C:\Users\user\PM11_FACTORY.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PM11_FACTORY_log', FILENAME = N'C:\Users\user\PM11_FACTORY_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [PM11_FACTORY] SET COMPATIBILITY_LEVEL = 170
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PM11_FACTORY].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PM11_FACTORY] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PM11_FACTORY] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PM11_FACTORY] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PM11_FACTORY] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PM11_FACTORY] SET ARITHABORT OFF 
GO
ALTER DATABASE [PM11_FACTORY] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PM11_FACTORY] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PM11_FACTORY] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PM11_FACTORY] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PM11_FACTORY] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PM11_FACTORY] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PM11_FACTORY] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PM11_FACTORY] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PM11_FACTORY] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PM11_FACTORY] SET  DISABLE_BROKER 
GO
ALTER DATABASE [PM11_FACTORY] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PM11_FACTORY] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PM11_FACTORY] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PM11_FACTORY] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PM11_FACTORY] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PM11_FACTORY] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PM11_FACTORY] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PM11_FACTORY] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [PM11_FACTORY] SET  MULTI_USER 
GO
ALTER DATABASE [PM11_FACTORY] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PM11_FACTORY] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PM11_FACTORY] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PM11_FACTORY] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PM11_FACTORY] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [PM11_FACTORY] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [PM11_FACTORY] SET OPTIMIZED_LOCKING = OFF 
GO
ALTER DATABASE [PM11_FACTORY] SET QUERY_STORE = ON
GO
ALTER DATABASE [PM11_FACTORY] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [PM11_FACTORY]
GO
/****** Object:  User [city_operator]    Script Date: 24.05.2026 14:14:03 ******/
CREATE USER [city_operator] FOR LOGIN [city_operator] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [city_analyst]    Script Date: 24.05.2026 14:14:03 ******/
CREATE USER [city_analyst] FOR LOGIN [city_analyst] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [city_admin]    Script Date: 24.05.2026 14:14:03 ******/
CREATE USER [city_admin] FOR LOGIN [city_admin] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  DatabaseRole [db_operator]    Script Date: 24.05.2026 14:14:03 ******/
CREATE ROLE [db_operator]
GO
/****** Object:  DatabaseRole [db_analyst]    Script Date: 24.05.2026 14:14:03 ******/
CREATE ROLE [db_analyst]
GO
ALTER ROLE [db_operator] ADD MEMBER [city_operator]
GO
ALTER ROLE [db_analyst] ADD MEMBER [city_analyst]
GO
ALTER ROLE [db_owner] ADD MEMBER [city_admin]
GO
/****** Object:  Table [dbo].[Appeal]    Script Date: 24.05.2026 14:14:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Appeal](
	[AppealID] [int] IDENTITY(1,1) NOT NULL,
	[AuthorID] [int] NOT NULL,
	[Title] [nvarchar](200) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[CategoryID] [int] NOT NULL,
	[StatusID] [int] NOT NULL,
	[AssignedToID] [int] NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
	[DueDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[AppealID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppealHistory]    Script Date: 24.05.2026 14:14:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppealHistory](
	[HistoryID] [int] IDENTITY(1,1) NOT NULL,
	[AppealID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[Action] [nvarchar](100) NOT NULL,
	[Comment] [nvarchar](max) NULL,
	[ActionDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[HistoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ApplicationUser]    Script Date: 24.05.2026 14:14:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ApplicationUser](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Login] [nvarchar](50) NOT NULL,
	[PasswordHash] [nvarchar](128) NOT NULL,
	[Email] [nvarchar](100) NULL,
	[Phone] [nvarchar](20) NULL,
	[FullName] [nvarchar](100) NOT NULL,
	[Role] [nvarchar](20) NOT NULL,
	[Address] [nvarchar](200) NULL,
	[Department] [nvarchar](100) NULL,
	[Position] [nvarchar](100) NULL,
	[CreatedAt] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Attachment]    Script Date: 24.05.2026 14:14:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Attachment](
	[AttachmentID] [int] IDENTITY(1,1) NOT NULL,
	[AppealID] [int] NOT NULL,
	[FileName] [nvarchar](255) NOT NULL,
	[FilePath] [nvarchar](500) NOT NULL,
	[UploadedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AttachmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 24.05.2026 14:14:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Status]    Script Date: 24.05.2026 14:14:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Status](
	[StatusID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[IsFinal] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[StatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Appeal] ON 
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (2, 9, N'Обращение №2 от гражданина 9', N'Текст обращения от гражданина 9 по вопросу категории 3. Просьба принять меры.', 3, 1, 6, CAST(N'2025-09-27T19:30:12.867' AS DateTime), CAST(N'2026-05-23T10:12:23.900' AS DateTime), CAST(N'2025-10-07' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (3, 9, N'Обращение №3 от гражданина 9', N'Текст обращения от гражданина 9 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2026-01-12T19:30:12.867' AS DateTime), CAST(N'2026-02-01T20:30:12.867' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (4, 9, N'Обращение №4 от гражданина 9', N'Текст обращения от гражданина 9 по вопросу категории 2. Просьба принять меры.', 2, 2, 6, CAST(N'2026-03-22T19:30:12.867' AS DateTime), CAST(N'2026-04-08T03:30:12.867' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (5, 10, N'Обращение №1 от гражданина 10', N'Текст обращения от гражданина 10 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-06-12T19:30:12.870' AS DateTime), CAST(N'2025-07-11T03:30:12.870' AS DateTime), CAST(N'2025-06-22' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (6, 10, N'Обращение №2 от гражданина 10', N'Текст обращения от гражданина 10 по вопросу категории 1. Просьба принять меры.', 1, 2, 7, CAST(N'2025-10-13T19:30:12.870' AS DateTime), CAST(N'2025-10-24T07:30:12.870' AS DateTime), CAST(N'2025-10-23' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (7, 11, N'Обращение №1 от гражданина 11', N'Текст обращения от гражданина 11 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-11-13T19:30:12.870' AS DateTime), CAST(N'2025-12-10T05:30:12.870' AS DateTime), CAST(N'2025-11-23' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (8, 11, N'Обращение №2 от гражданина 11', N'Текст обращения от гражданина 11 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-11-09T19:30:12.870' AS DateTime), CAST(N'2025-11-22T10:30:12.870' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (9, 12, N'Обращение №1 от гражданина 12', N'Текст обращения от гражданина 12 по вопросу категории 1. Просьба принять меры.', 1, 2, 7, CAST(N'2026-03-26T19:30:12.870' AS DateTime), CAST(N'2026-04-24T16:30:12.870' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (10, 12, N'Обращение №2 от гражданина 12', N'Текст обращения от гражданина 12 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2026-01-21T19:30:12.870' AS DateTime), CAST(N'2026-01-22T17:30:12.870' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (11, 12, N'Обращение №3 от гражданина 12', N'Текст обращения от гражданина 12 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-07-06T19:30:12.873' AS DateTime), CAST(N'2025-07-15T16:30:12.873' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (12, 13, N'Обращение №1 от гражданина 13', N'Текст обращения от гражданина 13 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2026-05-02T19:30:12.873' AS DateTime), CAST(N'2026-05-28T17:30:12.873' AS DateTime), CAST(N'2026-05-12' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (13, 13, N'Обращение №2 от гражданина 13', N'Текст обращения от гражданина 13 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-08-18T19:30:12.873' AS DateTime), CAST(N'2025-08-26T16:30:12.873' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (14, 14, N'Обращение №1 от гражданина 14', N'Текст обращения от гражданина 14 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-12-02T19:30:12.873' AS DateTime), CAST(N'2025-12-05T03:30:12.873' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (15, 14, N'Обращение №2 от гражданина 14', N'Текст обращения от гражданина 14 по вопросу категории 5. Просьба принять меры.', 5, 2, 7, CAST(N'2026-03-02T19:30:12.873' AS DateTime), CAST(N'2026-03-03T06:30:12.873' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (16, 14, N'Обращение №3 от гражданина 14', N'Текст обращения от гражданина 14 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-08-02T19:30:12.873' AS DateTime), CAST(N'2025-08-07T15:30:12.873' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (17, 15, N'Обращение №1 от гражданина 15', N'Текст обращения от гражданина 15 по вопросу категории 1. Просьба принять меры.', 1, 2, 8, CAST(N'2026-05-20T19:30:12.877' AS DateTime), CAST(N'2026-06-09T20:30:12.877' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (18, 15, N'Обращение №2 от гражданина 15', N'Текст обращения от гражданина 15 по вопросу категории 1. Просьба принять меры.', 1, 2, 5, CAST(N'2025-10-09T19:30:12.877' AS DateTime), CAST(N'2025-10-10T10:30:12.877' AS DateTime), CAST(N'2025-10-19' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (19, 15, N'Обращение №3 от гражданина 15', N'Текст обращения от гражданина 15 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-08-02T19:30:12.877' AS DateTime), CAST(N'2025-08-29T21:30:12.877' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (20, 15, N'Обращение №4 от гражданина 15', N'Текст обращения от гражданина 15 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-10-03T19:30:12.877' AS DateTime), CAST(N'2025-10-07T02:30:12.877' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (21, 16, N'Обращение №1 от гражданина 16', N'Текст обращения от гражданина 16 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-05-23T19:30:12.877' AS DateTime), CAST(N'2025-06-16T09:30:12.877' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (22, 16, N'Обращение №2 от гражданина 16', N'Текст обращения от гражданина 16 по вопросу категории 1. Просьба принять меры.', 1, 2, 7, CAST(N'2026-05-05T19:30:12.877' AS DateTime), CAST(N'2026-05-15T22:30:12.877' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (23, 16, N'Обращение №3 от гражданина 16', N'Текст обращения от гражданина 16 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-07-24T19:30:12.880' AS DateTime), CAST(N'2025-08-18T23:30:12.880' AS DateTime), CAST(N'2025-08-03' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (24, 16, N'Обращение №4 от гражданина 16', N'Текст обращения от гражданина 16 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2026-02-14T19:30:12.880' AS DateTime), CAST(N'2026-02-25T03:30:12.880' AS DateTime), CAST(N'2026-02-24' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (25, 17, N'Обращение №1 от гражданина 17', N'Текст обращения от гражданина 17 по вопросу категории 1. Просьба принять меры.', 1, 2, 5, CAST(N'2025-07-17T19:30:12.880' AS DateTime), CAST(N'2025-07-21T21:30:12.880' AS DateTime), CAST(N'2025-07-27' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (26, 17, N'Обращение №2 от гражданина 17', N'Текст обращения от гражданина 17 по вопросу категории 5. Просьба принять меры.', 5, 2, 7, CAST(N'2025-12-18T19:30:12.880' AS DateTime), CAST(N'2025-12-21T00:30:12.880' AS DateTime), CAST(N'2025-12-28' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (27, 18, N'Обращение №1 от гражданина 18', N'Текст обращения от гражданина 18 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-08-01T19:30:12.880' AS DateTime), CAST(N'2025-08-20T02:30:12.880' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (28, 18, N'Обращение №2 от гражданина 18', N'Текст обращения от гражданина 18 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-07-19T19:30:12.880' AS DateTime), CAST(N'2025-08-01T17:30:12.880' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (29, 19, N'Обращение №1 от гражданина 19', N'Текст обращения от гражданина 19 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-06-24T19:30:12.880' AS DateTime), CAST(N'2025-07-18T10:30:12.880' AS DateTime), CAST(N'2025-07-04' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (30, 19, N'Обращение №2 от гражданина 19', N'Текст обращения от гражданина 19 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-08-12T19:30:12.880' AS DateTime), CAST(N'2025-09-11T10:30:12.880' AS DateTime), CAST(N'2025-08-22' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (31, 19, N'Обращение №3 от гражданина 19', N'Текст обращения от гражданина 19 по вопросу категории 4. Просьба принять меры.', 4, 2, 7, CAST(N'2026-03-17T19:30:12.883' AS DateTime), CAST(N'2026-04-01T03:30:12.883' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (32, 19, N'Обращение №4 от гражданина 19', N'Текст обращения от гражданина 19 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-07-30T19:30:12.883' AS DateTime), CAST(N'2025-08-08T11:30:12.883' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (33, 20, N'Обращение №1 от гражданина 20', N'Текст обращения от гражданина 20 по вопросу категории 3. Просьба принять меры.', 3, 2, 7, CAST(N'2025-10-13T19:30:12.883' AS DateTime), CAST(N'2025-11-04T11:30:12.883' AS DateTime), CAST(N'2025-10-23' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (34, 20, N'Обращение №2 от гражданина 20', N'Текст обращения от гражданина 20 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-12-06T19:30:12.887' AS DateTime), CAST(N'2026-01-05T02:30:12.887' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (35, 21, N'Обращение №1 от гражданина 21', N'Текст обращения от гражданина 21 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-08-13T19:30:12.887' AS DateTime), CAST(N'2025-09-02T00:30:12.887' AS DateTime), CAST(N'2025-08-23' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (36, 21, N'Обращение №2 от гражданина 21', N'Текст обращения от гражданина 21 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-09-24T19:30:12.887' AS DateTime), CAST(N'2025-10-02T00:30:12.887' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (37, 21, N'Обращение №3 от гражданина 21', N'Текст обращения от гражданина 21 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-10-07T19:30:12.887' AS DateTime), CAST(N'2025-10-19T18:30:12.887' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (38, 22, N'Обращение №1 от гражданина 22', N'Текст обращения от гражданина 22 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-10-07T19:30:12.887' AS DateTime), CAST(N'2025-10-15T11:30:12.887' AS DateTime), CAST(N'2025-10-17' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (39, 22, N'Обращение №2 от гражданина 22', N'Текст обращения от гражданина 22 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-06-16T19:30:12.887' AS DateTime), CAST(N'2025-06-29T12:30:12.887' AS DateTime), CAST(N'2025-06-26' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (40, 22, N'Обращение №3 от гражданина 22', N'Текст обращения от гражданина 22 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-09-29T19:30:12.887' AS DateTime), CAST(N'2025-10-19T09:30:12.887' AS DateTime), CAST(N'2025-10-09' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (41, 22, N'Обращение №4 от гражданина 22', N'Текст обращения от гражданина 22 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-12-15T19:30:12.887' AS DateTime), CAST(N'2025-12-29T17:30:12.887' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (42, 23, N'Обращение №1 от гражданина 23', N'Текст обращения от гражданина 23 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2026-01-13T19:30:12.890' AS DateTime), CAST(N'2026-02-09T03:30:12.890' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (43, 23, N'Обращение №2 от гражданина 23', N'Текст обращения от гражданина 23 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2026-03-31T19:30:12.890' AS DateTime), CAST(N'2026-04-11T18:30:12.890' AS DateTime), CAST(N'2026-04-10' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (44, 23, N'Обращение №3 от гражданина 23', N'Текст обращения от гражданина 23 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-09-19T19:30:12.890' AS DateTime), CAST(N'2025-10-03T03:30:12.890' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (45, 24, N'Обращение №1 от гражданина 24', N'Текст обращения от гражданина 24 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2026-03-01T19:30:12.890' AS DateTime), CAST(N'2026-03-21T06:30:12.890' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (46, 24, N'Обращение №2 от гражданина 24', N'Текст обращения от гражданина 24 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-07-04T19:30:12.890' AS DateTime), CAST(N'2025-08-02T19:30:12.890' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (47, 24, N'Обращение №3 от гражданина 24', N'Текст обращения от гражданина 24 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-12-25T19:30:12.890' AS DateTime), CAST(N'2026-01-08T14:30:12.890' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (48, 25, N'Обращение №1 от гражданина 25', N'Текст обращения от гражданина 25 по вопросу категории 1. Просьба принять меры.', 1, 2, 8, CAST(N'2025-08-27T19:30:12.890' AS DateTime), CAST(N'2025-09-03T04:30:12.890' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (49, 25, N'Обращение №2 от гражданина 25', N'Текст обращения от гражданина 25 по вопросу категории 2. Просьба принять меры.', 2, 2, 4, CAST(N'2025-10-17T19:30:12.890' AS DateTime), CAST(N'2025-10-28T18:30:12.890' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (50, 25, N'Обращение №3 от гражданина 25', N'Текст обращения от гражданина 25 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2026-03-15T19:30:12.893' AS DateTime), CAST(N'2026-03-22T00:30:12.893' AS DateTime), CAST(N'2026-03-25' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (51, 26, N'Обращение №1 от гражданина 26', N'Текст обращения от гражданина 26 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2026-03-23T19:30:12.893' AS DateTime), CAST(N'2026-04-01T10:30:12.893' AS DateTime), CAST(N'2026-04-02' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (52, 26, N'Обращение №2 от гражданина 26', N'Текст обращения от гражданина 26 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2026-03-07T19:30:12.893' AS DateTime), CAST(N'2026-03-20T20:30:12.893' AS DateTime), CAST(N'2026-03-17' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (53, 26, N'Обращение №3 от гражданина 26', N'Текст обращения от гражданина 26 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2026-01-20T19:30:12.893' AS DateTime), CAST(N'2026-01-27T14:30:12.893' AS DateTime), CAST(N'2026-01-30' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (54, 27, N'Обращение №1 от гражданина 27', N'Текст обращения от гражданина 27 по вопросу категории 4. Просьба принять меры.', 4, 2, 4, CAST(N'2026-04-27T19:30:12.893' AS DateTime), CAST(N'2026-05-10T02:30:12.893' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (55, 27, N'Обращение №2 от гражданина 27', N'Текст обращения от гражданина 27 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-09-11T19:30:12.893' AS DateTime), CAST(N'2025-10-03T07:30:12.893' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (56, 28, N'Обращение №1 от гражданина 28', N'Текст обращения от гражданина 28 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-09-30T19:30:12.897' AS DateTime), CAST(N'2025-10-07T01:30:12.897' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (57, 28, N'Обращение №2 от гражданина 28', N'Текст обращения от гражданина 28 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2026-04-17T19:30:12.897' AS DateTime), CAST(N'2026-04-28T11:30:12.897' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (58, 29, N'Обращение №1 от гражданина 29', N'Текст обращения от гражданина 29 по вопросу категории 3. Просьба принять меры.', 3, 2, 8, CAST(N'2026-01-17T19:30:12.897' AS DateTime), CAST(N'2026-01-22T20:30:12.897' AS DateTime), CAST(N'2026-01-27' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (59, 29, N'Обращение №2 от гражданина 29', N'Текст обращения от гражданина 29 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2026-04-04T19:30:12.897' AS DateTime), CAST(N'2026-04-24T22:30:12.897' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (60, 29, N'Обращение №3 от гражданина 29', N'Текст обращения от гражданина 29 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2026-01-11T19:30:12.897' AS DateTime), CAST(N'2026-01-26T20:30:12.897' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (61, 29, N'Обращение №4 от гражданина 29', N'Текст обращения от гражданина 29 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-11-09T19:30:12.897' AS DateTime), CAST(N'2025-11-28T22:30:12.897' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (62, 30, N'Обращение №1 от гражданина 30', N'Текст обращения от гражданина 30 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2026-04-02T19:30:12.900' AS DateTime), CAST(N'2026-04-08T07:30:12.900' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (63, 30, N'Обращение №2 от гражданина 30', N'Текст обращения от гражданина 30 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2026-02-14T19:30:12.900' AS DateTime), CAST(N'2026-02-19T10:30:12.900' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (64, 31, N'Обращение №1 от гражданина 31', N'Текст обращения от гражданина 31 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-12-19T19:30:12.900' AS DateTime), CAST(N'2025-12-26T22:30:12.900' AS DateTime), CAST(N'2025-12-29' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (65, 31, N'Обращение №2 от гражданина 31', N'Текст обращения от гражданина 31 по вопросу категории 2. Просьба принять меры.', 2, 2, 8, CAST(N'2026-03-24T19:30:12.900' AS DateTime), CAST(N'2026-03-28T08:30:12.900' AS DateTime), CAST(N'2026-04-03' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (66, 31, N'Обращение №3 от гражданина 31', N'Текст обращения от гражданина 31 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-07-18T19:30:12.900' AS DateTime), CAST(N'2025-07-19T17:30:12.900' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (67, 32, N'Обращение №1 от гражданина 32', N'Текст обращения от гражданина 32 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-08-14T19:30:12.900' AS DateTime), CAST(N'2025-09-10T07:30:12.900' AS DateTime), CAST(N'2025-08-24' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (68, 32, N'Обращение №2 от гражданина 32', N'Текст обращения от гражданина 32 по вопросу категории 4. Просьба принять меры.', 4, 2, 6, CAST(N'2025-11-01T19:30:12.900' AS DateTime), CAST(N'2025-11-15T14:30:12.900' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (69, 32, N'Обращение №3 от гражданина 32', N'Текст обращения от гражданина 32 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2026-01-03T19:30:12.900' AS DateTime), CAST(N'2026-01-27T13:30:12.900' AS DateTime), CAST(N'2026-01-13' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (70, 32, N'Обращение №4 от гражданина 32', N'Текст обращения от гражданина 32 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-10-14T19:30:12.900' AS DateTime), CAST(N'2025-11-05T03:30:12.900' AS DateTime), CAST(N'2025-10-24' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (71, 33, N'Обращение №1 от гражданина 33', N'Текст обращения от гражданина 33 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-06-12T19:30:12.903' AS DateTime), CAST(N'2025-07-11T04:30:12.903' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (72, 33, N'Обращение №2 от гражданина 33', N'Текст обращения от гражданина 33 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2026-04-02T19:30:12.903' AS DateTime), CAST(N'2026-05-01T23:30:12.903' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (73, 34, N'Обращение №1 от гражданина 34', N'Текст обращения от гражданина 34 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-08-13T19:30:13.073' AS DateTime), CAST(N'2025-09-09T00:30:13.073' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (74, 34, N'Обращение №2 от гражданина 34', N'Текст обращения от гражданина 34 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-10-31T19:30:13.073' AS DateTime), CAST(N'2025-11-10T16:30:13.073' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (75, 35, N'Обращение №1 от гражданина 35', N'Текст обращения от гражданина 35 по вопросу категории 3. Просьба принять меры.', 3, 2, 6, CAST(N'2025-08-20T19:30:13.077' AS DateTime), CAST(N'2025-08-30T00:30:13.077' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (76, 35, N'Обращение №2 от гражданина 35', N'Текст обращения от гражданина 35 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-11-12T19:30:13.077' AS DateTime), CAST(N'2025-12-10T15:30:13.077' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (77, 36, N'Обращение №1 от гражданина 36', N'Текст обращения от гражданина 36 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2026-03-14T19:30:13.077' AS DateTime), CAST(N'2026-03-29T02:30:13.077' AS DateTime), CAST(N'2026-03-24' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (78, 36, N'Обращение №2 от гражданина 36', N'Текст обращения от гражданина 36 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2026-04-06T19:30:13.077' AS DateTime), CAST(N'2026-04-12T15:30:13.077' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (79, 37, N'Обращение №1 от гражданина 37', N'Текст обращения от гражданина 37 по вопросу категории 2. Просьба принять меры.', 2, 2, 5, CAST(N'2025-12-27T19:30:13.077' AS DateTime), CAST(N'2025-12-30T13:30:13.077' AS DateTime), CAST(N'2026-01-06' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (80, 37, N'Обращение №2 от гражданина 37', N'Текст обращения от гражданина 37 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2026-03-06T19:30:13.080' AS DateTime), CAST(N'2026-03-18T10:30:13.080' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (81, 37, N'Обращение №3 от гражданина 37', N'Текст обращения от гражданина 37 по вопросу категории 5. Просьба принять меры.', 5, 2, 8, CAST(N'2026-01-14T19:30:13.080' AS DateTime), CAST(N'2026-02-07T02:30:13.080' AS DateTime), CAST(N'2026-01-24' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (82, 38, N'Обращение №1 от гражданина 38', N'Текст обращения от гражданина 38 по вопросу категории 5. Просьба принять меры.', 5, 2, 8, CAST(N'2025-12-01T19:30:13.080' AS DateTime), CAST(N'2025-12-03T22:30:13.080' AS DateTime), CAST(N'2025-12-11' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (83, 38, N'Обращение №2 от гражданина 38', N'Текст обращения от гражданина 38 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-08-06T19:30:13.080' AS DateTime), CAST(N'2025-08-10T01:30:13.080' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (84, 38, N'Обращение №3 от гражданина 38', N'Текст обращения от гражданина 38 по вопросу категории 3. Просьба принять меры.', 3, 2, 4, CAST(N'2025-12-18T19:30:13.080' AS DateTime), CAST(N'2026-01-04T11:30:13.080' AS DateTime), CAST(N'2025-12-28' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (85, 38, N'Обращение №4 от гражданина 38', N'Текст обращения от гражданина 38 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2026-02-09T19:30:13.080' AS DateTime), CAST(N'2026-03-10T07:30:13.080' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (86, 39, N'Обращение №1 от гражданина 39', N'Текст обращения от гражданина 39 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-11-06T19:30:13.080' AS DateTime), CAST(N'2025-11-18T07:30:13.080' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (87, 39, N'Обращение №2 от гражданина 39', N'Текст обращения от гражданина 39 по вопросу категории 1. Просьба принять меры.', 1, 2, 6, CAST(N'2026-02-26T19:30:13.083' AS DateTime), CAST(N'2026-03-24T01:30:13.083' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (88, 39, N'Обращение №3 от гражданина 39', N'Текст обращения от гражданина 39 по вопросу категории 4. Просьба принять меры.', 4, 2, 4, CAST(N'2025-09-07T19:30:13.083' AS DateTime), CAST(N'2025-09-28T04:30:13.083' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (89, 40, N'Обращение №1 от гражданина 40', N'Текст обращения от гражданина 40 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2026-04-30T19:30:13.083' AS DateTime), CAST(N'2026-05-04T06:30:13.083' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (90, 40, N'Обращение №2 от гражданина 40', N'Текст обращения от гражданина 40 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-07-30T19:30:13.083' AS DateTime), CAST(N'2025-08-13T21:30:13.083' AS DateTime), CAST(N'2025-08-09' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (91, 41, N'Обращение №1 от гражданина 41', N'Текст обращения от гражданина 41 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2026-03-31T19:30:13.083' AS DateTime), CAST(N'2026-04-24T21:30:13.083' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (92, 41, N'Обращение №2 от гражданина 41', N'Текст обращения от гражданина 41 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2026-04-19T19:30:13.083' AS DateTime), CAST(N'2026-05-07T14:30:13.083' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (93, 42, N'Обращение №1 от гражданина 42', N'Текст обращения от гражданина 42 по вопросу категории 2. Просьба принять меры.', 2, 2, 7, CAST(N'2025-07-21T19:30:13.087' AS DateTime), CAST(N'2025-08-09T16:30:13.087' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (94, 42, N'Обращение №2 от гражданина 42', N'Текст обращения от гражданина 42 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2026-05-18T19:30:13.087' AS DateTime), CAST(N'2026-06-13T16:30:13.087' AS DateTime), CAST(N'2026-05-28' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (95, 42, N'Обращение №3 от гражданина 42', N'Текст обращения от гражданина 42 по вопросу категории 5. Просьба принять меры.', 5, 2, 8, CAST(N'2025-06-06T19:30:13.087' AS DateTime), CAST(N'2025-06-27T22:30:13.087' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (96, 42, N'Обращение №4 от гражданина 42', N'Текст обращения от гражданина 42 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2026-03-22T19:30:13.087' AS DateTime), CAST(N'2026-03-26T04:30:13.087' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (97, 43, N'Обращение №1 от гражданина 43', N'Текст обращения от гражданина 43 по вопросу категории 2. Просьба принять меры.', 2, 2, 8, CAST(N'2025-10-07T19:30:13.087' AS DateTime), CAST(N'2025-10-31T22:30:13.087' AS DateTime), CAST(N'2025-10-17' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (98, 43, N'Обращение №2 от гражданина 43', N'Текст обращения от гражданина 43 по вопросу категории 1. Просьба принять меры.', 1, 2, 7, CAST(N'2025-09-23T19:30:13.087' AS DateTime), CAST(N'2025-10-21T23:30:13.087' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (99, 43, N'Обращение №3 от гражданина 43', N'Текст обращения от гражданина 43 по вопросу категории 2. Просьба принять меры.', 2, 2, 4, CAST(N'2025-11-13T19:30:13.090' AS DateTime), CAST(N'2025-12-08T06:30:13.090' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (100, 44, N'Обращение №1 от гражданина 44', N'Текст обращения от гражданина 44 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2026-05-09T19:30:13.090' AS DateTime), CAST(N'2026-05-30T05:30:13.090' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (101, 44, N'Обращение №2 от гражданина 44', N'Текст обращения от гражданина 44 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-08-03T19:30:13.090' AS DateTime), CAST(N'2025-08-19T23:30:13.090' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (102, 45, N'Обращение №1 от гражданина 45', N'Текст обращения от гражданина 45 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2026-05-18T19:30:13.090' AS DateTime), CAST(N'2026-06-06T10:30:13.090' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (103, 45, N'Обращение №2 от гражданина 45', N'Текст обращения от гражданина 45 по вопросу категории 2. Просьба принять меры.', 2, 2, 8, CAST(N'2026-03-31T19:30:13.090' AS DateTime), CAST(N'2026-04-09T00:30:13.090' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (104, 45, N'Обращение №3 от гражданина 45', N'Текст обращения от гражданина 45 по вопросу категории 3. Просьба принять меры.', 3, 2, 7, CAST(N'2025-07-15T19:30:13.090' AS DateTime), CAST(N'2025-07-22T05:30:13.090' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (105, 45, N'Обращение №4 от гражданина 45', N'Текст обращения от гражданина 45 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-07-20T19:30:13.093' AS DateTime), CAST(N'2025-08-18T02:30:13.093' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (106, 46, N'Обращение №1 от гражданина 46', N'Текст обращения от гражданина 46 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2026-01-31T19:30:13.093' AS DateTime), CAST(N'2026-02-10T18:30:13.093' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (107, 46, N'Обращение №2 от гражданина 46', N'Текст обращения от гражданина 46 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2026-01-23T19:30:13.093' AS DateTime), CAST(N'2026-02-10T09:30:13.093' AS DateTime), CAST(N'2026-02-02' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (108, 46, N'Обращение №3 от гражданина 46', N'Текст обращения от гражданина 46 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2026-05-03T19:30:13.093' AS DateTime), CAST(N'2026-05-27T19:30:13.093' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (109, 46, N'Обращение №4 от гражданина 46', N'Текст обращения от гражданина 46 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-11-07T19:30:13.263' AS DateTime), CAST(N'2025-11-08T23:30:13.263' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (110, 47, N'Обращение №1 от гражданина 47', N'Текст обращения от гражданина 47 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2026-03-15T19:30:13.263' AS DateTime), CAST(N'2026-03-24T17:30:13.263' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (111, 47, N'Обращение №2 от гражданина 47', N'Текст обращения от гражданина 47 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2026-01-01T19:30:13.267' AS DateTime), CAST(N'2026-01-14T23:30:13.267' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (112, 48, N'Обращение №1 от гражданина 48', N'Текст обращения от гражданина 48 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2026-02-06T19:30:13.267' AS DateTime), CAST(N'2026-03-05T06:30:13.267' AS DateTime), CAST(N'2026-02-16' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (113, 48, N'Обращение №2 от гражданина 48', N'Текст обращения от гражданина 48 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-09-09T19:30:13.267' AS DateTime), CAST(N'2025-09-14T06:30:13.267' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (114, 48, N'Обращение №3 от гражданина 48', N'Текст обращения от гражданина 48 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-10-19T19:30:13.267' AS DateTime), CAST(N'2025-10-25T13:30:13.267' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (115, 49, N'Обращение №1 от гражданина 49', N'Текст обращения от гражданина 49 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-06-29T19:30:13.267' AS DateTime), CAST(N'2025-07-15T10:30:13.267' AS DateTime), CAST(N'2025-07-09' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (116, 49, N'Обращение №2 от гражданина 49', N'Текст обращения от гражданина 49 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2026-02-07T19:30:13.270' AS DateTime), CAST(N'2026-03-05T06:30:13.270' AS DateTime), CAST(N'2026-02-17' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (117, 49, N'Обращение №3 от гражданина 49', N'Текст обращения от гражданина 49 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2026-04-26T19:30:13.270' AS DateTime), CAST(N'2026-05-05T09:30:13.270' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (118, 49, N'Обращение №4 от гражданина 49', N'Текст обращения от гражданина 49 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-09-17T19:30:13.270' AS DateTime), CAST(N'2025-09-21T08:30:13.270' AS DateTime), CAST(N'2025-09-27' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (119, 50, N'Обращение №1 от гражданина 50', N'Текст обращения от гражданина 50 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-06-12T19:30:13.270' AS DateTime), CAST(N'2025-06-14T16:30:13.270' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (120, 50, N'Обращение №2 от гражданина 50', N'Текст обращения от гражданина 50 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-06-13T19:30:13.270' AS DateTime), CAST(N'2025-06-28T05:30:13.270' AS DateTime), CAST(N'2025-06-23' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (121, 51, N'Обращение №1 от гражданина 51', N'Текст обращения от гражданина 51 по вопросу категории 5. Просьба принять меры.', 5, 2, 4, CAST(N'2025-06-30T19:30:13.270' AS DateTime), CAST(N'2025-07-29T17:30:13.270' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (122, 51, N'Обращение №2 от гражданина 51', N'Текст обращения от гражданина 51 по вопросу категории 1. Просьба принять меры.', 1, 2, 5, CAST(N'2025-07-18T19:30:13.270' AS DateTime), CAST(N'2025-07-19T01:30:13.270' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (123, 51, N'Обращение №3 от гражданина 51', N'Текст обращения от гражданина 51 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2026-05-09T19:30:13.270' AS DateTime), CAST(N'2026-05-12T06:30:13.270' AS DateTime), CAST(N'2026-05-19' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (124, 51, N'Обращение №4 от гражданина 51', N'Текст обращения от гражданина 51 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-09-04T19:30:13.273' AS DateTime), CAST(N'2025-09-06T08:30:13.273' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (125, 52, N'Обращение №1 от гражданина 52', N'Текст обращения от гражданина 52 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-08-09T19:30:13.273' AS DateTime), CAST(N'2025-08-20T17:30:13.273' AS DateTime), CAST(N'2025-08-19' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (126, 52, N'Обращение №2 от гражданина 52', N'Текст обращения от гражданина 52 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-07-07T19:30:13.273' AS DateTime), CAST(N'2025-08-02T20:30:13.273' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (127, 52, N'Обращение №3 от гражданина 52', N'Текст обращения от гражданина 52 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2026-04-14T19:30:13.273' AS DateTime), CAST(N'2026-05-02T21:30:13.273' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (128, 53, N'Обращение №1 от гражданина 53', N'Текст обращения от гражданина 53 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-11-28T19:30:13.273' AS DateTime), CAST(N'2025-12-06T08:30:13.273' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (129, 53, N'Обращение №2 от гражданина 53', N'Текст обращения от гражданина 53 по вопросу категории 3. Просьба принять меры.', 3, 2, 5, CAST(N'2025-08-04T19:30:13.273' AS DateTime), CAST(N'2025-08-13T12:30:13.273' AS DateTime), CAST(N'2025-08-14' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (130, 53, N'Обращение №3 от гражданина 53', N'Текст обращения от гражданина 53 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-09-01T19:30:13.273' AS DateTime), CAST(N'2025-09-05T11:30:13.273' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (131, 53, N'Обращение №4 от гражданина 53', N'Текст обращения от гражданина 53 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2026-01-14T19:30:13.277' AS DateTime), CAST(N'2026-02-10T03:30:13.277' AS DateTime), CAST(N'2026-01-24' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (132, 54, N'Обращение №1 от гражданина 54', N'Текст обращения от гражданина 54 по вопросу категории 1. Просьба принять меры.', 1, 2, 8, CAST(N'2025-12-27T19:30:13.277' AS DateTime), CAST(N'2026-01-05T18:30:13.277' AS DateTime), CAST(N'2026-01-06' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (133, 54, N'Обращение №2 от гражданина 54', N'Текст обращения от гражданина 54 по вопросу категории 4. Просьба принять меры.', 4, 2, 5, CAST(N'2025-07-04T19:30:13.277' AS DateTime), CAST(N'2025-07-22T04:30:13.277' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (134, 54, N'Обращение №3 от гражданина 54', N'Текст обращения от гражданина 54 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2026-05-14T19:30:13.277' AS DateTime), CAST(N'2026-06-06T04:30:13.277' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (135, 55, N'Обращение №1 от гражданина 55', N'Текст обращения от гражданина 55 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2026-02-01T19:30:13.277' AS DateTime), CAST(N'2026-02-02T22:30:13.277' AS DateTime), CAST(N'2026-02-11' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (136, 55, N'Обращение №2 от гражданина 55', N'Текст обращения от гражданина 55 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-10-09T19:30:13.277' AS DateTime), CAST(N'2025-10-22T04:30:13.277' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (137, 55, N'Обращение №3 от гражданина 55', N'Текст обращения от гражданина 55 по вопросу категории 4. Просьба принять меры.', 4, 2, 7, CAST(N'2025-09-13T19:30:13.280' AS DateTime), CAST(N'2025-09-21T16:30:13.280' AS DateTime), CAST(N'2025-09-23' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (138, 55, N'Обращение №4 от гражданина 55', N'Текст обращения от гражданина 55 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-12-10T19:30:13.280' AS DateTime), CAST(N'2025-12-14T13:30:13.280' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (139, 56, N'Обращение №1 от гражданина 56', N'Текст обращения от гражданина 56 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-12-02T19:30:13.280' AS DateTime), CAST(N'2025-12-28T09:30:13.280' AS DateTime), CAST(N'2025-12-12' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (140, 56, N'Обращение №2 от гражданина 56', N'Текст обращения от гражданина 56 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-09-26T19:30:13.280' AS DateTime), CAST(N'2025-10-20T23:30:13.280' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (141, 56, N'Обращение №3 от гражданина 56', N'Текст обращения от гражданина 56 по вопросу категории 1. Просьба принять меры.', 1, 2, 6, CAST(N'2026-04-02T19:30:13.280' AS DateTime), CAST(N'2026-04-10T06:30:13.280' AS DateTime), CAST(N'2026-04-12' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (142, 56, N'Обращение №4 от гражданина 56', N'Текст обращения от гражданина 56 по вопросу категории 5. Просьба принять меры.', 5, 2, 8, CAST(N'2026-05-12T19:30:13.280' AS DateTime), CAST(N'2026-05-16T00:30:13.280' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (143, 57, N'Обращение №1 от гражданина 57', N'Текст обращения от гражданина 57 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-06-16T19:30:13.280' AS DateTime), CAST(N'2025-06-24T03:30:13.280' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (144, 57, N'Обращение №2 от гражданина 57', N'Текст обращения от гражданина 57 по вопросу категории 5. Просьба принять меры.', 5, 2, 7, CAST(N'2026-02-18T19:30:13.283' AS DateTime), CAST(N'2026-03-08T17:30:13.283' AS DateTime), CAST(N'2026-02-28' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (145, 57, N'Обращение №3 от гражданина 57', N'Текст обращения от гражданина 57 по вопросу категории 2. Просьба принять меры.', 2, 2, 8, CAST(N'2025-06-06T19:30:13.327' AS DateTime), CAST(N'2025-07-06T03:30:13.327' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (146, 57, N'Обращение №4 от гражданина 57', N'Текст обращения от гражданина 57 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-06-07T19:30:13.327' AS DateTime), CAST(N'2025-06-15T21:30:13.327' AS DateTime), CAST(N'2025-06-17' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (147, 58, N'Обращение №1 от гражданина 58', N'Текст обращения от гражданина 58 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2026-03-23T19:30:13.327' AS DateTime), CAST(N'2026-04-22T15:30:13.327' AS DateTime), CAST(N'2026-04-02' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (148, 58, N'Обращение №2 от гражданина 58', N'Текст обращения от гражданина 58 по вопросу категории 3. Просьба принять меры.', 3, 2, 4, CAST(N'2026-02-25T19:30:13.327' AS DateTime), CAST(N'2026-03-14T23:30:13.327' AS DateTime), CAST(N'2026-03-07' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (149, 58, N'Обращение №3 от гражданина 58', N'Текст обращения от гражданина 58 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2026-04-29T19:30:13.330' AS DateTime), CAST(N'2026-05-14T17:30:13.330' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (150, 58, N'Обращение №4 от гражданина 58', N'Текст обращения от гражданина 58 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-07-15T19:30:13.330' AS DateTime), CAST(N'2025-08-07T18:30:13.330' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (151, 59, N'Обращение №1 от гражданина 59', N'Текст обращения от гражданина 59 по вопросу категории 5. Просьба принять меры.', 5, 2, 4, CAST(N'2025-09-14T19:30:13.330' AS DateTime), CAST(N'2025-09-18T21:30:13.330' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (152, 59, N'Обращение №2 от гражданина 59', N'Текст обращения от гражданина 59 по вопросу категории 3. Просьба принять меры.', 3, 2, 7, CAST(N'2025-08-27T19:30:13.330' AS DateTime), CAST(N'2025-09-09T19:30:13.330' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (153, 60, N'Обращение №1 от гражданина 60', N'Текст обращения от гражданина 60 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2026-04-03T19:30:13.330' AS DateTime), CAST(N'2026-04-16T20:30:13.330' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (154, 60, N'Обращение №2 от гражданина 60', N'Текст обращения от гражданина 60 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-10-22T19:30:13.330' AS DateTime), CAST(N'2025-11-13T18:30:13.330' AS DateTime), CAST(N'2025-11-01' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (155, 61, N'Обращение №1 от гражданина 61', N'Текст обращения от гражданина 61 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-10-04T19:30:13.330' AS DateTime), CAST(N'2025-10-14T03:30:13.330' AS DateTime), CAST(N'2025-10-14' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (156, 61, N'Обращение №2 от гражданина 61', N'Текст обращения от гражданина 61 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-11-16T19:30:13.330' AS DateTime), CAST(N'2025-11-28T14:30:13.330' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (157, 62, N'Обращение №1 от гражданина 62', N'Текст обращения от гражданина 62 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2026-05-14T19:30:13.333' AS DateTime), CAST(N'2026-06-03T23:30:13.333' AS DateTime), CAST(N'2026-05-24' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (158, 62, N'Обращение №2 от гражданина 62', N'Текст обращения от гражданина 62 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2026-03-28T19:30:13.333' AS DateTime), CAST(N'2026-04-16T08:30:13.333' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (159, 63, N'Обращение №1 от гражданина 63', N'Текст обращения от гражданина 63 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-06-17T19:30:13.333' AS DateTime), CAST(N'2025-07-07T07:30:13.333' AS DateTime), CAST(N'2025-06-27' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (160, 63, N'Обращение №2 от гражданина 63', N'Текст обращения от гражданина 63 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-11-02T19:30:13.333' AS DateTime), CAST(N'2025-11-08T11:30:13.333' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (161, 63, N'Обращение №3 от гражданина 63', N'Текст обращения от гражданина 63 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-11-03T19:30:13.333' AS DateTime), CAST(N'2025-11-14T23:30:13.333' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (162, 64, N'Обращение №1 от гражданина 64', N'Текст обращения от гражданина 64 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-09-09T19:30:13.333' AS DateTime), CAST(N'2025-09-30T05:30:13.333' AS DateTime), CAST(N'2025-09-19' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (163, 64, N'Обращение №2 от гражданина 64', N'Текст обращения от гражданина 64 по вопросу категории 4. Просьба принять меры.', 4, 2, 6, CAST(N'2026-01-04T19:30:13.333' AS DateTime), CAST(N'2026-01-25T23:30:13.333' AS DateTime), CAST(N'2026-01-14' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (164, 64, N'Обращение №3 от гражданина 64', N'Текст обращения от гражданина 64 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2026-03-31T19:30:13.337' AS DateTime), CAST(N'2026-04-26T06:30:13.337' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (165, 64, N'Обращение №4 от гражданина 64', N'Текст обращения от гражданина 64 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2026-03-07T19:30:13.337' AS DateTime), CAST(N'2026-03-22T09:30:13.337' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (166, 65, N'Обращение №1 от гражданина 65', N'Текст обращения от гражданина 65 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-07-12T19:30:13.337' AS DateTime), CAST(N'2025-08-03T00:30:13.337' AS DateTime), CAST(N'2025-07-22' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (167, 65, N'Обращение №2 от гражданина 65', N'Текст обращения от гражданина 65 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2026-01-04T19:30:13.337' AS DateTime), CAST(N'2026-01-06T17:30:13.337' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (168, 66, N'Обращение №1 от гражданина 66', N'Текст обращения от гражданина 66 по вопросу категории 1. Просьба принять меры.', 1, 2, 5, CAST(N'2025-09-14T19:30:13.337' AS DateTime), CAST(N'2025-10-11T05:30:13.337' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (169, 66, N'Обращение №2 от гражданина 66', N'Текст обращения от гражданина 66 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-10-28T19:30:13.337' AS DateTime), CAST(N'2025-11-24T02:30:13.337' AS DateTime), CAST(N'2025-11-07' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (170, 66, N'Обращение №3 от гражданина 66', N'Текст обращения от гражданина 66 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-10-03T19:30:13.340' AS DateTime), CAST(N'2025-10-22T02:30:13.340' AS DateTime), CAST(N'2025-10-13' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (171, 67, N'Обращение №1 от гражданина 67', N'Текст обращения от гражданина 67 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-10-17T19:30:13.340' AS DateTime), CAST(N'2025-11-07T18:30:13.340' AS DateTime), CAST(N'2025-10-27' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (172, 67, N'Обращение №2 от гражданина 67', N'Текст обращения от гражданина 67 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2026-04-06T19:30:13.340' AS DateTime), CAST(N'2026-04-23T18:30:13.340' AS DateTime), CAST(N'2026-04-16' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (173, 67, N'Обращение №3 от гражданина 67', N'Текст обращения от гражданина 67 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-05-31T19:30:13.340' AS DateTime), CAST(N'2025-06-22T07:30:13.340' AS DateTime), CAST(N'2025-06-10' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (174, 68, N'Обращение №1 от гражданина 68', N'Текст обращения от гражданина 68 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2026-01-08T19:30:13.340' AS DateTime), CAST(N'2026-01-11T19:30:13.340' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (175, 68, N'Обращение №2 от гражданина 68', N'Текст обращения от гражданина 68 по вопросу категории 2. Просьба принять меры.', 2, 2, 4, CAST(N'2025-10-01T19:30:13.340' AS DateTime), CAST(N'2025-10-15T08:30:13.340' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (176, 68, N'Обращение №3 от гражданина 68', N'Текст обращения от гражданина 68 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-07-16T19:30:13.340' AS DateTime), CAST(N'2025-08-12T22:30:13.340' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (177, 68, N'Обращение №4 от гражданина 68', N'Текст обращения от гражданина 68 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-08-19T19:30:13.340' AS DateTime), CAST(N'2025-09-02T01:30:13.340' AS DateTime), CAST(N'2025-08-29' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (178, 69, N'Обращение №1 от гражданина 69', N'Текст обращения от гражданина 69 по вопросу категории 3. Просьба принять меры.', 3, 2, 6, CAST(N'2026-02-08T19:30:13.340' AS DateTime), CAST(N'2026-02-12T10:30:13.340' AS DateTime), CAST(N'2026-02-18' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (179, 69, N'Обращение №2 от гражданина 69', N'Текст обращения от гражданина 69 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-05-22T19:30:13.343' AS DateTime), CAST(N'2025-06-15T01:30:13.343' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (180, 69, N'Обращение №3 от гражданина 69', N'Текст обращения от гражданина 69 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-11-26T19:30:13.343' AS DateTime), CAST(N'2025-12-12T05:30:13.343' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (181, 70, N'Обращение №1 от гражданина 70', N'Текст обращения от гражданина 70 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2026-02-28T19:30:13.343' AS DateTime), CAST(N'2026-03-16T21:30:13.343' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (182, 70, N'Обращение №2 от гражданина 70', N'Текст обращения от гражданина 70 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-10-22T19:30:13.343' AS DateTime), CAST(N'2025-11-11T04:30:13.343' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (183, 71, N'Обращение №1 от гражданина 71', N'Текст обращения от гражданина 71 по вопросу категории 2. Просьба принять меры.', 2, 2, 6, CAST(N'2026-01-29T19:30:13.343' AS DateTime), CAST(N'2026-02-11T02:30:13.343' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (184, 71, N'Обращение №2 от гражданина 71', N'Текст обращения от гражданина 71 по вопросу категории 2. Просьба принять меры.', 2, 2, 7, CAST(N'2025-07-25T19:30:13.347' AS DateTime), CAST(N'2025-08-07T08:30:13.347' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (185, 71, N'Обращение №3 от гражданина 71', N'Текст обращения от гражданина 71 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2026-01-12T19:30:13.347' AS DateTime), CAST(N'2026-02-01T07:30:13.347' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (186, 72, N'Обращение №1 от гражданина 72', N'Текст обращения от гражданина 72 по вопросу категории 2. Просьба принять меры.', 2, 2, 5, CAST(N'2025-07-18T19:30:13.347' AS DateTime), CAST(N'2025-08-04T18:30:13.347' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (187, 72, N'Обращение №2 от гражданина 72', N'Текст обращения от гражданина 72 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2026-05-02T19:30:13.347' AS DateTime), CAST(N'2026-05-08T15:30:13.347' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (188, 73, N'Обращение №1 от гражданина 73', N'Текст обращения от гражданина 73 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2026-02-01T19:30:13.347' AS DateTime), CAST(N'2026-02-20T09:30:13.347' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (189, 73, N'Обращение №2 от гражданина 73', N'Текст обращения от гражданина 73 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2026-02-10T19:30:13.347' AS DateTime), CAST(N'2026-02-21T19:30:13.347' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (190, 73, N'Обращение №3 от гражданина 73', N'Текст обращения от гражданина 73 по вопросу категории 5. Просьба принять меры.', 5, 2, 7, CAST(N'2025-09-18T19:30:13.350' AS DateTime), CAST(N'2025-09-27T02:30:13.350' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (191, 74, N'Обращение №1 от гражданина 74', N'Текст обращения от гражданина 74 по вопросу категории 5. Просьба принять меры.', 5, 2, 8, CAST(N'2026-03-28T19:30:13.350' AS DateTime), CAST(N'2026-04-19T12:30:13.350' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (192, 74, N'Обращение №2 от гражданина 74', N'Текст обращения от гражданина 74 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2026-01-12T19:30:13.350' AS DateTime), CAST(N'2026-01-16T11:30:13.350' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (193, 74, N'Обращение №3 от гражданина 74', N'Текст обращения от гражданина 74 по вопросу категории 5. Просьба принять меры.', 5, 2, 5, CAST(N'2025-06-14T19:30:13.350' AS DateTime), CAST(N'2025-07-13T05:30:13.350' AS DateTime), CAST(N'2025-06-24' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (194, 75, N'Обращение №1 от гражданина 75', N'Текст обращения от гражданина 75 по вопросу категории 2. Просьба принять меры.', 2, 2, 7, CAST(N'2025-12-03T19:30:13.350' AS DateTime), CAST(N'2025-12-19T11:30:13.350' AS DateTime), CAST(N'2025-12-13' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (195, 75, N'Обращение №2 от гражданина 75', N'Текст обращения от гражданина 75 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-10-23T19:30:13.350' AS DateTime), CAST(N'2025-10-26T18:30:13.350' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (196, 75, N'Обращение №3 от гражданина 75', N'Текст обращения от гражданина 75 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2026-04-21T19:30:13.350' AS DateTime), CAST(N'2026-05-13T22:30:13.350' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (197, 75, N'Обращение №4 от гражданина 75', N'Текст обращения от гражданина 75 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-08-24T19:30:13.350' AS DateTime), CAST(N'2025-09-16T20:30:13.350' AS DateTime), CAST(N'2025-09-03' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (198, 76, N'Обращение №1 от гражданина 76', N'Текст обращения от гражданина 76 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2026-05-06T19:30:13.353' AS DateTime), CAST(N'2026-06-04T00:30:13.353' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (199, 76, N'Обращение №2 от гражданина 76', N'Текст обращения от гражданина 76 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2026-01-04T19:30:13.353' AS DateTime), CAST(N'2026-01-26T16:30:13.353' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (200, 76, N'Обращение №3 от гражданина 76', N'Текст обращения от гражданина 76 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-07-08T19:30:13.353' AS DateTime), CAST(N'2025-08-02T11:30:13.353' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (201, 77, N'Обращение №1 от гражданина 77', N'Текст обращения от гражданина 77 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-10-28T19:30:13.353' AS DateTime), CAST(N'2025-11-23T05:30:13.353' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (202, 77, N'Обращение №2 от гражданина 77', N'Текст обращения от гражданина 77 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-12-12T19:30:13.353' AS DateTime), CAST(N'2025-12-25T07:30:13.353' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (203, 78, N'Обращение №1 от гражданина 78', N'Текст обращения от гражданина 78 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-09-03T19:30:13.353' AS DateTime), CAST(N'2025-09-09T23:30:13.353' AS DateTime), CAST(N'2025-09-13' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (204, 78, N'Обращение №2 от гражданина 78', N'Текст обращения от гражданина 78 по вопросу категории 2. Просьба принять меры.', 2, 2, 7, CAST(N'2026-05-11T19:30:13.353' AS DateTime), CAST(N'2026-05-18T11:30:13.353' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (205, 78, N'Обращение №3 от гражданина 78', N'Текст обращения от гражданина 78 по вопросу категории 4. Просьба принять меры.', 4, 2, 5, CAST(N'2026-04-09T19:30:13.357' AS DateTime), CAST(N'2026-05-03T11:30:13.357' AS DateTime), CAST(N'2026-04-19' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (206, 78, N'Обращение №4 от гражданина 78', N'Текст обращения от гражданина 78 по вопросу категории 2. Просьба принять меры.', 2, 2, 6, CAST(N'2026-03-08T19:30:13.357' AS DateTime), CAST(N'2026-03-18T00:30:13.357' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (207, 79, N'Обращение №1 от гражданина 79', N'Текст обращения от гражданина 79 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-10-22T19:30:13.357' AS DateTime), CAST(N'2025-11-14T06:30:13.357' AS DateTime), CAST(N'2025-11-01' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (208, 79, N'Обращение №2 от гражданина 79', N'Текст обращения от гражданина 79 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-11-27T19:30:13.357' AS DateTime), CAST(N'2025-12-07T17:30:13.357' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (209, 80, N'Обращение №1 от гражданина 80', N'Текст обращения от гражданина 80 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2026-01-30T19:30:13.357' AS DateTime), CAST(N'2026-02-09T17:30:13.357' AS DateTime), CAST(N'2026-02-09' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (210, 80, N'Обращение №2 от гражданина 80', N'Текст обращения от гражданина 80 по вопросу категории 4. Просьба принять меры.', 4, 2, 5, CAST(N'2025-09-19T19:30:13.357' AS DateTime), CAST(N'2025-10-03T11:30:13.357' AS DateTime), CAST(N'2025-09-29' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (211, 81, N'Обращение №1 от гражданина 81', N'Текст обращения от гражданина 81 по вопросу категории 1. Просьба принять меры.', 1, 2, 8, CAST(N'2025-08-01T19:30:13.360' AS DateTime), CAST(N'2025-08-03T08:30:13.360' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (212, 81, N'Обращение №2 от гражданина 81', N'Текст обращения от гражданина 81 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-09-10T19:30:13.360' AS DateTime), CAST(N'2025-09-11T08:30:13.360' AS DateTime), CAST(N'2025-09-20' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (213, 81, N'Обращение №3 от гражданина 81', N'Текст обращения от гражданина 81 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2026-04-16T19:30:13.360' AS DateTime), CAST(N'2026-04-26T11:30:13.360' AS DateTime), CAST(N'2026-04-26' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (214, 81, N'Обращение №4 от гражданина 81', N'Текст обращения от гражданина 81 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-12-07T19:30:13.360' AS DateTime), CAST(N'2025-12-09T22:30:13.360' AS DateTime), CAST(N'2025-12-17' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (215, 82, N'Обращение №1 от гражданина 82', N'Текст обращения от гражданина 82 по вопросу категории 2. Просьба принять меры.', 2, 2, 8, CAST(N'2025-08-09T19:30:13.360' AS DateTime), CAST(N'2025-09-06T11:30:13.360' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (216, 82, N'Обращение №2 от гражданина 82', N'Текст обращения от гражданина 82 по вопросу категории 3. Просьба принять меры.', 3, 2, 6, CAST(N'2025-05-28T19:30:13.360' AS DateTime), CAST(N'2025-06-07T07:30:13.360' AS DateTime), CAST(N'2025-06-07' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (217, 82, N'Обращение №3 от гражданина 82', N'Текст обращения от гражданина 82 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-12-13T19:30:13.363' AS DateTime), CAST(N'2025-12-17T11:30:13.363' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (218, 82, N'Обращение №4 от гражданина 82', N'Текст обращения от гражданина 82 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-07-07T19:30:13.363' AS DateTime), CAST(N'2025-07-22T23:30:13.363' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (219, 83, N'Обращение №1 от гражданина 83', N'Текст обращения от гражданина 83 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-07-08T19:30:13.363' AS DateTime), CAST(N'2025-08-04T08:30:13.363' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (220, 83, N'Обращение №2 от гражданина 83', N'Текст обращения от гражданина 83 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-10-26T19:30:13.363' AS DateTime), CAST(N'2025-11-13T21:30:13.363' AS DateTime), CAST(N'2025-11-05' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (221, 84, N'Обращение №1 от гражданина 84', N'Текст обращения от гражданина 84 по вопросу категории 4. Просьба принять меры.', 4, 2, 8, CAST(N'2025-06-11T19:30:13.363' AS DateTime), CAST(N'2025-06-12T06:30:13.363' AS DateTime), CAST(N'2025-06-21' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (222, 84, N'Обращение №2 от гражданина 84', N'Текст обращения от гражданина 84 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-08-04T19:30:13.363' AS DateTime), CAST(N'2025-09-03T07:30:13.363' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (223, 84, N'Обращение №3 от гражданина 84', N'Текст обращения от гражданина 84 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-06-10T19:30:13.367' AS DateTime), CAST(N'2025-06-15T10:30:13.367' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (224, 85, N'Обращение №1 от гражданина 85', N'Текст обращения от гражданина 85 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-11-29T19:30:13.367' AS DateTime), CAST(N'2025-12-03T18:30:13.367' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (225, 85, N'Обращение №2 от гражданина 85', N'Текст обращения от гражданина 85 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-06-18T19:30:13.367' AS DateTime), CAST(N'2025-06-19T07:30:13.367' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (226, 86, N'Обращение №1 от гражданина 86', N'Текст обращения от гражданина 86 по вопросу категории 4. Просьба принять меры.', 4, 2, 7, CAST(N'2026-04-06T19:30:13.367' AS DateTime), CAST(N'2026-04-13T12:30:13.367' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (227, 86, N'Обращение №2 от гражданина 86', N'Текст обращения от гражданина 86 по вопросу категории 5. Просьба принять меры.', 5, 2, 6, CAST(N'2026-02-12T19:30:13.367' AS DateTime), CAST(N'2026-02-19T11:30:13.367' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (228, 86, N'Обращение №3 от гражданина 86', N'Текст обращения от гражданина 86 по вопросу категории 5. Просьба принять меры.', 5, 2, 8, CAST(N'2026-02-24T19:30:13.367' AS DateTime), CAST(N'2026-02-25T20:30:13.367' AS DateTime), CAST(N'2026-03-06' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (229, 86, N'Обращение №4 от гражданина 86', N'Текст обращения от гражданина 86 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2026-05-17T19:30:13.370' AS DateTime), CAST(N'2026-06-02T02:30:13.370' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (230, 87, N'Обращение №1 от гражданина 87', N'Текст обращения от гражданина 87 по вопросу категории 4. Просьба принять меры.', 4, 2, 5, CAST(N'2025-06-14T19:30:13.370' AS DateTime), CAST(N'2025-06-25T15:30:13.370' AS DateTime), CAST(N'2025-06-24' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (231, 87, N'Обращение №2 от гражданина 87', N'Текст обращения от гражданина 87 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-09-25T19:30:13.370' AS DateTime), CAST(N'2025-10-20T21:30:13.370' AS DateTime), CAST(N'2025-10-05' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (232, 88, N'Обращение №1 от гражданина 88', N'Текст обращения от гражданина 88 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-09-03T19:30:13.370' AS DateTime), CAST(N'2025-09-05T11:30:13.370' AS DateTime), CAST(N'2025-09-13' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (233, 88, N'Обращение №2 от гражданина 88', N'Текст обращения от гражданина 88 по вопросу категории 1. Просьба принять меры.', 1, 2, 7, CAST(N'2025-11-16T19:30:13.370' AS DateTime), CAST(N'2025-12-05T23:30:13.370' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (234, 88, N'Обращение №3 от гражданина 88', N'Текст обращения от гражданина 88 по вопросу категории 5. Просьба принять меры.', 5, 2, 6, CAST(N'2025-06-29T19:30:13.370' AS DateTime), CAST(N'2025-07-03T01:30:13.370' AS DateTime), CAST(N'2025-07-09' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (235, 89, N'Обращение №1 от гражданина 89', N'Текст обращения от гражданина 89 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2026-05-05T19:30:13.370' AS DateTime), CAST(N'2026-05-19T14:30:13.370' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (236, 89, N'Обращение №2 от гражданина 89', N'Текст обращения от гражданина 89 по вопросу категории 3. Просьба принять меры.', 3, 2, 7, CAST(N'2026-04-16T19:30:13.370' AS DateTime), CAST(N'2026-04-27T19:30:13.370' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (237, 89, N'Обращение №3 от гражданина 89', N'Текст обращения от гражданина 89 по вопросу категории 3. Просьба принять меры.', 3, 2, 6, CAST(N'2025-12-30T19:30:13.373' AS DateTime), CAST(N'2026-01-25T22:30:13.373' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (238, 89, N'Обращение №4 от гражданина 89', N'Текст обращения от гражданина 89 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-10-14T19:30:13.373' AS DateTime), CAST(N'2025-11-13T17:30:13.373' AS DateTime), CAST(N'2025-10-24' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (239, 90, N'Обращение №1 от гражданина 90', N'Текст обращения от гражданина 90 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-09-29T19:30:13.373' AS DateTime), CAST(N'2025-10-06T05:30:13.373' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (240, 90, N'Обращение №2 от гражданина 90', N'Текст обращения от гражданина 90 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-07-21T19:30:13.373' AS DateTime), CAST(N'2025-08-01T11:30:13.373' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (241, 90, N'Обращение №3 от гражданина 90', N'Текст обращения от гражданина 90 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-12-18T19:30:13.373' AS DateTime), CAST(N'2025-12-19T22:30:13.373' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (242, 90, N'Обращение №4 от гражданина 90', N'Текст обращения от гражданина 90 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-10-23T19:30:13.373' AS DateTime), CAST(N'2025-11-17T01:30:13.373' AS DateTime), CAST(N'2025-11-02' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (243, 91, N'Обращение №1 от гражданина 91', N'Текст обращения от гражданина 91 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-06-12T19:30:13.377' AS DateTime), CAST(N'2025-06-19T10:30:13.377' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (244, 91, N'Обращение №2 от гражданина 91', N'Текст обращения от гражданина 91 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-05-26T19:30:13.377' AS DateTime), CAST(N'2025-06-08T09:30:13.377' AS DateTime), CAST(N'2025-06-05' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (245, 91, N'Обращение №3 от гражданина 91', N'Текст обращения от гражданина 91 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-08-05T19:30:13.377' AS DateTime), CAST(N'2025-08-18T09:30:13.377' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (246, 91, N'Обращение №4 от гражданина 91', N'Текст обращения от гражданина 91 по вопросу категории 3. Просьба принять меры.', 3, 2, 6, CAST(N'2025-09-01T19:30:13.377' AS DateTime), CAST(N'2025-09-24T23:30:13.377' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (247, 92, N'Обращение №1 от гражданина 92', N'Текст обращения от гражданина 92 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-08-05T19:30:13.377' AS DateTime), CAST(N'2025-09-03T09:30:13.377' AS DateTime), CAST(N'2025-08-15' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (248, 92, N'Обращение №2 от гражданина 92', N'Текст обращения от гражданина 92 по вопросу категории 5. Просьба принять меры.', 5, 2, 5, CAST(N'2025-07-05T19:30:13.380' AS DateTime), CAST(N'2025-07-24T07:30:13.380' AS DateTime), CAST(N'2025-07-15' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (249, 93, N'Обращение №1 от гражданина 93', N'Текст обращения от гражданина 93 по вопросу категории 5. Просьба принять меры.', 5, 2, 5, CAST(N'2025-08-23T19:30:13.380' AS DateTime), CAST(N'2025-09-09T21:30:13.380' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (250, 93, N'Обращение №2 от гражданина 93', N'Текст обращения от гражданина 93 по вопросу категории 1. Просьба принять меры.', 1, 2, 7, CAST(N'2025-06-29T19:30:13.380' AS DateTime), CAST(N'2025-07-10T21:30:13.380' AS DateTime), CAST(N'2025-07-09' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (251, 93, N'Обращение №3 от гражданина 93', N'Текст обращения от гражданина 93 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-06-03T19:30:13.380' AS DateTime), CAST(N'2025-06-12T19:30:13.380' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (252, 93, N'Обращение №4 от гражданина 93', N'Текст обращения от гражданина 93 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-10-29T19:30:13.380' AS DateTime), CAST(N'2025-11-02T06:30:13.380' AS DateTime), CAST(N'2025-11-08' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (253, 94, N'Обращение №1 от гражданина 94', N'Текст обращения от гражданина 94 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2026-01-16T19:30:13.380' AS DateTime), CAST(N'2026-02-09T02:30:13.380' AS DateTime), CAST(N'2026-01-26' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (254, 94, N'Обращение №2 от гражданина 94', N'Текст обращения от гражданина 94 по вопросу категории 2. Просьба принять меры.', 2, 2, 5, CAST(N'2025-10-28T19:30:13.380' AS DateTime), CAST(N'2025-11-25T23:30:13.380' AS DateTime), CAST(N'2025-11-07' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (255, 95, N'Обращение №1 от гражданина 95', N'Текст обращения от гражданина 95 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2026-01-07T19:30:13.383' AS DateTime), CAST(N'2026-01-21T01:30:13.383' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (256, 95, N'Обращение №2 от гражданина 95', N'Текст обращения от гражданина 95 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-10-11T19:30:13.383' AS DateTime), CAST(N'2025-10-13T10:30:13.383' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (257, 96, N'Обращение №1 от гражданина 96', N'Текст обращения от гражданина 96 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2026-03-26T19:30:13.383' AS DateTime), CAST(N'2026-04-12T17:30:13.383' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (258, 96, N'Обращение №2 от гражданина 96', N'Текст обращения от гражданина 96 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-11-18T19:30:13.383' AS DateTime), CAST(N'2025-11-27T18:30:13.383' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (259, 97, N'Обращение №1 от гражданина 97', N'Текст обращения от гражданина 97 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-07-06T19:30:13.383' AS DateTime), CAST(N'2025-07-11T04:30:13.383' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (260, 97, N'Обращение №2 от гражданина 97', N'Текст обращения от гражданина 97 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2026-01-31T19:30:13.383' AS DateTime), CAST(N'2026-02-06T17:30:13.383' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (261, 97, N'Обращение №3 от гражданина 97', N'Текст обращения от гражданина 97 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-10-24T19:30:13.387' AS DateTime), CAST(N'2025-11-07T16:30:13.387' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (262, 97, N'Обращение №4 от гражданина 97', N'Текст обращения от гражданина 97 по вопросу категории 5. Просьба принять меры.', 5, 5, NULL, CAST(N'2025-11-05T19:30:13.387' AS DateTime), CAST(N'2026-05-21T21:45:25.210' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (263, 98, N'Обращение №1 от гражданина 98', N'Текст обращения от гражданина 98 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-11-30T19:30:13.387' AS DateTime), CAST(N'2025-12-02T05:30:13.387' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (264, 98, N'Обращение №2 от гражданина 98', N'Текст обращения от гражданина 98 по вопросу категории 5. Просьба принять меры.', 5, 2, 7, CAST(N'2025-07-25T19:30:13.387' AS DateTime), CAST(N'2025-08-21T08:30:13.387' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (265, 98, N'Обращение №3 от гражданина 98', N'Текст обращения от гражданина 98 по вопросу категории 5. Просьба принять меры.', 5, 2, 6, CAST(N'2026-04-22T19:30:13.387' AS DateTime), CAST(N'2026-05-01T00:30:13.387' AS DateTime), CAST(N'2026-05-02' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (266, 99, N'Обращение №1 от гражданина 99', N'Текст обращения от гражданина 99 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-05-23T19:30:13.387' AS DateTime), CAST(N'2025-05-27T23:30:13.387' AS DateTime), CAST(N'2025-06-02' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (267, 99, N'Обращение №2 от гражданина 99', N'Текст обращения от гражданина 99 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-07-11T19:30:13.390' AS DateTime), CAST(N'2025-08-05T09:30:13.390' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (268, 99, N'Обращение №3 от гражданина 99', N'Текст обращения от гражданина 99 по вопросу категории 2. Просьба принять меры.', 2, 2, 6, CAST(N'2025-10-25T19:30:13.390' AS DateTime), CAST(N'2025-11-21T01:30:13.390' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (269, 100, N'Обращение №1 от гражданина 100', N'Текст обращения от гражданина 100 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2026-01-17T19:30:13.390' AS DateTime), CAST(N'2026-01-19T01:30:13.390' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (270, 100, N'Обращение №2 от гражданина 100', N'Текст обращения от гражданина 100 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2026-03-09T19:30:13.390' AS DateTime), CAST(N'2026-03-17T00:30:13.390' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (271, 101, N'Обращение №1 от гражданина 101', N'Текст обращения от гражданина 101 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-12-13T19:30:13.390' AS DateTime), CAST(N'2025-12-23T22:30:13.390' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (272, 101, N'Обращение №2 от гражданина 101', N'Текст обращения от гражданина 101 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2026-01-19T19:30:13.390' AS DateTime), CAST(N'2026-02-13T15:30:13.390' AS DateTime), CAST(N'2026-01-29' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (273, 102, N'Обращение №1 от гражданина 102', N'Текст обращения от гражданина 102 по вопросу категории 1. Просьба принять меры.', 1, 2, 6, CAST(N'2025-12-27T19:30:13.390' AS DateTime), CAST(N'2026-01-23T23:30:13.390' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (274, 102, N'Обращение №2 от гражданина 102', N'Текст обращения от гражданина 102 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2026-04-08T19:30:13.390' AS DateTime), CAST(N'2026-04-12T19:30:13.390' AS DateTime), CAST(N'2026-04-18' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (275, 103, N'Обращение №1 от гражданина 103', N'Текст обращения от гражданина 103 по вопросу категории 5. Просьба принять меры.', 5, 2, 7, CAST(N'2026-01-09T19:30:13.393' AS DateTime), CAST(N'2026-01-16T08:30:13.393' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (276, 103, N'Обращение №2 от гражданина 103', N'Текст обращения от гражданина 103 по вопросу категории 2. Просьба принять меры.', 2, 2, 5, CAST(N'2026-01-02T19:30:13.393' AS DateTime), CAST(N'2026-01-10T18:30:13.393' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (277, 103, N'Обращение №3 от гражданина 103', N'Текст обращения от гражданина 103 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2026-01-24T19:30:13.393' AS DateTime), CAST(N'2026-02-05T21:30:13.393' AS DateTime), CAST(N'2026-02-03' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (278, 103, N'Обращение №4 от гражданина 103', N'Текст обращения от гражданина 103 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2026-02-17T19:30:13.393' AS DateTime), CAST(N'2026-03-12T20:30:13.393' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (279, 104, N'Обращение №1 от гражданина 104', N'Текст обращения от гражданина 104 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2026-04-26T19:30:13.393' AS DateTime), CAST(N'2026-05-23T01:30:13.393' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (280, 104, N'Обращение №2 от гражданина 104', N'Текст обращения от гражданина 104 по вопросу категории 2. Просьба принять меры.', 2, 2, 5, CAST(N'2025-09-06T19:30:13.393' AS DateTime), CAST(N'2025-09-26T10:30:13.393' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (281, 105, N'Обращение №1 от гражданина 105', N'Текст обращения от гражданина 105 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-11-17T19:30:13.397' AS DateTime), CAST(N'2025-11-26T02:30:13.397' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (282, 105, N'Обращение №2 от гражданина 105', N'Текст обращения от гражданина 105 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-10-09T19:30:13.397' AS DateTime), CAST(N'2025-11-02T20:30:13.397' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (283, 105, N'Обращение №3 от гражданина 105', N'Текст обращения от гражданина 105 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-11-26T19:30:13.397' AS DateTime), CAST(N'2025-12-07T12:30:13.397' AS DateTime), CAST(N'2025-12-06' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (284, 105, N'Обращение №4 от гражданина 105', N'Текст обращения от гражданина 105 по вопросу категории 3. Просьба принять меры.', 3, 2, 4, CAST(N'2025-12-29T19:30:13.397' AS DateTime), CAST(N'2026-01-01T20:30:13.397' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (285, 106, N'Обращение №1 от гражданина 106', N'Текст обращения от гражданина 106 по вопросу категории 3. Просьба принять меры.', 3, 2, 7, CAST(N'2025-07-20T19:30:13.400' AS DateTime), CAST(N'2025-08-10T23:30:13.400' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (286, 106, N'Обращение №2 от гражданина 106', N'Текст обращения от гражданина 106 по вопросу категории 1. Просьба принять меры.', 1, 2, 8, CAST(N'2026-05-17T19:30:13.400' AS DateTime), CAST(N'2026-05-19T09:30:13.400' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (287, 107, N'Обращение №1 от гражданина 107', N'Текст обращения от гражданина 107 по вопросу категории 3. Просьба принять меры.', 3, 2, 8, CAST(N'2026-04-08T19:30:13.400' AS DateTime), CAST(N'2026-04-25T04:30:13.400' AS DateTime), CAST(N'2026-04-18' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (288, 107, N'Обращение №2 от гражданина 107', N'Текст обращения от гражданина 107 по вопросу категории 1. Просьба принять меры.', 1, 2, 6, CAST(N'2025-07-16T19:30:13.400' AS DateTime), CAST(N'2025-08-04T09:30:13.400' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (289, 108, N'Обращение №1 от гражданина 108', N'Текст обращения от гражданина 108 по вопросу категории 2. Просьба принять меры.', 2, 2, 4, CAST(N'2026-03-12T19:30:13.400' AS DateTime), CAST(N'2026-03-20T18:30:13.400' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (290, 108, N'Обращение №2 от гражданина 108', N'Текст обращения от гражданина 108 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2026-04-21T19:30:13.400' AS DateTime), CAST(N'2026-05-08T22:30:13.400' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (291, 108, N'Обращение №3 от гражданина 108', N'Текст обращения от гражданина 108 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-10-17T19:30:13.400' AS DateTime), CAST(N'2025-10-20T11:30:13.400' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (292, 108, N'Обращение №4 от гражданина 108', N'Текст обращения от гражданина 108 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-07-14T19:30:13.400' AS DateTime), CAST(N'2025-07-22T03:30:13.400' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (293, 109, N'Обращение №1 от гражданина 109', N'Текст обращения от гражданина 109 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-10-03T19:30:13.403' AS DateTime), CAST(N'2025-10-11T06:30:13.403' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (294, 109, N'Обращение №2 от гражданина 109', N'Текст обращения от гражданина 109 по вопросу категории 3. Просьба принять меры.', 3, 2, 6, CAST(N'2025-05-26T19:30:13.403' AS DateTime), CAST(N'2025-06-11T17:30:13.403' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (295, 109, N'Обращение №3 от гражданина 109', N'Текст обращения от гражданина 109 по вопросу категории 4. Просьба принять меры.', 4, 2, 4, CAST(N'2025-10-17T19:30:13.403' AS DateTime), CAST(N'2025-11-01T17:30:13.403' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (296, 110, N'Обращение №1 от гражданина 110', N'Текст обращения от гражданина 110 по вопросу категории 4. Просьба принять меры.', 4, 2, 5, CAST(N'2026-01-27T19:30:13.403' AS DateTime), CAST(N'2026-02-23T10:30:13.403' AS DateTime), CAST(N'2026-02-06' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (297, 110, N'Обращение №2 от гражданина 110', N'Текст обращения от гражданина 110 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2026-02-11T19:30:13.403' AS DateTime), CAST(N'2026-03-01T21:30:13.403' AS DateTime), CAST(N'2026-02-21' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (298, 110, N'Обращение №3 от гражданина 110', N'Текст обращения от гражданина 110 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2026-03-07T19:30:13.407' AS DateTime), CAST(N'2026-03-30T13:30:13.407' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (299, 111, N'Обращение №1 от гражданина 111', N'Текст обращения от гражданина 111 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2026-01-08T19:30:13.407' AS DateTime), CAST(N'2026-01-21T20:30:13.407' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (300, 111, N'Обращение №2 от гражданина 111', N'Текст обращения от гражданина 111 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2026-04-12T19:30:13.407' AS DateTime), CAST(N'2026-04-22T11:30:13.407' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (301, 112, N'Обращение №1 от гражданина 112', N'Текст обращения от гражданина 112 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-11-29T19:30:13.407' AS DateTime), CAST(N'2025-12-07T04:30:13.407' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (302, 112, N'Обращение №2 от гражданина 112', N'Текст обращения от гражданина 112 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-06-21T19:30:13.407' AS DateTime), CAST(N'2025-06-25T07:30:13.407' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (303, 112, N'Обращение №3 от гражданина 112', N'Текст обращения от гражданина 112 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-05-24T19:30:13.407' AS DateTime), CAST(N'2025-06-14T05:30:13.407' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (304, 113, N'Обращение №1 от гражданина 113', N'Текст обращения от гражданина 113 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2026-05-17T19:30:13.410' AS DateTime), CAST(N'2026-05-22T12:30:13.410' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (305, 113, N'Обращение №2 от гражданина 113', N'Текст обращения от гражданина 113 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-07-01T19:30:13.410' AS DateTime), CAST(N'2025-07-13T08:30:13.410' AS DateTime), CAST(N'2025-07-11' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (306, 113, N'Обращение №3 от гражданина 113', N'Текст обращения от гражданина 113 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2026-05-12T19:30:13.410' AS DateTime), CAST(N'2026-05-21T13:30:13.410' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (307, 114, N'Обращение №1 от гражданина 114', N'Текст обращения от гражданина 114 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-06-23T19:30:13.410' AS DateTime), CAST(N'2025-06-25T15:30:13.410' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (308, 114, N'Обращение №2 от гражданина 114', N'Текст обращения от гражданина 114 по вопросу категории 3. Просьба принять меры.', 3, 2, 6, CAST(N'2026-04-18T19:30:13.410' AS DateTime), CAST(N'2026-04-29T05:30:13.410' AS DateTime), CAST(N'2026-04-28' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (309, 115, N'Обращение №1 от гражданина 115', N'Текст обращения от гражданина 115 по вопросу категории 1. Просьба принять меры.', 1, 2, 5, CAST(N'2025-07-13T19:30:13.410' AS DateTime), CAST(N'2025-07-26T02:30:13.410' AS DateTime), CAST(N'2025-07-23' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (310, 115, N'Обращение №2 от гражданина 115', N'Текст обращения от гражданина 115 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2026-01-05T19:30:13.410' AS DateTime), CAST(N'2026-01-26T23:30:13.410' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (311, 115, N'Обращение №3 от гражданина 115', N'Текст обращения от гражданина 115 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-07-28T19:30:13.410' AS DateTime), CAST(N'2025-08-17T05:30:13.410' AS DateTime), CAST(N'2025-08-07' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (312, 116, N'Обращение №1 от гражданина 116', N'Текст обращения от гражданина 116 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-10-13T19:30:13.413' AS DateTime), CAST(N'2025-10-26T15:30:13.413' AS DateTime), CAST(N'2025-10-23' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (313, 116, N'Обращение №2 от гражданина 116', N'Текст обращения от гражданина 116 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2026-02-22T19:30:13.413' AS DateTime), CAST(N'2026-03-03T20:30:13.413' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (314, 116, N'Обращение №3 от гражданина 116', N'Текст обращения от гражданина 116 по вопросу категории 1. Просьба принять меры.', 1, 2, 8, CAST(N'2025-07-28T19:30:13.413' AS DateTime), CAST(N'2025-08-25T00:30:13.413' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (315, 116, N'Обращение №4 от гражданина 116', N'Текст обращения от гражданина 116 по вопросу категории 1. Просьба принять меры.', 1, 2, 8, CAST(N'2025-10-12T19:30:13.413' AS DateTime), CAST(N'2025-10-19T07:30:13.413' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (316, 117, N'Обращение №1 от гражданина 117', N'Текст обращения от гражданина 117 по вопросу категории 2. Просьба принять меры.', 2, 2, 4, CAST(N'2026-01-19T19:30:13.413' AS DateTime), CAST(N'2026-01-23T14:30:13.413' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (317, 117, N'Обращение №2 от гражданина 117', N'Текст обращения от гражданина 117 по вопросу категории 2. Просьба принять меры.', 2, 2, 7, CAST(N'2025-08-13T19:30:13.413' AS DateTime), CAST(N'2025-08-14T06:30:13.413' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (318, 117, N'Обращение №3 от гражданина 117', N'Текст обращения от гражданина 117 по вопросу категории 2. Просьба принять меры.', 2, 2, 6, CAST(N'2026-02-01T19:30:13.417' AS DateTime), CAST(N'2026-02-26T23:30:13.417' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (319, 117, N'Обращение №4 от гражданина 117', N'Текст обращения от гражданина 117 по вопросу категории 5. Просьба принять меры.', 5, 2, 8, CAST(N'2026-03-28T19:30:13.417' AS DateTime), CAST(N'2026-04-11T15:30:13.417' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (320, 118, N'Обращение №1 от гражданина 118', N'Текст обращения от гражданина 118 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2026-05-10T19:30:13.417' AS DateTime), CAST(N'2026-06-04T15:30:13.417' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (321, 118, N'Обращение №2 от гражданина 118', N'Текст обращения от гражданина 118 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-06-14T19:30:13.417' AS DateTime), CAST(N'2025-07-09T20:30:13.417' AS DateTime), CAST(N'2025-06-24' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (322, 118, N'Обращение №3 от гражданина 118', N'Текст обращения от гражданина 118 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2026-04-24T19:30:13.417' AS DateTime), CAST(N'2026-05-17T22:30:13.417' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (323, 118, N'Обращение №4 от гражданина 118', N'Текст обращения от гражданина 118 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-09-01T19:30:13.417' AS DateTime), CAST(N'2025-09-16T03:30:13.417' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (324, 119, N'Обращение №1 от гражданина 119', N'Текст обращения от гражданина 119 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2026-03-18T19:30:13.420' AS DateTime), CAST(N'2026-04-03T17:30:13.420' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (325, 119, N'Обращение №2 от гражданина 119', N'Текст обращения от гражданина 119 по вопросу категории 1. Просьба принять меры.', 1, 2, 8, CAST(N'2025-11-22T19:30:13.420' AS DateTime), CAST(N'2025-12-05T09:30:13.420' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (326, 120, N'Обращение №1 от гражданина 120', N'Текст обращения от гражданина 120 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-10-25T19:30:13.420' AS DateTime), CAST(N'2025-11-05T22:30:13.420' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (327, 120, N'Обращение №2 от гражданина 120', N'Текст обращения от гражданина 120 по вопросу категории 4. Просьба принять меры.', 4, 2, 7, CAST(N'2026-05-14T19:30:13.420' AS DateTime), CAST(N'2026-06-10T22:30:13.420' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (328, 121, N'Обращение №1 от гражданина 121', N'Текст обращения от гражданина 121 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-05-27T19:30:13.420' AS DateTime), CAST(N'2025-05-31T01:30:13.420' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (329, 121, N'Обращение №2 от гражданина 121', N'Текст обращения от гражданина 121 по вопросу категории 4. Просьба принять меры.', 4, 2, 6, CAST(N'2025-11-17T19:30:13.420' AS DateTime), CAST(N'2025-11-19T12:30:13.420' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (330, 122, N'Обращение №1 от гражданина 122', N'Текст обращения от гражданина 122 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-05-28T19:30:13.420' AS DateTime), CAST(N'2025-06-04T11:30:13.420' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (331, 122, N'Обращение №2 от гражданина 122', N'Текст обращения от гражданина 122 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-08-04T19:30:13.420' AS DateTime), CAST(N'2025-08-17T20:30:13.420' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (332, 122, N'Обращение №3 от гражданина 122', N'Текст обращения от гражданина 122 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2026-02-12T19:30:13.423' AS DateTime), CAST(N'2026-03-06T23:30:13.423' AS DateTime), CAST(N'2026-02-22' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (333, 123, N'Обращение №1 от гражданина 123', N'Текст обращения от гражданина 123 по вопросу категории 5. Просьба принять меры.', 5, 2, 5, CAST(N'2026-04-08T19:30:13.423' AS DateTime), CAST(N'2026-04-17T15:30:13.423' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (334, 123, N'Обращение №2 от гражданина 123', N'Текст обращения от гражданина 123 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2026-03-07T19:30:13.423' AS DateTime), CAST(N'2026-03-29T16:30:13.423' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (335, 123, N'Обращение №3 от гражданина 123', N'Текст обращения от гражданина 123 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2026-02-21T19:30:13.423' AS DateTime), CAST(N'2026-03-23T18:30:13.423' AS DateTime), CAST(N'2026-03-03' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (336, 123, N'Обращение №4 от гражданина 123', N'Текст обращения от гражданина 123 по вопросу категории 1. Просьба принять меры.', 1, 2, 5, CAST(N'2025-11-06T19:30:13.423' AS DateTime), CAST(N'2025-11-26T16:30:13.423' AS DateTime), CAST(N'2025-11-16' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (337, 124, N'Обращение №1 от гражданина 124', N'Текст обращения от гражданина 124 по вопросу категории 5. Просьба принять меры.', 5, 2, 8, CAST(N'2026-01-13T19:30:13.427' AS DateTime), CAST(N'2026-01-16T17:30:13.427' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (338, 124, N'Обращение №2 от гражданина 124', N'Текст обращения от гражданина 124 по вопросу категории 5. Просьба принять меры.', 5, 2, 4, CAST(N'2025-09-02T19:30:13.427' AS DateTime), CAST(N'2025-09-14T20:30:13.427' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (339, 124, N'Обращение №3 от гражданина 124', N'Текст обращения от гражданина 124 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2026-03-08T19:30:13.427' AS DateTime), CAST(N'2026-03-31T09:30:13.427' AS DateTime), CAST(N'2026-03-18' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (340, 125, N'Обращение №1 от гражданина 125', N'Текст обращения от гражданина 125 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-11-04T19:30:13.427' AS DateTime), CAST(N'2025-11-24T12:30:13.427' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (341, 125, N'Обращение №2 от гражданина 125', N'Текст обращения от гражданина 125 по вопросу категории 5. Просьба принять меры.', 5, 2, 7, CAST(N'2026-04-05T19:30:13.427' AS DateTime), CAST(N'2026-04-19T12:30:13.427' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (342, 125, N'Обращение №3 от гражданина 125', N'Текст обращения от гражданина 125 по вопросу категории 3. Просьба принять меры.', 3, 2, 5, CAST(N'2026-05-11T19:30:13.430' AS DateTime), CAST(N'2026-06-06T06:30:13.430' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (343, 126, N'Обращение №1 от гражданина 126', N'Текст обращения от гражданина 126 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-06-17T19:30:13.430' AS DateTime), CAST(N'2025-07-09T23:30:13.430' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (344, 126, N'Обращение №2 от гражданина 126', N'Текст обращения от гражданина 126 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-07-27T19:30:13.430' AS DateTime), CAST(N'2025-08-23T00:30:13.430' AS DateTime), CAST(N'2025-08-06' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (345, 127, N'Обращение №1 от гражданина 127', N'Текст обращения от гражданина 127 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-11-09T19:30:13.430' AS DateTime), CAST(N'2025-11-20T12:30:13.430' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (346, 127, N'Обращение №2 от гражданина 127', N'Текст обращения от гражданина 127 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2026-03-11T19:30:13.430' AS DateTime), CAST(N'2026-03-30T15:30:13.430' AS DateTime), CAST(N'2026-03-21' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (347, 127, N'Обращение №3 от гражданина 127', N'Текст обращения от гражданина 127 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2026-03-03T19:30:13.430' AS DateTime), CAST(N'2026-03-15T20:30:13.430' AS DateTime), CAST(N'2026-03-13' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (348, 127, N'Обращение №4 от гражданина 127', N'Текст обращения от гражданина 127 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-05-23T19:30:13.430' AS DateTime), CAST(N'2025-06-12T04:30:13.430' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (349, 128, N'Обращение №1 от гражданина 128', N'Текст обращения от гражданина 128 по вопросу категории 5. Просьба принять меры.', 5, 2, 5, CAST(N'2026-04-04T19:30:13.430' AS DateTime), CAST(N'2026-04-28T22:30:13.430' AS DateTime), CAST(N'2026-04-14' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (350, 128, N'Обращение №2 от гражданина 128', N'Текст обращения от гражданина 128 по вопросу категории 5. Просьба принять меры.', 5, 2, 4, CAST(N'2026-04-21T19:30:13.433' AS DateTime), CAST(N'2026-05-01T12:30:13.433' AS DateTime), CAST(N'2026-05-01' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (351, 128, N'Обращение №3 от гражданина 128', N'Текст обращения от гражданина 128 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-09-09T19:30:13.433' AS DateTime), CAST(N'2025-09-10T00:30:13.433' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (352, 128, N'Обращение №4 от гражданина 128', N'Текст обращения от гражданина 128 по вопросу категории 3. Просьба принять меры.', 3, 2, 4, CAST(N'2025-08-13T19:30:13.433' AS DateTime), CAST(N'2025-09-02T13:30:13.433' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (353, 129, N'Обращение №1 от гражданина 129', N'Текст обращения от гражданина 129 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-08-31T19:30:13.433' AS DateTime), CAST(N'2025-09-30T13:30:13.433' AS DateTime), CAST(N'2025-09-10' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (354, 129, N'Обращение №2 от гражданина 129', N'Текст обращения от гражданина 129 по вопросу категории 4. Просьба принять меры.', 4, 2, 7, CAST(N'2025-10-21T19:30:13.433' AS DateTime), CAST(N'2025-10-23T01:30:13.433' AS DateTime), CAST(N'2025-10-31' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (355, 129, N'Обращение №3 от гражданина 129', N'Текст обращения от гражданина 129 по вопросу категории 5. Просьба принять меры.', 5, 2, 6, CAST(N'2026-03-16T19:30:13.433' AS DateTime), CAST(N'2026-03-26T12:30:13.433' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (356, 130, N'Обращение №1 от гражданина 130', N'Текст обращения от гражданина 130 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-09-21T19:30:13.437' AS DateTime), CAST(N'2025-10-16T02:30:13.437' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (357, 130, N'Обращение №2 от гражданина 130', N'Текст обращения от гражданина 130 по вопросу категории 3. Просьба принять меры.', 3, 2, 5, CAST(N'2026-04-15T19:30:13.437' AS DateTime), CAST(N'2026-05-05T08:30:13.437' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (358, 130, N'Обращение №3 от гражданина 130', N'Текст обращения от гражданина 130 по вопросу категории 2. Просьба принять меры.', 2, 2, 6, CAST(N'2025-12-29T19:30:13.437' AS DateTime), CAST(N'2026-01-09T12:30:13.437' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (359, 130, N'Обращение №4 от гражданина 130', N'Текст обращения от гражданина 130 по вопросу категории 2. Просьба принять меры.', 2, 2, 7, CAST(N'2025-06-20T19:30:13.437' AS DateTime), CAST(N'2025-07-17T11:30:13.437' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (360, 131, N'Обращение №1 от гражданина 131', N'Текст обращения от гражданина 131 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2026-04-25T19:30:13.437' AS DateTime), CAST(N'2026-04-26T02:30:13.437' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (361, 131, N'Обращение №2 от гражданина 131', N'Текст обращения от гражданина 131 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-09-23T19:30:13.440' AS DateTime), CAST(N'2025-10-14T09:30:13.440' AS DateTime), CAST(N'2025-10-03' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (362, 131, N'Обращение №3 от гражданина 131', N'Текст обращения от гражданина 131 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-06-26T19:30:13.440' AS DateTime), CAST(N'2025-07-18T07:30:13.440' AS DateTime), CAST(N'2025-07-06' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (363, 131, N'Обращение №4 от гражданина 131', N'Текст обращения от гражданина 131 по вопросу категории 2. Просьба принять меры.', 2, 2, 5, CAST(N'2025-12-19T19:30:13.440' AS DateTime), CAST(N'2025-12-21T18:30:13.440' AS DateTime), CAST(N'2025-12-29' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (364, 132, N'Обращение №1 от гражданина 132', N'Текст обращения от гражданина 132 по вопросу категории 5. Просьба принять меры.', 5, 2, 7, CAST(N'2025-05-28T19:30:13.440' AS DateTime), CAST(N'2025-05-30T04:30:13.440' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (365, 132, N'Обращение №2 от гражданина 132', N'Текст обращения от гражданина 132 по вопросу категории 1. Просьба принять меры.', 1, 2, 6, CAST(N'2025-06-13T19:30:13.440' AS DateTime), CAST(N'2025-07-05T17:30:13.440' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (366, 132, N'Обращение №3 от гражданина 132', N'Текст обращения от гражданина 132 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-09-10T19:30:13.440' AS DateTime), CAST(N'2025-10-01T13:30:13.440' AS DateTime), CAST(N'2025-09-20' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (367, 132, N'Обращение №4 от гражданина 132', N'Текст обращения от гражданина 132 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-09-05T19:30:13.440' AS DateTime), CAST(N'2025-09-09T00:30:13.440' AS DateTime), CAST(N'2025-09-15' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (368, 133, N'Обращение №1 от гражданина 133', N'Текст обращения от гражданина 133 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-05-28T19:30:13.443' AS DateTime), CAST(N'2025-05-30T12:30:13.443' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (369, 133, N'Обращение №2 от гражданина 133', N'Текст обращения от гражданина 133 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-11-01T19:30:13.443' AS DateTime), CAST(N'2025-11-30T10:30:13.443' AS DateTime), CAST(N'2025-11-11' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (370, 133, N'Обращение №3 от гражданина 133', N'Текст обращения от гражданина 133 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-11-13T19:30:13.443' AS DateTime), CAST(N'2025-12-03T09:30:13.443' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (371, 134, N'Обращение №1 от гражданина 134', N'Текст обращения от гражданина 134 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-10-26T19:30:13.443' AS DateTime), CAST(N'2025-11-01T08:30:13.443' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (372, 134, N'Обращение №2 от гражданина 134', N'Текст обращения от гражданина 134 по вопросу категории 5. Просьба принять меры.', 5, 2, 7, CAST(N'2026-03-04T19:30:13.443' AS DateTime), CAST(N'2026-03-07T11:30:13.443' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (373, 134, N'Обращение №3 от гражданина 134', N'Текст обращения от гражданина 134 по вопросу категории 1. Просьба принять меры.', 1, 2, 4, CAST(N'2025-06-13T19:30:13.443' AS DateTime), CAST(N'2025-07-09T02:30:13.443' AS DateTime), CAST(N'2025-06-23' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (374, 135, N'Обращение №1 от гражданина 135', N'Текст обращения от гражданина 135 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-11-04T19:30:13.447' AS DateTime), CAST(N'2025-11-30T01:30:13.447' AS DateTime), CAST(N'2025-11-14' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (375, 135, N'Обращение №2 от гражданина 135', N'Текст обращения от гражданина 135 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-12-20T19:30:13.447' AS DateTime), CAST(N'2026-01-06T17:30:13.447' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (376, 135, N'Обращение №3 от гражданина 135', N'Текст обращения от гражданина 135 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-07-03T19:30:13.447' AS DateTime), CAST(N'2025-07-11T11:30:13.447' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (377, 136, N'Обращение №1 от гражданина 136', N'Текст обращения от гражданина 136 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-12-01T19:30:13.447' AS DateTime), CAST(N'2025-12-23T12:30:13.447' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (378, 136, N'Обращение №2 от гражданина 136', N'Текст обращения от гражданина 136 по вопросу категории 1. Просьба принять меры.', 1, 2, 4, CAST(N'2026-03-15T19:30:13.447' AS DateTime), CAST(N'2026-04-08T07:30:13.447' AS DateTime), CAST(N'2026-03-25' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (379, 137, N'Обращение №1 от гражданина 137', N'Текст обращения от гражданина 137 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-09-28T19:30:13.447' AS DateTime), CAST(N'2025-10-23T15:30:13.447' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (380, 137, N'Обращение №2 от гражданина 137', N'Текст обращения от гражданина 137 по вопросу категории 1. Просьба принять меры.', 1, 2, 7, CAST(N'2026-01-02T19:30:13.447' AS DateTime), CAST(N'2026-01-06T09:30:13.447' AS DateTime), CAST(N'2026-01-12' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (381, 137, N'Обращение №3 от гражданина 137', N'Текст обращения от гражданина 137 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2026-03-08T19:30:13.450' AS DateTime), CAST(N'2026-03-20T13:30:13.450' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (382, 138, N'Обращение №1 от гражданина 138', N'Текст обращения от гражданина 138 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-12-02T19:30:13.450' AS DateTime), CAST(N'2025-12-15T13:30:13.450' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (383, 138, N'Обращение №2 от гражданина 138', N'Текст обращения от гражданина 138 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2026-01-26T19:30:13.450' AS DateTime), CAST(N'2026-02-05T21:30:13.450' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (384, 138, N'Обращение №3 от гражданина 138', N'Текст обращения от гражданина 138 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-08-07T19:30:13.450' AS DateTime), CAST(N'2025-08-22T04:30:13.450' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (385, 138, N'Обращение №4 от гражданина 138', N'Текст обращения от гражданина 138 по вопросу категории 5. Просьба принять меры.', 5, 2, 6, CAST(N'2026-01-16T19:30:13.450' AS DateTime), CAST(N'2026-02-07T00:30:13.450' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (386, 139, N'Обращение №1 от гражданина 139', N'Текст обращения от гражданина 139 по вопросу категории 4. Просьба принять меры.', 4, 2, 4, CAST(N'2025-12-26T19:30:13.450' AS DateTime), CAST(N'2026-01-22T17:30:13.450' AS DateTime), CAST(N'2026-01-05' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (387, 139, N'Обращение №2 от гражданина 139', N'Текст обращения от гражданина 139 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-07-25T19:30:13.450' AS DateTime), CAST(N'2025-08-09T15:30:13.450' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (388, 140, N'Обращение №1 от гражданина 140', N'Текст обращения от гражданина 140 по вопросу категории 3. Просьба принять меры.', 3, 2, 5, CAST(N'2025-12-13T19:30:13.450' AS DateTime), CAST(N'2025-12-22T00:30:13.450' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (389, 140, N'Обращение №2 от гражданина 140', N'Текст обращения от гражданина 140 по вопросу категории 4. Просьба принять меры.', 4, 2, 5, CAST(N'2025-10-19T19:30:13.450' AS DateTime), CAST(N'2025-11-06T20:30:13.450' AS DateTime), CAST(N'2025-10-29' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (390, 141, N'Обращение №1 от гражданина 141', N'Текст обращения от гражданина 141 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-06-14T19:30:13.453' AS DateTime), CAST(N'2025-07-10T17:30:13.453' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (391, 141, N'Обращение №2 от гражданина 141', N'Текст обращения от гражданина 141 по вопросу категории 5. Просьба принять меры.', 5, 2, 7, CAST(N'2025-06-12T19:30:13.453' AS DateTime), CAST(N'2025-06-30T23:30:13.453' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (392, 141, N'Обращение №3 от гражданина 141', N'Текст обращения от гражданина 141 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2026-03-10T19:30:13.453' AS DateTime), CAST(N'2026-03-25T14:30:13.453' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (393, 141, N'Обращение №4 от гражданина 141', N'Текст обращения от гражданина 141 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-07-24T19:30:13.453' AS DateTime), CAST(N'2025-08-02T13:30:13.453' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (394, 142, N'Обращение №1 от гражданина 142', N'Текст обращения от гражданина 142 по вопросу категории 5. Просьба принять меры.', 5, 2, 4, CAST(N'2025-12-03T19:30:13.453' AS DateTime), CAST(N'2025-12-25T15:30:13.453' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (395, 142, N'Обращение №2 от гражданина 142', N'Текст обращения от гражданина 142 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2026-01-24T19:30:13.453' AS DateTime), CAST(N'2026-01-31T11:30:13.453' AS DateTime), CAST(N'2026-02-03' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (396, 143, N'Обращение №1 от гражданина 143', N'Текст обращения от гражданина 143 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-09-09T19:30:13.457' AS DateTime), CAST(N'2025-09-22T11:30:13.457' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (397, 143, N'Обращение №2 от гражданина 143', N'Текст обращения от гражданина 143 по вопросу категории 2. Просьба принять меры.', 2, 2, 5, CAST(N'2025-05-21T19:30:13.457' AS DateTime), CAST(N'2025-06-01T06:30:13.457' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (398, 143, N'Обращение №3 от гражданина 143', N'Текст обращения от гражданина 143 по вопросу категории 3. Просьба принять меры.', 3, 2, 8, CAST(N'2025-05-22T19:30:13.457' AS DateTime), CAST(N'2025-06-08T10:30:13.457' AS DateTime), CAST(N'2025-06-01' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (399, 144, N'Обращение №1 от гражданина 144', N'Текст обращения от гражданина 144 по вопросу категории 1. Просьба принять меры.', 1, 2, 7, CAST(N'2025-06-03T19:30:13.457' AS DateTime), CAST(N'2025-06-20T13:30:13.457' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (400, 144, N'Обращение №2 от гражданина 144', N'Текст обращения от гражданина 144 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-09-19T19:30:13.460' AS DateTime), CAST(N'2025-10-16T16:30:13.460' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (401, 145, N'Обращение №1 от гражданина 145', N'Текст обращения от гражданина 145 по вопросу категории 2. Просьба принять меры.', 2, 2, 5, CAST(N'2026-03-22T19:30:13.460' AS DateTime), CAST(N'2026-04-16T20:30:13.460' AS DateTime), CAST(N'2026-04-01' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (402, 145, N'Обращение №2 от гражданина 145', N'Текст обращения от гражданина 145 по вопросу категории 1. Просьба принять меры.', 1, 2, 6, CAST(N'2026-03-17T19:30:13.460' AS DateTime), CAST(N'2026-03-23T17:30:13.460' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (403, 145, N'Обращение №3 от гражданина 145', N'Текст обращения от гражданина 145 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2026-01-13T19:30:13.460' AS DateTime), CAST(N'2026-02-01T02:30:13.460' AS DateTime), CAST(N'2026-01-23' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (404, 145, N'Обращение №4 от гражданина 145', N'Текст обращения от гражданина 145 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-11-13T19:30:13.460' AS DateTime), CAST(N'2025-11-19T19:30:13.460' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (405, 146, N'Обращение №1 от гражданина 146', N'Текст обращения от гражданина 146 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-07-27T19:30:13.460' AS DateTime), CAST(N'2025-08-17T02:30:13.460' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (406, 146, N'Обращение №2 от гражданина 146', N'Текст обращения от гражданина 146 по вопросу категории 2. Просьба принять меры.', 2, 2, 5, CAST(N'2026-05-03T19:30:13.460' AS DateTime), CAST(N'2026-05-14T15:30:13.460' AS DateTime), CAST(N'2026-05-13' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (407, 146, N'Обращение №3 от гражданина 146', N'Текст обращения от гражданина 146 по вопросу категории 1. Просьба принять меры.', 1, 2, 4, CAST(N'2025-11-16T19:30:13.463' AS DateTime), CAST(N'2025-11-28T10:30:13.463' AS DateTime), CAST(N'2025-11-26' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (408, 147, N'Обращение №1 от гражданина 147', N'Текст обращения от гражданина 147 по вопросу категории 5. Просьба принять меры.', 5, 2, 8, CAST(N'2025-08-22T19:30:13.463' AS DateTime), CAST(N'2025-09-17T03:30:13.463' AS DateTime), CAST(N'2025-09-01' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (409, 147, N'Обращение №2 от гражданина 147', N'Текст обращения от гражданина 147 по вопросу категории 4. Просьба принять меры.', 4, 2, 8, CAST(N'2026-04-28T19:30:13.463' AS DateTime), CAST(N'2026-05-07T07:30:13.463' AS DateTime), CAST(N'2026-05-08' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (410, 147, N'Обращение №3 от гражданина 147', N'Текст обращения от гражданина 147 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2026-03-31T19:30:13.463' AS DateTime), CAST(N'2026-04-28T21:30:13.463' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (411, 147, N'Обращение №4 от гражданина 147', N'Текст обращения от гражданина 147 по вопросу категории 4. Просьба принять меры.', 4, 2, 4, CAST(N'2025-11-07T19:30:13.463' AS DateTime), CAST(N'2025-11-07T19:30:13.463' AS DateTime), CAST(N'2025-11-17' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (412, 148, N'Обращение №1 от гражданина 148', N'Текст обращения от гражданина 148 по вопросу категории 1. Просьба принять меры.', 1, 2, 4, CAST(N'2025-06-27T19:30:13.463' AS DateTime), CAST(N'2025-07-12T06:30:13.463' AS DateTime), CAST(N'2025-07-07' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (413, 148, N'Обращение №2 от гражданина 148', N'Текст обращения от гражданина 148 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2026-01-30T19:30:13.467' AS DateTime), CAST(N'2026-02-23T15:30:13.467' AS DateTime), CAST(N'2026-02-09' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (414, 148, N'Обращение №3 от гражданина 148', N'Текст обращения от гражданина 148 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-10-29T19:30:13.467' AS DateTime), CAST(N'2025-11-06T18:30:13.467' AS DateTime), CAST(N'2025-11-08' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (415, 149, N'Обращение №1 от гражданина 149', N'Текст обращения от гражданина 149 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-09-23T19:30:13.467' AS DateTime), CAST(N'2025-10-05T01:30:13.467' AS DateTime), CAST(N'2025-10-03' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (416, 149, N'Обращение №2 от гражданина 149', N'Текст обращения от гражданина 149 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-07-19T19:30:13.467' AS DateTime), CAST(N'2025-08-18T02:30:13.467' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (417, 149, N'Обращение №3 от гражданина 149', N'Текст обращения от гражданина 149 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2026-05-20T19:30:13.467' AS DateTime), CAST(N'2026-06-14T20:30:13.467' AS DateTime), CAST(N'2026-05-30' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (418, 150, N'Обращение №1 от гражданина 150', N'Текст обращения от гражданина 150 по вопросу категории 3. Просьба принять меры.', 3, 2, 8, CAST(N'2026-01-12T19:30:13.467' AS DateTime), CAST(N'2026-01-18T00:30:13.467' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (419, 150, N'Обращение №2 от гражданина 150', N'Текст обращения от гражданина 150 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2026-01-12T19:30:13.470' AS DateTime), CAST(N'2026-01-17T18:30:13.470' AS DateTime), CAST(N'2026-01-22' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (420, 150, N'Обращение №3 от гражданина 150', N'Текст обращения от гражданина 150 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-07-06T19:30:13.470' AS DateTime), CAST(N'2025-07-17T23:30:13.470' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (421, 150, N'Обращение №4 от гражданина 150', N'Текст обращения от гражданина 150 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-07-31T19:30:13.470' AS DateTime), CAST(N'2025-08-17T03:30:13.470' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (422, 151, N'Обращение №1 от гражданина 151', N'Текст обращения от гражданина 151 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-06-30T19:30:13.470' AS DateTime), CAST(N'2025-07-15T01:30:13.470' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (423, 151, N'Обращение №2 от гражданина 151', N'Текст обращения от гражданина 151 по вопросу категории 2. Просьба принять меры.', 2, 2, 5, CAST(N'2026-05-19T19:30:13.470' AS DateTime), CAST(N'2026-06-02T22:30:13.470' AS DateTime), CAST(N'2026-05-29' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (424, 151, N'Обращение №3 от гражданина 151', N'Текст обращения от гражданина 151 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-09-11T19:30:13.470' AS DateTime), CAST(N'2025-10-11T10:30:13.470' AS DateTime), CAST(N'2025-09-21' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (425, 152, N'Обращение №1 от гражданина 152', N'Текст обращения от гражданина 152 по вопросу категории 2. Просьба принять меры.', 2, 2, 7, CAST(N'2025-11-01T19:30:13.470' AS DateTime), CAST(N'2025-11-28T12:30:13.470' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (426, 152, N'Обращение №2 от гражданина 152', N'Текст обращения от гражданина 152 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2026-04-06T19:30:13.470' AS DateTime), CAST(N'2026-04-15T12:30:13.470' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (427, 152, N'Обращение №3 от гражданина 152', N'Текст обращения от гражданина 152 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2026-02-01T19:30:13.470' AS DateTime), CAST(N'2026-02-09T00:30:13.470' AS DateTime), CAST(N'2026-02-11' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (428, 152, N'Обращение №4 от гражданина 152', N'Текст обращения от гражданина 152 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-08-05T19:30:13.473' AS DateTime), CAST(N'2025-08-07T23:30:13.473' AS DateTime), CAST(N'2025-08-15' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (429, 153, N'Обращение №1 от гражданина 153', N'Текст обращения от гражданина 153 по вопросу категории 2. Просьба принять меры.', 2, 2, 4, CAST(N'2025-05-24T19:30:13.473' AS DateTime), CAST(N'2025-06-20T17:30:13.473' AS DateTime), CAST(N'2025-06-03' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (430, 153, N'Обращение №2 от гражданина 153', N'Текст обращения от гражданина 153 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2026-02-04T19:30:13.473' AS DateTime), CAST(N'2026-02-17T14:30:13.473' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (431, 153, N'Обращение №3 от гражданина 153', N'Текст обращения от гражданина 153 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-06-11T19:30:13.473' AS DateTime), CAST(N'2025-07-10T15:30:13.473' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (432, 154, N'Обращение №1 от гражданина 154', N'Текст обращения от гражданина 154 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2026-03-20T19:30:13.477' AS DateTime), CAST(N'2026-04-17T10:30:13.477' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (433, 154, N'Обращение №2 от гражданина 154', N'Текст обращения от гражданина 154 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2026-02-28T19:30:13.477' AS DateTime), CAST(N'2026-03-13T11:30:13.477' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (434, 154, N'Обращение №3 от гражданина 154', N'Текст обращения от гражданина 154 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-09-18T19:30:13.477' AS DateTime), CAST(N'2025-10-18T11:30:13.477' AS DateTime), CAST(N'2025-09-28' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (435, 154, N'Обращение №4 от гражданина 154', N'Текст обращения от гражданина 154 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-08-15T19:30:13.477' AS DateTime), CAST(N'2025-09-08T18:30:13.477' AS DateTime), CAST(N'2025-08-25' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (436, 155, N'Обращение №1 от гражданина 155', N'Текст обращения от гражданина 155 по вопросу категории 5. Просьба принять меры.', 5, 2, 8, CAST(N'2025-05-23T19:30:13.477' AS DateTime), CAST(N'2025-06-18T13:30:13.477' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (437, 155, N'Обращение №2 от гражданина 155', N'Текст обращения от гражданина 155 по вопросу категории 3. Просьба принять меры.', 3, 2, 5, CAST(N'2026-03-10T19:30:13.477' AS DateTime), CAST(N'2026-04-08T12:30:13.477' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (438, 156, N'Обращение №1 от гражданина 156', N'Текст обращения от гражданина 156 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-10-30T19:30:13.480' AS DateTime), CAST(N'2025-11-22T06:30:13.480' AS DateTime), CAST(N'2025-11-09' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (439, 156, N'Обращение №2 от гражданина 156', N'Текст обращения от гражданина 156 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2026-04-17T19:30:13.480' AS DateTime), CAST(N'2026-04-19T04:30:13.480' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (440, 156, N'Обращение №3 от гражданина 156', N'Текст обращения от гражданина 156 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2026-05-12T19:30:13.480' AS DateTime), CAST(N'2026-05-29T18:30:13.480' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (441, 157, N'Обращение №1 от гражданина 157', N'Текст обращения от гражданина 157 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-10-15T19:30:13.480' AS DateTime), CAST(N'2025-11-07T17:30:13.480' AS DateTime), CAST(N'2025-10-25' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (442, 157, N'Обращение №2 от гражданина 157', N'Текст обращения от гражданина 157 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2026-04-06T19:30:13.480' AS DateTime), CAST(N'2026-04-28T15:30:13.480' AS DateTime), CAST(N'2026-04-16' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (443, 158, N'Обращение №1 от гражданина 158', N'Текст обращения от гражданина 158 по вопросу категории 5. Просьба принять меры.', 5, 2, 8, CAST(N'2026-03-27T19:30:13.480' AS DateTime), CAST(N'2026-04-19T01:30:13.480' AS DateTime), CAST(N'2026-04-06' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (444, 158, N'Обращение №2 от гражданина 158', N'Текст обращения от гражданина 158 по вопросу категории 4. Просьба принять меры.', 4, 2, 8, CAST(N'2025-05-30T19:30:13.480' AS DateTime), CAST(N'2025-06-28T13:30:13.480' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (445, 158, N'Обращение №3 от гражданина 158', N'Текст обращения от гражданина 158 по вопросу категории 5. Просьба принять меры.', 5, 2, 5, CAST(N'2026-02-09T19:30:13.480' AS DateTime), CAST(N'2026-03-11T08:30:13.480' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (446, 158, N'Обращение №4 от гражданина 158', N'Текст обращения от гражданина 158 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-06-28T19:30:13.483' AS DateTime), CAST(N'2025-07-09T22:30:13.483' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (447, 159, N'Обращение №1 от гражданина 159', N'Текст обращения от гражданина 159 по вопросу категории 3. Просьба принять меры.', 3, 2, 6, CAST(N'2026-02-08T19:30:13.483' AS DateTime), CAST(N'2026-02-28T02:30:13.483' AS DateTime), CAST(N'2026-02-18' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (448, 159, N'Обращение №2 от гражданина 159', N'Текст обращения от гражданина 159 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-08-26T19:30:13.483' AS DateTime), CAST(N'2025-09-02T15:30:13.483' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (449, 160, N'Обращение №1 от гражданина 160', N'Текст обращения от гражданина 160 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2026-03-31T19:30:13.483' AS DateTime), CAST(N'2026-04-18T21:30:13.483' AS DateTime), CAST(N'2026-04-10' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (450, 160, N'Обращение №2 от гражданина 160', N'Текст обращения от гражданина 160 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-06-03T19:30:13.483' AS DateTime), CAST(N'2025-06-16T09:30:13.483' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (451, 160, N'Обращение №3 от гражданина 160', N'Текст обращения от гражданина 160 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-11-05T19:30:13.483' AS DateTime), CAST(N'2025-11-20T10:30:13.483' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (452, 160, N'Обращение №4 от гражданина 160', N'Текст обращения от гражданина 160 по вопросу категории 5. Просьба принять меры.', 5, 2, 7, CAST(N'2025-10-11T19:30:13.483' AS DateTime), CAST(N'2025-10-12T06:30:13.483' AS DateTime), CAST(N'2025-10-21' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (453, 161, N'Обращение №1 от гражданина 161', N'Текст обращения от гражданина 161 по вопросу категории 1. Просьба принять меры.', 1, 2, 8, CAST(N'2025-08-02T19:30:13.487' AS DateTime), CAST(N'2025-08-30T21:30:13.487' AS DateTime), CAST(N'2025-08-12' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (454, 161, N'Обращение №2 от гражданина 161', N'Текст обращения от гражданина 161 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2026-01-17T19:30:13.487' AS DateTime), CAST(N'2026-01-21T07:30:13.487' AS DateTime), CAST(N'2026-01-27' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (455, 161, N'Обращение №3 от гражданина 161', N'Текст обращения от гражданина 161 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-10-17T19:30:13.487' AS DateTime), CAST(N'2025-11-04T12:30:13.487' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (456, 161, N'Обращение №4 от гражданина 161', N'Текст обращения от гражданина 161 по вопросу категории 3. Просьба принять меры.', 3, 2, 5, CAST(N'2025-08-12T19:30:13.487' AS DateTime), CAST(N'2025-08-20T22:30:13.487' AS DateTime), CAST(N'2025-08-22' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (457, 162, N'Обращение №1 от гражданина 162', N'Текст обращения от гражданина 162 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-08-07T19:30:13.487' AS DateTime), CAST(N'2025-08-09T16:30:13.487' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (458, 162, N'Обращение №2 от гражданина 162', N'Текст обращения от гражданина 162 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-07-18T19:30:13.490' AS DateTime), CAST(N'2025-07-19T08:30:13.490' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (459, 163, N'Обращение №1 от гражданина 163', N'Текст обращения от гражданина 163 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-07-19T19:30:13.490' AS DateTime), CAST(N'2025-08-10T04:30:13.490' AS DateTime), CAST(N'2025-07-29' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (460, 163, N'Обращение №2 от гражданина 163', N'Текст обращения от гражданина 163 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2026-03-14T19:30:13.490' AS DateTime), CAST(N'2026-04-06T14:30:13.490' AS DateTime), CAST(N'2026-03-24' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (461, 164, N'Обращение №1 от гражданина 164', N'Текст обращения от гражданина 164 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-11-16T19:30:13.490' AS DateTime), CAST(N'2025-11-29T14:30:13.490' AS DateTime), CAST(N'2025-11-26' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (462, 164, N'Обращение №2 от гражданина 164', N'Текст обращения от гражданина 164 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-06-14T19:30:13.490' AS DateTime), CAST(N'2025-07-07T14:30:13.490' AS DateTime), CAST(N'2025-06-24' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (463, 164, N'Обращение №3 от гражданина 164', N'Текст обращения от гражданина 164 по вопросу категории 3. Просьба принять меры.', 3, 2, 6, CAST(N'2026-02-02T19:30:13.490' AS DateTime), CAST(N'2026-02-19T20:30:13.490' AS DateTime), CAST(N'2026-02-12' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (464, 165, N'Обращение №1 от гражданина 165', N'Текст обращения от гражданина 165 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2026-01-06T19:30:13.490' AS DateTime), CAST(N'2026-01-16T02:30:13.490' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (465, 165, N'Обращение №2 от гражданина 165', N'Текст обращения от гражданина 165 по вопросу категории 5. Просьба принять меры.', 5, 2, 6, CAST(N'2025-09-13T19:30:13.490' AS DateTime), CAST(N'2025-09-22T11:30:13.490' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (466, 165, N'Обращение №3 от гражданина 165', N'Текст обращения от гражданина 165 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-05-27T19:30:13.493' AS DateTime), CAST(N'2025-06-14T19:30:13.493' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (467, 166, N'Обращение №1 от гражданина 166', N'Текст обращения от гражданина 166 по вопросу категории 3. Просьба принять меры.', 3, 2, 4, CAST(N'2025-11-23T19:30:13.493' AS DateTime), CAST(N'2025-12-08T11:30:13.493' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (468, 166, N'Обращение №2 от гражданина 166', N'Текст обращения от гражданина 166 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-06-12T19:30:13.493' AS DateTime), CAST(N'2025-06-17T16:30:13.493' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (469, 166, N'Обращение №3 от гражданина 166', N'Текст обращения от гражданина 166 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-12-17T19:30:13.493' AS DateTime), CAST(N'2025-12-24T11:30:13.493' AS DateTime), CAST(N'2025-12-27' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (470, 166, N'Обращение №4 от гражданина 166', N'Текст обращения от гражданина 166 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2026-03-11T19:30:13.493' AS DateTime), CAST(N'2026-03-27T19:30:13.493' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (471, 167, N'Обращение №1 от гражданина 167', N'Текст обращения от гражданина 167 по вопросу категории 4. Просьба принять меры.', 4, 2, 8, CAST(N'2026-03-08T19:30:13.497' AS DateTime), CAST(N'2026-03-28T22:30:13.497' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (472, 167, N'Обращение №2 от гражданина 167', N'Текст обращения от гражданина 167 по вопросу категории 3. Просьба принять меры.', 3, 2, 8, CAST(N'2025-06-18T19:30:13.497' AS DateTime), CAST(N'2025-06-27T07:30:13.497' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (473, 167, N'Обращение №3 от гражданина 167', N'Текст обращения от гражданина 167 по вопросу категории 4. Просьба принять меры.', 4, 2, 6, CAST(N'2026-01-12T19:30:13.497' AS DateTime), CAST(N'2026-01-30T01:30:13.497' AS DateTime), CAST(N'2026-01-22' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (474, 167, N'Обращение №4 от гражданина 167', N'Текст обращения от гражданина 167 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-09-03T19:30:13.497' AS DateTime), CAST(N'2025-09-16T21:30:13.497' AS DateTime), CAST(N'2025-09-13' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (475, 168, N'Обращение №1 от гражданина 168', N'Текст обращения от гражданина 168 по вопросу категории 5. Просьба принять меры.', 5, 2, 7, CAST(N'2025-09-21T19:30:13.497' AS DateTime), CAST(N'2025-10-01T04:30:13.497' AS DateTime), CAST(N'2025-10-01' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (476, 168, N'Обращение №2 от гражданина 168', N'Текст обращения от гражданина 168 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-09-22T19:30:13.497' AS DateTime), CAST(N'2025-10-18T16:30:13.497' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (477, 169, N'Обращение №1 от гражданина 169', N'Текст обращения от гражданина 169 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-06-23T19:30:13.500' AS DateTime), CAST(N'2025-06-30T10:30:13.500' AS DateTime), CAST(N'2025-07-03' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (478, 169, N'Обращение №2 от гражданина 169', N'Текст обращения от гражданина 169 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-09-04T19:30:13.500' AS DateTime), CAST(N'2025-09-23T20:30:13.500' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (479, 169, N'Обращение №3 от гражданина 169', N'Текст обращения от гражданина 169 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-11-17T19:30:13.500' AS DateTime), CAST(N'2025-11-22T04:30:13.500' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (480, 170, N'Обращение №1 от гражданина 170', N'Текст обращения от гражданина 170 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2026-03-25T19:30:13.500' AS DateTime), CAST(N'2026-04-06T02:30:13.500' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (481, 170, N'Обращение №2 от гражданина 170', N'Текст обращения от гражданина 170 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-11-18T19:30:13.500' AS DateTime), CAST(N'2025-11-24T16:30:13.500' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (482, 170, N'Обращение №3 от гражданина 170', N'Текст обращения от гражданина 170 по вопросу категории 1. Просьба принять меры.', 1, 2, 6, CAST(N'2026-04-14T19:30:13.500' AS DateTime), CAST(N'2026-04-30T11:30:13.500' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (483, 171, N'Обращение №1 от гражданина 171', N'Текст обращения от гражданина 171 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2026-04-13T19:30:13.500' AS DateTime), CAST(N'2026-05-03T13:30:13.500' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (484, 171, N'Обращение №2 от гражданина 171', N'Текст обращения от гражданина 171 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-05-23T19:30:13.500' AS DateTime), CAST(N'2025-06-10T13:30:13.500' AS DateTime), CAST(N'2025-06-02' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (485, 171, N'Обращение №3 от гражданина 171', N'Текст обращения от гражданина 171 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-07-30T19:30:13.500' AS DateTime), CAST(N'2025-08-12T20:30:13.500' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (486, 172, N'Обращение №1 от гражданина 172', N'Текст обращения от гражданина 172 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-07-02T19:30:13.500' AS DateTime), CAST(N'2025-07-04T06:30:13.500' AS DateTime), CAST(N'2025-07-12' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (487, 172, N'Обращение №2 от гражданина 172', N'Текст обращения от гражданина 172 по вопросу категории 4. Просьба принять меры.', 4, 2, 6, CAST(N'2025-10-01T19:30:13.503' AS DateTime), CAST(N'2025-10-20T18:30:13.503' AS DateTime), CAST(N'2025-10-11' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (488, 172, N'Обращение №3 от гражданина 172', N'Текст обращения от гражданина 172 по вопросу категории 1. Просьба принять меры.', 1, 2, 7, CAST(N'2025-08-17T19:30:13.503' AS DateTime), CAST(N'2025-09-11T22:30:13.503' AS DateTime), CAST(N'2025-08-27' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (489, 172, N'Обращение №4 от гражданина 172', N'Текст обращения от гражданина 172 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-06-19T19:30:13.503' AS DateTime), CAST(N'2025-06-25T01:30:13.503' AS DateTime), CAST(N'2025-06-29' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (490, 173, N'Обращение №1 от гражданина 173', N'Текст обращения от гражданина 173 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-11-14T19:30:13.503' AS DateTime), CAST(N'2025-11-18T01:30:13.503' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (491, 173, N'Обращение №2 от гражданина 173', N'Текст обращения от гражданина 173 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-11-09T19:30:13.503' AS DateTime), CAST(N'2025-12-03T14:30:13.503' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (492, 173, N'Обращение №3 от гражданина 173', N'Текст обращения от гражданина 173 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-08-10T19:30:13.503' AS DateTime), CAST(N'2025-08-22T23:30:13.503' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (493, 174, N'Обращение №1 от гражданина 174', N'Текст обращения от гражданина 174 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-09-19T19:30:13.507' AS DateTime), CAST(N'2025-10-11T07:30:13.507' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (494, 174, N'Обращение №2 от гражданина 174', N'Текст обращения от гражданина 174 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-06-23T19:30:13.507' AS DateTime), CAST(N'2025-07-09T11:30:13.507' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (495, 175, N'Обращение №1 от гражданина 175', N'Текст обращения от гражданина 175 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-08-24T19:30:13.507' AS DateTime), CAST(N'2025-08-31T19:30:13.507' AS DateTime), CAST(N'2025-09-03' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (496, 175, N'Обращение №2 от гражданина 175', N'Текст обращения от гражданина 175 по вопросу категории 4. Просьба принять меры.', 4, 2, 7, CAST(N'2025-10-07T19:30:13.507' AS DateTime), CAST(N'2025-10-16T03:30:13.507' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (497, 175, N'Обращение №3 от гражданина 175', N'Текст обращения от гражданина 175 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-11-01T19:30:13.507' AS DateTime), CAST(N'2025-11-14T17:30:13.507' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (498, 175, N'Обращение №4 от гражданина 175', N'Текст обращения от гражданина 175 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2026-03-19T19:30:13.507' AS DateTime), CAST(N'2026-03-30T07:30:13.507' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (499, 176, N'Обращение №1 от гражданина 176', N'Текст обращения от гражданина 176 по вопросу категории 5. Просьба принять меры.', 5, 2, 8, CAST(N'2025-11-22T19:30:13.510' AS DateTime), CAST(N'2025-12-11T05:30:13.510' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (500, 176, N'Обращение №2 от гражданина 176', N'Текст обращения от гражданина 176 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-08-09T19:30:13.510' AS DateTime), CAST(N'2025-08-10T20:30:13.510' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (501, 177, N'Обращение №1 от гражданина 177', N'Текст обращения от гражданина 177 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-12-27T19:30:13.510' AS DateTime), CAST(N'2026-01-06T22:30:13.510' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (502, 177, N'Обращение №2 от гражданина 177', N'Текст обращения от гражданина 177 по вопросу категории 3. Просьба принять меры.', 3, 2, 5, CAST(N'2026-01-22T19:30:13.510' AS DateTime), CAST(N'2026-02-06T12:30:13.510' AS DateTime), CAST(N'2026-02-01' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (503, 177, N'Обращение №3 от гражданина 177', N'Текст обращения от гражданина 177 по вопросу категории 5. Просьба принять меры.', 5, 2, 7, CAST(N'2026-04-28T19:30:13.510' AS DateTime), CAST(N'2026-05-16T12:30:13.510' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (504, 177, N'Обращение №4 от гражданина 177', N'Текст обращения от гражданина 177 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-11-24T19:30:13.510' AS DateTime), CAST(N'2025-12-13T01:30:13.510' AS DateTime), CAST(N'2025-12-04' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (505, 178, N'Обращение №1 от гражданина 178', N'Текст обращения от гражданина 178 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-12-04T19:30:13.513' AS DateTime), CAST(N'2025-12-20T04:30:13.513' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (506, 178, N'Обращение №2 от гражданина 178', N'Текст обращения от гражданина 178 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-12-12T19:30:13.513' AS DateTime), CAST(N'2026-01-05T12:30:13.513' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (507, 178, N'Обращение №3 от гражданина 178', N'Текст обращения от гражданина 178 по вопросу категории 3. Просьба принять меры.', 3, 2, 8, CAST(N'2025-12-12T19:30:13.513' AS DateTime), CAST(N'2025-12-21T01:30:13.513' AS DateTime), CAST(N'2025-12-22' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (508, 178, N'Обращение №4 от гражданина 178', N'Текст обращения от гражданина 178 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2026-01-18T19:30:13.513' AS DateTime), CAST(N'2026-01-22T11:30:13.513' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (509, 179, N'Обращение №1 от гражданина 179', N'Текст обращения от гражданина 179 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-12-29T19:30:13.513' AS DateTime), CAST(N'2026-01-15T10:30:13.513' AS DateTime), CAST(N'2026-01-08' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (510, 179, N'Обращение №2 от гражданина 179', N'Текст обращения от гражданина 179 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-08-15T19:30:13.513' AS DateTime), CAST(N'2025-08-18T00:30:13.513' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (511, 179, N'Обращение №3 от гражданина 179', N'Текст обращения от гражданина 179 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-10-13T19:30:13.517' AS DateTime), CAST(N'2025-10-14T18:30:13.517' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (512, 180, N'Обращение №1 от гражданина 180', N'Текст обращения от гражданина 180 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2026-01-06T19:30:13.517' AS DateTime), CAST(N'2026-02-02T09:30:13.517' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (513, 180, N'Обращение №2 от гражданина 180', N'Текст обращения от гражданина 180 по вопросу категории 4. Просьба принять меры.', 4, 2, 7, CAST(N'2025-05-25T19:30:13.517' AS DateTime), CAST(N'2025-06-13T02:30:13.517' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (514, 181, N'Обращение №1 от гражданина 181', N'Текст обращения от гражданина 181 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-07-05T19:30:13.517' AS DateTime), CAST(N'2025-07-08T07:30:13.517' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (515, 181, N'Обращение №2 от гражданина 181', N'Текст обращения от гражданина 181 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-05-30T19:30:13.517' AS DateTime), CAST(N'2025-06-03T03:30:13.517' AS DateTime), CAST(N'2025-06-09' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (516, 181, N'Обращение №3 от гражданина 181', N'Текст обращения от гражданина 181 по вопросу категории 2. Просьба принять меры.', 2, 2, 5, CAST(N'2025-11-21T19:30:13.517' AS DateTime), CAST(N'2025-12-06T13:30:13.517' AS DateTime), CAST(N'2025-12-01' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (517, 181, N'Обращение №4 от гражданина 181', N'Текст обращения от гражданина 181 по вопросу категории 1. Просьба принять меры.', 1, 2, 6, CAST(N'2025-07-19T19:30:13.520' AS DateTime), CAST(N'2025-08-04T04:30:13.520' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (518, 182, N'Обращение №1 от гражданина 182', N'Текст обращения от гражданина 182 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2026-01-01T19:30:13.520' AS DateTime), CAST(N'2026-01-05T21:30:13.520' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (519, 182, N'Обращение №2 от гражданина 182', N'Текст обращения от гражданина 182 по вопросу категории 4. Просьба принять меры.', 4, 2, 6, CAST(N'2025-12-02T19:30:13.520' AS DateTime), CAST(N'2025-12-31T02:30:13.520' AS DateTime), CAST(N'2025-12-12' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (520, 182, N'Обращение №3 от гражданина 182', N'Текст обращения от гражданина 182 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2026-01-25T19:30:13.520' AS DateTime), CAST(N'2026-02-18T10:30:13.520' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (521, 182, N'Обращение №4 от гражданина 182', N'Текст обращения от гражданина 182 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2026-03-20T19:30:13.520' AS DateTime), CAST(N'2026-04-07T10:30:13.520' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (522, 183, N'Обращение №1 от гражданина 183', N'Текст обращения от гражданина 183 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-07-29T19:30:13.520' AS DateTime), CAST(N'2025-08-19T17:30:13.520' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (523, 183, N'Обращение №2 от гражданина 183', N'Текст обращения от гражданина 183 по вопросу категории 3. Просьба принять меры.', 3, 2, 5, CAST(N'2026-03-22T19:30:13.520' AS DateTime), CAST(N'2026-04-13T22:30:13.520' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (524, 183, N'Обращение №3 от гражданина 183', N'Текст обращения от гражданина 183 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-10-23T19:30:13.520' AS DateTime), CAST(N'2025-11-07T10:30:13.520' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (525, 183, N'Обращение №4 от гражданина 183', N'Текст обращения от гражданина 183 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2026-05-12T19:30:13.523' AS DateTime), CAST(N'2026-05-27T09:30:13.523' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (526, 184, N'Обращение №1 от гражданина 184', N'Текст обращения от гражданина 184 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2026-01-05T19:30:13.523' AS DateTime), CAST(N'2026-01-30T09:30:13.523' AS DateTime), CAST(N'2026-01-15' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (527, 184, N'Обращение №2 от гражданина 184', N'Текст обращения от гражданина 184 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-11-26T19:30:13.523' AS DateTime), CAST(N'2025-12-02T20:30:13.523' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (528, 184, N'Обращение №3 от гражданина 184', N'Текст обращения от гражданина 184 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2026-04-20T19:30:13.523' AS DateTime), CAST(N'2026-04-22T22:30:13.523' AS DateTime), CAST(N'2026-04-30' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (529, 185, N'Обращение №1 от гражданина 185', N'Текст обращения от гражданина 185 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-10-15T19:30:13.523' AS DateTime), CAST(N'2025-10-27T23:30:13.523' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (530, 185, N'Обращение №2 от гражданина 185', N'Текст обращения от гражданина 185 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2026-05-09T19:30:13.523' AS DateTime), CAST(N'2026-05-10T17:30:13.523' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (531, 185, N'Обращение №3 от гражданина 185', N'Текст обращения от гражданина 185 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2026-04-27T19:30:13.527' AS DateTime), CAST(N'2026-05-13T18:30:13.527' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (532, 185, N'Обращение №4 от гражданина 185', N'Текст обращения от гражданина 185 по вопросу категории 1. Просьба принять меры.', 1, 2, 7, CAST(N'2026-04-11T19:30:13.527' AS DateTime), CAST(N'2026-05-10T05:30:13.527' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (533, 186, N'Обращение №1 от гражданина 186', N'Текст обращения от гражданина 186 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-07-11T19:30:13.527' AS DateTime), CAST(N'2025-08-05T17:30:13.527' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (534, 186, N'Обращение №2 от гражданина 186', N'Текст обращения от гражданина 186 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-06-18T19:30:13.527' AS DateTime), CAST(N'2025-07-18T16:30:13.527' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (535, 187, N'Обращение №1 от гражданина 187', N'Текст обращения от гражданина 187 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-08-10T19:30:13.527' AS DateTime), CAST(N'2025-09-02T14:30:13.527' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (536, 187, N'Обращение №2 от гражданина 187', N'Текст обращения от гражданина 187 по вопросу категории 3. Просьба принять меры.', 3, 2, 7, CAST(N'2026-02-17T19:30:13.527' AS DateTime), CAST(N'2026-03-14T03:30:13.527' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (537, 187, N'Обращение №3 от гражданина 187', N'Текст обращения от гражданина 187 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-07-11T19:30:13.530' AS DateTime), CAST(N'2025-07-13T05:30:13.530' AS DateTime), CAST(N'2025-07-21' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (538, 187, N'Обращение №4 от гражданина 187', N'Текст обращения от гражданина 187 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-08-05T19:30:13.530' AS DateTime), CAST(N'2025-09-01T09:30:13.530' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (539, 188, N'Обращение №1 от гражданина 188', N'Текст обращения от гражданина 188 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-07-30T19:30:13.530' AS DateTime), CAST(N'2025-08-16T05:30:13.530' AS DateTime), CAST(N'2025-08-09' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (540, 188, N'Обращение №2 от гражданина 188', N'Текст обращения от гражданина 188 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-07-07T19:30:13.530' AS DateTime), CAST(N'2025-07-18T15:30:13.530' AS DateTime), CAST(N'2025-07-17' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (541, 188, N'Обращение №3 от гражданина 188', N'Текст обращения от гражданина 188 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2026-04-20T19:30:13.530' AS DateTime), CAST(N'2026-05-19T00:30:13.530' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (542, 188, N'Обращение №4 от гражданина 188', N'Текст обращения от гражданина 188 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2026-02-27T19:30:13.530' AS DateTime), CAST(N'2026-03-23T06:30:13.530' AS DateTime), CAST(N'2026-03-09' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (543, 189, N'Обращение №1 от гражданина 189', N'Текст обращения от гражданина 189 по вопросу категории 5. Просьба принять меры.', 5, 2, 4, CAST(N'2025-12-01T19:30:13.530' AS DateTime), CAST(N'2025-12-19T05:30:13.530' AS DateTime), CAST(N'2025-12-11' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (544, 189, N'Обращение №2 от гражданина 189', N'Текст обращения от гражданина 189 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2026-02-17T19:30:13.530' AS DateTime), CAST(N'2026-03-14T08:30:13.530' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (545, 189, N'Обращение №3 от гражданина 189', N'Текст обращения от гражданина 189 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2026-04-01T19:30:13.533' AS DateTime), CAST(N'2026-04-07T16:30:13.533' AS DateTime), CAST(N'2026-04-11' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (546, 189, N'Обращение №4 от гражданина 189', N'Текст обращения от гражданина 189 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-06-02T19:30:13.533' AS DateTime), CAST(N'2025-06-19T00:30:13.533' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (547, 190, N'Обращение №1 от гражданина 190', N'Текст обращения от гражданина 190 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-11-07T19:30:13.533' AS DateTime), CAST(N'2025-12-06T07:30:13.533' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (548, 190, N'Обращение №2 от гражданина 190', N'Текст обращения от гражданина 190 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2026-05-17T19:30:13.533' AS DateTime), CAST(N'2026-05-30T13:30:13.533' AS DateTime), CAST(N'2026-05-27' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (549, 190, N'Обращение №3 от гражданина 190', N'Текст обращения от гражданина 190 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-07-21T19:30:13.533' AS DateTime), CAST(N'2025-08-09T23:30:13.533' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (550, 190, N'Обращение №4 от гражданина 190', N'Текст обращения от гражданина 190 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2026-02-19T19:30:13.533' AS DateTime), CAST(N'2026-02-27T19:30:13.533' AS DateTime), CAST(N'2026-03-01' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (551, 191, N'Обращение №1 от гражданина 191', N'Текст обращения от гражданина 191 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2026-04-24T19:30:13.537' AS DateTime), CAST(N'2026-05-17T17:30:13.537' AS DateTime), CAST(N'2026-05-04' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (552, 191, N'Обращение №2 от гражданина 191', N'Текст обращения от гражданина 191 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-07-16T19:30:13.537' AS DateTime), CAST(N'2025-07-22T04:30:13.537' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (553, 191, N'Обращение №3 от гражданина 191', N'Текст обращения от гражданина 191 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-08-09T19:30:13.537' AS DateTime), CAST(N'2025-09-05T23:30:13.537' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (554, 191, N'Обращение №4 от гражданина 191', N'Текст обращения от гражданина 191 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-05-29T19:30:13.537' AS DateTime), CAST(N'2025-06-25T23:30:13.537' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (555, 192, N'Обращение №1 от гражданина 192', N'Текст обращения от гражданина 192 по вопросу категории 5. Просьба принять меры.', 5, 2, 7, CAST(N'2025-10-23T19:30:13.537' AS DateTime), CAST(N'2025-11-05T21:30:13.537' AS DateTime), CAST(N'2025-11-02' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (556, 192, N'Обращение №2 от гражданина 192', N'Текст обращения от гражданина 192 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-05-24T19:30:13.537' AS DateTime), CAST(N'2025-06-15T16:30:13.537' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (557, 193, N'Обращение №1 от гражданина 193', N'Текст обращения от гражданина 193 по вопросу категории 2. Просьба принять меры.', 2, 2, 7, CAST(N'2026-03-11T19:30:13.537' AS DateTime), CAST(N'2026-04-09T16:30:13.537' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (558, 193, N'Обращение №2 от гражданина 193', N'Текст обращения от гражданина 193 по вопросу категории 2. Просьба принять меры.', 2, 2, 6, CAST(N'2026-02-05T19:30:13.540' AS DateTime), CAST(N'2026-02-14T09:30:13.540' AS DateTime), CAST(N'2026-02-15' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (559, 194, N'Обращение №1 от гражданина 194', N'Текст обращения от гражданина 194 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-09-05T19:30:13.540' AS DateTime), CAST(N'2025-09-27T06:30:13.540' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (560, 194, N'Обращение №2 от гражданина 194', N'Текст обращения от гражданина 194 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2026-04-09T19:30:13.540' AS DateTime), CAST(N'2026-04-21T14:30:13.540' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (561, 194, N'Обращение №3 от гражданина 194', N'Текст обращения от гражданина 194 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-05-29T19:30:13.540' AS DateTime), CAST(N'2025-06-15T15:30:13.540' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (562, 195, N'Обращение №1 от гражданина 195', N'Текст обращения от гражданина 195 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2026-05-05T19:30:13.540' AS DateTime), CAST(N'2026-05-10T02:30:13.540' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (563, 195, N'Обращение №2 от гражданина 195', N'Текст обращения от гражданина 195 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2026-01-11T19:30:13.540' AS DateTime), CAST(N'2026-01-28T23:30:13.540' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (564, 195, N'Обращение №3 от гражданина 195', N'Текст обращения от гражданина 195 по вопросу категории 5. Просьба принять меры.', 5, 2, 5, CAST(N'2025-06-15T19:30:13.540' AS DateTime), CAST(N'2025-06-28T02:30:13.540' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (565, 196, N'Обращение №1 от гражданина 196', N'Текст обращения от гражданина 196 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-11-18T19:30:13.540' AS DateTime), CAST(N'2025-12-05T07:30:13.540' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (566, 196, N'Обращение №2 от гражданина 196', N'Текст обращения от гражданина 196 по вопросу категории 4. Просьба принять меры.', 4, 2, 8, CAST(N'2026-04-13T19:30:13.540' AS DateTime), CAST(N'2026-04-28T04:30:13.540' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (567, 197, N'Обращение №1 от гражданина 197', N'Текст обращения от гражданина 197 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-12-01T19:30:13.543' AS DateTime), CAST(N'2025-12-26T12:30:13.543' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (568, 197, N'Обращение №2 от гражданина 197', N'Текст обращения от гражданина 197 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-12-25T19:30:13.543' AS DateTime), CAST(N'2026-01-10T11:30:13.543' AS DateTime), CAST(N'2026-01-04' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (569, 197, N'Обращение №3 от гражданина 197', N'Текст обращения от гражданина 197 по вопросу категории 5. Просьба принять меры.', 5, 2, 7, CAST(N'2026-02-25T19:30:13.543' AS DateTime), CAST(N'2026-03-25T01:30:13.543' AS DateTime), CAST(N'2026-03-07' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (570, 198, N'Обращение №1 от гражданина 198', N'Текст обращения от гражданина 198 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-07-12T19:30:13.543' AS DateTime), CAST(N'2025-07-14T08:30:13.543' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (571, 198, N'Обращение №2 от гражданина 198', N'Текст обращения от гражданина 198 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-11-18T19:30:13.543' AS DateTime), CAST(N'2025-11-29T14:30:13.543' AS DateTime), CAST(N'2025-11-28' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (572, 199, N'Обращение №1 от гражданина 199', N'Текст обращения от гражданина 199 по вопросу категории 1. Просьба принять меры.', 1, 2, 4, CAST(N'2026-02-12T19:30:13.547' AS DateTime), CAST(N'2026-02-27T18:30:13.547' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (573, 199, N'Обращение №2 от гражданина 199', N'Текст обращения от гражданина 199 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-06-20T19:30:13.547' AS DateTime), CAST(N'2025-07-12T20:30:13.547' AS DateTime), CAST(N'2025-06-30' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (574, 200, N'Обращение №1 от гражданина 200', N'Текст обращения от гражданина 200 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-10-06T19:30:13.547' AS DateTime), CAST(N'2025-10-09T00:30:13.547' AS DateTime), CAST(N'2025-10-16' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (575, 200, N'Обращение №2 от гражданина 200', N'Текст обращения от гражданина 200 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2026-02-24T19:30:13.547' AS DateTime), CAST(N'2026-03-23T15:30:13.547' AS DateTime), CAST(N'2026-03-06' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (576, 200, N'Обращение №3 от гражданина 200', N'Текст обращения от гражданина 200 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-05-26T19:30:13.547' AS DateTime), CAST(N'2025-06-20T19:30:13.547' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (577, 200, N'Обращение №4 от гражданина 200', N'Текст обращения от гражданина 200 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2026-05-04T19:30:13.547' AS DateTime), CAST(N'2026-05-15T18:30:13.547' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (578, 201, N'Обращение №1 от гражданина 201', N'Текст обращения от гражданина 201 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-08-15T19:30:13.550' AS DateTime), CAST(N'2025-09-03T22:30:13.550' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (579, 201, N'Обращение №2 от гражданина 201', N'Текст обращения от гражданина 201 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-09-25T19:30:13.550' AS DateTime), CAST(N'2025-10-11T07:30:13.550' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (580, 201, N'Обращение №3 от гражданина 201', N'Текст обращения от гражданина 201 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2026-03-22T19:30:13.550' AS DateTime), CAST(N'2026-04-05T03:30:13.550' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (581, 201, N'Обращение №4 от гражданина 201', N'Текст обращения от гражданина 201 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-10-19T19:30:13.550' AS DateTime), CAST(N'2025-11-10T05:30:13.550' AS DateTime), CAST(N'2025-10-29' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (582, 202, N'Обращение №1 от гражданина 202', N'Текст обращения от гражданина 202 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-08-24T19:30:13.550' AS DateTime), CAST(N'2025-09-15T09:30:13.550' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (583, 202, N'Обращение №2 от гражданина 202', N'Текст обращения от гражданина 202 по вопросу категории 5. Просьба принять меры.', 5, 2, 6, CAST(N'2026-05-16T19:30:13.550' AS DateTime), CAST(N'2026-06-06T00:30:13.550' AS DateTime), CAST(N'2026-05-26' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (584, 202, N'Обращение №3 от гражданина 202', N'Текст обращения от гражданина 202 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-06-01T19:30:13.550' AS DateTime), CAST(N'2025-06-13T08:30:13.550' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (585, 203, N'Обращение №1 от гражданина 203', N'Текст обращения от гражданина 203 по вопросу категории 3. Просьба принять меры.', 3, 2, 5, CAST(N'2025-07-14T19:30:13.550' AS DateTime), CAST(N'2025-07-30T22:30:13.550' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (586, 203, N'Обращение №2 от гражданина 203', N'Текст обращения от гражданина 203 по вопросу категории 2. Просьба принять меры.', 2, 2, 6, CAST(N'2025-07-04T19:30:13.550' AS DateTime), CAST(N'2025-07-17T12:30:13.550' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (587, 203, N'Обращение №3 от гражданина 203', N'Текст обращения от гражданина 203 по вопросу категории 5. Просьба принять меры.', 5, 2, 5, CAST(N'2025-11-18T19:30:13.553' AS DateTime), CAST(N'2025-12-15T13:30:13.553' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (588, 203, N'Обращение №4 от гражданина 203', N'Текст обращения от гражданина 203 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2026-03-15T19:30:13.553' AS DateTime), CAST(N'2026-03-25T20:30:13.553' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (589, 204, N'Обращение №1 от гражданина 204', N'Текст обращения от гражданина 204 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-08-22T19:30:13.553' AS DateTime), CAST(N'2025-08-30T00:30:13.553' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (590, 204, N'Обращение №2 от гражданина 204', N'Текст обращения от гражданина 204 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-09-13T19:30:13.553' AS DateTime), CAST(N'2025-09-20T16:30:13.553' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (591, 205, N'Обращение №1 от гражданина 205', N'Текст обращения от гражданина 205 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2026-04-22T19:30:13.553' AS DateTime), CAST(N'2026-05-07T21:30:13.553' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (592, 205, N'Обращение №2 от гражданина 205', N'Текст обращения от гражданина 205 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-10-10T19:30:13.553' AS DateTime), CAST(N'2025-11-02T14:30:13.553' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (593, 205, N'Обращение №3 от гражданина 205', N'Текст обращения от гражданина 205 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2026-05-16T19:30:13.553' AS DateTime), CAST(N'2026-06-04T15:30:13.553' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (594, 206, N'Обращение №1 от гражданина 206', N'Текст обращения от гражданина 206 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-12-21T19:30:13.557' AS DateTime), CAST(N'2025-12-31T02:30:13.557' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (595, 206, N'Обращение №2 от гражданина 206', N'Текст обращения от гражданина 206 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-12-20T19:30:13.557' AS DateTime), CAST(N'2026-01-13T21:30:13.557' AS DateTime), CAST(N'2025-12-30' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (596, 206, N'Обращение №3 от гражданина 206', N'Текст обращения от гражданина 206 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-05-22T19:30:13.557' AS DateTime), CAST(N'2025-06-18T16:30:13.557' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (597, 207, N'Обращение №1 от гражданина 207', N'Текст обращения от гражданина 207 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2026-01-28T19:30:13.557' AS DateTime), CAST(N'2026-02-22T21:30:13.557' AS DateTime), CAST(N'2026-02-07' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (598, 207, N'Обращение №2 от гражданина 207', N'Текст обращения от гражданина 207 по вопросу категории 5. Просьба принять меры.', 5, 2, 8, CAST(N'2025-12-24T19:30:13.557' AS DateTime), CAST(N'2026-01-05T11:30:13.557' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (599, 208, N'Обращение №1 от гражданина 208', N'Текст обращения от гражданина 208 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-06-06T19:30:13.557' AS DateTime), CAST(N'2025-06-11T07:30:13.557' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (600, 208, N'Обращение №2 от гражданина 208', N'Текст обращения от гражданина 208 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2026-04-27T19:30:13.557' AS DateTime), CAST(N'2026-05-13T02:30:13.557' AS DateTime), CAST(N'2026-05-07' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (601, 209, N'Обращение №1 от гражданина 209', N'Текст обращения от гражданина 209 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-10-17T19:30:13.560' AS DateTime), CAST(N'2025-11-16T17:30:13.560' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (602, 209, N'Обращение №2 от гражданина 209', N'Текст обращения от гражданина 209 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-06-10T19:30:13.560' AS DateTime), CAST(N'2025-06-12T15:30:13.560' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (603, 210, N'Обращение №1 от гражданина 210', N'Текст обращения от гражданина 210 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2026-05-13T19:30:13.560' AS DateTime), CAST(N'2026-06-08T14:30:13.560' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (604, 210, N'Обращение №2 от гражданина 210', N'Текст обращения от гражданина 210 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2026-01-24T19:30:13.560' AS DateTime), CAST(N'2026-02-03T12:30:13.560' AS DateTime), CAST(N'2026-02-03' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (605, 210, N'Обращение №3 от гражданина 210', N'Текст обращения от гражданина 210 по вопросу категории 4. Просьба принять меры.', 4, 2, 5, CAST(N'2025-11-06T19:30:13.560' AS DateTime), CAST(N'2025-11-14T19:30:13.560' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (606, 210, N'Обращение №4 от гражданина 210', N'Текст обращения от гражданина 210 по вопросу категории 1. Просьба принять меры.', 1, 2, 8, CAST(N'2025-10-16T19:30:13.560' AS DateTime), CAST(N'2025-10-21T06:30:13.560' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (607, 211, N'Обращение №1 от гражданина 211', N'Текст обращения от гражданина 211 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-08-01T19:30:13.560' AS DateTime), CAST(N'2025-08-14T15:30:13.560' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (608, 211, N'Обращение №2 от гражданина 211', N'Текст обращения от гражданина 211 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2026-02-01T19:30:13.560' AS DateTime), CAST(N'2026-02-07T13:30:13.560' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (609, 211, N'Обращение №3 от гражданина 211', N'Текст обращения от гражданина 211 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2026-05-09T19:30:13.560' AS DateTime), CAST(N'2026-06-08T01:30:13.560' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (610, 212, N'Обращение №1 от гражданина 212', N'Текст обращения от гражданина 212 по вопросу категории 1. Просьба принять меры.', 1, 2, 6, CAST(N'2025-07-26T19:30:13.563' AS DateTime), CAST(N'2025-08-15T04:30:13.563' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (611, 212, N'Обращение №2 от гражданина 212', N'Текст обращения от гражданина 212 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-09-21T19:30:13.563' AS DateTime), CAST(N'2025-10-05T21:30:13.563' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (612, 212, N'Обращение №3 от гражданина 212', N'Текст обращения от гражданина 212 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-06-19T19:30:13.563' AS DateTime), CAST(N'2025-06-19T23:30:13.563' AS DateTime), CAST(N'2025-06-29' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (613, 212, N'Обращение №4 от гражданина 212', N'Текст обращения от гражданина 212 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-10-31T19:30:13.563' AS DateTime), CAST(N'2025-11-13T01:30:13.563' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (614, 213, N'Обращение №1 от гражданина 213', N'Текст обращения от гражданина 213 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-10-14T19:30:13.563' AS DateTime), CAST(N'2025-11-07T20:30:13.563' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (615, 213, N'Обращение №2 от гражданина 213', N'Текст обращения от гражданина 213 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2026-02-06T19:30:13.563' AS DateTime), CAST(N'2026-02-10T09:30:13.563' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (616, 214, N'Обращение №1 от гражданина 214', N'Текст обращения от гражданина 214 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2026-05-07T19:30:13.567' AS DateTime), CAST(N'2026-06-03T09:30:13.567' AS DateTime), CAST(N'2026-05-17' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (617, 214, N'Обращение №2 от гражданина 214', N'Текст обращения от гражданина 214 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-11-07T19:30:13.567' AS DateTime), CAST(N'2025-11-25T19:30:13.567' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (618, 214, N'Обращение №3 от гражданина 214', N'Текст обращения от гражданина 214 по вопросу категории 1. Просьба принять меры.', 1, 2, 6, CAST(N'2025-10-28T19:30:13.567' AS DateTime), CAST(N'2025-11-15T05:30:13.567' AS DateTime), CAST(N'2025-11-07' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (619, 215, N'Обращение №1 от гражданина 215', N'Текст обращения от гражданина 215 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-07-15T19:30:13.567' AS DateTime), CAST(N'2025-07-27T05:30:13.567' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (620, 215, N'Обращение №2 от гражданина 215', N'Текст обращения от гражданина 215 по вопросу категории 1. Просьба принять меры.', 1, 2, 7, CAST(N'2025-12-28T19:30:13.567' AS DateTime), CAST(N'2026-01-10T15:30:13.567' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (621, 215, N'Обращение №3 от гражданина 215', N'Текст обращения от гражданина 215 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-07-06T19:30:13.570' AS DateTime), CAST(N'2025-07-31T09:30:13.570' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (622, 215, N'Обращение №4 от гражданина 215', N'Текст обращения от гражданина 215 по вопросу категории 3. Просьба принять меры.', 3, 2, 8, CAST(N'2026-04-08T19:30:13.570' AS DateTime), CAST(N'2026-04-19T17:30:13.570' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (623, 216, N'Обращение №1 от гражданина 216', N'Текст обращения от гражданина 216 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-12-03T19:30:13.570' AS DateTime), CAST(N'2025-12-14T21:30:13.570' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (624, 216, N'Обращение №2 от гражданина 216', N'Текст обращения от гражданина 216 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-09-02T19:30:13.570' AS DateTime), CAST(N'2025-09-06T05:30:13.570' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (625, 216, N'Обращение №3 от гражданина 216', N'Текст обращения от гражданина 216 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-12-20T19:30:13.570' AS DateTime), CAST(N'2026-01-02T15:30:13.570' AS DateTime), CAST(N'2025-12-30' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (626, 216, N'Обращение №4 от гражданина 216', N'Текст обращения от гражданина 216 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2026-02-18T19:30:13.570' AS DateTime), CAST(N'2026-02-21T10:30:13.570' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (627, 217, N'Обращение №1 от гражданина 217', N'Текст обращения от гражданина 217 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-05-30T19:30:13.570' AS DateTime), CAST(N'2025-06-10T21:30:13.570' AS DateTime), CAST(N'2025-06-09' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (628, 217, N'Обращение №2 от гражданина 217', N'Текст обращения от гражданина 217 по вопросу категории 1. Просьба принять меры.', 1, 2, 8, CAST(N'2025-09-28T19:30:13.570' AS DateTime), CAST(N'2025-10-01T11:30:13.570' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (629, 217, N'Обращение №3 от гражданина 217', N'Текст обращения от гражданина 217 по вопросу категории 1. Просьба принять меры.', 1, 2, 8, CAST(N'2026-02-25T19:30:13.573' AS DateTime), CAST(N'2026-03-10T02:30:13.573' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (630, 218, N'Обращение №1 от гражданина 218', N'Текст обращения от гражданина 218 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-06-28T19:30:13.573' AS DateTime), CAST(N'2025-07-15T04:30:13.573' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (631, 218, N'Обращение №2 от гражданина 218', N'Текст обращения от гражданина 218 по вопросу категории 3. Просьба принять меры.', 3, 2, 8, CAST(N'2026-05-03T19:30:13.573' AS DateTime), CAST(N'2026-05-05T18:30:13.573' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (632, 218, N'Обращение №3 от гражданина 218', N'Текст обращения от гражданина 218 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2026-04-03T19:30:13.573' AS DateTime), CAST(N'2026-04-06T06:30:13.573' AS DateTime), CAST(N'2026-04-13' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (633, 219, N'Обращение №1 от гражданина 219', N'Текст обращения от гражданина 219 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-09-25T19:30:13.573' AS DateTime), CAST(N'2025-10-06T05:30:13.573' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (634, 219, N'Обращение №2 от гражданина 219', N'Текст обращения от гражданина 219 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-08-20T19:30:13.577' AS DateTime), CAST(N'2025-08-26T20:30:13.577' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (635, 219, N'Обращение №3 от гражданина 219', N'Текст обращения от гражданина 219 по вопросу категории 1. Просьба принять меры.', 1, 2, 7, CAST(N'2026-01-25T19:30:13.577' AS DateTime), CAST(N'2026-01-26T16:30:13.577' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (636, 220, N'Обращение №1 от гражданина 220', N'Текст обращения от гражданина 220 по вопросу категории 3. Просьба принять меры.', 3, 2, 4, CAST(N'2026-05-12T19:30:13.577' AS DateTime), CAST(N'2026-05-24T00:30:13.577' AS DateTime), CAST(N'2026-05-22' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (637, 220, N'Обращение №2 от гражданина 220', N'Текст обращения от гражданина 220 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2026-02-23T19:30:13.577' AS DateTime), CAST(N'2026-03-18T06:30:13.577' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (638, 220, N'Обращение №3 от гражданина 220', N'Текст обращения от гражданина 220 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-05-21T19:30:13.577' AS DateTime), CAST(N'2025-06-02T09:30:13.577' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (639, 220, N'Обращение №4 от гражданина 220', N'Текст обращения от гражданина 220 по вопросу категории 2. Просьба принять меры.', 2, 2, 6, CAST(N'2025-07-26T19:30:13.577' AS DateTime), CAST(N'2025-08-20T23:30:13.577' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (640, 221, N'Обращение №1 от гражданина 221', N'Текст обращения от гражданина 221 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-05-22T19:30:13.580' AS DateTime), CAST(N'2025-05-28T23:30:13.580' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (641, 221, N'Обращение №2 от гражданина 221', N'Текст обращения от гражданина 221 по вопросу категории 3. Просьба принять меры.', 3, 2, 7, CAST(N'2025-09-01T19:30:13.580' AS DateTime), CAST(N'2025-09-23T18:30:13.580' AS DateTime), CAST(N'2025-09-11' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (642, 222, N'Обращение №1 от гражданина 222', N'Текст обращения от гражданина 222 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-09-16T19:30:13.580' AS DateTime), CAST(N'2025-10-15T17:30:13.580' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (643, 222, N'Обращение №2 от гражданина 222', N'Текст обращения от гражданина 222 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-07-07T19:30:13.607' AS DateTime), CAST(N'2025-07-23T02:30:13.607' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (644, 222, N'Обращение №3 от гражданина 222', N'Текст обращения от гражданина 222 по вопросу категории 5. Просьба принять меры.', 5, 2, 4, CAST(N'2025-06-30T19:30:13.610' AS DateTime), CAST(N'2025-07-12T16:30:13.610' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (645, 222, N'Обращение №4 от гражданина 222', N'Текст обращения от гражданина 222 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-08-15T19:30:13.610' AS DateTime), CAST(N'2025-08-16T09:30:13.610' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (646, 223, N'Обращение №1 от гражданина 223', N'Текст обращения от гражданина 223 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-06-07T19:30:13.610' AS DateTime), CAST(N'2025-06-23T15:30:13.610' AS DateTime), CAST(N'2025-06-17' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (647, 223, N'Обращение №2 от гражданина 223', N'Текст обращения от гражданина 223 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2026-02-04T19:30:13.610' AS DateTime), CAST(N'2026-03-02T20:30:13.610' AS DateTime), CAST(N'2026-02-14' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (648, 223, N'Обращение №3 от гражданина 223', N'Текст обращения от гражданина 223 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2026-05-20T19:30:13.610' AS DateTime), CAST(N'2026-05-23T18:30:13.610' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (649, 223, N'Обращение №4 от гражданина 223', N'Текст обращения от гражданина 223 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2026-03-27T19:30:13.610' AS DateTime), CAST(N'2026-04-06T18:30:13.610' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (650, 224, N'Обращение №1 от гражданина 224', N'Текст обращения от гражданина 224 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2026-01-04T19:30:13.613' AS DateTime), CAST(N'2026-01-26T01:30:13.613' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (651, 224, N'Обращение №2 от гражданина 224', N'Текст обращения от гражданина 224 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2026-01-04T19:30:13.613' AS DateTime), CAST(N'2026-01-07T19:30:13.613' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (652, 224, N'Обращение №3 от гражданина 224', N'Текст обращения от гражданина 224 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2026-02-18T19:30:13.613' AS DateTime), CAST(N'2026-02-27T08:30:13.613' AS DateTime), CAST(N'2026-02-28' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (653, 225, N'Обращение №1 от гражданина 225', N'Текст обращения от гражданина 225 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-11-11T19:30:13.613' AS DateTime), CAST(N'2025-12-06T00:30:13.613' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (654, 225, N'Обращение №2 от гражданина 225', N'Текст обращения от гражданина 225 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-09-02T19:30:13.613' AS DateTime), CAST(N'2025-09-08T03:30:13.613' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (655, 225, N'Обращение №3 от гражданина 225', N'Текст обращения от гражданина 225 по вопросу категории 5. Просьба принять меры.', 5, 2, 7, CAST(N'2025-12-25T19:30:13.613' AS DateTime), CAST(N'2025-12-28T14:30:13.613' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (656, 226, N'Обращение №1 от гражданина 226', N'Текст обращения от гражданина 226 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-07-23T19:30:13.617' AS DateTime), CAST(N'2025-08-05T03:30:13.617' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (657, 226, N'Обращение №2 от гражданина 226', N'Текст обращения от гражданина 226 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-09-18T19:30:13.617' AS DateTime), CAST(N'2025-09-25T22:30:13.617' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (658, 226, N'Обращение №3 от гражданина 226', N'Текст обращения от гражданина 226 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-06-28T19:30:13.617' AS DateTime), CAST(N'2025-07-10T15:30:13.617' AS DateTime), CAST(N'2025-07-08' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (659, 226, N'Обращение №4 от гражданина 226', N'Текст обращения от гражданина 226 по вопросу категории 5. Просьба принять меры.', 5, 2, 6, CAST(N'2025-07-07T19:30:13.617' AS DateTime), CAST(N'2025-07-08T19:30:13.617' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (660, 227, N'Обращение №1 от гражданина 227', N'Текст обращения от гражданина 227 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2026-03-17T19:30:13.617' AS DateTime), CAST(N'2026-04-14T01:30:13.617' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (661, 227, N'Обращение №2 от гражданина 227', N'Текст обращения от гражданина 227 по вопросу категории 3. Просьба принять меры.', 3, 2, 4, CAST(N'2026-04-25T19:30:13.617' AS DateTime), CAST(N'2026-05-18T02:30:13.617' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (662, 227, N'Обращение №3 от гражданина 227', N'Текст обращения от гражданина 227 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2026-05-14T19:30:13.620' AS DateTime), CAST(N'2026-06-06T13:30:13.620' AS DateTime), CAST(N'2026-05-24' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (663, 228, N'Обращение №1 от гражданина 228', N'Текст обращения от гражданина 228 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-12-08T19:30:13.620' AS DateTime), CAST(N'2026-01-06T20:30:13.620' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (664, 228, N'Обращение №2 от гражданина 228', N'Текст обращения от гражданина 228 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-09-25T19:30:13.620' AS DateTime), CAST(N'2025-10-24T09:30:13.620' AS DateTime), CAST(N'2025-10-05' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (665, 228, N'Обращение №3 от гражданина 228', N'Текст обращения от гражданина 228 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2026-01-24T19:30:13.620' AS DateTime), CAST(N'2026-02-01T23:30:13.620' AS DateTime), CAST(N'2026-02-03' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (666, 229, N'Обращение №1 от гражданина 229', N'Текст обращения от гражданина 229 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2026-02-26T19:30:13.620' AS DateTime), CAST(N'2026-03-24T01:30:13.620' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (667, 229, N'Обращение №2 от гражданина 229', N'Текст обращения от гражданина 229 по вопросу категории 2. Просьба принять меры.', 2, 2, 4, CAST(N'2026-01-08T19:30:13.620' AS DateTime), CAST(N'2026-01-27T17:30:13.620' AS DateTime), CAST(N'2026-01-18' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (668, 229, N'Обращение №3 от гражданина 229', N'Текст обращения от гражданина 229 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-09-26T19:30:13.620' AS DateTime), CAST(N'2025-10-21T09:30:13.620' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (669, 230, N'Обращение №1 от гражданина 230', N'Текст обращения от гражданина 230 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2026-01-21T19:30:13.620' AS DateTime), CAST(N'2026-02-09T18:30:13.620' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (670, 230, N'Обращение №2 от гражданина 230', N'Текст обращения от гражданина 230 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2026-01-11T19:30:13.623' AS DateTime), CAST(N'2026-01-25T00:30:13.623' AS DateTime), CAST(N'2026-01-21' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (671, 230, N'Обращение №3 от гражданина 230', N'Текст обращения от гражданина 230 по вопросу категории 1. Просьба принять меры.', 1, 2, 4, CAST(N'2025-06-19T19:30:13.623' AS DateTime), CAST(N'2025-06-21T12:30:13.623' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (672, 230, N'Обращение №4 от гражданина 230', N'Текст обращения от гражданина 230 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-09-10T19:30:13.623' AS DateTime), CAST(N'2025-10-03T01:30:13.623' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (673, 231, N'Обращение №1 от гражданина 231', N'Текст обращения от гражданина 231 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-11-10T19:30:13.623' AS DateTime), CAST(N'2025-12-09T04:30:13.623' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (674, 231, N'Обращение №2 от гражданина 231', N'Текст обращения от гражданина 231 по вопросу категории 3. Просьба принять меры.', 3, 2, 4, CAST(N'2026-05-03T19:30:13.623' AS DateTime), CAST(N'2026-05-17T00:30:13.623' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (675, 231, N'Обращение №3 от гражданина 231', N'Текст обращения от гражданина 231 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-09-05T19:30:13.627' AS DateTime), CAST(N'2025-09-28T15:30:13.627' AS DateTime), CAST(N'2025-09-15' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (676, 232, N'Обращение №1 от гражданина 232', N'Текст обращения от гражданина 232 по вопросу категории 4. Просьба принять меры.', 4, 2, 5, CAST(N'2026-04-15T19:30:13.627' AS DateTime), CAST(N'2026-05-04T04:30:13.627' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (677, 232, N'Обращение №2 от гражданина 232', N'Текст обращения от гражданина 232 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-05-30T19:30:13.627' AS DateTime), CAST(N'2025-06-28T04:30:13.627' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (678, 232, N'Обращение №3 от гражданина 232', N'Текст обращения от гражданина 232 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2026-01-17T19:30:13.627' AS DateTime), CAST(N'2026-01-18T14:30:13.627' AS DateTime), CAST(N'2026-01-27' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (679, 233, N'Обращение №1 от гражданина 233', N'Текст обращения от гражданина 233 по вопросу категории 2. Просьба принять меры.', 2, 2, 7, CAST(N'2026-02-05T19:30:13.627' AS DateTime), CAST(N'2026-02-09T03:30:13.627' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (680, 233, N'Обращение №2 от гражданина 233', N'Текст обращения от гражданина 233 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-08-20T19:30:13.630' AS DateTime), CAST(N'2025-09-07T01:30:13.630' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (681, 233, N'Обращение №3 от гражданина 233', N'Текст обращения от гражданина 233 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-10-30T19:30:13.630' AS DateTime), CAST(N'2025-11-26T14:30:13.630' AS DateTime), CAST(N'2025-11-09' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (682, 233, N'Обращение №4 от гражданина 233', N'Текст обращения от гражданина 233 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-10-24T19:30:13.630' AS DateTime), CAST(N'2025-11-07T16:30:13.630' AS DateTime), CAST(N'2025-11-03' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (683, 234, N'Обращение №1 от гражданина 234', N'Текст обращения от гражданина 234 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-08-14T19:30:13.630' AS DateTime), CAST(N'2025-08-29T07:30:13.630' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (684, 234, N'Обращение №2 от гражданина 234', N'Текст обращения от гражданина 234 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-09-16T19:30:13.630' AS DateTime), CAST(N'2025-10-01T02:30:13.630' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (685, 235, N'Обращение №1 от гражданина 235', N'Текст обращения от гражданина 235 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-06-04T19:30:13.630' AS DateTime), CAST(N'2025-06-06T00:30:13.630' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (686, 235, N'Обращение №2 от гражданина 235', N'Текст обращения от гражданина 235 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-06-02T19:30:13.630' AS DateTime), CAST(N'2025-06-10T10:30:13.630' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (687, 235, N'Обращение №3 от гражданина 235', N'Текст обращения от гражданина 235 по вопросу категории 5. Просьба принять меры.', 5, 2, 5, CAST(N'2025-11-11T19:30:13.630' AS DateTime), CAST(N'2025-12-10T20:30:13.630' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (688, 235, N'Обращение №4 от гражданина 235', N'Текст обращения от гражданина 235 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-08-25T19:30:13.633' AS DateTime), CAST(N'2025-08-31T13:30:13.633' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (689, 236, N'Обращение №1 от гражданина 236', N'Текст обращения от гражданина 236 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2026-02-14T19:30:13.633' AS DateTime), CAST(N'2026-02-17T03:30:13.633' AS DateTime), CAST(N'2026-02-24' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (690, 236, N'Обращение №2 от гражданина 236', N'Текст обращения от гражданина 236 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-06-01T19:30:13.633' AS DateTime), CAST(N'2025-06-06T19:30:13.633' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (691, 236, N'Обращение №3 от гражданина 236', N'Текст обращения от гражданина 236 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2026-04-24T19:30:13.633' AS DateTime), CAST(N'2026-05-07T00:30:13.633' AS DateTime), CAST(N'2026-05-04' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (692, 236, N'Обращение №4 от гражданина 236', N'Текст обращения от гражданина 236 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2026-03-12T19:30:13.633' AS DateTime), CAST(N'2026-03-22T10:30:13.633' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (693, 237, N'Обращение №1 от гражданина 237', N'Текст обращения от гражданина 237 по вопросу категории 1. Просьба принять меры.', 1, 2, 7, CAST(N'2026-02-18T19:30:13.633' AS DateTime), CAST(N'2026-03-20T11:30:13.633' AS DateTime), CAST(N'2026-02-28' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (694, 237, N'Обращение №2 от гражданина 237', N'Текст обращения от гражданина 237 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2026-01-23T19:30:13.637' AS DateTime), CAST(N'2026-02-22T02:30:13.637' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (695, 237, N'Обращение №3 от гражданина 237', N'Текст обращения от гражданина 237 по вопросу категории 5. Просьба принять меры.', 5, 2, 7, CAST(N'2025-06-18T19:30:13.637' AS DateTime), CAST(N'2025-06-24T14:30:13.637' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (696, 238, N'Обращение №1 от гражданина 238', N'Текст обращения от гражданина 238 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-09-01T19:30:13.637' AS DateTime), CAST(N'2025-09-12T13:30:13.637' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (697, 238, N'Обращение №2 от гражданина 238', N'Текст обращения от гражданина 238 по вопросу категории 1. Просьба принять меры.', 1, 2, 5, CAST(N'2025-06-22T19:30:13.637' AS DateTime), CAST(N'2025-06-29T00:30:13.637' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (698, 238, N'Обращение №3 от гражданина 238', N'Текст обращения от гражданина 238 по вопросу категории 1. Просьба принять меры.', 1, 2, 6, CAST(N'2026-03-19T19:30:13.637' AS DateTime), CAST(N'2026-04-09T13:30:13.637' AS DateTime), CAST(N'2026-03-29' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (699, 239, N'Обращение №1 от гражданина 239', N'Текст обращения от гражданина 239 по вопросу категории 5. Просьба принять меры.', 5, 2, 4, CAST(N'2026-03-30T19:30:13.637' AS DateTime), CAST(N'2026-03-30T20:30:13.637' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (700, 239, N'Обращение №2 от гражданина 239', N'Текст обращения от гражданина 239 по вопросу категории 5. Просьба принять меры.', 5, 2, 4, CAST(N'2026-02-06T19:30:13.637' AS DateTime), CAST(N'2026-02-08T01:30:13.637' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (701, 239, N'Обращение №3 от гражданина 239', N'Текст обращения от гражданина 239 по вопросу категории 4. Просьба принять меры.', 4, 2, 7, CAST(N'2025-12-10T19:30:13.640' AS DateTime), CAST(N'2025-12-19T12:30:13.640' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (702, 240, N'Обращение №1 от гражданина 240', N'Текст обращения от гражданина 240 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-06-03T19:30:13.640' AS DateTime), CAST(N'2025-06-08T01:30:13.640' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (703, 240, N'Обращение №2 от гражданина 240', N'Текст обращения от гражданина 240 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-08-21T19:30:13.640' AS DateTime), CAST(N'2025-09-07T08:30:13.640' AS DateTime), CAST(N'2025-08-31' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (704, 241, N'Обращение №1 от гражданина 241', N'Текст обращения от гражданина 241 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2026-05-15T19:30:13.640' AS DateTime), CAST(N'2026-06-01T08:30:13.640' AS DateTime), CAST(N'2026-05-25' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (705, 241, N'Обращение №2 от гражданина 241', N'Текст обращения от гражданина 241 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-08-28T19:30:13.640' AS DateTime), CAST(N'2025-09-08T22:30:13.640' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (706, 241, N'Обращение №3 от гражданина 241', N'Текст обращения от гражданина 241 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-07-05T19:30:13.640' AS DateTime), CAST(N'2025-07-09T14:30:13.640' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (707, 241, N'Обращение №4 от гражданина 241', N'Текст обращения от гражданина 241 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2026-03-25T19:30:13.640' AS DateTime), CAST(N'2026-04-24T03:30:13.640' AS DateTime), CAST(N'2026-04-04' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (708, 242, N'Обращение №1 от гражданина 242', N'Текст обращения от гражданина 242 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-10-26T19:30:13.640' AS DateTime), CAST(N'2025-11-06T03:30:13.640' AS DateTime), CAST(N'2025-11-05' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (709, 242, N'Обращение №2 от гражданина 242', N'Текст обращения от гражданина 242 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-10-28T19:30:13.643' AS DateTime), CAST(N'2025-11-24T03:30:13.643' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (710, 242, N'Обращение №3 от гражданина 242', N'Текст обращения от гражданина 242 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-12-08T19:30:13.643' AS DateTime), CAST(N'2025-12-16T01:30:13.643' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (711, 243, N'Обращение №1 от гражданина 243', N'Текст обращения от гражданина 243 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-09-10T19:30:13.643' AS DateTime), CAST(N'2025-09-18T05:30:13.643' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (712, 243, N'Обращение №2 от гражданина 243', N'Текст обращения от гражданина 243 по вопросу категории 2. Просьба принять меры.', 2, 2, 4, CAST(N'2025-08-08T19:30:13.643' AS DateTime), CAST(N'2025-08-18T13:30:13.643' AS DateTime), CAST(N'2025-08-18' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (713, 244, N'Обращение №1 от гражданина 244', N'Текст обращения от гражданина 244 по вопросу категории 1. Просьба принять меры.', 1, 2, 8, CAST(N'2026-05-20T19:30:13.643' AS DateTime), CAST(N'2026-06-19T08:30:13.643' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (714, 244, N'Обращение №2 от гражданина 244', N'Текст обращения от гражданина 244 по вопросу категории 4. Просьба принять меры.', 4, 2, 6, CAST(N'2026-03-26T19:30:13.643' AS DateTime), CAST(N'2026-04-09T17:30:13.643' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (715, 245, N'Обращение №1 от гражданина 245', N'Текст обращения от гражданина 245 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-09-11T19:30:13.647' AS DateTime), CAST(N'2025-10-10T12:30:13.647' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (716, 245, N'Обращение №2 от гражданина 245', N'Текст обращения от гражданина 245 по вопросу категории 2. Просьба принять меры.', 2, 2, 5, CAST(N'2026-04-19T19:30:13.647' AS DateTime), CAST(N'2026-05-10T10:30:13.647' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (717, 245, N'Обращение №3 от гражданина 245', N'Текст обращения от гражданина 245 по вопросу категории 3. Просьба принять меры.', 3, 2, 5, CAST(N'2026-01-10T19:30:13.647' AS DateTime), CAST(N'2026-01-24T11:30:13.647' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (718, 246, N'Обращение №1 от гражданина 246', N'Текст обращения от гражданина 246 по вопросу категории 5. Просьба принять меры.', 5, 2, 4, CAST(N'2026-02-23T19:30:13.647' AS DateTime), CAST(N'2026-02-24T04:30:13.647' AS DateTime), CAST(N'2026-03-05' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (719, 246, N'Обращение №2 от гражданина 246', N'Текст обращения от гражданина 246 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-10-27T19:30:13.647' AS DateTime), CAST(N'2025-10-29T09:30:13.647' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (720, 246, N'Обращение №3 от гражданина 246', N'Текст обращения от гражданина 246 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-06-22T19:30:13.647' AS DateTime), CAST(N'2025-07-20T12:30:13.647' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (721, 247, N'Обращение №1 от гражданина 247', N'Текст обращения от гражданина 247 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-08-25T19:30:13.650' AS DateTime), CAST(N'2025-08-28T23:30:13.650' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (722, 247, N'Обращение №2 от гражданина 247', N'Текст обращения от гражданина 247 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-09-12T19:30:13.650' AS DateTime), CAST(N'2025-09-29T06:30:13.650' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (723, 248, N'Обращение №1 от гражданина 248', N'Текст обращения от гражданина 248 по вопросу категории 4. Просьба принять меры.', 4, 2, 5, CAST(N'2025-08-12T19:30:13.650' AS DateTime), CAST(N'2025-08-14T23:30:13.650' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (724, 248, N'Обращение №2 от гражданина 248', N'Текст обращения от гражданина 248 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2026-01-21T19:30:13.650' AS DateTime), CAST(N'2026-01-31T23:30:13.650' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (725, 249, N'Обращение №1 от гражданина 249', N'Текст обращения от гражданина 249 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-09-25T19:30:13.650' AS DateTime), CAST(N'2025-10-09T00:30:13.650' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (726, 249, N'Обращение №2 от гражданина 249', N'Текст обращения от гражданина 249 по вопросу категории 1. Просьба принять меры.', 1, 2, 6, CAST(N'2026-02-20T19:30:13.650' AS DateTime), CAST(N'2026-03-16T12:30:13.650' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (727, 249, N'Обращение №3 от гражданина 249', N'Текст обращения от гражданина 249 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-07-05T19:30:13.653' AS DateTime), CAST(N'2025-07-20T15:30:13.653' AS DateTime), CAST(N'2025-07-15' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (728, 249, N'Обращение №4 от гражданина 249', N'Текст обращения от гражданина 249 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2026-03-11T19:30:13.653' AS DateTime), CAST(N'2026-03-31T23:30:13.653' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (729, 250, N'Обращение №1 от гражданина 250', N'Текст обращения от гражданина 250 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-08-31T19:30:13.653' AS DateTime), CAST(N'2025-09-09T21:30:13.653' AS DateTime), CAST(N'2025-09-10' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (730, 250, N'Обращение №2 от гражданина 250', N'Текст обращения от гражданина 250 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-12-19T19:30:13.653' AS DateTime), CAST(N'2026-01-12T16:30:13.653' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (731, 251, N'Обращение №1 от гражданина 251', N'Текст обращения от гражданина 251 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2026-03-26T19:30:13.653' AS DateTime), CAST(N'2026-04-12T12:30:13.653' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (732, 251, N'Обращение №2 от гражданина 251', N'Текст обращения от гражданина 251 по вопросу категории 4. Просьба принять меры.', 4, 2, 4, CAST(N'2026-02-26T19:30:13.653' AS DateTime), CAST(N'2026-03-05T06:30:13.653' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (733, 251, N'Обращение №3 от гражданина 251', N'Текст обращения от гражданина 251 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-09-03T19:30:13.653' AS DateTime), CAST(N'2025-09-04T21:30:13.653' AS DateTime), CAST(N'2025-09-13' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (734, 251, N'Обращение №4 от гражданина 251', N'Текст обращения от гражданина 251 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2026-02-17T19:30:13.657' AS DateTime), CAST(N'2026-02-26T07:30:13.657' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (735, 252, N'Обращение №1 от гражданина 252', N'Текст обращения от гражданина 252 по вопросу категории 2. Просьба принять меры.', 2, 2, 8, CAST(N'2025-08-10T19:30:13.657' AS DateTime), CAST(N'2025-09-09T07:30:13.657' AS DateTime), CAST(N'2025-08-20' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (736, 252, N'Обращение №2 от гражданина 252', N'Текст обращения от гражданина 252 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2026-03-03T19:30:13.657' AS DateTime), CAST(N'2026-03-27T00:30:13.657' AS DateTime), CAST(N'2026-03-13' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (737, 252, N'Обращение №3 от гражданина 252', N'Текст обращения от гражданина 252 по вопросу категории 2. Просьба принять меры.', 2, 2, 8, CAST(N'2025-10-22T19:30:13.657' AS DateTime), CAST(N'2025-11-06T00:30:13.657' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (738, 253, N'Обращение №1 от гражданина 253', N'Текст обращения от гражданина 253 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2026-04-06T19:30:13.657' AS DateTime), CAST(N'2026-04-26T08:30:13.657' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (739, 253, N'Обращение №2 от гражданина 253', N'Текст обращения от гражданина 253 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-11-11T19:30:13.657' AS DateTime), CAST(N'2025-12-02T10:30:13.657' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (740, 253, N'Обращение №3 от гражданина 253', N'Текст обращения от гражданина 253 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-07-13T19:30:13.657' AS DateTime), CAST(N'2025-08-07T18:30:13.657' AS DateTime), CAST(N'2025-07-23' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (741, 253, N'Обращение №4 от гражданина 253', N'Текст обращения от гражданина 253 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-10-10T19:30:13.660' AS DateTime), CAST(N'2025-11-06T22:30:13.660' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (742, 254, N'Обращение №1 от гражданина 254', N'Текст обращения от гражданина 254 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-11-27T19:30:13.660' AS DateTime), CAST(N'2025-12-26T22:30:13.660' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (743, 254, N'Обращение №2 от гражданина 254', N'Текст обращения от гражданина 254 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-07-04T19:30:13.660' AS DateTime), CAST(N'2025-07-05T06:30:13.660' AS DateTime), CAST(N'2025-07-14' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (744, 255, N'Обращение №1 от гражданина 255', N'Текст обращения от гражданина 255 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-06-22T19:30:13.660' AS DateTime), CAST(N'2025-06-24T06:30:13.660' AS DateTime), CAST(N'2025-07-02' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (745, 255, N'Обращение №2 от гражданина 255', N'Текст обращения от гражданина 255 по вопросу категории 3. Просьба принять меры.', 3, 2, 4, CAST(N'2026-02-09T19:30:13.660' AS DateTime), CAST(N'2026-03-05T13:30:13.660' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (746, 256, N'Обращение №1 от гражданина 256', N'Текст обращения от гражданина 256 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-12-27T19:30:13.660' AS DateTime), CAST(N'2026-01-07T08:30:13.660' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (747, 256, N'Обращение №2 от гражданина 256', N'Текст обращения от гражданина 256 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-09-26T19:30:13.660' AS DateTime), CAST(N'2025-10-18T21:30:13.660' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (748, 257, N'Обращение №1 от гражданина 257', N'Текст обращения от гражданина 257 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-07-06T19:30:13.660' AS DateTime), CAST(N'2025-07-14T22:30:13.660' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (749, 257, N'Обращение №2 от гражданина 257', N'Текст обращения от гражданина 257 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-08-02T19:30:13.660' AS DateTime), CAST(N'2025-08-15T10:30:13.660' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (750, 257, N'Обращение №3 от гражданина 257', N'Текст обращения от гражданина 257 по вопросу категории 3. Просьба принять меры.', 3, 2, 6, CAST(N'2025-10-17T19:30:13.663' AS DateTime), CAST(N'2025-11-13T16:30:13.663' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (751, 258, N'Обращение №1 от гражданина 258', N'Текст обращения от гражданина 258 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-07-09T19:30:13.663' AS DateTime), CAST(N'2025-08-08T18:30:13.663' AS DateTime), CAST(N'2025-07-19' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (752, 258, N'Обращение №2 от гражданина 258', N'Текст обращения от гражданина 258 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2026-01-31T19:30:13.663' AS DateTime), CAST(N'2026-02-18T19:30:13.663' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (753, 258, N'Обращение №3 от гражданина 258', N'Текст обращения от гражданина 258 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-11-09T19:30:13.663' AS DateTime), CAST(N'2025-11-11T14:30:13.663' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (754, 258, N'Обращение №4 от гражданина 258', N'Текст обращения от гражданина 258 по вопросу категории 5. Просьба принять меры.', 5, 2, 4, CAST(N'2025-07-08T19:30:13.663' AS DateTime), CAST(N'2025-08-01T08:30:13.663' AS DateTime), CAST(N'2025-07-18' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (755, 259, N'Обращение №1 от гражданина 259', N'Текст обращения от гражданина 259 по вопросу категории 5. Просьба принять меры.', 5, 2, 5, CAST(N'2025-07-18T19:30:13.663' AS DateTime), CAST(N'2025-07-26T05:30:13.663' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (756, 259, N'Обращение №2 от гражданина 259', N'Текст обращения от гражданина 259 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2026-03-12T19:30:13.667' AS DateTime), CAST(N'2026-03-17T03:30:13.667' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (757, 259, N'Обращение №3 от гражданина 259', N'Текст обращения от гражданина 259 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-10-08T19:30:13.667' AS DateTime), CAST(N'2025-10-24T22:30:13.667' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (758, 260, N'Обращение №1 от гражданина 260', N'Текст обращения от гражданина 260 по вопросу категории 4. Просьба принять меры.', 4, 2, 8, CAST(N'2025-12-16T19:30:13.667' AS DateTime), CAST(N'2025-12-25T04:30:13.667' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (759, 260, N'Обращение №2 от гражданина 260', N'Текст обращения от гражданина 260 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-06-11T19:30:13.667' AS DateTime), CAST(N'2025-07-08T06:30:13.667' AS DateTime), CAST(N'2025-06-21' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (760, 260, N'Обращение №3 от гражданина 260', N'Текст обращения от гражданина 260 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-05-28T19:30:13.667' AS DateTime), CAST(N'2025-06-21T03:30:13.667' AS DateTime), CAST(N'2025-06-07' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (761, 261, N'Обращение №1 от гражданина 261', N'Текст обращения от гражданина 261 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-06-13T19:30:13.670' AS DateTime), CAST(N'2025-07-11T14:30:13.670' AS DateTime), CAST(N'2025-06-23' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (762, 261, N'Обращение №2 от гражданина 261', N'Текст обращения от гражданина 261 по вопросу категории 2. Просьба принять меры.', 2, 2, 6, CAST(N'2025-10-11T19:30:13.670' AS DateTime), CAST(N'2025-10-21T10:30:13.670' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (763, 261, N'Обращение №3 от гражданина 261', N'Текст обращения от гражданина 261 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2026-02-11T19:30:13.670' AS DateTime), CAST(N'2026-03-06T00:30:13.670' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (764, 261, N'Обращение №4 от гражданина 261', N'Текст обращения от гражданина 261 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2026-03-25T19:30:13.670' AS DateTime), CAST(N'2026-04-16T10:30:13.670' AS DateTime), CAST(N'2026-04-04' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (765, 262, N'Обращение №1 от гражданина 262', N'Текст обращения от гражданина 262 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2026-01-14T19:30:13.670' AS DateTime), CAST(N'2026-02-10T11:30:13.670' AS DateTime), CAST(N'2026-01-24' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (766, 262, N'Обращение №2 от гражданина 262', N'Текст обращения от гражданина 262 по вопросу категории 4. Просьба принять меры.', 4, 2, 4, CAST(N'2025-06-21T19:30:13.670' AS DateTime), CAST(N'2025-07-09T03:30:13.670' AS DateTime), CAST(N'2025-07-01' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (767, 262, N'Обращение №3 от гражданина 262', N'Текст обращения от гражданина 262 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-08-23T19:30:13.670' AS DateTime), CAST(N'2025-09-20T18:30:13.670' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (768, 262, N'Обращение №4 от гражданина 262', N'Текст обращения от гражданина 262 по вопросу категории 2. Просьба принять меры.', 2, 2, 6, CAST(N'2026-04-04T19:30:13.670' AS DateTime), CAST(N'2026-04-22T17:30:13.670' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (769, 263, N'Обращение №1 от гражданина 263', N'Текст обращения от гражданина 263 по вопросу категории 2. Просьба принять меры.', 2, 2, 5, CAST(N'2026-05-18T19:30:13.670' AS DateTime), CAST(N'2026-06-13T01:30:13.670' AS DateTime), CAST(N'2026-05-28' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (770, 263, N'Обращение №2 от гражданина 263', N'Текст обращения от гражданина 263 по вопросу категории 5. Просьба принять меры.', 5, 2, 4, CAST(N'2025-07-17T19:30:13.673' AS DateTime), CAST(N'2025-07-30T07:30:13.673' AS DateTime), CAST(N'2025-07-27' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (771, 264, N'Обращение №1 от гражданина 264', N'Текст обращения от гражданина 264 по вопросу категории 3. Просьба принять меры.', 3, 2, 7, CAST(N'2026-04-13T19:30:13.673' AS DateTime), CAST(N'2026-05-09T14:30:13.673' AS DateTime), CAST(N'2026-04-23' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (772, 264, N'Обращение №2 от гражданина 264', N'Текст обращения от гражданина 264 по вопросу категории 2. Просьба принять меры.', 2, 2, 4, CAST(N'2025-06-25T19:30:13.673' AS DateTime), CAST(N'2025-07-20T16:30:13.673' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (773, 265, N'Обращение №1 от гражданина 265', N'Текст обращения от гражданина 265 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-09-09T19:30:13.673' AS DateTime), CAST(N'2025-09-25T02:30:13.673' AS DateTime), CAST(N'2025-09-19' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (774, 265, N'Обращение №2 от гражданина 265', N'Текст обращения от гражданина 265 по вопросу категории 5. Просьба принять меры.', 5, 2, 7, CAST(N'2026-05-08T19:30:13.673' AS DateTime), CAST(N'2026-05-09T08:30:13.673' AS DateTime), CAST(N'2026-05-18' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (775, 265, N'Обращение №3 от гражданина 265', N'Текст обращения от гражданина 265 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2026-03-14T19:30:13.673' AS DateTime), CAST(N'2026-03-26T21:30:13.673' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (776, 266, N'Обращение №1 от гражданина 266', N'Текст обращения от гражданина 266 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2026-02-25T19:30:13.677' AS DateTime), CAST(N'2026-02-28T06:30:13.677' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (777, 266, N'Обращение №2 от гражданина 266', N'Текст обращения от гражданина 266 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2026-01-31T19:30:13.677' AS DateTime), CAST(N'2026-02-03T23:30:13.677' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (778, 266, N'Обращение №3 от гражданина 266', N'Текст обращения от гражданина 266 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2026-04-06T19:30:13.677' AS DateTime), CAST(N'2026-04-12T14:30:13.677' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (779, 267, N'Обращение №1 от гражданина 267', N'Текст обращения от гражданина 267 по вопросу категории 2. Просьба принять меры.', 2, 2, 6, CAST(N'2026-04-16T19:30:13.677' AS DateTime), CAST(N'2026-04-19T20:30:13.677' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (780, 267, N'Обращение №2 от гражданина 267', N'Текст обращения от гражданина 267 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2026-01-06T19:30:13.677' AS DateTime), CAST(N'2026-01-22T22:30:13.677' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (781, 268, N'Обращение №1 от гражданина 268', N'Текст обращения от гражданина 268 по вопросу категории 1. Просьба принять меры.', 1, 2, 8, CAST(N'2025-06-24T19:30:13.677' AS DateTime), CAST(N'2025-06-25T10:30:13.677' AS DateTime), CAST(N'2025-07-04' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (782, 268, N'Обращение №2 от гражданина 268', N'Текст обращения от гражданина 268 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-07-07T19:30:13.680' AS DateTime), CAST(N'2025-08-03T10:30:13.680' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (783, 269, N'Обращение №1 от гражданина 269', N'Текст обращения от гражданина 269 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2026-05-01T19:30:13.680' AS DateTime), CAST(N'2026-05-23T13:30:13.680' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (784, 269, N'Обращение №2 от гражданина 269', N'Текст обращения от гражданина 269 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2026-01-12T19:30:13.680' AS DateTime), CAST(N'2026-01-17T14:30:13.680' AS DateTime), CAST(N'2026-01-22' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (785, 269, N'Обращение №3 от гражданина 269', N'Текст обращения от гражданина 269 по вопросу категории 2. Просьба принять меры.', 2, 2, 8, CAST(N'2025-11-04T19:30:13.680' AS DateTime), CAST(N'2025-12-03T06:30:13.680' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (786, 269, N'Обращение №4 от гражданина 269', N'Текст обращения от гражданина 269 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-11-21T19:30:13.680' AS DateTime), CAST(N'2025-12-06T16:30:13.680' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (787, 270, N'Обращение №1 от гражданина 270', N'Текст обращения от гражданина 270 по вопросу категории 2. Просьба принять меры.', 2, 2, 8, CAST(N'2025-12-27T19:30:13.680' AS DateTime), CAST(N'2026-01-25T11:30:13.680' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (788, 270, N'Обращение №2 от гражданина 270', N'Текст обращения от гражданина 270 по вопросу категории 4. Просьба принять меры.', 4, 2, 7, CAST(N'2026-04-22T19:30:13.680' AS DateTime), CAST(N'2026-05-21T04:30:13.680' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (789, 271, N'Обращение №1 от гражданина 271', N'Текст обращения от гражданина 271 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-12-21T19:30:13.683' AS DateTime), CAST(N'2026-01-02T19:30:13.683' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (790, 271, N'Обращение №2 от гражданина 271', N'Текст обращения от гражданина 271 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2026-02-23T19:30:13.683' AS DateTime), CAST(N'2026-03-20T18:30:13.683' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (791, 271, N'Обращение №3 от гражданина 271', N'Текст обращения от гражданина 271 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-06-17T19:30:13.683' AS DateTime), CAST(N'2025-07-08T22:30:13.683' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (792, 271, N'Обращение №4 от гражданина 271', N'Текст обращения от гражданина 271 по вопросу категории 4. Просьба принять меры.', 4, 2, 8, CAST(N'2025-08-11T19:30:13.683' AS DateTime), CAST(N'2025-09-07T10:30:13.683' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (793, 272, N'Обращение №1 от гражданина 272', N'Текст обращения от гражданина 272 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2026-04-12T19:30:13.683' AS DateTime), CAST(N'2026-04-21T20:30:13.683' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (794, 272, N'Обращение №2 от гражданина 272', N'Текст обращения от гражданина 272 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-06-07T19:30:13.683' AS DateTime), CAST(N'2025-06-25T08:30:13.683' AS DateTime), CAST(N'2025-06-17' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (795, 273, N'Обращение №1 от гражданина 273', N'Текст обращения от гражданина 273 по вопросу категории 3. Просьба принять меры.', 3, 2, 6, CAST(N'2026-02-20T19:30:13.687' AS DateTime), CAST(N'2026-02-23T02:30:13.687' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (796, 273, N'Обращение №2 от гражданина 273', N'Текст обращения от гражданина 273 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2026-01-17T19:30:13.687' AS DateTime), CAST(N'2026-02-07T05:30:13.687' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (797, 273, N'Обращение №3 от гражданина 273', N'Текст обращения от гражданина 273 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2026-04-14T19:30:13.687' AS DateTime), CAST(N'2026-04-15T10:30:13.687' AS DateTime), CAST(N'2026-04-24' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (798, 274, N'Обращение №1 от гражданина 274', N'Текст обращения от гражданина 274 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2026-01-17T19:30:13.687' AS DateTime), CAST(N'2026-01-18T14:30:13.687' AS DateTime), CAST(N'2026-01-27' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (799, 274, N'Обращение №2 от гражданина 274', N'Текст обращения от гражданина 274 по вопросу категории 2. Просьба принять меры.', 2, 2, 4, CAST(N'2025-11-17T19:30:13.687' AS DateTime), CAST(N'2025-12-15T12:30:13.687' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (800, 275, N'Обращение №1 от гражданина 275', N'Текст обращения от гражданина 275 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-08-03T19:30:13.690' AS DateTime), CAST(N'2025-08-11T22:30:13.690' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (801, 275, N'Обращение №2 от гражданина 275', N'Текст обращения от гражданина 275 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2026-02-17T19:30:13.690' AS DateTime), CAST(N'2026-03-14T21:30:13.690' AS DateTime), CAST(N'2026-02-27' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (802, 275, N'Обращение №3 от гражданина 275', N'Текст обращения от гражданина 275 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2026-04-26T19:30:13.690' AS DateTime), CAST(N'2026-05-09T00:30:13.690' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (803, 275, N'Обращение №4 от гражданина 275', N'Текст обращения от гражданина 275 по вопросу категории 2. Просьба принять меры.', 2, 2, 4, CAST(N'2026-02-02T19:30:13.690' AS DateTime), CAST(N'2026-02-13T15:30:13.690' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (804, 276, N'Обращение №1 от гражданина 276', N'Текст обращения от гражданина 276 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2026-01-06T19:30:13.690' AS DateTime), CAST(N'2026-01-22T09:30:13.690' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (805, 276, N'Обращение №2 от гражданина 276', N'Текст обращения от гражданина 276 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-07-22T19:30:13.690' AS DateTime), CAST(N'2025-08-20T06:30:13.690' AS DateTime), CAST(N'2025-08-01' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (806, 276, N'Обращение №3 от гражданина 276', N'Текст обращения от гражданина 276 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-12-21T19:30:13.690' AS DateTime), CAST(N'2026-01-11T20:30:13.690' AS DateTime), CAST(N'2025-12-31' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (807, 277, N'Обращение №1 от гражданина 277', N'Текст обращения от гражданина 277 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2026-04-02T19:30:13.690' AS DateTime), CAST(N'2026-04-26T14:30:13.690' AS DateTime), CAST(N'2026-04-12' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (808, 277, N'Обращение №2 от гражданина 277', N'Текст обращения от гражданина 277 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-10-06T19:30:13.690' AS DateTime), CAST(N'2025-10-16T06:30:13.690' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (809, 277, N'Обращение №3 от гражданина 277', N'Текст обращения от гражданина 277 по вопросу категории 4. Просьба принять меры.', 4, 2, 8, CAST(N'2026-01-10T19:30:13.690' AS DateTime), CAST(N'2026-02-04T21:30:13.690' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (810, 278, N'Обращение №1 от гражданина 278', N'Текст обращения от гражданина 278 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-12-08T19:30:13.693' AS DateTime), CAST(N'2025-12-24T10:30:13.693' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (811, 278, N'Обращение №2 от гражданина 278', N'Текст обращения от гражданина 278 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2026-05-12T19:30:13.693' AS DateTime), CAST(N'2026-05-20T01:30:13.693' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (812, 279, N'Обращение №1 от гражданина 279', N'Текст обращения от гражданина 279 по вопросу категории 2. Просьба принять меры.', 2, 2, 8, CAST(N'2025-06-30T19:30:13.693' AS DateTime), CAST(N'2025-07-02T10:30:13.693' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (813, 279, N'Обращение №2 от гражданина 279', N'Текст обращения от гражданина 279 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-10-30T19:30:13.693' AS DateTime), CAST(N'2025-11-23T16:30:13.693' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (814, 279, N'Обращение №3 от гражданина 279', N'Текст обращения от гражданина 279 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-10-18T19:30:13.693' AS DateTime), CAST(N'2025-10-21T20:30:13.693' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (815, 280, N'Обращение №1 от гражданина 280', N'Текст обращения от гражданина 280 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-12-04T19:30:13.697' AS DateTime), CAST(N'2025-12-05T02:30:13.697' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (816, 280, N'Обращение №2 от гражданина 280', N'Текст обращения от гражданина 280 по вопросу категории 3. Просьба принять меры.', 3, 2, 4, CAST(N'2025-11-30T19:30:13.697' AS DateTime), CAST(N'2025-12-17T14:30:13.697' AS DateTime), CAST(N'2025-12-10' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (817, 280, N'Обращение №3 от гражданина 280', N'Текст обращения от гражданина 280 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-09-25T19:30:13.697' AS DateTime), CAST(N'2025-10-15T13:30:13.697' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (818, 281, N'Обращение №1 от гражданина 281', N'Текст обращения от гражданина 281 по вопросу категории 2. Просьба принять меры.', 2, 2, 4, CAST(N'2026-04-28T19:30:13.697' AS DateTime), CAST(N'2026-05-12T14:30:13.697' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (819, 281, N'Обращение №2 от гражданина 281', N'Текст обращения от гражданина 281 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-12-15T19:30:13.697' AS DateTime), CAST(N'2026-01-12T18:30:13.697' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (820, 281, N'Обращение №3 от гражданина 281', N'Текст обращения от гражданина 281 по вопросу категории 4. Просьба принять меры.', 4, 2, 6, CAST(N'2025-09-17T19:30:13.697' AS DateTime), CAST(N'2025-09-28T10:30:13.697' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (821, 281, N'Обращение №4 от гражданина 281', N'Текст обращения от гражданина 281 по вопросу категории 2. Просьба принять меры.', 2, 2, 8, CAST(N'2025-11-11T19:30:13.697' AS DateTime), CAST(N'2025-12-07T09:30:13.697' AS DateTime), CAST(N'2025-11-21' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (822, 282, N'Обращение №1 от гражданина 282', N'Текст обращения от гражданина 282 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-05-28T19:30:13.700' AS DateTime), CAST(N'2025-06-13T05:30:13.700' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (823, 282, N'Обращение №2 от гражданина 282', N'Текст обращения от гражданина 282 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2026-02-01T19:30:13.700' AS DateTime), CAST(N'2026-02-06T11:30:13.700' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (824, 283, N'Обращение №1 от гражданина 283', N'Текст обращения от гражданина 283 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2026-01-05T19:30:13.700' AS DateTime), CAST(N'2026-02-02T17:30:13.700' AS DateTime), CAST(N'2026-01-15' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (825, 283, N'Обращение №2 от гражданина 283', N'Текст обращения от гражданина 283 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2026-02-14T19:30:13.700' AS DateTime), CAST(N'2026-02-22T03:30:13.700' AS DateTime), CAST(N'2026-02-24' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (826, 283, N'Обращение №3 от гражданина 283', N'Текст обращения от гражданина 283 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2026-03-16T19:30:13.700' AS DateTime), CAST(N'2026-03-27T23:30:13.700' AS DateTime), CAST(N'2026-03-26' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (827, 284, N'Обращение №1 от гражданина 284', N'Текст обращения от гражданина 284 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2026-03-19T19:30:13.700' AS DateTime), CAST(N'2026-04-06T14:30:13.700' AS DateTime), CAST(N'2026-03-29' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (828, 284, N'Обращение №2 от гражданина 284', N'Текст обращения от гражданина 284 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-07-14T19:30:13.700' AS DateTime), CAST(N'2025-07-16T19:30:13.700' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (829, 284, N'Обращение №3 от гражданина 284', N'Текст обращения от гражданина 284 по вопросу категории 3. Просьба принять меры.', 3, 2, 7, CAST(N'2025-12-15T19:30:13.700' AS DateTime), CAST(N'2025-12-25T12:30:13.700' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (830, 284, N'Обращение №4 от гражданина 284', N'Текст обращения от гражданина 284 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2026-03-30T19:30:13.703' AS DateTime), CAST(N'2026-04-22T06:30:13.703' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (831, 285, N'Обращение №1 от гражданина 285', N'Текст обращения от гражданина 285 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-09-22T19:30:13.703' AS DateTime), CAST(N'2025-10-21T18:30:13.703' AS DateTime), CAST(N'2025-10-02' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (832, 285, N'Обращение №2 от гражданина 285', N'Текст обращения от гражданина 285 по вопросу категории 3. Просьба принять меры.', 3, 2, 8, CAST(N'2025-07-05T19:30:13.703' AS DateTime), CAST(N'2025-07-24T11:30:13.703' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (833, 285, N'Обращение №3 от гражданина 285', N'Текст обращения от гражданина 285 по вопросу категории 1. Просьба принять меры.', 1, 2, 7, CAST(N'2026-03-25T19:30:13.703' AS DateTime), CAST(N'2026-04-24T03:30:13.703' AS DateTime), CAST(N'2026-04-04' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (834, 286, N'Обращение №1 от гражданина 286', N'Текст обращения от гражданина 286 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-07-12T19:30:13.703' AS DateTime), CAST(N'2025-08-05T15:30:13.703' AS DateTime), CAST(N'2025-07-22' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (835, 286, N'Обращение №2 от гражданина 286', N'Текст обращения от гражданина 286 по вопросу категории 5. Просьба принять меры.', 5, 2, 6, CAST(N'2026-02-08T19:30:13.703' AS DateTime), CAST(N'2026-02-14T06:30:13.703' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (836, 287, N'Обращение №1 от гражданина 287', N'Текст обращения от гражданина 287 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-05-22T19:30:13.707' AS DateTime), CAST(N'2025-06-04T13:30:13.707' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (837, 287, N'Обращение №2 от гражданина 287', N'Текст обращения от гражданина 287 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-06-06T19:30:13.707' AS DateTime), CAST(N'2025-06-18T21:30:13.707' AS DateTime), CAST(N'2025-06-16' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (838, 288, N'Обращение №1 от гражданина 288', N'Текст обращения от гражданина 288 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-08-04T19:30:13.707' AS DateTime), CAST(N'2025-08-22T19:30:13.707' AS DateTime), CAST(N'2025-08-14' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (839, 288, N'Обращение №2 от гражданина 288', N'Текст обращения от гражданина 288 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-08-28T19:30:13.707' AS DateTime), CAST(N'2025-09-14T16:30:13.707' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (840, 288, N'Обращение №3 от гражданина 288', N'Текст обращения от гражданина 288 по вопросу категории 3. Просьба принять меры.', 3, 2, 6, CAST(N'2025-07-25T19:30:13.707' AS DateTime), CAST(N'2025-08-14T15:30:13.707' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (841, 288, N'Обращение №4 от гражданина 288', N'Текст обращения от гражданина 288 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-11-15T19:30:13.710' AS DateTime), CAST(N'2025-12-06T17:30:13.710' AS DateTime), CAST(N'2025-11-25' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (842, 289, N'Обращение №1 от гражданина 289', N'Текст обращения от гражданина 289 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-11-21T19:30:13.710' AS DateTime), CAST(N'2025-12-03T20:30:13.710' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (843, 289, N'Обращение №2 от гражданина 289', N'Текст обращения от гражданина 289 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-06-03T19:30:13.710' AS DateTime), CAST(N'2025-06-17T11:30:13.710' AS DateTime), CAST(N'2025-06-13' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (844, 290, N'Обращение №1 от гражданина 290', N'Текст обращения от гражданина 290 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-10-30T19:30:13.710' AS DateTime), CAST(N'2025-11-26T14:30:13.710' AS DateTime), CAST(N'2025-11-09' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (845, 290, N'Обращение №2 от гражданина 290', N'Текст обращения от гражданина 290 по вопросу категории 5. Просьба принять меры.', 5, 2, 7, CAST(N'2025-07-18T19:30:13.710' AS DateTime), CAST(N'2025-08-07T21:30:13.710' AS DateTime), CAST(N'2025-07-28' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (846, 291, N'Обращение №1 от гражданина 291', N'Текст обращения от гражданина 291 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-09-27T19:30:13.710' AS DateTime), CAST(N'2025-09-28T13:30:13.710' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (847, 291, N'Обращение №2 от гражданина 291', N'Текст обращения от гражданина 291 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2026-03-02T19:30:13.710' AS DateTime), CAST(N'2026-03-22T07:30:13.710' AS DateTime), CAST(N'2026-03-12' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (848, 292, N'Обращение №1 от гражданина 292', N'Текст обращения от гражданина 292 по вопросу категории 2. Просьба принять меры.', 2, 2, 6, CAST(N'2025-11-23T19:30:13.710' AS DateTime), CAST(N'2025-12-16T01:30:13.710' AS DateTime), CAST(N'2025-12-03' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (849, 292, N'Обращение №2 от гражданина 292', N'Текст обращения от гражданина 292 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-09-18T19:30:13.713' AS DateTime), CAST(N'2025-10-11T14:30:13.713' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (850, 293, N'Обращение №1 от гражданина 293', N'Текст обращения от гражданина 293 по вопросу категории 3. Просьба принять меры.', 3, 2, 6, CAST(N'2026-01-21T19:30:13.713' AS DateTime), CAST(N'2026-02-16T03:30:13.713' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (851, 293, N'Обращение №2 от гражданина 293', N'Текст обращения от гражданина 293 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2026-04-21T19:30:13.713' AS DateTime), CAST(N'2026-05-01T01:30:13.713' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (852, 293, N'Обращение №3 от гражданина 293', N'Текст обращения от гражданина 293 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2026-01-10T19:30:13.713' AS DateTime), CAST(N'2026-01-28T09:30:13.713' AS DateTime), CAST(N'2026-01-20' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (853, 293, N'Обращение №4 от гражданина 293', N'Текст обращения от гражданина 293 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2026-04-12T19:30:13.713' AS DateTime), CAST(N'2026-04-19T00:30:13.713' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (854, 294, N'Обращение №1 от гражданина 294', N'Текст обращения от гражданина 294 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2026-04-30T19:30:13.713' AS DateTime), CAST(N'2026-05-29T21:30:13.713' AS DateTime), CAST(N'2026-05-10' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (855, 294, N'Обращение №2 от гражданина 294', N'Текст обращения от гражданина 294 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-12-15T19:30:13.713' AS DateTime), CAST(N'2025-12-30T14:30:13.713' AS DateTime), CAST(N'2025-12-25' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (856, 294, N'Обращение №3 от гражданина 294', N'Текст обращения от гражданина 294 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-09-23T19:30:13.713' AS DateTime), CAST(N'2025-10-09T09:30:13.713' AS DateTime), CAST(N'2025-10-03' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (857, 295, N'Обращение №1 от гражданина 295', N'Текст обращения от гражданина 295 по вопросу категории 5. Просьба принять меры.', 5, 2, 8, CAST(N'2026-05-03T19:30:13.717' AS DateTime), CAST(N'2026-05-06T05:30:13.717' AS DateTime), CAST(N'2026-05-13' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (858, 295, N'Обращение №2 от гражданина 295', N'Текст обращения от гражданина 295 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2026-04-20T19:30:13.717' AS DateTime), CAST(N'2026-05-18T20:30:13.717' AS DateTime), CAST(N'2026-04-30' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (859, 295, N'Обращение №3 от гражданина 295', N'Текст обращения от гражданина 295 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-08-08T19:30:13.717' AS DateTime), CAST(N'2025-09-05T14:30:13.717' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (860, 295, N'Обращение №4 от гражданина 295', N'Текст обращения от гражданина 295 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2026-03-17T19:30:13.717' AS DateTime), CAST(N'2026-03-25T01:30:13.717' AS DateTime), CAST(N'2026-03-27' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (861, 296, N'Обращение №1 от гражданина 296', N'Текст обращения от гражданина 296 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2026-01-01T19:30:13.717' AS DateTime), CAST(N'2026-01-30T12:30:13.717' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (862, 296, N'Обращение №2 от гражданина 296', N'Текст обращения от гражданина 296 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-10-17T19:30:13.717' AS DateTime), CAST(N'2025-10-19T15:30:13.717' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (863, 297, N'Обращение №1 от гражданина 297', N'Текст обращения от гражданина 297 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2026-01-05T19:30:13.720' AS DateTime), CAST(N'2026-01-20T05:30:13.720' AS DateTime), CAST(N'2026-01-15' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (864, 297, N'Обращение №2 от гражданина 297', N'Текст обращения от гражданина 297 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-12-14T19:30:13.720' AS DateTime), CAST(N'2026-01-08T06:30:13.720' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (865, 298, N'Обращение №1 от гражданина 298', N'Текст обращения от гражданина 298 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-08-19T19:30:13.720' AS DateTime), CAST(N'2025-09-11T04:30:13.720' AS DateTime), CAST(N'2025-08-29' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (866, 298, N'Обращение №2 от гражданина 298', N'Текст обращения от гражданина 298 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2026-02-26T19:30:13.720' AS DateTime), CAST(N'2026-03-03T13:30:13.720' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (867, 299, N'Обращение №1 от гражданина 299', N'Текст обращения от гражданина 299 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-11-20T19:30:13.720' AS DateTime), CAST(N'2025-12-12T14:30:13.720' AS DateTime), CAST(N'2025-11-30' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (868, 299, N'Обращение №2 от гражданина 299', N'Текст обращения от гражданина 299 по вопросу категории 2. Просьба принять меры.', 2, 2, 8, CAST(N'2026-04-03T19:30:13.720' AS DateTime), CAST(N'2026-04-25T05:30:13.720' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (869, 299, N'Обращение №3 от гражданина 299', N'Текст обращения от гражданина 299 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2026-04-12T19:30:13.720' AS DateTime), CAST(N'2026-04-28T00:30:13.720' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (870, 299, N'Обращение №4 от гражданина 299', N'Текст обращения от гражданина 299 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-11-29T19:30:13.720' AS DateTime), CAST(N'2025-12-15T23:30:13.720' AS DateTime), CAST(N'2025-12-09' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (871, 300, N'Обращение №1 от гражданина 300', N'Текст обращения от гражданина 300 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-10-22T19:30:13.720' AS DateTime), CAST(N'2025-11-05T21:30:13.720' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (872, 300, N'Обращение №2 от гражданина 300', N'Текст обращения от гражданина 300 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-09-21T19:30:13.723' AS DateTime), CAST(N'2025-10-01T01:30:13.723' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (873, 300, N'Обращение №3 от гражданина 300', N'Текст обращения от гражданина 300 по вопросу категории 5. Просьба принять меры.', 5, 2, 8, CAST(N'2025-11-22T19:30:13.723' AS DateTime), CAST(N'2025-11-23T18:30:13.723' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (874, 301, N'Обращение №1 от гражданина 301', N'Текст обращения от гражданина 301 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2026-04-18T19:30:13.723' AS DateTime), CAST(N'2026-05-15T06:30:13.723' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (875, 301, N'Обращение №2 от гражданина 301', N'Текст обращения от гражданина 301 по вопросу категории 2. Просьба принять меры.', 2, 2, 4, CAST(N'2026-01-22T19:30:13.723' AS DateTime), CAST(N'2026-02-15T08:30:13.723' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (876, 301, N'Обращение №3 от гражданина 301', N'Текст обращения от гражданина 301 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2026-03-20T19:30:13.723' AS DateTime), CAST(N'2026-03-28T03:30:13.723' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (877, 302, N'Обращение №1 от гражданина 302', N'Текст обращения от гражданина 302 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2026-05-09T19:30:13.727' AS DateTime), CAST(N'2026-05-19T10:30:13.727' AS DateTime), CAST(N'2026-05-19' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (878, 302, N'Обращение №2 от гражданина 302', N'Текст обращения от гражданина 302 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2026-05-16T19:30:13.727' AS DateTime), CAST(N'2026-05-26T19:30:13.727' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (879, 303, N'Обращение №1 от гражданина 303', N'Текст обращения от гражданина 303 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-08-09T19:30:13.727' AS DateTime), CAST(N'2025-08-22T04:30:13.727' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (880, 303, N'Обращение №2 от гражданина 303', N'Текст обращения от гражданина 303 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-07-15T19:30:13.727' AS DateTime), CAST(N'2025-07-18T18:30:13.727' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (881, 303, N'Обращение №3 от гражданина 303', N'Текст обращения от гражданина 303 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-05-28T19:30:13.727' AS DateTime), CAST(N'2025-06-08T01:30:13.727' AS DateTime), CAST(N'2025-06-07' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (882, 303, N'Обращение №4 от гражданина 303', N'Текст обращения от гражданина 303 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-07-15T19:30:13.727' AS DateTime), CAST(N'2025-08-05T08:30:13.727' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (883, 304, N'Обращение №1 от гражданина 304', N'Текст обращения от гражданина 304 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-07-19T19:30:13.730' AS DateTime), CAST(N'2025-08-12T01:30:13.730' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (884, 304, N'Обращение №2 от гражданина 304', N'Текст обращения от гражданина 304 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-05-25T19:30:13.730' AS DateTime), CAST(N'2025-06-18T18:30:13.730' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (885, 304, N'Обращение №3 от гражданина 304', N'Текст обращения от гражданина 304 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-10-14T19:30:13.730' AS DateTime), CAST(N'2025-10-17T10:30:13.730' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (886, 304, N'Обращение №4 от гражданина 304', N'Текст обращения от гражданина 304 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-05-25T19:30:13.730' AS DateTime), CAST(N'2025-06-08T18:30:13.730' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (887, 305, N'Обращение №1 от гражданина 305', N'Текст обращения от гражданина 305 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-07-03T19:30:13.730' AS DateTime), CAST(N'2025-07-19T19:30:13.730' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (888, 305, N'Обращение №2 от гражданина 305', N'Текст обращения от гражданина 305 по вопросу категории 3. Просьба принять меры.', 3, 1, NULL, CAST(N'2025-12-13T19:30:13.730' AS DateTime), CAST(N'2025-12-13T23:30:13.730' AS DateTime), CAST(N'2025-12-23' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (889, 306, N'Обращение №1 от гражданина 306', N'Текст обращения от гражданина 306 по вопросу категории 1. Просьба принять меры.', 1, 2, 4, CAST(N'2025-08-08T19:30:13.730' AS DateTime), CAST(N'2025-08-19T18:30:13.730' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (890, 306, N'Обращение №2 от гражданина 306', N'Текст обращения от гражданина 306 по вопросу категории 1. Просьба принять меры.', 1, 1, NULL, CAST(N'2025-10-23T19:30:13.730' AS DateTime), CAST(N'2025-11-18T00:30:13.730' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (891, 306, N'Обращение №3 от гражданина 306', N'Текст обращения от гражданина 306 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-07-28T19:30:13.730' AS DateTime), CAST(N'2025-08-09T13:30:13.730' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (892, 306, N'Обращение №4 от гражданина 306', N'Текст обращения от гражданина 306 по вопросу категории 3. Просьба принять меры.', 3, 2, 5, CAST(N'2026-02-08T19:30:13.730' AS DateTime), CAST(N'2026-02-19T03:30:13.730' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (893, 307, N'Обращение №1 от гражданина 307', N'Текст обращения от гражданина 307 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2025-09-28T19:30:13.733' AS DateTime), CAST(N'2025-10-28T14:30:13.733' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (894, 307, N'Обращение №2 от гражданина 307', N'Текст обращения от гражданина 307 по вопросу категории 3. Просьба принять меры.', 3, 2, 8, CAST(N'2026-04-17T19:30:13.733' AS DateTime), CAST(N'2026-05-05T06:30:13.733' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (895, 307, N'Обращение №3 от гражданина 307', N'Текст обращения от гражданина 307 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2025-07-19T19:30:13.733' AS DateTime), CAST(N'2025-08-07T13:30:13.733' AS DateTime), CAST(N'2025-07-29' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (896, 308, N'Обращение №1 от гражданина 308', N'Текст обращения от гражданина 308 по вопросу категории 2. Просьба принять меры.', 2, 1, NULL, CAST(N'2025-12-16T19:30:13.733' AS DateTime), CAST(N'2026-01-05T02:30:13.733' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (897, 308, N'Обращение №2 от гражданина 308', N'Текст обращения от гражданина 308 по вопросу категории 4. Просьба принять меры.', 4, 1, NULL, CAST(N'2026-03-11T19:30:13.733' AS DateTime), CAST(N'2026-04-06T17:30:13.733' AS DateTime), CAST(N'2026-03-21' AS Date))
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (898, 308, N'Обращение №3 от гражданина 308', N'Текст обращения от гражданина 308 по вопросу категории 1. Просьба принять меры.', 1, 2, 4, CAST(N'2026-05-06T19:30:13.733' AS DateTime), CAST(N'2026-06-01T10:30:13.733' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (899, 308, N'Обращение №4 от гражданина 308', N'Текст обращения от гражданина 308 по вопросу категории 5. Просьба принять меры.', 5, 1, NULL, CAST(N'2026-01-29T19:30:13.737' AS DateTime), CAST(N'2026-02-02T21:30:13.737' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (900, 309, N'почему ', N'вопрос?', 5, 2, 4, CAST(N'2026-05-20T21:25:46.530' AS DateTime), CAST(N'2026-05-20T21:30:11.793' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (901, 79, N'ffdfdfd', N'dfdfdfd', 2, 5, NULL, CAST(N'2026-05-20T21:32:33.700' AS DateTime), CAST(N'2026-05-23T10:14:42.057' AS DateTime), NULL)
GO
INSERT [dbo].[Appeal] ([AppealID], [AuthorID], [Title], [Description], [CategoryID], [StatusID], [AssignedToID], [CreatedAt], [UpdatedAt], [DueDate]) VALUES (1900, 9, N'ывыв', N'', 2, 1, NULL, CAST(N'2026-05-23T14:54:15.953' AS DateTime), CAST(N'2026-05-23T14:54:15.953' AS DateTime), NULL)
GO
SET IDENTITY_INSERT [dbo].[Appeal] OFF
GO
SET IDENTITY_INSERT [dbo].[AppealHistory] ON 
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (2, 2, 9, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-27T19:30:12.867' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (3, 3, 9, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-12T19:30:12.867' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (4, 4, 9, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-22T19:30:12.867' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (5, 4, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2026-03-22T19:35:12.867' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (6, 5, 10, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-12T19:30:12.870' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (7, 6, 10, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-13T19:30:12.870' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (8, 6, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2025-10-13T19:35:12.870' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (9, 7, 11, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-13T19:30:12.870' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (10, 8, 11, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-09T19:30:12.870' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (11, 9, 12, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-26T19:30:12.870' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (12, 9, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2026-03-26T19:35:12.870' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (13, 10, 12, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-21T19:30:12.870' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (14, 11, 12, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-06T19:30:12.873' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (15, 12, 13, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-02T19:30:12.873' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (16, 13, 13, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-18T19:30:12.873' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (17, 14, 14, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-02T19:30:12.873' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (18, 15, 14, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-02T19:30:12.873' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (19, 15, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2026-03-02T19:35:12.873' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (20, 16, 14, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-02T19:30:12.873' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (21, 17, 15, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-20T19:30:12.877' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (22, 17, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2026-05-20T19:35:12.877' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (23, 18, 15, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-09T19:30:12.877' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (24, 18, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=5', CAST(N'2025-10-09T19:35:12.877' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (25, 19, 15, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-02T19:30:12.877' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (26, 20, 15, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-03T19:30:12.877' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (27, 21, 16, N'Создано', N'Обращение подано через портал', CAST(N'2025-05-23T19:30:12.877' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (28, 22, 16, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-05T19:30:12.877' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (29, 22, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2026-05-05T19:35:12.877' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (30, 23, 16, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-24T19:30:12.880' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (31, 24, 16, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-14T19:30:12.880' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (32, 25, 17, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-17T19:30:12.880' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (33, 25, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=5', CAST(N'2025-07-17T19:35:12.880' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (34, 26, 17, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-18T19:30:12.880' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (35, 26, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2025-12-18T19:35:12.880' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (36, 27, 18, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-01T19:30:12.880' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (37, 28, 18, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-19T19:30:12.880' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (38, 29, 19, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-24T19:30:12.880' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (39, 30, 19, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-12T19:30:12.880' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (40, 31, 19, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-17T19:30:12.883' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (41, 31, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2026-03-17T19:35:12.883' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (42, 32, 19, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-30T19:30:12.883' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (43, 33, 20, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-13T19:30:12.883' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (44, 33, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2025-10-13T19:35:12.883' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (45, 34, 20, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-06T19:30:12.887' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (46, 35, 21, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-13T19:30:12.887' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (47, 36, 21, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-24T19:30:12.887' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (48, 37, 21, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-07T19:30:12.887' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (49, 38, 22, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-07T19:30:12.887' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (50, 39, 22, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-16T19:30:12.887' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (51, 40, 22, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-29T19:30:12.887' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (52, 41, 22, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-15T19:30:12.887' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (53, 42, 23, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-13T19:30:12.890' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (54, 43, 23, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-31T19:30:12.890' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (55, 44, 23, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-19T19:30:12.890' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (56, 45, 24, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-01T19:30:12.890' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (57, 46, 24, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-04T19:30:12.890' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (58, 47, 24, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-25T19:30:12.890' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (59, 48, 25, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-27T19:30:12.890' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (60, 48, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2025-08-27T19:35:12.890' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (61, 49, 25, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-17T19:30:12.890' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (62, 49, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=4', CAST(N'2025-10-17T19:35:12.890' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (63, 50, 25, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-15T19:30:12.893' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (64, 51, 26, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-23T19:30:12.893' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (65, 52, 26, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-07T19:30:12.893' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (66, 53, 26, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-20T19:30:12.893' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (67, 54, 27, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-27T19:30:12.893' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (68, 54, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=4', CAST(N'2026-04-27T19:35:12.893' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (69, 55, 27, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-11T19:30:12.893' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (70, 56, 28, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-30T19:30:12.897' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (71, 57, 28, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-17T19:30:12.897' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (72, 58, 29, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-17T19:30:12.897' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (73, 58, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2026-01-17T19:35:12.897' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (74, 59, 29, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-04T19:30:12.897' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (75, 60, 29, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-11T19:30:12.897' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (76, 61, 29, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-09T19:30:12.897' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (77, 62, 30, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-02T19:30:12.900' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (78, 63, 30, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-14T19:30:12.900' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (79, 64, 31, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-19T19:30:12.900' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (80, 65, 31, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-24T19:30:12.900' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (81, 65, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2026-03-24T19:35:12.900' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (82, 66, 31, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-18T19:30:12.900' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (83, 67, 32, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-14T19:30:12.900' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (84, 68, 32, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-01T19:30:12.900' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (85, 68, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2025-11-01T19:35:12.900' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (86, 69, 32, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-03T19:30:12.900' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (87, 70, 32, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-14T19:30:12.900' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (88, 71, 33, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-12T19:30:12.903' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (89, 72, 33, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-02T19:30:12.903' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (90, 73, 34, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-13T19:30:13.073' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (91, 74, 34, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-31T19:30:13.073' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (92, 75, 35, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-20T19:30:13.077' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (93, 75, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2025-08-20T19:35:13.077' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (94, 76, 35, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-12T19:30:13.077' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (95, 77, 36, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-14T19:30:13.077' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (96, 78, 36, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-06T19:30:13.077' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (97, 79, 37, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-27T19:30:13.077' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (98, 79, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=5', CAST(N'2025-12-27T19:35:13.077' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (99, 80, 37, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-06T19:30:13.080' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (100, 81, 37, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-14T19:30:13.080' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (101, 81, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2026-01-14T19:35:13.080' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (102, 82, 38, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-01T19:30:13.080' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (103, 82, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2025-12-01T19:35:13.080' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (104, 83, 38, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-06T19:30:13.080' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (105, 84, 38, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-18T19:30:13.080' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (106, 84, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=4', CAST(N'2025-12-18T19:35:13.080' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (107, 85, 38, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-09T19:30:13.080' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (108, 86, 39, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-06T19:30:13.080' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (109, 87, 39, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-26T19:30:13.083' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (110, 87, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2026-02-26T19:35:13.083' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (111, 88, 39, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-07T19:30:13.083' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (112, 88, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=4', CAST(N'2025-09-07T19:35:13.083' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (113, 89, 40, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-30T19:30:13.083' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (114, 90, 40, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-30T19:30:13.083' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (115, 91, 41, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-31T19:30:13.083' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (116, 92, 41, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-19T19:30:13.083' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (117, 93, 42, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-21T19:30:13.087' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (118, 93, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2025-07-21T19:35:13.087' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (119, 94, 42, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-18T19:30:13.087' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (120, 95, 42, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-06T19:30:13.087' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (121, 95, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2025-06-06T19:35:13.087' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (122, 96, 42, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-22T19:30:13.087' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (123, 97, 43, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-07T19:30:13.087' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (124, 97, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2025-10-07T19:35:13.087' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (125, 98, 43, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-23T19:30:13.087' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (126, 98, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2025-09-23T19:35:13.087' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (127, 99, 43, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-13T19:30:13.090' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (128, 99, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=4', CAST(N'2025-11-13T19:35:13.090' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (129, 100, 44, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-09T19:30:13.090' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (130, 101, 44, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-03T19:30:13.090' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (131, 102, 45, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-18T19:30:13.090' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (132, 103, 45, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-31T19:30:13.090' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (133, 103, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2026-03-31T19:35:13.090' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (134, 104, 45, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-15T19:30:13.090' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (135, 104, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2025-07-15T19:35:13.090' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (136, 105, 45, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-20T19:30:13.093' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (137, 106, 46, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-31T19:30:13.093' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (138, 107, 46, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-23T19:30:13.093' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (139, 108, 46, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-03T19:30:13.093' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (140, 109, 46, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-07T19:30:13.263' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (141, 110, 47, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-15T19:30:13.263' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (142, 111, 47, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-01T19:30:13.267' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (143, 112, 48, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-06T19:30:13.267' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (144, 113, 48, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-09T19:30:13.267' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (145, 114, 48, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-19T19:30:13.267' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (146, 115, 49, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-29T19:30:13.267' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (147, 116, 49, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-07T19:30:13.270' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (148, 117, 49, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-26T19:30:13.270' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (149, 118, 49, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-17T19:30:13.270' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (150, 119, 50, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-12T19:30:13.270' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (151, 120, 50, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-13T19:30:13.270' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (152, 121, 51, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-30T19:30:13.270' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (153, 121, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=4', CAST(N'2025-06-30T19:35:13.270' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (154, 122, 51, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-18T19:30:13.270' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (155, 122, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=5', CAST(N'2025-07-18T19:35:13.270' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (156, 123, 51, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-09T19:30:13.270' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (157, 124, 51, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-04T19:30:13.273' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (158, 125, 52, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-09T19:30:13.273' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (159, 126, 52, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-07T19:30:13.273' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (160, 127, 52, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-14T19:30:13.273' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (161, 128, 53, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-28T19:30:13.273' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (162, 129, 53, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-04T19:30:13.273' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (163, 129, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=5', CAST(N'2025-08-04T19:35:13.273' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (164, 130, 53, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-01T19:30:13.273' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (165, 131, 53, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-14T19:30:13.277' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (166, 132, 54, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-27T19:30:13.277' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (167, 132, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2025-12-27T19:35:13.277' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (168, 133, 54, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-04T19:30:13.277' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (169, 133, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=5', CAST(N'2025-07-04T19:35:13.277' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (170, 134, 54, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-14T19:30:13.277' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (171, 135, 55, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-01T19:30:13.277' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (172, 136, 55, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-09T19:30:13.277' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (173, 137, 55, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-13T19:30:13.280' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (174, 137, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2025-09-13T19:35:13.280' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (175, 138, 55, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-10T19:30:13.280' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (176, 139, 56, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-02T19:30:13.280' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (177, 140, 56, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-26T19:30:13.280' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (178, 141, 56, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-02T19:30:13.280' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (179, 141, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2026-04-02T19:35:13.280' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (180, 142, 56, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-12T19:30:13.280' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (181, 142, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2026-05-12T19:35:13.280' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (182, 143, 57, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-16T19:30:13.280' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (183, 144, 57, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-18T19:30:13.283' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (184, 144, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2026-02-18T19:35:13.283' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (185, 145, 57, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-06T19:30:13.327' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (186, 145, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2025-06-06T19:35:13.327' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (187, 146, 57, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-07T19:30:13.327' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (188, 147, 58, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-23T19:30:13.327' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (189, 148, 58, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-25T19:30:13.327' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (190, 148, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=4', CAST(N'2026-02-25T19:35:13.327' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (191, 149, 58, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-29T19:30:13.330' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (192, 150, 58, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-15T19:30:13.330' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (193, 151, 59, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-14T19:30:13.330' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (194, 151, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=4', CAST(N'2025-09-14T19:35:13.330' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (195, 152, 59, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-27T19:30:13.330' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (196, 152, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2025-08-27T19:35:13.330' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (197, 153, 60, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-03T19:30:13.330' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (198, 154, 60, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-22T19:30:13.330' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (199, 155, 61, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-04T19:30:13.330' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (200, 156, 61, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-16T19:30:13.330' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (201, 157, 62, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-14T19:30:13.333' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (202, 158, 62, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-28T19:30:13.333' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (203, 159, 63, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-17T19:30:13.333' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (204, 160, 63, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-02T19:30:13.333' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (205, 161, 63, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-03T19:30:13.333' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (206, 162, 64, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-09T19:30:13.333' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (207, 163, 64, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-04T19:30:13.333' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (208, 163, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2026-01-04T19:35:13.333' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (209, 164, 64, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-31T19:30:13.337' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (210, 165, 64, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-07T19:30:13.337' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (211, 166, 65, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-12T19:30:13.337' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (212, 167, 65, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-04T19:30:13.337' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (213, 168, 66, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-14T19:30:13.337' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (214, 168, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=5', CAST(N'2025-09-14T19:35:13.337' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (215, 169, 66, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-28T19:30:13.337' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (216, 170, 66, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-03T19:30:13.340' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (217, 171, 67, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-17T19:30:13.340' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (218, 172, 67, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-06T19:30:13.340' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (219, 173, 67, N'Создано', N'Обращение подано через портал', CAST(N'2025-05-31T19:30:13.340' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (220, 174, 68, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-08T19:30:13.340' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (221, 175, 68, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-01T19:30:13.340' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (222, 175, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=4', CAST(N'2025-10-01T19:35:13.340' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (223, 176, 68, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-16T19:30:13.340' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (224, 177, 68, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-19T19:30:13.340' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (225, 178, 69, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-08T19:30:13.340' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (226, 178, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2026-02-08T19:35:13.340' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (227, 179, 69, N'Создано', N'Обращение подано через портал', CAST(N'2025-05-22T19:30:13.343' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (228, 180, 69, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-26T19:30:13.343' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (229, 181, 70, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-28T19:30:13.343' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (230, 182, 70, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-22T19:30:13.343' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (231, 183, 71, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-29T19:30:13.343' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (232, 183, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2026-01-29T19:35:13.343' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (233, 184, 71, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-25T19:30:13.347' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (234, 184, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2025-07-25T19:35:13.347' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (235, 185, 71, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-12T19:30:13.347' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (236, 186, 72, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-18T19:30:13.347' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (237, 186, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=5', CAST(N'2025-07-18T19:35:13.347' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (238, 187, 72, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-02T19:30:13.347' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (239, 188, 73, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-01T19:30:13.347' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (240, 189, 73, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-10T19:30:13.347' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (241, 190, 73, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-18T19:30:13.350' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (242, 190, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2025-09-18T19:35:13.350' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (243, 191, 74, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-28T19:30:13.350' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (244, 191, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2026-03-28T19:35:13.350' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (245, 192, 74, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-12T19:30:13.350' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (246, 193, 74, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-14T19:30:13.350' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (247, 193, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=5', CAST(N'2025-06-14T19:35:13.350' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (248, 194, 75, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-03T19:30:13.350' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (249, 194, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2025-12-03T19:35:13.350' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (250, 195, 75, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-23T19:30:13.350' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (251, 196, 75, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-21T19:30:13.350' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (252, 197, 75, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-24T19:30:13.350' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (253, 198, 76, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-06T19:30:13.353' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (254, 199, 76, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-04T19:30:13.353' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (255, 200, 76, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-08T19:30:13.353' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (256, 201, 77, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-28T19:30:13.353' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (257, 202, 77, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-12T19:30:13.353' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (258, 203, 78, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-03T19:30:13.353' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (259, 204, 78, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-11T19:30:13.353' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (260, 204, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2026-05-11T19:35:13.353' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (261, 205, 78, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-09T19:30:13.357' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (262, 205, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=5', CAST(N'2026-04-09T19:35:13.357' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (263, 206, 78, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-08T19:30:13.357' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (264, 206, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2026-03-08T19:35:13.357' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (265, 207, 79, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-22T19:30:13.357' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (266, 208, 79, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-27T19:30:13.357' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (267, 209, 80, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-30T19:30:13.357' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (268, 210, 80, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-19T19:30:13.357' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (269, 210, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=5', CAST(N'2025-09-19T19:35:13.357' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (270, 211, 81, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-01T19:30:13.360' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (271, 211, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2025-08-01T19:35:13.360' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (272, 212, 81, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-10T19:30:13.360' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (273, 213, 81, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-16T19:30:13.360' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (274, 214, 81, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-07T19:30:13.360' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (275, 215, 82, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-09T19:30:13.360' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (276, 215, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2025-08-09T19:35:13.360' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (277, 216, 82, N'Создано', N'Обращение подано через портал', CAST(N'2025-05-28T19:30:13.360' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (278, 216, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2025-05-28T19:35:13.360' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (279, 217, 82, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-13T19:30:13.363' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (280, 218, 82, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-07T19:30:13.363' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (281, 219, 83, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-08T19:30:13.363' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (282, 220, 83, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-26T19:30:13.363' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (283, 221, 84, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-11T19:30:13.363' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (284, 221, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2025-06-11T19:35:13.363' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (285, 222, 84, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-04T19:30:13.363' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (286, 223, 84, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-10T19:30:13.367' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (287, 224, 85, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-29T19:30:13.367' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (288, 225, 85, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-18T19:30:13.367' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (289, 226, 86, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-06T19:30:13.367' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (290, 226, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2026-04-06T19:35:13.367' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (291, 227, 86, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-12T19:30:13.367' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (292, 227, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2026-02-12T19:35:13.367' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (293, 228, 86, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-24T19:30:13.367' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (294, 228, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2026-02-24T19:35:13.367' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (295, 229, 86, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-17T19:30:13.370' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (296, 230, 87, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-14T19:30:13.370' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (297, 230, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=5', CAST(N'2025-06-14T19:35:13.370' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (298, 231, 87, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-25T19:30:13.370' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (299, 232, 88, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-03T19:30:13.370' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (300, 233, 88, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-16T19:30:13.370' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (301, 233, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2025-11-16T19:35:13.370' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (302, 234, 88, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-29T19:30:13.370' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (303, 234, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2025-06-29T19:35:13.370' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (304, 235, 89, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-05T19:30:13.370' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (305, 236, 89, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-16T19:30:13.370' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (306, 236, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2026-04-16T19:35:13.370' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (307, 237, 89, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-30T19:30:13.373' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (308, 237, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2025-12-30T19:35:13.373' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (309, 238, 89, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-14T19:30:13.373' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (310, 239, 90, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-29T19:30:13.373' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (311, 240, 90, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-21T19:30:13.373' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (312, 241, 90, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-18T19:30:13.373' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (313, 242, 90, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-23T19:30:13.373' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (314, 243, 91, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-12T19:30:13.377' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (315, 244, 91, N'Создано', N'Обращение подано через портал', CAST(N'2025-05-26T19:30:13.377' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (316, 245, 91, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-05T19:30:13.377' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (317, 246, 91, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-01T19:30:13.377' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (318, 246, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2025-09-01T19:35:13.377' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (319, 247, 92, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-05T19:30:13.377' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (320, 248, 92, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-05T19:30:13.380' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (321, 248, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=5', CAST(N'2025-07-05T19:35:13.380' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (322, 249, 93, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-23T19:30:13.380' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (323, 249, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=5', CAST(N'2025-08-23T19:35:13.380' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (324, 250, 93, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-29T19:30:13.380' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (325, 250, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2025-06-29T19:35:13.380' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (326, 251, 93, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-03T19:30:13.380' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (327, 252, 93, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-29T19:30:13.380' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (328, 253, 94, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-16T19:30:13.380' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (329, 254, 94, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-28T19:30:13.380' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (330, 254, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=5', CAST(N'2025-10-28T19:35:13.380' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (331, 255, 95, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-07T19:30:13.383' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (332, 256, 95, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-11T19:30:13.383' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (333, 257, 96, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-26T19:30:13.383' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (334, 258, 96, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-18T19:30:13.383' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (335, 259, 97, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-06T19:30:13.383' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (336, 260, 97, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-31T19:30:13.383' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (337, 261, 97, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-24T19:30:13.387' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (338, 262, 97, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-05T19:30:13.387' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (339, 263, 98, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-30T19:30:13.387' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (340, 264, 98, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-25T19:30:13.387' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (341, 264, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2025-07-25T19:35:13.387' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (342, 265, 98, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-22T19:30:13.387' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (343, 265, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2026-04-22T19:35:13.387' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (344, 266, 99, N'Создано', N'Обращение подано через портал', CAST(N'2025-05-23T19:30:13.387' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (345, 267, 99, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-11T19:30:13.390' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (346, 268, 99, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-25T19:30:13.390' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (347, 268, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2025-10-25T19:35:13.390' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (348, 269, 100, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-17T19:30:13.390' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (349, 270, 100, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-09T19:30:13.390' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (350, 271, 101, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-13T19:30:13.390' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (351, 272, 101, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-19T19:30:13.390' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (352, 273, 102, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-27T19:30:13.390' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (353, 273, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2025-12-27T19:35:13.390' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (354, 274, 102, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-08T19:30:13.390' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (355, 275, 103, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-09T19:30:13.393' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (356, 275, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2026-01-09T19:35:13.393' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (357, 276, 103, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-02T19:30:13.393' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (358, 276, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=5', CAST(N'2026-01-02T19:35:13.393' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (359, 277, 103, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-24T19:30:13.393' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (360, 278, 103, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-17T19:30:13.393' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (361, 279, 104, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-26T19:30:13.393' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (362, 280, 104, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-06T19:30:13.393' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (363, 280, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=5', CAST(N'2025-09-06T19:35:13.393' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (364, 281, 105, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-17T19:30:13.397' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (365, 282, 105, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-09T19:30:13.397' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (366, 283, 105, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-26T19:30:13.397' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (367, 284, 105, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-29T19:30:13.397' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (368, 284, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=4', CAST(N'2025-12-29T19:35:13.397' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (369, 285, 106, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-20T19:30:13.400' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (370, 285, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2025-07-20T19:35:13.400' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (371, 286, 106, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-17T19:30:13.400' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (372, 286, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2026-05-17T19:35:13.400' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (373, 287, 107, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-08T19:30:13.400' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (374, 287, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2026-04-08T19:35:13.400' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (375, 288, 107, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-16T19:30:13.400' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (376, 288, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2025-07-16T19:35:13.400' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (377, 289, 108, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-12T19:30:13.400' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (378, 289, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=4', CAST(N'2026-03-12T19:35:13.400' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (379, 290, 108, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-21T19:30:13.400' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (380, 291, 108, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-17T19:30:13.400' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (381, 292, 108, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-14T19:30:13.400' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (382, 293, 109, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-03T19:30:13.403' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (383, 294, 109, N'Создано', N'Обращение подано через портал', CAST(N'2025-05-26T19:30:13.403' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (384, 294, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2025-05-26T19:35:13.403' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (385, 295, 109, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-17T19:30:13.403' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (386, 295, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=4', CAST(N'2025-10-17T19:35:13.403' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (387, 296, 110, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-27T19:30:13.403' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (388, 296, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=5', CAST(N'2026-01-27T19:35:13.403' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (389, 297, 110, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-11T19:30:13.403' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (390, 298, 110, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-07T19:30:13.407' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (391, 299, 111, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-08T19:30:13.407' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (392, 300, 111, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-12T19:30:13.407' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (393, 301, 112, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-29T19:30:13.407' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (394, 302, 112, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-21T19:30:13.407' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (395, 303, 112, N'Создано', N'Обращение подано через портал', CAST(N'2025-05-24T19:30:13.407' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (396, 304, 113, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-17T19:30:13.410' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (397, 305, 113, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-01T19:30:13.410' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (398, 306, 113, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-12T19:30:13.410' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (399, 307, 114, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-23T19:30:13.410' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (400, 308, 114, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-18T19:30:13.410' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (401, 308, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2026-04-18T19:35:13.410' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (402, 309, 115, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-13T19:30:13.410' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (403, 309, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=5', CAST(N'2025-07-13T19:35:13.410' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (404, 310, 115, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-05T19:30:13.410' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (405, 311, 115, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-28T19:30:13.410' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (406, 312, 116, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-13T19:30:13.413' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (407, 313, 116, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-22T19:30:13.413' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (408, 314, 116, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-28T19:30:13.413' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (409, 314, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2025-07-28T19:35:13.413' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (410, 315, 116, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-12T19:30:13.413' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (411, 315, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2025-10-12T19:35:13.413' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (412, 316, 117, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-19T19:30:13.413' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (413, 316, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=4', CAST(N'2026-01-19T19:35:13.413' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (414, 317, 117, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-13T19:30:13.413' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (415, 317, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2025-08-13T19:35:13.413' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (416, 318, 117, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-01T19:30:13.417' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (417, 318, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2026-02-01T19:35:13.417' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (418, 319, 117, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-28T19:30:13.417' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (419, 319, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2026-03-28T19:35:13.417' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (420, 320, 118, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-10T19:30:13.417' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (421, 321, 118, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-14T19:30:13.417' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (422, 322, 118, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-24T19:30:13.417' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (423, 323, 118, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-01T19:30:13.417' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (424, 324, 119, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-18T19:30:13.420' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (425, 325, 119, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-22T19:30:13.420' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (426, 325, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2025-11-22T19:35:13.420' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (427, 326, 120, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-25T19:30:13.420' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (428, 327, 120, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-14T19:30:13.420' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (429, 327, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2026-05-14T19:35:13.420' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (430, 328, 121, N'Создано', N'Обращение подано через портал', CAST(N'2025-05-27T19:30:13.420' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (431, 329, 121, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-17T19:30:13.420' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (432, 329, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2025-11-17T19:35:13.420' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (433, 330, 122, N'Создано', N'Обращение подано через портал', CAST(N'2025-05-28T19:30:13.420' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (434, 331, 122, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-04T19:30:13.420' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (435, 332, 122, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-12T19:30:13.423' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (436, 333, 123, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-08T19:30:13.423' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (437, 333, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=5', CAST(N'2026-04-08T19:35:13.423' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (438, 334, 123, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-07T19:30:13.423' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (439, 335, 123, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-21T19:30:13.423' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (440, 336, 123, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-06T19:30:13.423' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (441, 336, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=5', CAST(N'2025-11-06T19:35:13.423' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (442, 337, 124, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-13T19:30:13.427' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (443, 337, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2026-01-13T19:35:13.427' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (444, 338, 124, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-02T19:30:13.427' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (445, 338, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=4', CAST(N'2025-09-02T19:35:13.427' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (446, 339, 124, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-08T19:30:13.427' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (447, 340, 125, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-04T19:30:13.427' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (448, 341, 125, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-05T19:30:13.427' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (449, 341, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2026-04-05T19:35:13.427' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (450, 342, 125, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-11T19:30:13.430' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (451, 342, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=5', CAST(N'2026-05-11T19:35:13.430' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (452, 343, 126, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-17T19:30:13.430' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (453, 344, 126, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-27T19:30:13.430' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (454, 345, 127, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-09T19:30:13.430' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (455, 346, 127, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-11T19:30:13.430' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (456, 347, 127, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-03T19:30:13.430' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (457, 348, 127, N'Создано', N'Обращение подано через портал', CAST(N'2025-05-23T19:30:13.430' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (458, 349, 128, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-04T19:30:13.430' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (459, 349, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=5', CAST(N'2026-04-04T19:35:13.430' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (460, 350, 128, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-21T19:30:13.433' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (461, 350, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=4', CAST(N'2026-04-21T19:35:13.433' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (462, 351, 128, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-09T19:30:13.433' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (463, 352, 128, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-13T19:30:13.433' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (464, 352, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=4', CAST(N'2025-08-13T19:35:13.433' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (465, 353, 129, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-31T19:30:13.433' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (466, 354, 129, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-21T19:30:13.433' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (467, 354, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2025-10-21T19:35:13.433' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (468, 355, 129, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-16T19:30:13.433' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (469, 355, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2026-03-16T19:35:13.433' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (470, 356, 130, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-21T19:30:13.437' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (471, 357, 130, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-15T19:30:13.437' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (472, 357, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=5', CAST(N'2026-04-15T19:35:13.437' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (473, 358, 130, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-29T19:30:13.437' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (474, 358, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2025-12-29T19:35:13.437' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (475, 359, 130, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-20T19:30:13.437' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (476, 359, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2025-06-20T19:35:13.437' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (477, 360, 131, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-25T19:30:13.437' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (478, 361, 131, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-23T19:30:13.440' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (479, 362, 131, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-26T19:30:13.440' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (480, 363, 131, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-19T19:30:13.440' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (481, 363, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=5', CAST(N'2025-12-19T19:35:13.440' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (482, 364, 132, N'Создано', N'Обращение подано через портал', CAST(N'2025-05-28T19:30:13.440' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (483, 364, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2025-05-28T19:35:13.440' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (484, 365, 132, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-13T19:30:13.440' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (485, 365, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2025-06-13T19:35:13.440' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (486, 366, 132, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-10T19:30:13.440' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (487, 367, 132, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-05T19:30:13.440' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (488, 368, 133, N'Создано', N'Обращение подано через портал', CAST(N'2025-05-28T19:30:13.443' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (489, 369, 133, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-01T19:30:13.443' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (490, 370, 133, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-13T19:30:13.443' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (491, 371, 134, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-26T19:30:13.443' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (492, 372, 134, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-04T19:30:13.443' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (493, 372, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2026-03-04T19:35:13.443' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (494, 373, 134, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-13T19:30:13.443' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (495, 373, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=4', CAST(N'2025-06-13T19:35:13.443' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (496, 374, 135, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-04T19:30:13.447' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (497, 375, 135, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-20T19:30:13.447' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (498, 376, 135, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-03T19:30:13.447' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (499, 377, 136, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-01T19:30:13.447' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (500, 378, 136, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-15T19:30:13.447' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (501, 378, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=4', CAST(N'2026-03-15T19:35:13.447' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (502, 379, 137, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-28T19:30:13.447' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (503, 380, 137, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-02T19:30:13.447' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (504, 380, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2026-01-02T19:35:13.447' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (505, 381, 137, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-08T19:30:13.450' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (506, 382, 138, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-02T19:30:13.450' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (507, 383, 138, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-26T19:30:13.450' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (508, 384, 138, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-07T19:30:13.450' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (509, 385, 138, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-16T19:30:13.450' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (510, 385, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2026-01-16T19:35:13.450' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (511, 386, 139, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-26T19:30:13.450' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (512, 386, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=4', CAST(N'2025-12-26T19:35:13.450' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (513, 387, 139, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-25T19:30:13.450' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (514, 388, 140, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-13T19:30:13.450' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (515, 388, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=5', CAST(N'2025-12-13T19:35:13.450' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (516, 389, 140, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-19T19:30:13.450' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (517, 389, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=5', CAST(N'2025-10-19T19:35:13.450' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (518, 390, 141, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-14T19:30:13.453' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (519, 391, 141, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-12T19:30:13.453' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (520, 391, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2025-06-12T19:35:13.453' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (521, 392, 141, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-10T19:30:13.453' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (522, 393, 141, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-24T19:30:13.453' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (523, 394, 142, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-03T19:30:13.453' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (524, 394, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=4', CAST(N'2025-12-03T19:35:13.453' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (525, 395, 142, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-24T19:30:13.453' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (526, 396, 143, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-09T19:30:13.457' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (527, 397, 143, N'Создано', N'Обращение подано через портал', CAST(N'2025-05-21T19:30:13.457' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (528, 397, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=5', CAST(N'2025-05-21T19:35:13.457' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (529, 398, 143, N'Создано', N'Обращение подано через портал', CAST(N'2025-05-22T19:30:13.457' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (530, 398, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2025-05-22T19:35:13.457' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (531, 399, 144, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-03T19:30:13.457' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (532, 399, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2025-06-03T19:35:13.457' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (533, 400, 144, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-19T19:30:13.460' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (534, 401, 145, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-22T19:30:13.460' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (535, 401, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=5', CAST(N'2026-03-22T19:35:13.460' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (536, 402, 145, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-17T19:30:13.460' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (537, 402, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2026-03-17T19:35:13.460' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (538, 403, 145, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-13T19:30:13.460' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (539, 404, 145, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-13T19:30:13.460' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (540, 405, 146, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-27T19:30:13.460' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (541, 406, 146, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-03T19:30:13.460' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (542, 406, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=5', CAST(N'2026-05-03T19:35:13.460' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (543, 407, 146, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-16T19:30:13.463' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (544, 407, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=4', CAST(N'2025-11-16T19:35:13.463' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (545, 408, 147, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-22T19:30:13.463' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (546, 408, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2025-08-22T19:35:13.463' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (547, 409, 147, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-28T19:30:13.463' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (548, 409, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2026-04-28T19:35:13.463' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (549, 410, 147, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-31T19:30:13.463' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (550, 411, 147, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-07T19:30:13.463' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (551, 411, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=4', CAST(N'2025-11-07T19:35:13.463' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (552, 412, 148, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-27T19:30:13.463' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (553, 412, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=4', CAST(N'2025-06-27T19:35:13.463' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (554, 413, 148, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-30T19:30:13.467' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (555, 414, 148, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-29T19:30:13.467' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (556, 415, 149, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-23T19:30:13.467' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (557, 416, 149, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-19T19:30:13.467' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (558, 417, 149, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-20T19:30:13.467' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (559, 418, 150, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-12T19:30:13.467' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (560, 418, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2026-01-12T19:35:13.467' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (561, 419, 150, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-12T19:30:13.470' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (562, 420, 150, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-06T19:30:13.470' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (563, 421, 150, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-31T19:30:13.470' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (564, 422, 151, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-30T19:30:13.470' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (565, 423, 151, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-19T19:30:13.470' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (566, 423, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=5', CAST(N'2026-05-19T19:35:13.470' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (567, 424, 151, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-11T19:30:13.470' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (568, 425, 152, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-01T19:30:13.470' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (569, 425, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2025-11-01T19:35:13.470' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (570, 426, 152, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-06T19:30:13.470' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (571, 427, 152, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-01T19:30:13.470' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (572, 428, 152, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-05T19:30:13.473' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (573, 429, 153, N'Создано', N'Обращение подано через портал', CAST(N'2025-05-24T19:30:13.473' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (574, 429, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=4', CAST(N'2025-05-24T19:35:13.473' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (575, 430, 153, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-04T19:30:13.473' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (576, 431, 153, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-11T19:30:13.473' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (577, 432, 154, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-20T19:30:13.477' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (578, 433, 154, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-28T19:30:13.477' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (579, 434, 154, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-18T19:30:13.477' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (580, 435, 154, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-15T19:30:13.477' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (581, 436, 155, N'Создано', N'Обращение подано через портал', CAST(N'2025-05-23T19:30:13.477' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (582, 436, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2025-05-23T19:35:13.477' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (583, 437, 155, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-10T19:30:13.477' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (584, 437, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=5', CAST(N'2026-03-10T19:35:13.477' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (585, 438, 156, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-30T19:30:13.480' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (586, 439, 156, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-17T19:30:13.480' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (587, 440, 156, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-12T19:30:13.480' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (588, 441, 157, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-15T19:30:13.480' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (589, 442, 157, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-06T19:30:13.480' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (590, 443, 158, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-27T19:30:13.480' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (591, 443, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2026-03-27T19:35:13.480' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (592, 444, 158, N'Создано', N'Обращение подано через портал', CAST(N'2025-05-30T19:30:13.480' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (593, 444, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2025-05-30T19:35:13.480' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (594, 445, 158, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-09T19:30:13.480' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (595, 445, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=5', CAST(N'2026-02-09T19:35:13.480' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (596, 446, 158, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-28T19:30:13.483' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (597, 447, 159, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-08T19:30:13.483' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (598, 447, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2026-02-08T19:35:13.483' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (599, 448, 159, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-26T19:30:13.483' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (600, 449, 160, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-31T19:30:13.483' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (601, 450, 160, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-03T19:30:13.483' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (602, 451, 160, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-05T19:30:13.483' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (603, 452, 160, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-11T19:30:13.483' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (604, 452, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2025-10-11T19:35:13.483' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (605, 453, 161, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-02T19:30:13.487' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (606, 453, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2025-08-02T19:35:13.487' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (607, 454, 161, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-17T19:30:13.487' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (608, 455, 161, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-17T19:30:13.487' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (609, 456, 161, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-12T19:30:13.487' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (610, 456, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=5', CAST(N'2025-08-12T19:35:13.487' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (611, 457, 162, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-07T19:30:13.487' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (612, 458, 162, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-18T19:30:13.490' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (613, 459, 163, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-19T19:30:13.490' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (614, 460, 163, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-14T19:30:13.490' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (615, 461, 164, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-16T19:30:13.490' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (616, 462, 164, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-14T19:30:13.490' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (617, 463, 164, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-02T19:30:13.490' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (618, 463, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2026-02-02T19:35:13.490' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (619, 464, 165, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-06T19:30:13.490' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (620, 465, 165, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-13T19:30:13.490' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (621, 465, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2025-09-13T19:35:13.490' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (622, 466, 165, N'Создано', N'Обращение подано через портал', CAST(N'2025-05-27T19:30:13.493' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (623, 467, 166, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-23T19:30:13.493' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (624, 467, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=4', CAST(N'2025-11-23T19:35:13.493' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (625, 468, 166, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-12T19:30:13.493' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (626, 469, 166, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-17T19:30:13.493' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (627, 470, 166, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-11T19:30:13.493' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (628, 471, 167, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-08T19:30:13.497' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (629, 471, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2026-03-08T19:35:13.497' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (630, 472, 167, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-18T19:30:13.497' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (631, 472, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2025-06-18T19:35:13.497' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (632, 473, 167, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-12T19:30:13.497' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (633, 473, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2026-01-12T19:35:13.497' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (634, 474, 167, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-03T19:30:13.497' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (635, 475, 168, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-21T19:30:13.497' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (636, 475, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2025-09-21T19:35:13.497' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (637, 476, 168, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-22T19:30:13.497' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (638, 477, 169, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-23T19:30:13.500' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (639, 478, 169, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-04T19:30:13.500' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (640, 479, 169, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-17T19:30:13.500' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (641, 480, 170, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-25T19:30:13.500' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (642, 481, 170, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-18T19:30:13.500' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (643, 482, 170, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-14T19:30:13.500' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (644, 482, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2026-04-14T19:35:13.500' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (645, 483, 171, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-13T19:30:13.500' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (646, 484, 171, N'Создано', N'Обращение подано через портал', CAST(N'2025-05-23T19:30:13.500' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (647, 485, 171, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-30T19:30:13.500' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (648, 486, 172, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-02T19:30:13.500' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (649, 487, 172, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-01T19:30:13.503' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (650, 487, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2025-10-01T19:35:13.503' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (651, 488, 172, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-17T19:30:13.503' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (652, 488, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2025-08-17T19:35:13.503' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (653, 489, 172, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-19T19:30:13.503' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (654, 490, 173, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-14T19:30:13.503' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (655, 491, 173, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-09T19:30:13.503' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (656, 492, 173, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-10T19:30:13.503' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (657, 493, 174, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-19T19:30:13.507' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (658, 494, 174, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-23T19:30:13.507' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (659, 495, 175, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-24T19:30:13.507' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (660, 496, 175, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-07T19:30:13.507' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (661, 496, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2025-10-07T19:35:13.507' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (662, 497, 175, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-01T19:30:13.507' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (663, 498, 175, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-19T19:30:13.507' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (664, 499, 176, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-22T19:30:13.510' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (665, 499, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2025-11-22T19:35:13.510' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (666, 500, 176, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-09T19:30:13.510' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (667, 501, 177, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-27T19:30:13.510' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (668, 502, 177, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-22T19:30:13.510' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (669, 502, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=5', CAST(N'2026-01-22T19:35:13.510' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (670, 503, 177, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-28T19:30:13.510' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (671, 503, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2026-04-28T19:35:13.510' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (672, 504, 177, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-24T19:30:13.510' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (673, 505, 178, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-04T19:30:13.513' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (674, 506, 178, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-12T19:30:13.513' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (675, 507, 178, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-12T19:30:13.513' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (676, 507, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2025-12-12T19:35:13.513' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (677, 508, 178, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-18T19:30:13.513' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (678, 509, 179, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-29T19:30:13.513' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (679, 510, 179, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-15T19:30:13.513' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (680, 511, 179, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-13T19:30:13.517' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (681, 512, 180, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-06T19:30:13.517' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (682, 513, 180, N'Создано', N'Обращение подано через портал', CAST(N'2025-05-25T19:30:13.517' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (683, 513, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2025-05-25T19:35:13.517' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (684, 514, 181, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-05T19:30:13.517' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (685, 515, 181, N'Создано', N'Обращение подано через портал', CAST(N'2025-05-30T19:30:13.517' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (686, 516, 181, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-21T19:30:13.517' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (687, 516, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=5', CAST(N'2025-11-21T19:35:13.517' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (688, 517, 181, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-19T19:30:13.520' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (689, 517, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2025-07-19T19:35:13.520' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (690, 518, 182, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-01T19:30:13.520' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (691, 519, 182, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-02T19:30:13.520' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (692, 519, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2025-12-02T19:35:13.520' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (693, 520, 182, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-25T19:30:13.520' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (694, 521, 182, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-20T19:30:13.520' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (695, 522, 183, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-29T19:30:13.520' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (696, 523, 183, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-22T19:30:13.520' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (697, 523, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=5', CAST(N'2026-03-22T19:35:13.520' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (698, 524, 183, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-23T19:30:13.520' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (699, 525, 183, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-12T19:30:13.523' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (700, 526, 184, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-05T19:30:13.523' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (701, 527, 184, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-26T19:30:13.523' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (702, 528, 184, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-20T19:30:13.523' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (703, 529, 185, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-15T19:30:13.523' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (704, 530, 185, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-09T19:30:13.523' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (705, 531, 185, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-27T19:30:13.527' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (706, 532, 185, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-11T19:30:13.527' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (707, 532, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2026-04-11T19:35:13.527' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (708, 533, 186, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-11T19:30:13.527' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (709, 534, 186, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-18T19:30:13.527' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (710, 535, 187, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-10T19:30:13.527' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (711, 536, 187, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-17T19:30:13.527' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (712, 536, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2026-02-17T19:35:13.527' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (713, 537, 187, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-11T19:30:13.530' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (714, 538, 187, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-05T19:30:13.530' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (715, 539, 188, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-30T19:30:13.530' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (716, 540, 188, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-07T19:30:13.530' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (717, 541, 188, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-20T19:30:13.530' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (718, 542, 188, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-27T19:30:13.530' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (719, 543, 189, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-01T19:30:13.530' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (720, 543, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=4', CAST(N'2025-12-01T19:35:13.530' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (721, 544, 189, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-17T19:30:13.530' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (722, 545, 189, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-01T19:30:13.533' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (723, 546, 189, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-02T19:30:13.533' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (724, 547, 190, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-07T19:30:13.533' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (725, 548, 190, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-17T19:30:13.533' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (726, 549, 190, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-21T19:30:13.533' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (727, 550, 190, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-19T19:30:13.533' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (728, 551, 191, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-24T19:30:13.537' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (729, 552, 191, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-16T19:30:13.537' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (730, 553, 191, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-09T19:30:13.537' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (731, 554, 191, N'Создано', N'Обращение подано через портал', CAST(N'2025-05-29T19:30:13.537' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (732, 555, 192, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-23T19:30:13.537' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (733, 555, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2025-10-23T19:35:13.537' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (734, 556, 192, N'Создано', N'Обращение подано через портал', CAST(N'2025-05-24T19:30:13.537' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (735, 557, 193, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-11T19:30:13.537' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (736, 557, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2026-03-11T19:35:13.537' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (737, 558, 193, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-05T19:30:13.540' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (738, 558, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2026-02-05T19:35:13.540' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (739, 559, 194, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-05T19:30:13.540' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (740, 560, 194, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-09T19:30:13.540' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (741, 561, 194, N'Создано', N'Обращение подано через портал', CAST(N'2025-05-29T19:30:13.540' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (742, 562, 195, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-05T19:30:13.540' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (743, 563, 195, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-11T19:30:13.540' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (744, 564, 195, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-15T19:30:13.540' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (745, 564, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=5', CAST(N'2025-06-15T19:35:13.540' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (746, 565, 196, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-18T19:30:13.540' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (747, 566, 196, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-13T19:30:13.540' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (748, 566, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2026-04-13T19:35:13.540' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (749, 567, 197, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-01T19:30:13.543' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (750, 568, 197, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-25T19:30:13.543' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (751, 569, 197, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-25T19:30:13.543' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (752, 569, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2026-02-25T19:35:13.543' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (753, 570, 198, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-12T19:30:13.543' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (754, 571, 198, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-18T19:30:13.543' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (755, 572, 199, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-12T19:30:13.547' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (756, 572, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=4', CAST(N'2026-02-12T19:35:13.547' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (757, 573, 199, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-20T19:30:13.547' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (758, 574, 200, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-06T19:30:13.547' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (759, 575, 200, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-24T19:30:13.547' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (760, 576, 200, N'Создано', N'Обращение подано через портал', CAST(N'2025-05-26T19:30:13.547' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (761, 577, 200, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-04T19:30:13.547' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (762, 578, 201, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-15T19:30:13.550' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (763, 579, 201, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-25T19:30:13.550' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (764, 580, 201, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-22T19:30:13.550' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (765, 581, 201, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-19T19:30:13.550' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (766, 582, 202, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-24T19:30:13.550' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (767, 583, 202, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-16T19:30:13.550' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (768, 583, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2026-05-16T19:35:13.550' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (769, 584, 202, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-01T19:30:13.550' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (770, 585, 203, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-14T19:30:13.550' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (771, 585, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=5', CAST(N'2025-07-14T19:35:13.550' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (772, 586, 203, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-04T19:30:13.550' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (773, 586, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2025-07-04T19:35:13.550' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (774, 587, 203, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-18T19:30:13.553' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (775, 587, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=5', CAST(N'2025-11-18T19:35:13.553' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (776, 588, 203, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-15T19:30:13.553' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (777, 589, 204, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-22T19:30:13.553' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (778, 590, 204, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-13T19:30:13.553' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (779, 591, 205, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-22T19:30:13.553' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (780, 592, 205, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-10T19:30:13.553' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (781, 593, 205, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-16T19:30:13.553' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (782, 594, 206, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-21T19:30:13.557' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (783, 595, 206, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-20T19:30:13.557' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (784, 596, 206, N'Создано', N'Обращение подано через портал', CAST(N'2025-05-22T19:30:13.557' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (785, 597, 207, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-28T19:30:13.557' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (786, 598, 207, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-24T19:30:13.557' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (787, 598, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2025-12-24T19:35:13.557' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (788, 599, 208, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-06T19:30:13.557' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (789, 600, 208, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-27T19:30:13.557' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (790, 601, 209, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-17T19:30:13.560' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (791, 602, 209, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-10T19:30:13.560' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (792, 603, 210, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-13T19:30:13.560' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (793, 604, 210, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-24T19:30:13.560' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (794, 605, 210, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-06T19:30:13.560' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (795, 605, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=5', CAST(N'2025-11-06T19:35:13.560' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (796, 606, 210, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-16T19:30:13.560' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (797, 606, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2025-10-16T19:35:13.560' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (798, 607, 211, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-01T19:30:13.560' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (799, 608, 211, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-01T19:30:13.560' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (800, 609, 211, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-09T19:30:13.560' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (801, 610, 212, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-26T19:30:13.563' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (802, 610, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2025-07-26T19:35:13.563' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (803, 611, 212, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-21T19:30:13.563' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (804, 612, 212, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-19T19:30:13.563' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (805, 613, 212, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-31T19:30:13.563' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (806, 614, 213, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-14T19:30:13.563' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (807, 615, 213, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-06T19:30:13.563' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (808, 616, 214, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-07T19:30:13.567' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (809, 617, 214, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-07T19:30:13.567' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (810, 618, 214, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-28T19:30:13.567' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (811, 618, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2025-10-28T19:35:13.567' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (812, 619, 215, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-15T19:30:13.567' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (813, 620, 215, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-28T19:30:13.567' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (814, 620, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2025-12-28T19:35:13.567' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (815, 621, 215, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-06T19:30:13.570' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (816, 622, 215, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-08T19:30:13.570' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (817, 622, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2026-04-08T19:35:13.570' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (818, 623, 216, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-03T19:30:13.570' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (819, 624, 216, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-02T19:30:13.570' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (820, 625, 216, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-20T19:30:13.570' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (821, 626, 216, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-18T19:30:13.570' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (822, 627, 217, N'Создано', N'Обращение подано через портал', CAST(N'2025-05-30T19:30:13.570' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (823, 628, 217, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-28T19:30:13.570' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (824, 628, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2025-09-28T19:35:13.570' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (825, 629, 217, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-25T19:30:13.573' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (826, 629, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2026-02-25T19:35:13.573' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (827, 630, 218, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-28T19:30:13.573' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (828, 631, 218, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-03T19:30:13.573' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (829, 631, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2026-05-03T19:35:13.573' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (830, 632, 218, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-03T19:30:13.573' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (831, 633, 219, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-25T19:30:13.573' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (832, 634, 219, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-20T19:30:13.577' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (833, 635, 219, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-25T19:30:13.577' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (834, 635, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2026-01-25T19:35:13.577' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (835, 636, 220, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-12T19:30:13.577' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (836, 636, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=4', CAST(N'2026-05-12T19:35:13.577' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (837, 637, 220, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-23T19:30:13.577' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (838, 638, 220, N'Создано', N'Обращение подано через портал', CAST(N'2025-05-21T19:30:13.577' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (839, 639, 220, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-26T19:30:13.577' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (840, 639, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2025-07-26T19:35:13.577' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (841, 640, 221, N'Создано', N'Обращение подано через портал', CAST(N'2025-05-22T19:30:13.580' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (842, 641, 221, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-01T19:30:13.580' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (843, 641, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2025-09-01T19:35:13.580' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (844, 642, 222, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-16T19:30:13.580' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (845, 643, 222, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-07T19:30:13.607' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (846, 644, 222, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-30T19:30:13.610' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (847, 644, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=4', CAST(N'2025-06-30T19:35:13.610' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (848, 645, 222, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-15T19:30:13.610' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (849, 646, 223, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-07T19:30:13.610' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (850, 647, 223, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-04T19:30:13.610' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (851, 648, 223, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-20T19:30:13.610' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (852, 649, 223, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-27T19:30:13.610' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (853, 650, 224, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-04T19:30:13.613' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (854, 651, 224, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-04T19:30:13.613' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (855, 652, 224, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-18T19:30:13.613' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (856, 653, 225, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-11T19:30:13.613' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (857, 654, 225, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-02T19:30:13.613' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (858, 655, 225, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-25T19:30:13.613' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (859, 655, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2025-12-25T19:35:13.613' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (860, 656, 226, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-23T19:30:13.617' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (861, 657, 226, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-18T19:30:13.617' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (862, 658, 226, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-28T19:30:13.617' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (863, 659, 226, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-07T19:30:13.617' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (864, 659, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2025-07-07T19:35:13.617' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (865, 660, 227, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-17T19:30:13.617' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (866, 661, 227, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-25T19:30:13.617' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (867, 661, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=4', CAST(N'2026-04-25T19:35:13.617' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (868, 662, 227, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-14T19:30:13.620' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (869, 663, 228, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-08T19:30:13.620' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (870, 664, 228, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-25T19:30:13.620' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (871, 665, 228, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-24T19:30:13.620' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (872, 666, 229, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-26T19:30:13.620' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (873, 667, 229, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-08T19:30:13.620' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (874, 667, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=4', CAST(N'2026-01-08T19:35:13.620' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (875, 668, 229, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-26T19:30:13.620' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (876, 669, 230, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-21T19:30:13.620' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (877, 670, 230, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-11T19:30:13.623' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (878, 671, 230, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-19T19:30:13.623' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (879, 671, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=4', CAST(N'2025-06-19T19:35:13.623' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (880, 672, 230, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-10T19:30:13.623' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (881, 673, 231, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-10T19:30:13.623' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (882, 674, 231, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-03T19:30:13.623' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (883, 674, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=4', CAST(N'2026-05-03T19:35:13.623' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (884, 675, 231, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-05T19:30:13.627' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (885, 676, 232, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-15T19:30:13.627' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (886, 676, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=5', CAST(N'2026-04-15T19:35:13.627' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (887, 677, 232, N'Создано', N'Обращение подано через портал', CAST(N'2025-05-30T19:30:13.627' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (888, 678, 232, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-17T19:30:13.627' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (889, 679, 233, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-05T19:30:13.627' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (890, 679, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2026-02-05T19:35:13.627' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (891, 680, 233, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-20T19:30:13.630' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (892, 681, 233, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-30T19:30:13.630' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (893, 682, 233, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-24T19:30:13.630' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (894, 683, 234, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-14T19:30:13.630' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (895, 684, 234, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-16T19:30:13.630' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (896, 685, 235, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-04T19:30:13.630' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (897, 686, 235, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-02T19:30:13.630' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (898, 687, 235, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-11T19:30:13.630' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (899, 687, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=5', CAST(N'2025-11-11T19:35:13.630' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (900, 688, 235, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-25T19:30:13.633' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (901, 689, 236, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-14T19:30:13.633' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (902, 690, 236, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-01T19:30:13.633' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (903, 691, 236, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-24T19:30:13.633' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (904, 692, 236, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-12T19:30:13.633' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (905, 693, 237, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-18T19:30:13.633' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (906, 693, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2026-02-18T19:35:13.633' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (907, 694, 237, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-23T19:30:13.637' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (908, 695, 237, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-18T19:30:13.637' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (909, 695, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2025-06-18T19:35:13.637' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (910, 696, 238, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-01T19:30:13.637' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (911, 697, 238, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-22T19:30:13.637' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (912, 697, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=5', CAST(N'2025-06-22T19:35:13.637' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (913, 698, 238, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-19T19:30:13.637' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (914, 698, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2026-03-19T19:35:13.637' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (915, 699, 239, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-30T19:30:13.637' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (916, 699, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=4', CAST(N'2026-03-30T19:35:13.637' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (917, 700, 239, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-06T19:30:13.637' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (918, 700, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=4', CAST(N'2026-02-06T19:35:13.637' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (919, 701, 239, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-10T19:30:13.640' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (920, 701, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2025-12-10T19:35:13.640' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (921, 702, 240, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-03T19:30:13.640' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (922, 703, 240, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-21T19:30:13.640' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (923, 704, 241, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-15T19:30:13.640' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (924, 705, 241, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-28T19:30:13.640' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (925, 706, 241, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-05T19:30:13.640' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (926, 707, 241, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-25T19:30:13.640' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (927, 708, 242, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-26T19:30:13.640' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (928, 709, 242, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-28T19:30:13.643' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (929, 710, 242, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-08T19:30:13.643' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (930, 711, 243, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-10T19:30:13.643' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (931, 712, 243, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-08T19:30:13.643' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (932, 712, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=4', CAST(N'2025-08-08T19:35:13.643' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (933, 713, 244, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-20T19:30:13.643' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (934, 713, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2026-05-20T19:35:13.643' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (935, 714, 244, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-26T19:30:13.643' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (936, 714, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2026-03-26T19:35:13.643' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (937, 715, 245, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-11T19:30:13.647' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (938, 716, 245, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-19T19:30:13.647' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (939, 716, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=5', CAST(N'2026-04-19T19:35:13.647' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (940, 717, 245, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-10T19:30:13.647' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (941, 717, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=5', CAST(N'2026-01-10T19:35:13.647' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (942, 718, 246, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-23T19:30:13.647' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (943, 718, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=4', CAST(N'2026-02-23T19:35:13.647' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (944, 719, 246, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-27T19:30:13.647' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (945, 720, 246, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-22T19:30:13.647' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (946, 721, 247, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-25T19:30:13.650' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (947, 722, 247, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-12T19:30:13.650' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (948, 723, 248, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-12T19:30:13.650' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (949, 723, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=5', CAST(N'2025-08-12T19:35:13.650' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (950, 724, 248, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-21T19:30:13.650' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (951, 725, 249, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-25T19:30:13.650' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (952, 726, 249, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-20T19:30:13.650' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (953, 726, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2026-02-20T19:35:13.650' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (954, 727, 249, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-05T19:30:13.653' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (955, 728, 249, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-11T19:30:13.653' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (956, 729, 250, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-31T19:30:13.653' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (957, 730, 250, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-19T19:30:13.653' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (958, 731, 251, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-26T19:30:13.653' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (959, 732, 251, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-26T19:30:13.653' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (960, 732, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=4', CAST(N'2026-02-26T19:35:13.653' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (961, 733, 251, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-03T19:30:13.653' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (962, 734, 251, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-17T19:30:13.657' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (963, 735, 252, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-10T19:30:13.657' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (964, 735, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2025-08-10T19:35:13.657' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (965, 736, 252, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-03T19:30:13.657' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (966, 737, 252, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-22T19:30:13.657' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (967, 737, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2025-10-22T19:35:13.657' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (968, 738, 253, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-06T19:30:13.657' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (969, 739, 253, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-11T19:30:13.657' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (970, 740, 253, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-13T19:30:13.657' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (971, 741, 253, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-10T19:30:13.660' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (972, 742, 254, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-27T19:30:13.660' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (973, 743, 254, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-04T19:30:13.660' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (974, 744, 255, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-22T19:30:13.660' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (975, 745, 255, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-09T19:30:13.660' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (976, 745, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=4', CAST(N'2026-02-09T19:35:13.660' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (977, 746, 256, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-27T19:30:13.660' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (978, 747, 256, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-26T19:30:13.660' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (979, 748, 257, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-06T19:30:13.660' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (980, 749, 257, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-02T19:30:13.660' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (981, 750, 257, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-17T19:30:13.663' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (982, 750, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2025-10-17T19:35:13.663' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (983, 751, 258, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-09T19:30:13.663' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (984, 752, 258, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-31T19:30:13.663' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (985, 753, 258, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-09T19:30:13.663' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (986, 754, 258, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-08T19:30:13.663' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (987, 754, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=4', CAST(N'2025-07-08T19:35:13.663' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (988, 755, 259, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-18T19:30:13.663' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (989, 755, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=5', CAST(N'2025-07-18T19:35:13.663' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (990, 756, 259, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-12T19:30:13.667' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (991, 757, 259, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-08T19:30:13.667' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (992, 758, 260, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-16T19:30:13.667' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (993, 758, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2025-12-16T19:35:13.667' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (994, 759, 260, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-11T19:30:13.667' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (995, 760, 260, N'Создано', N'Обращение подано через портал', CAST(N'2025-05-28T19:30:13.667' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (996, 761, 261, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-13T19:30:13.670' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (997, 762, 261, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-11T19:30:13.670' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (998, 762, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2025-10-11T19:35:13.670' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (999, 763, 261, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-11T19:30:13.670' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1000, 764, 261, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-25T19:30:13.670' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1001, 765, 262, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-14T19:30:13.670' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1002, 766, 262, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-21T19:30:13.670' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1003, 766, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=4', CAST(N'2025-06-21T19:35:13.670' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1004, 767, 262, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-23T19:30:13.670' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1005, 768, 262, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-04T19:30:13.670' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1006, 768, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2026-04-04T19:35:13.670' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1007, 769, 263, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-18T19:30:13.670' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1008, 769, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=5', CAST(N'2026-05-18T19:35:13.670' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1009, 770, 263, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-17T19:30:13.673' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1010, 770, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=4', CAST(N'2025-07-17T19:35:13.673' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1011, 771, 264, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-13T19:30:13.673' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1012, 771, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2026-04-13T19:35:13.673' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1013, 772, 264, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-25T19:30:13.673' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1014, 772, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=4', CAST(N'2025-06-25T19:35:13.673' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1015, 773, 265, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-09T19:30:13.673' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1016, 774, 265, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-08T19:30:13.673' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1017, 774, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2026-05-08T19:35:13.673' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1018, 775, 265, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-14T19:30:13.673' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1019, 776, 266, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-25T19:30:13.677' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1020, 777, 266, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-31T19:30:13.677' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1021, 778, 266, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-06T19:30:13.677' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1022, 779, 267, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-16T19:30:13.677' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1023, 779, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2026-04-16T19:35:13.677' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1024, 780, 267, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-06T19:30:13.677' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1025, 781, 268, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-24T19:30:13.677' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1026, 781, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2025-06-24T19:35:13.677' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1027, 782, 268, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-07T19:30:13.680' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1028, 783, 269, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-01T19:30:13.680' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1029, 784, 269, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-12T19:30:13.680' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1030, 785, 269, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-04T19:30:13.680' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1031, 785, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2025-11-04T19:35:13.680' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1032, 786, 269, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-21T19:30:13.680' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1033, 787, 270, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-27T19:30:13.680' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1034, 787, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2025-12-27T19:35:13.680' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1035, 788, 270, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-22T19:30:13.680' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1036, 788, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2026-04-22T19:35:13.680' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1037, 789, 271, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-21T19:30:13.683' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1038, 790, 271, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-23T19:30:13.683' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1039, 791, 271, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-17T19:30:13.683' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1040, 792, 271, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-11T19:30:13.683' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1041, 792, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2025-08-11T19:35:13.683' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1042, 793, 272, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-12T19:30:13.683' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1043, 794, 272, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-07T19:30:13.683' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1044, 795, 273, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-20T19:30:13.687' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1045, 795, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2026-02-20T19:35:13.687' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1046, 796, 273, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-17T19:30:13.687' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1047, 797, 273, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-14T19:30:13.687' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1048, 798, 274, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-17T19:30:13.687' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1049, 799, 274, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-17T19:30:13.687' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1050, 799, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=4', CAST(N'2025-11-17T19:35:13.687' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1051, 800, 275, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-03T19:30:13.690' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1052, 801, 275, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-17T19:30:13.690' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1053, 802, 275, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-26T19:30:13.690' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1054, 803, 275, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-02T19:30:13.690' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1055, 803, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=4', CAST(N'2026-02-02T19:35:13.690' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1056, 804, 276, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-06T19:30:13.690' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1057, 805, 276, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-22T19:30:13.690' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1058, 806, 276, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-21T19:30:13.690' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1059, 807, 277, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-02T19:30:13.690' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1060, 808, 277, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-06T19:30:13.690' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1061, 809, 277, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-10T19:30:13.690' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1062, 809, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2026-01-10T19:35:13.690' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1063, 810, 278, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-08T19:30:13.693' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1064, 811, 278, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-12T19:30:13.693' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1065, 812, 279, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-30T19:30:13.693' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1066, 812, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2025-06-30T19:35:13.693' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1067, 813, 279, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-30T19:30:13.693' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1068, 814, 279, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-18T19:30:13.693' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1069, 815, 280, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-04T19:30:13.697' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1070, 816, 280, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-30T19:30:13.697' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1071, 816, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=4', CAST(N'2025-11-30T19:35:13.697' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1072, 817, 280, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-25T19:30:13.697' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1073, 818, 281, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-28T19:30:13.697' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1074, 818, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=4', CAST(N'2026-04-28T19:35:13.697' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1075, 819, 281, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-15T19:30:13.697' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1076, 820, 281, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-17T19:30:13.697' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1077, 820, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2025-09-17T19:35:13.697' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1078, 821, 281, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-11T19:30:13.697' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1079, 821, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2025-11-11T19:35:13.697' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1080, 822, 282, N'Создано', N'Обращение подано через портал', CAST(N'2025-05-28T19:30:13.700' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1081, 823, 282, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-01T19:30:13.700' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1082, 824, 283, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-05T19:30:13.700' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1083, 825, 283, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-14T19:30:13.700' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1084, 826, 283, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-16T19:30:13.700' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1085, 827, 284, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-19T19:30:13.700' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1086, 828, 284, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-14T19:30:13.700' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1087, 829, 284, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-15T19:30:13.700' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1088, 829, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2025-12-15T19:35:13.700' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1089, 830, 284, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-30T19:30:13.703' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1090, 831, 285, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-22T19:30:13.703' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1091, 832, 285, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-05T19:30:13.703' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1092, 832, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2025-07-05T19:35:13.703' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1093, 833, 285, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-25T19:30:13.703' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1094, 833, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2026-03-25T19:35:13.703' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1095, 834, 286, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-12T19:30:13.703' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1096, 835, 286, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-08T19:30:13.703' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1097, 835, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2026-02-08T19:35:13.703' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1098, 836, 287, N'Создано', N'Обращение подано через портал', CAST(N'2025-05-22T19:30:13.707' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1099, 837, 287, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-06T19:30:13.707' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1100, 838, 288, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-04T19:30:13.707' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1101, 839, 288, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-28T19:30:13.707' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1102, 840, 288, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-25T19:30:13.707' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1103, 840, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2025-07-25T19:35:13.707' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1104, 841, 288, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-15T19:30:13.710' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1105, 842, 289, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-21T19:30:13.710' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1106, 843, 289, N'Создано', N'Обращение подано через портал', CAST(N'2025-06-03T19:30:13.710' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1107, 844, 290, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-30T19:30:13.710' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1108, 845, 290, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-18T19:30:13.710' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1109, 845, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=7', CAST(N'2025-07-18T19:35:13.710' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1110, 846, 291, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-27T19:30:13.710' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1111, 847, 291, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-02T19:30:13.710' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1112, 848, 292, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-23T19:30:13.710' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1113, 848, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2025-11-23T19:35:13.710' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1114, 849, 292, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-18T19:30:13.713' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1115, 850, 293, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-21T19:30:13.713' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1116, 850, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=6', CAST(N'2026-01-21T19:35:13.713' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1117, 851, 293, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-21T19:30:13.713' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1118, 852, 293, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-10T19:30:13.713' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1119, 853, 293, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-12T19:30:13.713' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1120, 854, 294, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-30T19:30:13.713' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1121, 855, 294, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-15T19:30:13.713' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1122, 856, 294, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-23T19:30:13.713' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1123, 857, 295, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-03T19:30:13.717' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1124, 857, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2026-05-03T19:35:13.717' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1125, 858, 295, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-20T19:30:13.717' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1126, 859, 295, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-08T19:30:13.717' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1127, 860, 295, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-17T19:30:13.717' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1128, 861, 296, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-01T19:30:13.717' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1129, 862, 296, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-17T19:30:13.717' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1130, 863, 297, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-05T19:30:13.720' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1131, 864, 297, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-14T19:30:13.720' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1132, 865, 298, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-19T19:30:13.720' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1133, 866, 298, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-26T19:30:13.720' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1134, 867, 299, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-20T19:30:13.720' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1135, 868, 299, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-03T19:30:13.720' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1136, 868, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2026-04-03T19:35:13.720' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1137, 869, 299, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-12T19:30:13.720' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1138, 870, 299, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-29T19:30:13.720' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1139, 871, 300, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-22T19:30:13.720' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1140, 872, 300, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-21T19:30:13.723' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1141, 873, 300, N'Создано', N'Обращение подано через портал', CAST(N'2025-11-22T19:30:13.723' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1142, 873, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2025-11-22T19:35:13.723' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1143, 874, 301, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-18T19:30:13.723' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1144, 875, 301, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-22T19:30:13.723' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1145, 875, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=4', CAST(N'2026-01-22T19:35:13.723' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1146, 876, 301, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-20T19:30:13.723' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1147, 877, 302, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-09T19:30:13.727' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1148, 878, 302, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-16T19:30:13.727' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1149, 879, 303, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-09T19:30:13.727' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1150, 880, 303, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-15T19:30:13.727' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1151, 881, 303, N'Создано', N'Обращение подано через портал', CAST(N'2025-05-28T19:30:13.727' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1152, 882, 303, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-15T19:30:13.727' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1153, 883, 304, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-19T19:30:13.730' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1154, 884, 304, N'Создано', N'Обращение подано через портал', CAST(N'2025-05-25T19:30:13.730' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1155, 885, 304, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-14T19:30:13.730' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1156, 886, 304, N'Создано', N'Обращение подано через портал', CAST(N'2025-05-25T19:30:13.730' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1157, 887, 305, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-03T19:30:13.730' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1158, 888, 305, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-13T19:30:13.730' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1159, 889, 306, N'Создано', N'Обращение подано через портал', CAST(N'2025-08-08T19:30:13.730' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1160, 889, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=4', CAST(N'2025-08-08T19:35:13.730' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1161, 890, 306, N'Создано', N'Обращение подано через портал', CAST(N'2025-10-23T19:30:13.730' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1162, 891, 306, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-28T19:30:13.730' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1163, 892, 306, N'Создано', N'Обращение подано через портал', CAST(N'2026-02-08T19:30:13.730' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1164, 892, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=5', CAST(N'2026-02-08T19:35:13.730' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1165, 893, 307, N'Создано', N'Обращение подано через портал', CAST(N'2025-09-28T19:30:13.733' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1166, 894, 307, N'Создано', N'Обращение подано через портал', CAST(N'2026-04-17T19:30:13.733' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1167, 894, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=8', CAST(N'2026-04-17T19:35:13.733' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1168, 895, 307, N'Создано', N'Обращение подано через портал', CAST(N'2025-07-19T19:30:13.733' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1169, 896, 308, N'Создано', N'Обращение подано через портал', CAST(N'2025-12-16T19:30:13.733' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1170, 897, 308, N'Создано', N'Обращение подано через портал', CAST(N'2026-03-11T19:30:13.733' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1171, 898, 308, N'Создано', N'Обращение подано через портал', CAST(N'2026-05-06T19:30:13.733' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1172, 898, 2, N'Назначен исполнитель', N'Назначен сотрудник ID=4', CAST(N'2026-05-06T19:35:13.733' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1173, 899, 308, N'Создано', N'Обращение подано через портал', CAST(N'2026-01-29T19:30:13.737' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1174, 6, 7, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-10-14T19:30:12.870' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1175, 9, 7, N'Изменён статус', N'Промежуточное действие', CAST(N'2026-03-27T19:30:12.870' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1176, 15, 14, N'Изменён статус', N'Промежуточное действие', CAST(N'2026-03-03T19:30:12.873' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1177, 18, 5, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-10-10T19:30:12.877' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1178, 33, 7, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-10-14T19:30:12.883' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1179, 48, 25, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-08-28T19:30:12.890' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1180, 54, 4, N'Изменён статус', N'Промежуточное действие', CAST(N'2026-04-28T19:30:12.893' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1181, 75, 6, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-08-21T19:30:13.077' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1182, 81, 8, N'Изменён статус', N'Промежуточное действие', CAST(N'2026-01-15T19:30:13.080' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1183, 84, 4, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-12-19T19:30:13.080' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1184, 87, 6, N'Изменён статус', N'Промежуточное действие', CAST(N'2026-02-27T19:30:13.083' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1185, 93, 7, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-07-22T19:30:13.087' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1186, 99, 43, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-11-14T19:30:13.090' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1187, 129, 5, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-08-05T19:30:13.273' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1188, 132, 54, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-12-28T19:30:13.277' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1189, 141, 6, N'Изменён статус', N'Промежуточное действие', CAST(N'2026-04-03T19:30:13.280' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1190, 144, 57, N'Изменён статус', N'Промежуточное действие', CAST(N'2026-02-19T19:30:13.283' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1191, 168, 66, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-09-15T19:30:13.337' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1192, 183, 71, N'Изменён статус', N'Промежуточное действие', CAST(N'2026-01-30T19:30:13.343' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1193, 186, 72, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-07-19T19:30:13.347' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1194, 204, 7, N'Изменён статус', N'Промежуточное действие', CAST(N'2026-05-12T19:30:13.353' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1195, 210, 5, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-09-20T19:30:13.357' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1196, 216, 6, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-05-29T19:30:13.360' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1197, 228, 8, N'Изменён статус', N'Промежуточное действие', CAST(N'2026-02-25T19:30:13.367' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1198, 234, 88, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-06-30T19:30:13.370' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1199, 237, 89, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-12-31T19:30:13.373' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1200, 246, 6, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-09-02T19:30:13.377' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1201, 249, 93, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-08-24T19:30:13.380' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1202, 264, 7, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-07-26T19:30:13.387' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1203, 273, 102, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-12-28T19:30:13.390' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1204, 276, 103, N'Изменён статус', N'Промежуточное действие', CAST(N'2026-01-03T19:30:13.393' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1205, 285, 106, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-07-21T19:30:13.400' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1206, 288, 6, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-07-17T19:30:13.400' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1207, 294, 109, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-05-27T19:30:13.403' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1208, 309, 5, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-07-14T19:30:13.410' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1209, 315, 8, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-10-13T19:30:13.413' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1210, 318, 6, N'Изменён статус', N'Промежуточное действие', CAST(N'2026-02-02T19:30:13.417' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1211, 327, 7, N'Изменён статус', N'Промежуточное действие', CAST(N'2026-05-15T19:30:13.420' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1212, 333, 123, N'Изменён статус', N'Промежуточное действие', CAST(N'2026-04-09T19:30:13.423' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1213, 336, 123, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-11-07T19:30:13.423' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1214, 342, 5, N'Изменён статус', N'Промежуточное действие', CAST(N'2026-05-12T19:30:13.430' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1215, 354, 7, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-10-22T19:30:13.433' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1216, 357, 130, N'Изменён статус', N'Промежуточное действие', CAST(N'2026-04-16T19:30:13.437' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1217, 363, 131, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-12-20T19:30:13.440' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1218, 372, 7, N'Изменён статус', N'Промежуточное действие', CAST(N'2026-03-05T19:30:13.443' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1219, 378, 136, N'Изменён статус', N'Промежуточное действие', CAST(N'2026-03-16T19:30:13.447' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1220, 399, 144, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-06-04T19:30:13.457' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1221, 402, 6, N'Изменён статус', N'Промежуточное действие', CAST(N'2026-03-18T19:30:13.460' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1222, 408, 147, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-08-23T19:30:13.463' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1223, 411, 147, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-11-08T19:30:13.463' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1224, 423, 5, N'Изменён статус', N'Промежуточное действие', CAST(N'2026-05-20T19:30:13.470' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1225, 429, 4, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-05-25T19:30:13.473' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1226, 444, 8, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-05-31T19:30:13.480' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1227, 447, 6, N'Изменён статус', N'Промежуточное действие', CAST(N'2026-02-09T19:30:13.483' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1228, 453, 8, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-08-03T19:30:13.487' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1229, 456, 5, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-08-13T19:30:13.487' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1230, 465, 6, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-09-14T19:30:13.490' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1231, 471, 8, N'Изменён статус', N'Промежуточное действие', CAST(N'2026-03-09T19:30:13.497' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1232, 507, 8, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-12-13T19:30:13.513' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1233, 513, 7, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-05-26T19:30:13.517' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1234, 516, 181, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-11-22T19:30:13.517' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1235, 519, 182, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-12-03T19:30:13.520' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1236, 543, 4, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-12-02T19:30:13.530' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1237, 555, 192, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-10-24T19:30:13.537' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1238, 558, 193, N'Изменён статус', N'Промежуточное действие', CAST(N'2026-02-06T19:30:13.540' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1239, 564, 5, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-06-16T19:30:13.540' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1240, 585, 5, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-07-15T19:30:13.550' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1241, 606, 8, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-10-17T19:30:13.560' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1242, 618, 214, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-10-29T19:30:13.567' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1243, 636, 220, N'Изменён статус', N'Промежуточное действие', CAST(N'2026-05-13T19:30:13.577' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1244, 639, 220, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-07-27T19:30:13.577' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1245, 687, 235, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-11-12T19:30:13.630' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1246, 693, 237, N'Изменён статус', N'Промежуточное действие', CAST(N'2026-02-19T19:30:13.633' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1247, 699, 239, N'Изменён статус', N'Промежуточное действие', CAST(N'2026-03-31T19:30:13.637' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1248, 714, 244, N'Изменён статус', N'Промежуточное действие', CAST(N'2026-03-27T19:30:13.643' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1249, 717, 5, N'Изменён статус', N'Промежуточное действие', CAST(N'2026-01-11T19:30:13.647' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1250, 723, 248, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-08-13T19:30:13.650' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1251, 726, 6, N'Изменён статус', N'Промежуточное действие', CAST(N'2026-02-21T19:30:13.650' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1252, 732, 4, N'Изменён статус', N'Промежуточное действие', CAST(N'2026-02-27T19:30:13.653' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1253, 735, 252, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-08-11T19:30:13.657' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1254, 750, 257, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-10-18T19:30:13.663' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1255, 762, 261, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-10-12T19:30:13.670' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1256, 768, 6, N'Изменён статус', N'Промежуточное действие', CAST(N'2026-04-05T19:30:13.670' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1257, 771, 7, N'Изменён статус', N'Промежуточное действие', CAST(N'2026-04-14T19:30:13.673' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1258, 774, 265, N'Изменён статус', N'Промежуточное действие', CAST(N'2026-05-09T19:30:13.673' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1259, 792, 8, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-08-12T19:30:13.683' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1260, 795, 6, N'Изменён статус', N'Промежуточное действие', CAST(N'2026-02-21T19:30:13.687' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1261, 816, 4, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-12-01T19:30:13.697' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1262, 840, 288, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-07-26T19:30:13.707' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1263, 873, 8, N'Изменён статус', N'Промежуточное действие', CAST(N'2025-11-23T19:30:13.723' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1264, 894, 8, N'Изменён статус', N'Промежуточное действие', CAST(N'2026-04-18T19:30:13.733' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1265, 900, 309, N'Создано', N'Обращение подано гражданином', CAST(N'2026-05-20T21:25:46.570' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1266, 900, 2, N'Изменён статус', N'Статус изменён на «В работе»', CAST(N'2026-05-20T21:29:17.837' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1267, 900, 2, N'Назначен исполнитель', N'Назначен исполнитель Смирнов И.П.', CAST(N'2026-05-20T21:30:11.793' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1268, 901, 79, N'Создано', N'Обращение подано гражданином', CAST(N'2026-05-20T21:32:33.700' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (1269, 901, 2, N'Добавлен комментарий', N'ddfdfdf', CAST(N'2026-05-20T21:38:08.747' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (2265, 262, 2, N'Изменён статус', N'Статус изменён на «Отклонено»', CAST(N'2026-05-21T21:45:25.210' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (3265, 2, 9, N'Назначен исполнитель', N'Назначен исполнитель Васильев А.Н.', CAST(N'2026-05-23T10:12:23.900' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (3266, 901, 2, N'Изменён статус', N'Статус изменён на «Отклонено»', CAST(N'2026-05-23T10:14:42.057' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (3267, 900, 2, N'Добавлен комментарий', N'кпавпвапав', CAST(N'2026-05-23T10:49:04.507' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (3268, 900, 4, N'Добавлен комментарий', N'авав', CAST(N'2026-05-23T10:49:38.987' AS DateTime))
GO
INSERT [dbo].[AppealHistory] ([HistoryID], [AppealID], [UserID], [Action], [Comment], [ActionDate]) VALUES (3269, 1900, 9, N'Создано', N'Обращение подано гражданином', CAST(N'2026-05-23T14:54:15.997' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[AppealHistory] OFF
GO
SET IDENTITY_INSERT [dbo].[ApplicationUser] ON 
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (1, N'admin', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'admin@city.ru', N'+7(000)000-00-01', N'Администраторов А.А.', N'Администратор', NULL, N'ИТ-отдел', N'Главный администратор', CAST(N'2026-05-20T19:30:12.217' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (2, N'operator1', N'e99a18c428cb38d5f260853678922e03abd833cba744db2e15e8b8b0f0c7c5c8', N'op1@city.ru', N'+7(000)000-00-02', N'Петрова О.С.', N'Оператор', NULL, N'Приёмная', N'Старший оператор', CAST(N'2026-05-20T19:30:12.217' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (3, N'operator2', N'8b7df143d91c716ecfa5fc1730022f6b421b05cedee8fd52b1fc65a96030ad52', N'op2@city.ru', N'+7(000)000-00-03', N'Сидоров В.В.', N'Оператор', NULL, N'Приёмная', N'Оператор', CAST(N'2026-05-20T19:30:12.217' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (4, N'isp1', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', N'isp1@city.ru', N'+7(000)000-00-04', N'Смирнов И.П.', N'Исполнитель', NULL, N'Отдел ЖКХ', N'Главный специалист', CAST(N'2026-05-20T19:30:12.220' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (5, N'isp2', N'd82c8d1619ad8176d665453cfb2e55f0b0c4b91d4e6e06e7bf1504b7d4b7b7b7', N'isp2@city.ru', N'+7(000)000-00-05', N'Кузнецова Е.А.', N'Исполнитель', NULL, N'Отдел благоустройства', N'Ведущий инженер', CAST(N'2026-05-20T19:30:12.220' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (6, N'isp3', N'e5e9fa1ba31ecd1ae84f75caaa474f3a663f05f4e9c5e4c4d4d4d4d4d4d4d4d4', N'isp3@city.ru', N'+7(000)000-00-06', N'Васильев А.Н.', N'Исполнитель', NULL, N'Социальный отдел', N'Социальный работник', CAST(N'2026-05-20T19:30:12.220' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (7, N'isp4', N'e5e9fa1ba31ecd1ae84f75caaa474f3a663f05f4e9c5e4c4d4d4d4d4d4d4d4d4', N'isp4@city.ru', N'+7(000)000-00-07', N'Николаев Д.С.', N'Исполнитель', NULL, N'Транспортный отдел', N'Инспектор', CAST(N'2026-05-20T19:30:12.220' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (8, N'isp5', N'e5e9fa1ba31ecd1ae84f75caaa474f3a663f05f4e9c5e4c4d4d4d4d4d4d4d4d4', N'isp5@city.ru', N'+7(000)000-00-08', N'Морозов П.В.', N'Исполнитель', NULL, N'Отдел образования', N'Методист', CAST(N'2026-05-20T19:30:12.220' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (9, N'citizen1', N'E6C3DA5B206634D7F3F3586D747FFDB36B5C675757B380C6A5FE5C570C714349', N'citizen1@mail.com', N'+7(9001)25-28', N'Гражданин 1 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.1', NULL, NULL, CAST(N'2026-05-20T19:30:12.220' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (10, N'citizen2', N'1BA3D16E9881959F8C9A9762854F72C6E6321CDD44358A10A4E939033117EAB9', N'citizen2@mail.com', N'+7(9002)93-66', N'Гражданин 2 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.2', NULL, NULL, CAST(N'2026-05-20T19:30:12.220' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (11, N'citizen3', N'3ACB59306EF6E660CF832D1D34C4FBA3D88D616F0BB5C2A9E0F82D18EF6FC167', N'citizen3@mail.com', N'+7(9003)39-42', N'Гражданин 3 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.3', NULL, NULL, CAST(N'2026-05-20T19:30:12.220' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (12, N'citizen4', N'A417B5DC3D06D15D91C6687E27FC1705EBC56B3B2D813ABE03066E5643FE4E74', N'citizen4@mail.com', N'+7(9004)19-70', N'Гражданин 4 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.4', NULL, NULL, CAST(N'2026-05-20T19:30:12.220' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (13, N'citizen5', N'0EEAC8171768D0CDEF3A20FEE6DB4362D019C91E10662A6B55186336E1A42778', N'citizen5@mail.com', N'+7(9005)39-03', N'Гражданин 5 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.5', NULL, NULL, CAST(N'2026-05-20T19:30:12.220' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (14, N'citizen6', N'5C4950C94A3461441C356AFA783F76B83B38FD65F730F291403EFBCC798ACC1F', N'citizen6@mail.com', N'+7(9006)50-08', N'Гражданин 6 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.6', NULL, NULL, CAST(N'2026-05-20T19:30:12.220' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (15, N'citizen7', N'1526F5E0E31D42FE1C3664CE923AC22AC1333417A90B32043797AC454CD03112', N'citizen7@mail.com', N'+7(9007)20-62', N'Гражданин 7 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.7', NULL, NULL, CAST(N'2026-05-20T19:30:12.220' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (16, N'citizen8', N'C8FEA5B0B76DC690FEAF5544749F99B40E78E2A37C0E867A086696509416302A', N'citizen8@mail.com', N'+7(9008)55-94', N'Гражданин 8 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.8', NULL, NULL, CAST(N'2026-05-20T19:30:12.220' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (17, N'citizen9', N'2D4589473FB3F4581D7452CD25182159D68D2A50056A0CCE35A529B010E32F2B', N'citizen9@mail.com', N'+7(9009)26-16', N'Гражданин 9 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.9', NULL, NULL, CAST(N'2026-05-20T19:30:12.220' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (18, N'citizen10', N'B35892CB8B089E03E4420B94DF688122A2B76D4AD0F8B94AD20808BB029E48A5', N'citizen10@mail.com', N'+7(9010)70-16', N'Гражданин 10 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.10', NULL, NULL, CAST(N'2026-05-20T19:30:12.220' AS DateTime), 0)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (19, N'citizen11', N'8057F787EBD8B4F9D40F53D7FBBFCBDDE7067C1A074435B68F525B3DE0E2AC2B', N'citizen11@mail.com', N'+7(9011)72-35', N'Гражданин 11 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.11', NULL, NULL, CAST(N'2026-05-20T19:30:12.220' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (20, N'citizen12', N'FDAC810D0C09F25C5DDCEE9976AB1F1AE1973DBA7C65152D95B0937BC2A6C883', N'citizen12@mail.com', N'+7(9012)17-10', N'Гражданин 12 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.12', NULL, NULL, CAST(N'2026-05-20T19:30:12.220' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (21, N'citizen13', N'1E53DE2A2B4AB888CC24002EF8832D433B21956AB83DDEEF989C8224B5C8F9F2', N'citizen13@mail.com', N'+7(9013)51-35', N'Гражданин 13 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.13', NULL, NULL, CAST(N'2026-05-20T19:30:12.220' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (22, N'citizen14', N'B78F24953963AC5ED773D6EC83120E3B1A65510201DC09ED2ED9E9781BA88870', N'citizen14@mail.com', N'+7(9014)30-80', N'Гражданин 14 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.14', NULL, NULL, CAST(N'2026-05-20T19:30:12.220' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (23, N'citizen15', N'B5A4EC869015095060B1171791334513F741177C4011E2C5C36E3E37A5FF8E5F', N'citizen15@mail.com', N'+7(9015)83-17', N'Гражданин 15 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.15', NULL, NULL, CAST(N'2026-05-20T19:30:12.220' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (24, N'citizen16', N'F0C28BA3FD9E0DCDCD0470ACFCB98CC5A58D7D93422DBBEFB930455EF714C87D', N'citizen16@mail.com', N'+7(9016)17-99', N'Гражданин 16 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.16', NULL, NULL, CAST(N'2026-05-20T19:30:12.223' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (25, N'citizen17', N'4A6B7FA040BCFC734A113FEE84D3789C0A626D70D029AFAD0D1C3E7B6C562E14', N'citizen17@mail.com', N'+7(9017)60-02', N'Гражданин 17 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.17', NULL, NULL, CAST(N'2026-05-20T19:30:12.223' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (26, N'citizen18', N'B99DDD77E59C96B13B64B3ABE1902DB4C0A76DABF8622AA6C71F8F5670BE6625', N'citizen18@mail.com', N'+7(9018)21-31', N'Гражданин 18 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.18', NULL, NULL, CAST(N'2026-05-20T19:30:12.223' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (27, N'citizen19', N'871431053023291D24B403F1F9D761C6F01B3050A0A83CD9D9759A970F8D4D92', N'citizen19@mail.com', N'+7(9019)23-61', N'Гражданин 19 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.19', NULL, NULL, CAST(N'2026-05-20T19:30:12.223' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (28, N'citizen20', N'51D11024031A8951B4722671ADFC8587538F5E5417206E7862E60752758A5C35', N'citizen20@mail.com', N'+7(9020)02-87', N'Гражданин 20 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.20', NULL, NULL, CAST(N'2026-05-20T19:30:12.223' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (29, N'citizen21', N'2D6B3BB57CB9E22FA36516172EF096B30AE00D08EEDC1499C599B6269975521D', N'citizen21@mail.com', N'+7(9021)60-71', N'Гражданин 21 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.21', NULL, NULL, CAST(N'2026-05-20T19:30:12.223' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (30, N'citizen22', N'D0F82756C4D40D20E1FDBC90CF4DA4ADFF02FE23B355687525880514642F764E', N'citizen22@mail.com', N'+7(9022)46-66', N'Гражданин 22 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.22', NULL, NULL, CAST(N'2026-05-20T19:30:12.223' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (31, N'citizen23', N'8893186D24CCE07E1C82F2E020D41177E699318B4BE9535483FDF55EDF58CD50', N'citizen23@mail.com', N'+7(9023)22-37', N'Гражданин 23 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.23', NULL, NULL, CAST(N'2026-05-20T19:30:12.223' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (32, N'citizen24', N'CAFDC894EACC597AD76DB1A750CCB876D4ED69C73B7D3D23F5E3A9E3B5C9FC2E', N'citizen24@mail.com', N'+7(9024)56-80', N'Гражданин 24 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.24', NULL, NULL, CAST(N'2026-05-20T19:30:12.223' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (33, N'citizen25', N'0028E1C0D2C60966390545414567D33BCA9F0165FECE6D0109C59A3F29B5FDD0', N'citizen25@mail.com', N'+7(9025)26-98', N'Гражданин 25 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.25', NULL, NULL, CAST(N'2026-05-20T19:30:12.223' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (34, N'citizen26', N'45E17065DDC6FB3A682F7732DF5804652952DBE1F5CA5377A661515A8FCF66BE', N'citizen26@mail.com', N'+7(9026)60-66', N'Гражданин 26 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.26', NULL, NULL, CAST(N'2026-05-20T19:30:12.223' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (35, N'citizen27', N'43B3EC9EA3961A319D37B4CC775D3F43F68709B62A93DB10DD6C598137F28732', N'citizen27@mail.com', N'+7(9027)96-13', N'Гражданин 27 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.27', NULL, NULL, CAST(N'2026-05-20T19:30:12.223' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (36, N'citizen28', N'034A0CDF079DFA3CA924E07E3C509BBF50768D1949B021C0EA0030CFF80BA4D1', N'citizen28@mail.com', N'+7(9028)24-49', N'Гражданин 28 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.28', NULL, NULL, CAST(N'2026-05-20T19:30:12.223' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (37, N'citizen29', N'53F6F072E26D36B9E55D5DC828872856D5286F18CE3818D367F9E4473E464A66', N'citizen29@mail.com', N'+7(9029)35-87', N'Гражданин 29 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.29', NULL, NULL, CAST(N'2026-05-20T19:30:12.223' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (38, N'citizen30', N'85FCBE6BF830F23209EA6A932921E8DA31A653A24A20CB84E75C4997E505690B', N'citizen30@mail.com', N'+7(9030)43-35', N'Гражданин 30 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.30', NULL, NULL, CAST(N'2026-05-20T19:30:12.227' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (39, N'citizen31', N'3B3AD733C8571384C133694595C33D96C638B36F08A484BD0AD38BF312FDB294', N'citizen31@mail.com', N'+7(9031)81-12', N'Гражданин 31 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.31', NULL, NULL, CAST(N'2026-05-20T19:30:12.227' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (40, N'citizen32', N'451A8149EBD58DBD064E3337C6DE5D4F4BB08CD70BBBD48D62A205BD706B6BB0', N'citizen32@mail.com', N'+7(9032)24-37', N'Гражданин 32 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.32', NULL, NULL, CAST(N'2026-05-20T19:30:12.227' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (41, N'citizen33', N'0756810289814362EFBEA8BB826FEA0A7BC4318A7F22A4B27B48290CD39951A3', N'citizen33@mail.com', N'+7(9033)53-67', N'Гражданин 33 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.33', NULL, NULL, CAST(N'2026-05-20T19:30:12.227' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (42, N'citizen34', N'94CD5DB06BAF087FD56C0042ADC1DEB162D271ACFB8B3EB0277069517998D489', N'citizen34@mail.com', N'+7(9034)89-60', N'Гражданин 34 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.34', NULL, NULL, CAST(N'2026-05-20T19:30:12.227' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (43, N'citizen35', N'5A66C7BA1398DD71C92A77CC7647C4183E6BF97B227E441BB2674A319B184E63', N'citizen35@mail.com', N'+7(9035)00-40', N'Гражданин 35 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.35', NULL, NULL, CAST(N'2026-05-20T19:30:12.227' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (44, N'citizen36', N'133F8A05107E5442771C85DA3DEC70050AE5F3273849326B4A4E2CEAAB2EF058', N'citizen36@mail.com', N'+7(9036)89-08', N'Гражданин 36 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.36', NULL, NULL, CAST(N'2026-05-20T19:30:12.227' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (45, N'citizen37', N'1A31AC086EBF1341C916929E6D982767CD8568887D7C930BA8ABD062AFA08EAC', N'citizen37@mail.com', N'+7(9037)38-30', N'Гражданин 37 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.37', NULL, NULL, CAST(N'2026-05-20T19:30:12.227' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (46, N'citizen38', N'B64171FDA74426604480B9BF7C10CCDC2EBC80266C8667C42346F54CE87D4DEC', N'citizen38@mail.com', N'+7(9038)03-43', N'Гражданин 38 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.38', NULL, NULL, CAST(N'2026-05-20T19:30:12.227' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (47, N'citizen39', N'099646084ABBBC2C403C480BEA87E7DE23CE18DB73A3E28251EFFEF3ED49F1EA', N'citizen39@mail.com', N'+7(9039)34-86', N'Гражданин 39 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.39', NULL, NULL, CAST(N'2026-05-20T19:30:12.227' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (48, N'citizen40', N'D88A53CD8FFE65AB18D2C62882479559AA781642CE7A8D340B22FC0A637B0359', N'citizen40@mail.com', N'+7(9040)19-81', N'Гражданин 40 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.40', NULL, NULL, CAST(N'2026-05-20T19:30:12.227' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (49, N'citizen41', N'A8A5146B1F97C2C8987CCB3A87D2F30B8AA258C2A32CB96115BF381D42DF875C', N'citizen41@mail.com', N'+7(9041)07-20', N'Гражданин 41 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.41', NULL, NULL, CAST(N'2026-05-20T19:30:12.230' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (50, N'citizen42', N'DE3543C757D459090B9ADAF9A80A54D54724A0F1600D4C77D6017DDE58CF1189', N'citizen42@mail.com', N'+7(9042)04-77', N'Гражданин 42 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.42', NULL, NULL, CAST(N'2026-05-20T19:30:12.230' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (51, N'citizen43', N'DB9AA0719DBF5CAC40E44B268042014E9BC28B4134DF9051A35F8C64F6603B6F', N'citizen43@mail.com', N'+7(9043)82-47', N'Гражданин 43 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.43', NULL, NULL, CAST(N'2026-05-20T19:30:12.230' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (52, N'citizen44', N'147EB7DD0F4C59120BE8ADB20F9DC4D4A0CCB27A0D48D7546DFA171DD980F075', N'citizen44@mail.com', N'+7(9044)50-44', N'Гражданин 44 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.44', NULL, NULL, CAST(N'2026-05-20T19:30:12.230' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (53, N'citizen45', N'64BF83FCF172A284E3DB6B4CC76BB175184EE9DD57E77F0421E3E401EA3858E0', N'citizen45@mail.com', N'+7(9045)80-16', N'Гражданин 45 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.45', NULL, NULL, CAST(N'2026-05-20T19:30:12.230' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (54, N'citizen46', N'3F1B954C84D8216E09AE793664571DEDB1E1BCC9A2BFDC2B6DC58DB9A24FA7DE', N'citizen46@mail.com', N'+7(9046)86-50', N'Гражданин 46 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.46', NULL, NULL, CAST(N'2026-05-20T19:30:12.230' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (55, N'citizen47', N'DBB70B94B6B192A1085E8056872DAA4EB24002D47C82E88B1323F1A5882567BA', N'citizen47@mail.com', N'+7(9047)66-14', N'Гражданин 47 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.47', NULL, NULL, CAST(N'2026-05-20T19:30:12.230' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (56, N'citizen48', N'FFE4DAF45AF0E803FBE1FBA2DE5C7F7644F30B71DDB082100779D7884E0291C2', N'citizen48@mail.com', N'+7(9048)42-29', N'Гражданин 48 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.48', NULL, NULL, CAST(N'2026-05-20T19:30:12.230' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (57, N'citizen49', N'A0C69AE7AD7629347D41A89D9A558B26BD9B126A3A183F3498444843ACD7270D', N'citizen49@mail.com', N'+7(9049)20-28', N'Гражданин 49 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.49', NULL, NULL, CAST(N'2026-05-20T19:30:12.230' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (58, N'citizen50', N'BE46E03449534372E45F1ABF511F78148625CF11D99F2F550E2F32B3A551DFB6', N'citizen50@mail.com', N'+7(9050)08-02', N'Гражданин 50 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.50', NULL, NULL, CAST(N'2026-05-20T19:30:12.230' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (59, N'citizen51', N'CC35E4B303C84633F2E64C1FE30A9C2F9E0F1DCDD53D1A748451B83164DB475A', N'citizen51@mail.com', N'+7(9051)49-21', N'Гражданин 51 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.51', NULL, NULL, CAST(N'2026-05-20T19:30:12.230' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (60, N'citizen52', N'F511F615CD867553EDD2FC66F4DC34441851F699CC1457F767C5EC0BAD8CD250', N'citizen52@mail.com', N'+7(9052)97-22', N'Гражданин 52 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.52', NULL, NULL, CAST(N'2026-05-20T19:30:12.230' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (61, N'citizen53', N'F75B853A4521962CA5D349E4CA4CB69DCE2DBFEF61731CB9D14F1F2F1B6499FE', N'citizen53@mail.com', N'+7(9053)83-21', N'Гражданин 53 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.53', NULL, NULL, CAST(N'2026-05-20T19:30:12.230' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (62, N'citizen54', N'DB383DB8666C1C7F372E49B801A0405E0DD4193AB772163521B16E78879FA334', N'citizen54@mail.com', N'+7(9054)43-75', N'Гражданин 54 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.54', NULL, NULL, CAST(N'2026-05-20T19:30:12.230' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (63, N'citizen55', N'D6F7ADABABFD90706CC787591CDAF547F91D53ABCB9008A180D90FC3D4F651E2', N'citizen55@mail.com', N'+7(9055)75-88', N'Гражданин 55 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.55', NULL, NULL, CAST(N'2026-05-20T19:30:12.230' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (64, N'citizen56', N'BACB5D03BEE1AF445B7CC73BA8DB52A7FC01D474327C87899831FFE3B4C3543B', N'citizen56@mail.com', N'+7(9056)61-82', N'Гражданин 56 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.56', NULL, NULL, CAST(N'2026-05-20T19:30:12.230' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (65, N'citizen57', N'3B356CDBAEB3D03A6B6F713A048489D62FD63B4A8FD0C70A976CB0B70C119E46', N'citizen57@mail.com', N'+7(9057)54-25', N'Гражданин 57 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.57', NULL, NULL, CAST(N'2026-05-20T19:30:12.230' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (66, N'citizen58', N'DAA7C4BC3F1506B52B2BCC7864DB9A96AEE3EC1A8A68B29C5DB60DE1F8A6918B', N'citizen58@mail.com', N'+7(9058)66-97', N'Гражданин 58 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.58', NULL, NULL, CAST(N'2026-05-20T19:30:12.233' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (67, N'citizen59', N'E5E0E771C99778AEF6F0046ADB86A3D3E3EDE2C68F43AAE6B4EE9D498709328B', N'citizen59@mail.com', N'+7(9059)87-28', N'Гражданин 59 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.59', NULL, NULL, CAST(N'2026-05-20T19:30:12.233' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (68, N'citizen60', N'598ED9422E3D9C328F48CAFC2C66A66A3D393B64290F7741D60E6E22C03CA031', N'citizen60@mail.com', N'+7(9060)57-72', N'Гражданин 60 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.60', NULL, NULL, CAST(N'2026-05-20T19:30:12.233' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (69, N'citizen61', N'DA3DF0F1C138CC7B9E79E218587A605E12B7A9B9AC24E1287DA5ED056CF10C22', N'citizen61@mail.com', N'+7(9061)32-11', N'Гражданин 61 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.61', NULL, NULL, CAST(N'2026-05-20T19:30:12.233' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (70, N'citizen62', N'9B857DC1D1DC03B131BDB429B972F5F28C7D72B8466A22D54C359C48D19551FE', N'citizen62@mail.com', N'+7(9062)13-92', N'Гражданин 62 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.62', NULL, NULL, CAST(N'2026-05-20T19:30:12.233' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (71, N'citizen63', N'7E251EA07D59CD5FC9D7D1DC4225104E474B93D6C6881797DFBFA010774D4ACB', N'citizen63@mail.com', N'+7(9063)19-24', N'Гражданин 63 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.63', NULL, NULL, CAST(N'2026-05-20T19:30:12.233' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (72, N'citizen64', N'51031E17CE0A58242BF97F01A2883D077C6DD21F22674EE500DBFB60228851E7', N'citizen64@mail.com', N'+7(9064)91-85', N'Гражданин 64 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.64', NULL, NULL, CAST(N'2026-05-20T19:30:12.233' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (73, N'citizen65', N'3C62426F46EBB414FF53540C6F1AF32639C28B434126AE98B9F1651DD5E4FD4A', N'citizen65@mail.com', N'+7(9065)72-02', N'Гражданин 65 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.65', NULL, NULL, CAST(N'2026-05-20T19:30:12.233' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (74, N'citizen66', N'06599C96E52FF54F21E65CEC89DF4B96CE519704136D6F7246A56BE613EED8FB', N'citizen66@mail.com', N'+7(9066)42-93', N'Гражданин 66 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.66', NULL, NULL, CAST(N'2026-05-20T19:30:12.233' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (75, N'citizen67', N'8A110E75A8142AB756BABE02160548ED6C254AE3FD931B297AA4EDBA91065732', N'citizen67@mail.com', N'+7(9067)27-93', N'Гражданин 67 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.67', NULL, NULL, CAST(N'2026-05-20T19:30:12.233' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (76, N'citizen68', N'5A583FAB00AA1C17ACAAD80B2B9B5A16A8563E7E66808BF4B4ACBFB55D9B85D4', N'citizen68@mail.com', N'+7(9068)54-06', N'Гражданин 68 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.68', NULL, NULL, CAST(N'2026-05-20T19:30:12.233' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (77, N'citizen69', N'667D45D6D55C4FE6A7239BB554854E3B8FC0B392ABEA73864E91104BB1B4581D', N'citizen69@mail.com', N'+7(9069)28-77', N'Гражданин 69 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.69', NULL, NULL, CAST(N'2026-05-20T19:30:12.233' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (78, N'citizen70', N'44B6DADF9835FF29D5342DA14DFAF76E3D828081A1704B131BAA355F950E6047', N'citizen70@mail.com', N'+7(9070)67-73', N'Гражданин 70 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.70', NULL, NULL, CAST(N'2026-05-20T19:30:12.237' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (79, N'citizen71', N'A06AFAF373A81A1BCD1641FDD0F8B9C2C0D7104171ABAFBD80D11E933A9C6A13', N'citizen71@mail.com', N'+7(9071)08-91', N'Гражданин 71 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.71', NULL, NULL, CAST(N'2026-05-20T19:30:12.237' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (80, N'citizen72', N'79DB1E22563AF60BE55A3717827926B76139D2428CBE693EBA1643C2798E048D', N'citizen72@mail.com', N'+7(9072)75-91', N'Гражданин 72 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.72', NULL, NULL, CAST(N'2026-05-20T19:30:12.237' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (81, N'citizen73', N'25AC9B17F8113CEDA4E3B18B639AC0C5821FA6CF61E31A4B2CAFEC4573B89522', N'citizen73@mail.com', N'+7(9073)77-00', N'Гражданин 73 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.73', NULL, NULL, CAST(N'2026-05-20T19:30:12.237' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (82, N'citizen74', N'EFACF97ED63D8D618E5C1F03E2FBD3656ED4C97BA04ABF6DB791534B425641C2', N'citizen74@mail.com', N'+7(9074)98-83', N'Гражданин 74 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.74', NULL, NULL, CAST(N'2026-05-20T19:30:12.237' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (83, N'citizen75', N'AAA88F12093DDCA8064CDB97BF7635D7CD82C94D264121133F79F24E9B645BF1', N'citizen75@mail.com', N'+7(9075)19-01', N'Гражданин 75 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.75', NULL, NULL, CAST(N'2026-05-20T19:30:12.237' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (84, N'citizen76', N'55E315FACE2C7BCFC4B1D43BE3A863E3BBB565AD3DAFE30A9DD45B51B190BE9D', N'citizen76@mail.com', N'+7(9076)72-61', N'Гражданин 76 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.76', NULL, NULL, CAST(N'2026-05-20T19:30:12.237' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (85, N'citizen77', N'2590D18604C282FF195459DB33D0AE2CAAB98B14D4CBFDFD4DC3ED4923BF31B8', N'citizen77@mail.com', N'+7(9077)01-40', N'Гражданин 77 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.77', NULL, NULL, CAST(N'2026-05-20T19:30:12.237' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (86, N'citizen78', N'70DFB731F9ECFB0C9015B28838281E2A3CDE900A791C45532154DDB5A95ED31B', N'citizen78@mail.com', N'+7(9078)19-88', N'Гражданин 78 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.78', NULL, NULL, CAST(N'2026-05-20T19:30:12.237' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (87, N'citizen79', N'F46C534EA1CB330122334BE00303592A10BCBBC238D1B11E1B498D4486D13755', N'citizen79@mail.com', N'+7(9079)03-22', N'Гражданин 79 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.79', NULL, NULL, CAST(N'2026-05-20T19:30:12.237' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (88, N'citizen80', N'A5276C24114971ECEB4D5149894034741BCF22825B30C39942FF63007E031956', N'citizen80@mail.com', N'+7(9080)94-93', N'Гражданин 80 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.80', NULL, NULL, CAST(N'2026-05-20T19:30:12.237' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (89, N'citizen81', N'7137BC5132A11C4937A830C4F594A551B18D0764F66F8478DE3DB48377F2B611', N'citizen81@mail.com', N'+7(9081)79-19', N'Гражданин 81 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.81', NULL, NULL, CAST(N'2026-05-20T19:30:12.237' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (90, N'citizen82', N'CA619ACDADD8EB0F598C954031B5F359A2FBD4FE0179EB02ACFEAB2AD373C999', N'citizen82@mail.com', N'+7(9082)63-46', N'Гражданин 82 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.82', NULL, NULL, CAST(N'2026-05-20T19:30:12.237' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (91, N'citizen83', N'DD76076F40644E9E57F7459BFC37B2EF8B7084BDA5A3127C24A62C86DD45EB0B', N'citizen83@mail.com', N'+7(9083)37-87', N'Гражданин 83 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.83', NULL, NULL, CAST(N'2026-05-20T19:30:12.237' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (92, N'citizen84', N'11EE91BDBB90B967D18E45226BD3BC17D72A85A4486315B3568D070722445FE1', N'citizen84@mail.com', N'+7(9084)21-97', N'Гражданин 84 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.84', NULL, NULL, CAST(N'2026-05-20T19:30:12.237' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (93, N'citizen85', N'CFECDF5846F8E8279F4DCF79A2135308E11C0D283175A2FB79B33B76F487CB24', N'citizen85@mail.com', N'+7(9085)77-35', N'Гражданин 85 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.85', NULL, NULL, CAST(N'2026-05-20T19:30:12.237' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (94, N'citizen86', N'3C0C8E2F0527574ED275F4FC831AF606B283370490F9C39C7389FB5D16DD6AC8', N'citizen86@mail.com', N'+7(9086)65-87', N'Гражданин 86 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.86', NULL, NULL, CAST(N'2026-05-20T19:30:12.237' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (95, N'citizen87', N'4A2EFE616F41F27F583D7E1E628A7B019F2B2603677AE0216D14559EEFB83975', N'citizen87@mail.com', N'+7(9087)44-56', N'Гражданин 87 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.87', NULL, NULL, CAST(N'2026-05-20T19:30:12.237' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (96, N'citizen88', N'1D45A36925BCB8F729F8F06EE0EC689F440CC6B08C3A0573ED12E10104E1E9A0', N'citizen88@mail.com', N'+7(9088)92-44', N'Гражданин 88 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.88', NULL, NULL, CAST(N'2026-05-20T19:30:12.237' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (97, N'citizen89', N'9D57EE06AAC896609727855ADD2CFC3D9C50CD545395974CDEE219C91E29FD25', N'citizen89@mail.com', N'+7(9089)07-98', N'Гражданин 89 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.89', NULL, NULL, CAST(N'2026-05-20T19:30:12.240' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (98, N'citizen90', N'A4273F882CAB7A89E7FA8E5A1298799B62233ADA8A93F880F58BBD87DB44D6A3', N'citizen90@mail.com', N'+7(9090)20-80', N'Гражданин 90 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.90', NULL, NULL, CAST(N'2026-05-20T19:30:12.240' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (99, N'citizen91', N'7F6CECA338F7FE1BB409870C95CBF5009115DF953AF77A91EF912A11CF6423C7', N'citizen91@mail.com', N'+7(9091)44-35', N'Гражданин 91 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.91', NULL, NULL, CAST(N'2026-05-20T19:30:12.240' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (100, N'citizen92', N'905026A6DDAB21A9D1DCA17CC4F47B843ECCD1C4806F7F3C59B88CDAC12E339F', N'citizen92@mail.com', N'+7(9092)84-13', N'Гражданин 92 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.92', NULL, NULL, CAST(N'2026-05-20T19:30:12.240' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (101, N'citizen93', N'3DCC4D43A91AE471BE9FB0DFB7E7A44DCBAF8125B389D65D38604EC5582825EC', N'citizen93@mail.com', N'+7(9093)92-02', N'Гражданин 93 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.93', NULL, NULL, CAST(N'2026-05-20T19:30:12.240' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (102, N'citizen94', N'3FDD6E2FCAE488C7C7818992AD08249CD0F6576F6FF846BCECAA816E002CDE3C', N'citizen94@mail.com', N'+7(9094)11-05', N'Гражданин 94 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.94', NULL, NULL, CAST(N'2026-05-20T19:30:12.240' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (103, N'citizen95', N'B3F20FF60A6E1EDA26F8C412E7173C7EE7F5B3A1124B87A38D3DEB63274C1A61', N'citizen95@mail.com', N'+7(9095)20-06', N'Гражданин 95 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.95', NULL, NULL, CAST(N'2026-05-20T19:30:12.240' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (104, N'citizen96', N'38EE64C8E2536E41E2543266F6A5216747B24C8B8ADA7D5F7CFBA8B1E80752FB', N'citizen96@mail.com', N'+7(9096)33-61', N'Гражданин 96 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.96', NULL, NULL, CAST(N'2026-05-20T19:30:12.240' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (105, N'citizen97', N'7F5106053C87018F57187A0A485DEDACB2EF37F08F05AB2313F23217A9EE928B', N'citizen97@mail.com', N'+7(9097)80-99', N'Гражданин 97 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.97', NULL, NULL, CAST(N'2026-05-20T19:30:12.240' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (106, N'citizen98', N'125E175312B42CA54475207F1AD47DF9AC421DD758FCC5C2AB19AE31E451CC53', N'citizen98@mail.com', N'+7(9098)91-95', N'Гражданин 98 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.98', NULL, NULL, CAST(N'2026-05-20T19:30:12.240' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (107, N'citizen99', N'AB2F50FE825BC3A9A8B649F173AF23BE3A052DB9B410FCB0127E50AE9C356BA7', N'citizen99@mail.com', N'+7(9099)06-66', N'Гражданин 99 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.99', NULL, NULL, CAST(N'2026-05-20T19:30:12.240' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (108, N'citizen100', N'29BF72F8D89F83E2FCA11F01A530B0C39058B8FD0B0563ACA173D2C624C71FFB', N'citizen100@mail.com', N'+7(9100)01-35', N'Гражданин 100 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.100', NULL, NULL, CAST(N'2026-05-20T19:30:12.240' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (109, N'citizen101', N'2BD2A833384945BE5A4D05109F418ACBC78CC41D7640842F0E881BA892651296', N'citizen101@mail.com', N'+7(9101)15-10', N'Гражданин 101 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.101', NULL, NULL, CAST(N'2026-05-20T19:30:12.240' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (110, N'citizen102', N'68B5AA742A3C02D41CA5C6582F9EB685AE72218E0C93680F91D51086D45E67DF', N'citizen102@mail.com', N'+7(9102)12-16', N'Гражданин 102 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.102', NULL, NULL, CAST(N'2026-05-20T19:30:12.240' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (111, N'citizen103', N'9E436B2455B7D1B818D56B04B8985D84AC27E7FB45630E579F7B0695430FBAB5', N'citizen103@mail.com', N'+7(9103)71-09', N'Гражданин 103 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.103', NULL, NULL, CAST(N'2026-05-20T19:30:12.240' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (112, N'citizen104', N'34158B36B0DCCB351AD920CF5EBB74820D7825119C647B16DB4F535BFEF25C65', N'citizen104@mail.com', N'+7(9104)72-96', N'Гражданин 104 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.104', NULL, NULL, CAST(N'2026-05-20T19:30:12.240' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (113, N'citizen105', N'ACB3085AC0FA0CE03AF7E46DA8E5AC3BBB2C03D6A28CFA95C778DAA5D525412B', N'citizen105@mail.com', N'+7(9105)44-79', N'Гражданин 105 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.105', NULL, NULL, CAST(N'2026-05-20T19:30:12.240' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (114, N'citizen106', N'D0F775036F29BA7540BE994605826AB25B7F153A1D8157E5E09218B8FA59AA91', N'citizen106@mail.com', N'+7(9106)06-08', N'Гражданин 106 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.106', NULL, NULL, CAST(N'2026-05-20T19:30:12.240' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (115, N'citizen107', N'225ADBCA5F1445B65F065079FD6B3FDDA829B6E660554B6200E86FE4A129672E', N'citizen107@mail.com', N'+7(9107)43-38', N'Гражданин 107 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.107', NULL, NULL, CAST(N'2026-05-20T19:30:12.240' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (116, N'citizen108', N'02548935A13223836DC0FDFA7574D4ADC6BD5B60A99296CC54CEFE1E7103FBCD', N'citizen108@mail.com', N'+7(9108)49-45', N'Гражданин 108 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.108', NULL, NULL, CAST(N'2026-05-20T19:30:12.240' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (117, N'citizen109', N'CF78821E30A469451BBB37EB5BD9976EA68D77EA3DD54AC3DFD83DE5CF91EBA5', N'citizen109@mail.com', N'+7(9109)62-63', N'Гражданин 109 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.109', NULL, NULL, CAST(N'2026-05-20T19:30:12.240' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (118, N'citizen110', N'8F3B97E5C348A48D4CDE1CF58B7746221CC4F23B1471CB7B530A4E4B7AC5B887', N'citizen110@mail.com', N'+7(9110)07-38', N'Гражданин 110 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.110', NULL, NULL, CAST(N'2026-05-20T19:30:12.243' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (119, N'citizen111', N'B2C56341CC2B9F8BF898BD7528DD39E641B51C4FBD51F241B46AD70872DD1B99', N'citizen111@mail.com', N'+7(9111)30-67', N'Гражданин 111 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.111', NULL, NULL, CAST(N'2026-05-20T19:30:12.243' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (120, N'citizen112', N'A1F5626F394C753975A9060627B1894E2C82436D7D9FB6103F58455641771682', N'citizen112@mail.com', N'+7(9112)55-93', N'Гражданин 112 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.112', NULL, NULL, CAST(N'2026-05-20T19:30:12.243' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (121, N'citizen113', N'D2D8FDD3E123C147CA908C7FEC41C7FE5746E7CC1B90E3507859AB0A7A0212D1', N'citizen113@mail.com', N'+7(9113)92-07', N'Гражданин 113 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.113', NULL, NULL, CAST(N'2026-05-20T19:30:12.243' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (122, N'citizen114', N'6A4CA776C3EF0C0D69107200FF1FF66217511AAB72E032962FB5D6C01AABB158', N'citizen114@mail.com', N'+7(9114)15-98', N'Гражданин 114 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.114', NULL, NULL, CAST(N'2026-05-20T19:30:12.243' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (123, N'citizen115', N'62FBF022FF434C1CF42EED2A12C109388AF61EA661A1CF75E8A16B45F0063C77', N'citizen115@mail.com', N'+7(9115)25-39', N'Гражданин 115 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.115', NULL, NULL, CAST(N'2026-05-20T19:30:12.243' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (124, N'citizen116', N'747FF88FD5750FF3FF02E7B5BD02508EB0C9DBAEE5BB5D472FC9393878C8A733', N'citizen116@mail.com', N'+7(9116)13-03', N'Гражданин 116 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.116', NULL, NULL, CAST(N'2026-05-20T19:30:12.243' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (125, N'citizen117', N'96A194C82BF3B9E984CF3740C3A29632C9F2AC55A35D46A5C719C6FF65823D24', N'citizen117@mail.com', N'+7(9117)51-51', N'Гражданин 117 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.117', NULL, NULL, CAST(N'2026-05-20T19:30:12.243' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (126, N'citizen118', N'B48166B6083B5CC4BECDA5BF00282ABF57C1166B1D4E9C65F59BE95659320E39', N'citizen118@mail.com', N'+7(9118)09-74', N'Гражданин 118 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.118', NULL, NULL, CAST(N'2026-05-20T19:30:12.243' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (127, N'citizen119', N'3F5A78FDFF13749416CD1F00E6919427A387C843F78E3FE11DDA1F471198276E', N'citizen119@mail.com', N'+7(9119)11-46', N'Гражданин 119 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.119', NULL, NULL, CAST(N'2026-05-20T19:30:12.243' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (128, N'citizen120', N'8FCA772F847CD309EE9F795D10AA141AC4BEF4D87F4B80272E2573CD51010EA1', N'citizen120@mail.com', N'+7(9120)04-95', N'Гражданин 120 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.120', NULL, NULL, CAST(N'2026-05-20T19:30:12.243' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (129, N'citizen121', N'3FE239DFB6207AA4E467245CABC3A8221E5F15F0414B3B60371EFE7A05AAF1B4', N'citizen121@mail.com', N'+7(9121)66-81', N'Гражданин 121 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.121', NULL, NULL, CAST(N'2026-05-20T19:30:12.243' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (130, N'citizen122', N'882363CD1C89DC3169B92A33947BB42AD60E975B8A4D177989C6AE2F013DE721', N'citizen122@mail.com', N'+7(9122)29-76', N'Гражданин 122 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.122', NULL, NULL, CAST(N'2026-05-20T19:30:12.243' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (131, N'citizen123', N'9B8769A4A742959A2D0298C36FB70623F2DFACDA8436237DF08D8DFD5B37374C', N'citizen123@mail.com', N'+7(9123)02-61', N'Гражданин 123 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.123', NULL, NULL, CAST(N'2026-05-20T19:30:12.243' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (132, N'citizen124', N'67DA66DB02BBD90735C73E948BD5B8222A60A884554B217EB066F89B70C264E8', N'citizen124@mail.com', N'+7(9124)96-35', N'Гражданин 124 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.124', NULL, NULL, CAST(N'2026-05-20T19:30:12.243' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (133, N'citizen125', N'51E126A6E7BDEC24C7E7B07E1C86C5FD6D1FC674ED560C5B2133335384A54C95', N'citizen125@mail.com', N'+7(9125)45-45', N'Гражданин 125 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.125', NULL, NULL, CAST(N'2026-05-20T19:30:12.243' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (134, N'citizen126', N'94FDD9E803F50AD10E634EED483D01F83DB8326AA393A68CEDB6E2D32C996ADE', N'citizen126@mail.com', N'+7(9126)47-87', N'Гражданин 126 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.126', NULL, NULL, CAST(N'2026-05-20T19:30:12.243' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (135, N'citizen127', N'B2AA39291446250A4963B308653ABB9FC746C72777759F3E6708FA6CF8FB1900', N'citizen127@mail.com', N'+7(9127)38-59', N'Гражданин 127 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.127', NULL, NULL, CAST(N'2026-05-20T19:30:12.243' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (136, N'citizen128', N'C9148C9FD5A65E12B6D924EFDBA0F36195C78B9C1C7CDD4755817DAF32DC174F', N'citizen128@mail.com', N'+7(9128)66-73', N'Гражданин 128 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.128', NULL, NULL, CAST(N'2026-05-20T19:30:12.247' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (137, N'citizen129', N'2A8ECCF0310F27A038297A74B99FE76A7887CE332D8F73610CAB88F5E8FAC637', N'citizen129@mail.com', N'+7(9129)24-13', N'Гражданин 129 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.129', NULL, NULL, CAST(N'2026-05-20T19:30:12.247' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (138, N'citizen130', N'6F3C808B0C349BF9310731E29AAE8BEB5C978A73878E4D3CDC5C7B7E7423BB18', N'citizen130@mail.com', N'+7(9130)31-45', N'Гражданин 130 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.130', NULL, NULL, CAST(N'2026-05-20T19:30:12.247' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (139, N'citizen131', N'C1D095050623A101F1BE6E2DA08F4DA86227310FB360DC566551DE880EFC22E3', N'citizen131@mail.com', N'+7(9131)09-21', N'Гражданин 131 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.131', NULL, NULL, CAST(N'2026-05-20T19:30:12.247' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (140, N'citizen132', N'309379267483B31FEA2FA71BE956C1B5992F9107AE601D46E15275152E293F35', N'citizen132@mail.com', N'+7(9132)61-62', N'Гражданин 132 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.132', NULL, NULL, CAST(N'2026-05-20T19:30:12.247' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (141, N'citizen133', N'B842B6339C1900EFB74F09FD8DC048BB50C1E7BCB179964ED31207C0E9C7DECC', N'citizen133@mail.com', N'+7(9133)85-57', N'Гражданин 133 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.133', NULL, NULL, CAST(N'2026-05-20T19:30:12.247' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (142, N'citizen134', N'2E8F49F90946F2DE44E4E900D85AD1DA5887C5FEAFF24E467F06742FFEAB686B', N'citizen134@mail.com', N'+7(9134)11-85', N'Гражданин 134 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.134', NULL, NULL, CAST(N'2026-05-20T19:30:12.247' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (143, N'citizen135', N'9B1B6A52450435B5C61ACFC1765542D8BB8D4E023327B2A87827FB89CAB2BFF3', N'citizen135@mail.com', N'+7(9135)95-87', N'Гражданин 135 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.135', NULL, NULL, CAST(N'2026-05-20T19:30:12.247' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (144, N'citizen136', N'4450BF0C02623F832C7F7F93FC067F085BC95162D345FE1E95E640B294735E0A', N'citizen136@mail.com', N'+7(9136)78-93', N'Гражданин 136 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.136', NULL, NULL, CAST(N'2026-05-20T19:30:12.247' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (145, N'citizen137', N'00F78AFF5B35171A4A10AC9BAD5ECCC121AC4E678CB74BAB0E71BFB972AB7AD6', N'citizen137@mail.com', N'+7(9137)55-48', N'Гражданин 137 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.137', NULL, NULL, CAST(N'2026-05-20T19:30:12.247' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (146, N'citizen138', N'BC647EF28B901E09E8B5C373ECA43BA2C64611247D70ECC973DBBFA49A385E53', N'citizen138@mail.com', N'+7(9138)26-23', N'Гражданин 138 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.138', NULL, NULL, CAST(N'2026-05-20T19:30:12.247' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (147, N'citizen139', N'B883DC59E83D063F0AD1C5FC917D5C95DF10349C2A5EAA0054D40448D0E30261', N'citizen139@mail.com', N'+7(9139)74-62', N'Гражданин 139 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.139', NULL, NULL, CAST(N'2026-05-20T19:30:12.247' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (148, N'citizen140', N'C5585B8E6481359E9115EE634E6E7D347FDD2CCE19C36A450F388643D8FBF3D9', N'citizen140@mail.com', N'+7(9140)02-30', N'Гражданин 140 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.140', NULL, NULL, CAST(N'2026-05-20T19:30:12.247' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (149, N'citizen141', N'CD75D9010F6F120A32361BA9E26396FDAB2F2122602FABE818321F42F09F5D20', N'citizen141@mail.com', N'+7(9141)52-99', N'Гражданин 141 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.141', NULL, NULL, CAST(N'2026-05-20T19:30:12.247' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (150, N'citizen142', N'B2DB914133C89E6A0798C08136A40E0810B869816C44AAB5F2C98F4BD210EAC3', N'citizen142@mail.com', N'+7(9142)50-23', N'Гражданин 142 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.142', NULL, NULL, CAST(N'2026-05-20T19:30:12.247' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (151, N'citizen143', N'C3B87469726089DA03985E426738BADFC40B00048C383CAEB8784762A9C760DC', N'citizen143@mail.com', N'+7(9143)13-28', N'Гражданин 143 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.143', NULL, NULL, CAST(N'2026-05-20T19:30:12.247' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (152, N'citizen144', N'8A46261B0B1A264E19114BFA09C64B289DC93819D9978349177CBFC1C7098538', N'citizen144@mail.com', N'+7(9144)69-11', N'Гражданин 144 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.144', NULL, NULL, CAST(N'2026-05-20T19:30:12.247' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (153, N'citizen145', N'0738F94C476BDDC7E78C286EBE8836875E9A247B192BADF4A1CDA2307BE6861F', N'citizen145@mail.com', N'+7(9145)93-66', N'Гражданин 145 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.145', NULL, NULL, CAST(N'2026-05-20T19:30:12.247' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (154, N'citizen146', N'2B9A57088CBDF4386BAFEDC5A3653538613587198532C24E7A40DA3208150A77', N'citizen146@mail.com', N'+7(9146)88-39', N'Гражданин 146 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.146', NULL, NULL, CAST(N'2026-05-20T19:30:12.250' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (155, N'citizen147', N'7A6AE0B891D5473F1D239C21D41BBF01C9FB3C9E9F6579FDA796053D8406E40F', N'citizen147@mail.com', N'+7(9147)86-40', N'Гражданин 147 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.147', NULL, NULL, CAST(N'2026-05-20T19:30:12.250' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (156, N'citizen148', N'228410CC8B122EB4AD2D8EC3B82A98E9F931FFD51F4B6D4631B44D38B0BA17CF', N'citizen148@mail.com', N'+7(9148)49-67', N'Гражданин 148 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.148', NULL, NULL, CAST(N'2026-05-20T19:30:12.250' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (157, N'citizen149', N'8518DD4530C31281599093E6FF42F50024E516ED208EDA80C8FEF6214D0C5036', N'citizen149@mail.com', N'+7(9149)00-09', N'Гражданин 149 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.149', NULL, NULL, CAST(N'2026-05-20T19:30:12.250' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (158, N'citizen150', N'963F65F9D1A9BF30CF2102F2E6EFCFF7C9899537ACC7831CE5270616052839EF', N'citizen150@mail.com', N'+7(9150)53-13', N'Гражданин 150 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.150', NULL, NULL, CAST(N'2026-05-20T19:30:12.250' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (159, N'citizen151', N'B9D7319CF037DC2CD01704356FE3671B449829653C56E8C93EF37D5189EAA655', N'citizen151@mail.com', N'+7(9151)19-56', N'Гражданин 151 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.151', NULL, NULL, CAST(N'2026-05-20T19:30:12.250' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (160, N'citizen152', N'E9488E9209629F0B61BA2F2CAC89BC4741BD4FB21D3E408A012BCDB7A8CF7950', N'citizen152@mail.com', N'+7(9152)74-46', N'Гражданин 152 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.152', NULL, NULL, CAST(N'2026-05-20T19:30:12.250' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (161, N'citizen153', N'5419CFEF2FDF2C0E240ADC340B7930D43857389E775C5FB2CC36980B8521F2CE', N'citizen153@mail.com', N'+7(9153)71-83', N'Гражданин 153 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.153', NULL, NULL, CAST(N'2026-05-20T19:30:12.250' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (162, N'citizen154', N'CD16FA43071D6CFA25884D2CACED1CE52EFA59B92DFC99AB836813FC5E69DB03', N'citizen154@mail.com', N'+7(9154)45-21', N'Гражданин 154 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.154', NULL, NULL, CAST(N'2026-05-20T19:30:12.250' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (163, N'citizen155', N'F1D4ADBAD69CC4F1271B9C9682DB410A1741300D5CCC632F90FAEADC8B934E66', N'citizen155@mail.com', N'+7(9155)96-48', N'Гражданин 155 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.155', NULL, NULL, CAST(N'2026-05-20T19:30:12.250' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (164, N'citizen156', N'B90397A77E0F5216FEFFA1392C9AEA5D1CEC0F513D237726725DB4BEAAB4C79D', N'citizen156@mail.com', N'+7(9156)25-52', N'Гражданин 156 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.156', NULL, NULL, CAST(N'2026-05-20T19:30:12.250' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (165, N'citizen157', N'67977A0A44852851C4B5F8EFA40815F304E1BB4648C0FF0412BA9D420B6F6934', N'citizen157@mail.com', N'+7(9157)97-65', N'Гражданин 157 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.157', NULL, NULL, CAST(N'2026-05-20T19:30:12.250' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (166, N'citizen158', N'DA8977C150AEB01F6FD84D48FA7D2E4807BDD3512E03B9E9DFF854DE3094F970', N'citizen158@mail.com', N'+7(9158)17-98', N'Гражданин 158 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.158', NULL, NULL, CAST(N'2026-05-20T19:30:12.250' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (167, N'citizen159', N'444420659B079015D309E33D983C0466134DA01B5884C18F6DACEA3EAE98EF82', N'citizen159@mail.com', N'+7(9159)92-77', N'Гражданин 159 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.159', NULL, NULL, CAST(N'2026-05-20T19:30:12.250' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (168, N'citizen160', N'00C1956E5D6C5DE46388B9875730B0AFA1D3107C9D1C9AC1DC072E1763C93F06', N'citizen160@mail.com', N'+7(9160)98-22', N'Гражданин 160 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.160', NULL, NULL, CAST(N'2026-05-20T19:30:12.250' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (169, N'citizen161', N'1971D8D564C23EC092839D6EA9FD36DEECC0451A437D368FDF22B9EC4E6B92E5', N'citizen161@mail.com', N'+7(9161)50-22', N'Гражданин 161 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.161', NULL, NULL, CAST(N'2026-05-20T19:30:12.250' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (170, N'citizen162', N'CE0CC5D6AA577F8B966B4D738A85522A641734B4CD0EB96FAC1FB149F32007A7', N'citizen162@mail.com', N'+7(9162)47-19', N'Гражданин 162 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.162', NULL, NULL, CAST(N'2026-05-20T19:30:12.250' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (171, N'citizen163', N'14970D5553628849705C327B02159358C048AF6B5B3D10154CB21436D6CFD84E', N'citizen163@mail.com', N'+7(9163)13-34', N'Гражданин 163 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.163', NULL, NULL, CAST(N'2026-05-20T19:30:12.250' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (172, N'citizen164', N'4F40D5EA6BBA1E84C6F18448CD1A7A316FC31B82C616843A4F312D2931734BC8', N'citizen164@mail.com', N'+7(9164)89-12', N'Гражданин 164 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.164', NULL, NULL, CAST(N'2026-05-20T19:30:12.250' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (173, N'citizen165', N'D185F2B0F80FA3187CED69DDD858127703AF6ADA6C73188921E71ECEC29E3B86', N'citizen165@mail.com', N'+7(9165)78-33', N'Гражданин 165 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.165', NULL, NULL, CAST(N'2026-05-20T19:30:12.250' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (174, N'citizen166', N'C40832C56BC9882A6972A3AEEE7BEAA56BBFD68F2476800F01FAC3027F886E41', N'citizen166@mail.com', N'+7(9166)98-83', N'Гражданин 166 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.166', NULL, NULL, CAST(N'2026-05-20T19:30:12.250' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (175, N'citizen167', N'F119146B406BD7B72461CC675B8A61E9E082E7E124F6E944A982547C8A847023', N'citizen167@mail.com', N'+7(9167)54-24', N'Гражданин 167 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.167', NULL, NULL, CAST(N'2026-05-20T19:30:12.250' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (176, N'citizen168', N'5CBA853B36CCAFB52B3AD11D0C218DCFF589C9168218C620A18FA094EBFA3FFE', N'citizen168@mail.com', N'+7(9168)05-62', N'Гражданин 168 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.168', NULL, NULL, CAST(N'2026-05-20T19:30:12.250' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (177, N'citizen169', N'4AF8D9659200E8D30D8A056A14B3EAE088D64DD151FCFF72FFCF3D08CC9B7977', N'citizen169@mail.com', N'+7(9169)77-34', N'Гражданин 169 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.169', NULL, NULL, CAST(N'2026-05-20T19:30:12.250' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (178, N'citizen170', N'F08C71D147CC34F4B144866232758AA35238D29F336AAA8F89C76408C1CF16FD', N'citizen170@mail.com', N'+7(9170)37-55', N'Гражданин 170 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.170', NULL, NULL, CAST(N'2026-05-20T19:30:12.250' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (179, N'citizen171', N'A8E746A7F23319A9F705297E700980FD003907151770B570200BD74693FFC945', N'citizen171@mail.com', N'+7(9171)50-97', N'Гражданин 171 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.171', NULL, NULL, CAST(N'2026-05-20T19:30:12.250' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (180, N'citizen172', N'4E198562E9846D7DB9EDD6CF77FDFF9330DB7A23279D6D04FFCBC1C02680ECDD', N'citizen172@mail.com', N'+7(9172)52-28', N'Гражданин 172 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.172', NULL, NULL, CAST(N'2026-05-20T19:30:12.253' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (181, N'citizen173', N'D20FFEF6F9B9969C6A99EB65268A0D457F1631195375A3FC9EA2757C82F1C267', N'citizen173@mail.com', N'+7(9173)19-66', N'Гражданин 173 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.173', NULL, NULL, CAST(N'2026-05-20T19:30:12.253' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (182, N'citizen174', N'3C970D58B00BBFBD11BE99238412B8DC8C95392524057A7C79987502245BC813', N'citizen174@mail.com', N'+7(9174)67-67', N'Гражданин 174 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.174', NULL, NULL, CAST(N'2026-05-20T19:30:12.253' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (183, N'citizen175', N'5AAF677BD8CFE27D494B927B5CD69431DDF92B3B037AAC21889C432E5496BDB9', N'citizen175@mail.com', N'+7(9175)43-83', N'Гражданин 175 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.175', NULL, NULL, CAST(N'2026-05-20T19:30:12.253' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (184, N'citizen176', N'104266CC04DADAE9683358555FA193734617B15804913EF965C74773BDBD575A', N'citizen176@mail.com', N'+7(9176)46-17', N'Гражданин 176 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.176', NULL, NULL, CAST(N'2026-05-20T19:30:12.253' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (185, N'citizen177', N'5CD72B9BBA9A46617799DD18304322F82E0E66E9FA3FCD3DA9CDCB995CFBEDDF', N'citizen177@mail.com', N'+7(9177)06-03', N'Гражданин 177 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.177', NULL, NULL, CAST(N'2026-05-20T19:30:12.253' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (186, N'citizen178', N'956FAEEC27B882D8AA972D50BFA99B11AB6F7856F67AB9FFAFBE1B66241EF4C7', N'citizen178@mail.com', N'+7(9178)65-01', N'Гражданин 178 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.178', NULL, NULL, CAST(N'2026-05-20T19:30:12.253' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (187, N'citizen179', N'8E8225CA92553C420AEA93FC2F8B5A143B9C9C1FC78F84E6A25DD18023AA7DB3', N'citizen179@mail.com', N'+7(9179)92-42', N'Гражданин 179 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.179', NULL, NULL, CAST(N'2026-05-20T19:30:12.253' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (188, N'citizen180', N'450BF5E97FA8F4F04D50D84CE7398963E5DF9278226AA57C2988451A7274769E', N'citizen180@mail.com', N'+7(9180)92-88', N'Гражданин 180 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.180', NULL, NULL, CAST(N'2026-05-20T19:30:12.253' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (189, N'citizen181', N'E60F65CDC15DC09AB7E182CB569C1E4296DAD5EB9540E75542EB47492FC81E7D', N'citizen181@mail.com', N'+7(9181)04-25', N'Гражданин 181 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.181', NULL, NULL, CAST(N'2026-05-20T19:30:12.253' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (190, N'citizen182', N'5A258638F0A176640F9BD9A0FAA8DAEB403B83FCDF2DEB2D4686D2F05938C29B', N'citizen182@mail.com', N'+7(9182)04-20', N'Гражданин 182 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.182', NULL, NULL, CAST(N'2026-05-20T19:30:12.253' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (191, N'citizen183', N'7714695BF057D6BAA0E352409C96EFD190286DB4A2CBDA4B2255937258FCB3EE', N'citizen183@mail.com', N'+7(9183)71-53', N'Гражданин 183 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.183', NULL, NULL, CAST(N'2026-05-20T19:30:12.253' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (192, N'citizen184', N'A459EEC8F81E241C105297BF0ACE06D2810C5C0C3D2F6C30F624905396664F6D', N'citizen184@mail.com', N'+7(9184)37-04', N'Гражданин 184 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.184', NULL, NULL, CAST(N'2026-05-20T19:30:12.253' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (193, N'citizen185', N'DEEF99D335BBD310F5C6986922090E2AC487005BA1E84001A36F036652872B18', N'citizen185@mail.com', N'+7(9185)79-29', N'Гражданин 185 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.185', NULL, NULL, CAST(N'2026-05-20T19:30:12.253' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (194, N'citizen186', N'7DFB019CB9A337A188DDB4FEE0B8E679C9D2479AC6B94C7C83BF9BD565D109ED', N'citizen186@mail.com', N'+7(9186)64-10', N'Гражданин 186 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.186', NULL, NULL, CAST(N'2026-05-20T19:30:12.253' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (195, N'citizen187', N'1BF3064B71D17CDBE7A756D45913E9715E93F6DBDB470DABE37F4C9F1247FC6A', N'citizen187@mail.com', N'+7(9187)69-13', N'Гражданин 187 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.187', NULL, NULL, CAST(N'2026-05-20T19:30:12.253' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (196, N'citizen188', N'4DE66CA94812977400F463080D0F81A0016DC5CE29F4778009F4F0D12F48643A', N'citizen188@mail.com', N'+7(9188)12-28', N'Гражданин 188 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.188', NULL, NULL, CAST(N'2026-05-20T19:30:12.253' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (197, N'citizen189', N'1915EA8A41F31BDBB0B879253783585C0A001B84911F045BF150C4281CB54E6C', N'citizen189@mail.com', N'+7(9189)62-26', N'Гражданин 189 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.189', NULL, NULL, CAST(N'2026-05-20T19:30:12.253' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (198, N'citizen190', N'7759C9A5A8B5474B76C7B5C00B3C04D6CA6CDEABBBC52E25F9A54F2556E59C0D', N'citizen190@mail.com', N'+7(9190)29-95', N'Гражданин 190 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.190', NULL, NULL, CAST(N'2026-05-20T19:30:12.253' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (199, N'citizen191', N'6D5B63FBB2A973497BDC9DC4A0C8010792BD51A8EB330491DC572E4BC2BF051B', N'citizen191@mail.com', N'+7(9191)44-48', N'Гражданин 191 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.191', NULL, NULL, CAST(N'2026-05-20T19:30:12.257' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (200, N'citizen192', N'4A31314B88AB8C6B07D92CAAA0E4A7005592B1428057FE9529A7453A19FDAE85', N'citizen192@mail.com', N'+7(9192)33-32', N'Гражданин 192 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.192', NULL, NULL, CAST(N'2026-05-20T19:30:12.257' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (201, N'citizen193', N'D99D67863F59E7EDEBA66002BE4DB1C98E286B60CFADBCB51698B17AA184B842', N'citizen193@mail.com', N'+7(9193)86-77', N'Гражданин 193 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.193', NULL, NULL, CAST(N'2026-05-20T19:30:12.257' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (202, N'citizen194', N'E4C911E848BEC00BA411ECD205D27B6491AFB7AB09827D2E533715A144F5AFD4', N'citizen194@mail.com', N'+7(9194)26-39', N'Гражданин 194 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.194', NULL, NULL, CAST(N'2026-05-20T19:30:12.257' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (203, N'citizen195', N'E3F983A118F5555062EDB40C37E8B4530BFB87C6C89C76004DD3CEC7126796B9', N'citizen195@mail.com', N'+7(9195)60-16', N'Гражданин 195 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.195', NULL, NULL, CAST(N'2026-05-20T19:30:12.257' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (204, N'citizen196', N'45BD6B371D1011E47BB740399A7E081A7FCF9B75658A59407ECE7BADCA23C34F', N'citizen196@mail.com', N'+7(9196)74-78', N'Гражданин 196 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.196', NULL, NULL, CAST(N'2026-05-20T19:30:12.257' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (205, N'citizen197', N'F0CE3DCABDE8D6C2BB2DB2F4855722A0DE8086F0D25E938FAF19242BF1CDD730', N'citizen197@mail.com', N'+7(9197)43-23', N'Гражданин 197 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.197', NULL, NULL, CAST(N'2026-05-20T19:30:12.257' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (206, N'citizen198', N'409531CD7D31812AB58A30B6B8EB25642CF68DC4C8929A100B231F70553A4D42', N'citizen198@mail.com', N'+7(9198)50-74', N'Гражданин 198 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.198', NULL, NULL, CAST(N'2026-05-20T19:30:12.257' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (207, N'citizen199', N'0EAA0730CC0EE0F8C888A00450006D514664D528688C87CF42047F0269E1AA3D', N'citizen199@mail.com', N'+7(9199)03-98', N'Гражданин 199 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.199', NULL, NULL, CAST(N'2026-05-20T19:30:12.257' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (208, N'citizen200', N'311514B6345CD997BDB96ACB5DA71813C1F086AC3EE3319D74A0EF5E92555F33', N'citizen200@mail.com', N'+7(9200)31-28', N'Гражданин 200 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.200', NULL, NULL, CAST(N'2026-05-20T19:30:12.257' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (209, N'citizen201', N'DA4846985EF84DC7AB646D011B05A5E76ADA0E64085F9F6534CC511E3569CA50', N'citizen201@mail.com', N'+7(9201)05-06', N'Гражданин 201 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.201', NULL, NULL, CAST(N'2026-05-20T19:30:12.257' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (210, N'citizen202', N'B5CEF39C429C739F715624213D975B1B5FACA8323F2F0A2EFBB98F39C5A44C09', N'citizen202@mail.com', N'+7(9202)81-53', N'Гражданин 202 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.202', NULL, NULL, CAST(N'2026-05-20T19:30:12.257' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (211, N'citizen203', N'F79F7A3C512DD25A34D3E52E705A2FCEE1599B3189CD1AAD42D46D8348F20060', N'citizen203@mail.com', N'+7(9203)48-27', N'Гражданин 203 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.203', NULL, NULL, CAST(N'2026-05-20T19:30:12.257' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (212, N'citizen204', N'330CDA373D6BB5AFE204300F10B6AB8F44B8824D9784C0CB5E855E95A991EB33', N'citizen204@mail.com', N'+7(9204)03-38', N'Гражданин 204 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.204', NULL, NULL, CAST(N'2026-05-20T19:30:12.257' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (213, N'citizen205', N'1F1135F3BA54AA12D43979E55C0A5C7E82E3BA4BD6BB4C3E80029A2CAEC1234D', N'citizen205@mail.com', N'+7(9205)06-68', N'Гражданин 205 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.205', NULL, NULL, CAST(N'2026-05-20T19:30:12.257' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (214, N'citizen206', N'ACC0593572B2B490C790E49F60535E8BC23EBDC497B5793722593BAA03BFF36E', N'citizen206@mail.com', N'+7(9206)08-98', N'Гражданин 206 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.206', NULL, NULL, CAST(N'2026-05-20T19:30:12.257' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (215, N'citizen207', N'0AD5A100673CE1B9178AAD77A0B49EEFB0C0C383CF00671076C8783BEE924A16', N'citizen207@mail.com', N'+7(9207)94-36', N'Гражданин 207 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.207', NULL, NULL, CAST(N'2026-05-20T19:30:12.260' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (216, N'citizen208', N'152FEE8FC758D01FAE98C591EDC9093F316D2326310BBD4F83109558FEA8BAF3', N'citizen208@mail.com', N'+7(9208)81-29', N'Гражданин 208 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.208', NULL, NULL, CAST(N'2026-05-20T19:30:12.260' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (217, N'citizen209', N'BCEA7C9DE92839EE09BEA59E96EDA28BB8AE73C7B1F98A282455F7597FF38ECC', N'citizen209@mail.com', N'+7(9209)62-90', N'Гражданин 209 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.209', NULL, NULL, CAST(N'2026-05-20T19:30:12.260' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (218, N'citizen210', N'6B56E8BF3FEB2FACC4ED8B7810666275681E4DA0BA6435ADBC764EEADD143BC5', N'citizen210@mail.com', N'+7(9210)99-57', N'Гражданин 210 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.210', NULL, NULL, CAST(N'2026-05-20T19:30:12.260' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (219, N'citizen211', N'0C74539EBBEAAADFD3A528C276FB7D1F4247AB9C2EB3BA1509C9C04FDA70D9A8', N'citizen211@mail.com', N'+7(9211)59-77', N'Гражданин 211 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.211', NULL, NULL, CAST(N'2026-05-20T19:30:12.260' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (220, N'citizen212', N'ACDA2617FE79A477D9AE94D9D3B5C5DA59039B4E5433D8DEE527A0C1A40990F1', N'citizen212@mail.com', N'+7(9212)90-47', N'Гражданин 212 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.212', NULL, NULL, CAST(N'2026-05-20T19:30:12.260' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (221, N'citizen213', N'403846274E8A10397737432DFF1DF86750857F5C37D5CD49B174D6CC0B36D21D', N'citizen213@mail.com', N'+7(9213)20-53', N'Гражданин 213 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.213', NULL, NULL, CAST(N'2026-05-20T19:30:12.260' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (222, N'citizen214', N'DA241575FCBE3B28C504D211857F135403D2133983DD1811F62BCFCFC33EAAD4', N'citizen214@mail.com', N'+7(9214)87-70', N'Гражданин 214 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.214', NULL, NULL, CAST(N'2026-05-20T19:30:12.260' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (223, N'citizen215', N'44593AD77D8FFA8545B81D7032B94F91AF035B2F0B0B8CD32478D94BFB5345F8', N'citizen215@mail.com', N'+7(9215)32-45', N'Гражданин 215 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.215', NULL, NULL, CAST(N'2026-05-20T19:30:12.260' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (224, N'citizen216', N'6A345D6D21205D378449607E90542241F89753FF62E06B11AB6ADEFC789A0B8B', N'citizen216@mail.com', N'+7(9216)95-40', N'Гражданин 216 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.216', NULL, NULL, CAST(N'2026-05-20T19:30:12.260' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (225, N'citizen217', N'F52515F3EE122A70DA4A945943D4D4A5A9908B4A53F9CCA2B7E170A765642109', N'citizen217@mail.com', N'+7(9217)13-00', N'Гражданин 217 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.217', NULL, NULL, CAST(N'2026-05-20T19:30:12.260' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (226, N'citizen218', N'062D23AA42AEEFEF34827BB89039A3B72C912E3ED0F6ED00417A28CB07C6CACE', N'citizen218@mail.com', N'+7(9218)54-68', N'Гражданин 218 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.218', NULL, NULL, CAST(N'2026-05-20T19:30:12.260' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (227, N'citizen219', N'CF3DAFD9D161CDF8CF81368886E89AD677367A81A4E632CC0873ADBCE0278D92', N'citizen219@mail.com', N'+7(9219)43-04', N'Гражданин 219 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.219', NULL, NULL, CAST(N'2026-05-20T19:30:12.260' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (228, N'citizen220', N'280EF98070DCEA4EE0C1C1BD4C2699F33AA96337329E68698EEA548683EC9C0B', N'citizen220@mail.com', N'+7(9220)12-55', N'Гражданин 220 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.220', NULL, NULL, CAST(N'2026-05-20T19:30:12.260' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (229, N'citizen221', N'78BFE8ABC6397F96D849516055335B749AF6E5581103DAAFF95CB41B029B7561', N'citizen221@mail.com', N'+7(9221)26-51', N'Гражданин 221 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.221', NULL, NULL, CAST(N'2026-05-20T19:30:12.260' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (230, N'citizen222', N'0BE5449FD7E110E562888C7F6B2CEAC607083936E4A8F286FCF9A2D672F73135', N'citizen222@mail.com', N'+7(9222)02-48', N'Гражданин 222 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.222', NULL, NULL, CAST(N'2026-05-20T19:30:12.260' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (231, N'citizen223', N'643663941CEEEAEA2CC8559048CD047DC2555CBBBFA7E8ABFF899B5DB7EDE88D', N'citizen223@mail.com', N'+7(9223)80-70', N'Гражданин 223 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.223', NULL, NULL, CAST(N'2026-05-20T19:30:12.260' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (232, N'citizen224', N'A8D1C5A1646001B31BDFDBAFBBA64D3BD04CF5A8C1FDE1CA39CFAC43937EE897', N'citizen224@mail.com', N'+7(9224)06-16', N'Гражданин 224 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.224', NULL, NULL, CAST(N'2026-05-20T19:30:12.260' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (233, N'citizen225', N'91186C578E957201F46F2FAE580B9728CE27871831F8C11EBFB60B1108890D8E', N'citizen225@mail.com', N'+7(9225)12-18', N'Гражданин 225 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.225', NULL, NULL, CAST(N'2026-05-20T19:30:12.260' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (234, N'citizen226', N'2C5E294FCCA3FCF934DB63D265C1FE2A714CC9C8AE431620105A622454AB332F', N'citizen226@mail.com', N'+7(9226)04-99', N'Гражданин 226 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.226', NULL, NULL, CAST(N'2026-05-20T19:30:12.263' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (235, N'citizen227', N'BFE83893FBB96D01F08BAFED5D593A118EA9C847712786A06C8C17DC0B90CFAE', N'citizen227@mail.com', N'+7(9227)86-42', N'Гражданин 227 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.227', NULL, NULL, CAST(N'2026-05-20T19:30:12.263' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (236, N'citizen228', N'F535A123CE07E46BC486033CA1006E2BEE21F4061AADB94A5E228E92CD367334', N'citizen228@mail.com', N'+7(9228)56-72', N'Гражданин 228 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.228', NULL, NULL, CAST(N'2026-05-20T19:30:12.263' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (237, N'citizen229', N'64FB7CCFF879EF7884CDA37596B976E2049243E7635C4141582D760AE6C90F16', N'citizen229@mail.com', N'+7(9229)52-84', N'Гражданин 229 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.229', NULL, NULL, CAST(N'2026-05-20T19:30:12.263' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (238, N'citizen230', N'E04D7ECB9D006BC00041DCB5DDC064531B7D1E94559B734E227F3326975E05BE', N'citizen230@mail.com', N'+7(9230)70-82', N'Гражданин 230 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.230', NULL, NULL, CAST(N'2026-05-20T19:30:12.263' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (239, N'citizen231', N'42AC3967667B95FAAAB0D21865DC1D799DFFC9F8E92649E1B39733F8FD06D1C3', N'citizen231@mail.com', N'+7(9231)08-17', N'Гражданин 231 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.231', NULL, NULL, CAST(N'2026-05-20T19:30:12.263' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (240, N'citizen232', N'EC652EBB5A6F32736A59800C9071C60DEE146F30DF326C6F7C15F721EEE3B167', N'citizen232@mail.com', N'+7(9232)04-84', N'Гражданин 232 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.232', NULL, NULL, CAST(N'2026-05-20T19:30:12.263' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (241, N'citizen233', N'F4D42D47D22D5C5037ECD0801B010AEE934D17E329993BC815DA32774B792DD3', N'citizen233@mail.com', N'+7(9233)07-62', N'Гражданин 233 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.233', NULL, NULL, CAST(N'2026-05-20T19:30:12.263' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (242, N'citizen234', N'3C8B8ED3401C4B9B261A52277E6A18CB44E13BDBB13F8E0DDF5DCFA29035340D', N'citizen234@mail.com', N'+7(9234)44-37', N'Гражданин 234 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.234', NULL, NULL, CAST(N'2026-05-20T19:30:12.263' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (243, N'citizen235', N'3B18C897AD0D04CAEB906C1BABBAD2BE011FF1E816F0FE5224167D75FC4EBEC8', N'citizen235@mail.com', N'+7(9235)61-54', N'Гражданин 235 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.235', NULL, NULL, CAST(N'2026-05-20T19:30:12.263' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (244, N'citizen236', N'CE07BFBFAFEB160CB96E6C88F922985C1388917145234B34BC2952CBFCC5C5B6', N'citizen236@mail.com', N'+7(9236)43-43', N'Гражданин 236 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.236', NULL, NULL, CAST(N'2026-05-20T19:30:12.263' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (245, N'citizen237', N'2FF5D597BB5B13633E7224BF053AE09251D464927790C83428F7D722B9D2732A', N'citizen237@mail.com', N'+7(9237)96-37', N'Гражданин 237 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.237', NULL, NULL, CAST(N'2026-05-20T19:30:12.263' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (246, N'citizen238', N'198BCE6B72CC579834F5C10EED14515DF080FD34AB655B4497617FF10436EA99', N'citizen238@mail.com', N'+7(9238)92-71', N'Гражданин 238 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.238', NULL, NULL, CAST(N'2026-05-20T19:30:12.263' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (247, N'citizen239', N'E1D1CC435D7204B036345028DC4E83641D079B7131E1204C43CE250CC80E5B29', N'citizen239@mail.com', N'+7(9239)69-28', N'Гражданин 239 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.239', NULL, NULL, CAST(N'2026-05-20T19:30:12.263' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (248, N'citizen240', N'5EFB93D3D153C1096CE40FC56452CFC5D4F0B631B6962E008D35730777807F42', N'citizen240@mail.com', N'+7(9240)09-31', N'Гражданин 240 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.240', NULL, NULL, CAST(N'2026-05-20T19:30:12.263' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (249, N'citizen241', N'0BF5A90660B1D83831F37BB70036E3E4F6BF4FAB7B61D2C4E427342751545F4F', N'citizen241@mail.com', N'+7(9241)81-95', N'Гражданин 241 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.241', NULL, NULL, CAST(N'2026-05-20T19:30:12.267' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (250, N'citizen242', N'4E7E424C2523E5A9351B2A6CA70A4DA1FFEC12CAD40E8665B832C64B57DC2968', N'citizen242@mail.com', N'+7(9242)95-86', N'Гражданин 242 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.242', NULL, NULL, CAST(N'2026-05-20T19:30:12.267' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (251, N'citizen243', N'9951BDEE66ADA681B7713603E3F4F35EEE04443392B8D3C6CBA00C09C886D7FC', N'citizen243@mail.com', N'+7(9243)97-99', N'Гражданин 243 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.243', NULL, NULL, CAST(N'2026-05-20T19:30:12.267' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (252, N'citizen244', N'429994433B8780DE68720291E85E99551201C2614D9065196A8B40E1AE5F9548', N'citizen244@mail.com', N'+7(9244)05-73', N'Гражданин 244 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.244', NULL, NULL, CAST(N'2026-05-20T19:30:12.267' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (253, N'citizen245', N'516696FD81402A115627080017ED58C3F0C79BEA2FAE68A48462D01863A33D6F', N'citizen245@mail.com', N'+7(9245)41-28', N'Гражданин 245 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.245', NULL, NULL, CAST(N'2026-05-20T19:30:12.267' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (254, N'citizen246', N'F54A11A009AE15536BC946DD02D7B62F345C2CF823EBF94CE3CDF44ACC09D57B', N'citizen246@mail.com', N'+7(9246)70-63', N'Гражданин 246 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.246', NULL, NULL, CAST(N'2026-05-20T19:30:12.267' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (255, N'citizen247', N'7E9885C7F2CDE0ED59E806553871FCA150CBEDA6E98C7E8BCF5D0E4930861E23', N'citizen247@mail.com', N'+7(9247)96-14', N'Гражданин 247 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.247', NULL, NULL, CAST(N'2026-05-20T19:30:12.267' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (256, N'citizen248', N'272142C32FA2003677AAC64748C424B78085AACCB095AB6ADE56A8070B0E7BEC', N'citizen248@mail.com', N'+7(9248)09-67', N'Гражданин 248 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.248', NULL, NULL, CAST(N'2026-05-20T19:30:12.267' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (257, N'citizen249', N'BC54E615F33ECED0FAE4CD8245F7A34FD451E5729FC57E9E63E6E86DEB24F35F', N'citizen249@mail.com', N'+7(9249)29-53', N'Гражданин 249 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.249', NULL, NULL, CAST(N'2026-05-20T19:30:12.267' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (258, N'citizen250', N'5476EFD13DB56E0172B8888345358321A8BB41E694AEED0CFB4A71362F881362', N'citizen250@mail.com', N'+7(9250)15-57', N'Гражданин 250 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.250', NULL, NULL, CAST(N'2026-05-20T19:30:12.267' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (259, N'citizen251', N'31B2DDF043D2F7F90C64DB7940AD7C9C9BD9C758A191A0CBD8E4C2F56EADCFB2', N'citizen251@mail.com', N'+7(9251)99-37', N'Гражданин 251 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.251', NULL, NULL, CAST(N'2026-05-20T19:30:12.267' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (260, N'citizen252', N'9D89D49C93C4190CC93C835E49ADE5F94A5DA2B956ECC536B054A4D5CD337145', N'citizen252@mail.com', N'+7(9252)98-23', N'Гражданин 252 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.252', NULL, NULL, CAST(N'2026-05-20T19:30:12.267' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (261, N'citizen253', N'D34F02A2C5E82183AF2BCFD6BD4EC396EF97D1A96DF4A5E92BB1F151FC721ECE', N'citizen253@mail.com', N'+7(9253)86-23', N'Гражданин 253 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.253', NULL, NULL, CAST(N'2026-05-20T19:30:12.267' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (262, N'citizen254', N'AD635ABD099AE56BBAB117ABF03EB79A4781C35D31D04E359D7A675FB82581E6', N'citizen254@mail.com', N'+7(9254)33-33', N'Гражданин 254 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.254', NULL, NULL, CAST(N'2026-05-20T19:30:12.267' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (263, N'citizen255', N'37BED248C177CFE4FCFE3E0DD1A1F14F0E8963EA1180C6BBCB75719D61F03AF3', N'citizen255@mail.com', N'+7(9255)65-13', N'Гражданин 255 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.255', NULL, NULL, CAST(N'2026-05-20T19:30:12.267' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (264, N'citizen256', N'C4861465987F4CF2B188A5E8024EF8E5B9E84135B82558220E52CBADA66E22D2', N'citizen256@mail.com', N'+7(9256)18-54', N'Гражданин 256 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.256', NULL, NULL, CAST(N'2026-05-20T19:30:12.267' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (265, N'citizen257', N'58370301C53519F3726A0B1B5AB5930FB44011D55AE725757ACB1C8DAD71EBD9', N'citizen257@mail.com', N'+7(9257)37-90', N'Гражданин 257 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.257', NULL, NULL, CAST(N'2026-05-20T19:30:12.267' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (266, N'citizen258', N'6167A628EFCE4FBCFFA4ED0E9E6915A7EF14A1FC8F224E4C9810E4E7E56F07F4', N'citizen258@mail.com', N'+7(9258)98-44', N'Гражданин 258 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.258', NULL, NULL, CAST(N'2026-05-20T19:30:12.267' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (267, N'citizen259', N'68674E310C8A973C8B2B967B274FC42DA6624EA2B20154B6D26521BE7F1EE534', N'citizen259@mail.com', N'+7(9259)22-69', N'Гражданин 259 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.259', NULL, NULL, CAST(N'2026-05-20T19:30:12.270' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (268, N'citizen260', N'11ED82B3BDD73C3E2712CAE6840F7518338BCEDCCFF491BB5CE516E96D2F4533', N'citizen260@mail.com', N'+7(9260)35-59', N'Гражданин 260 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.260', NULL, NULL, CAST(N'2026-05-20T19:30:12.270' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (269, N'citizen261', N'A32AE9F2E8103CC8CFB607A2B49C986E5BD58D092DDA57147FE880E8B236C56F', N'citizen261@mail.com', N'+7(9261)50-64', N'Гражданин 261 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.261', NULL, NULL, CAST(N'2026-05-20T19:30:12.270' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (270, N'citizen262', N'F48EB70451DF8CC961F874DCB31117A28C3253DAB8D4A5E15926B69693F40CF9', N'citizen262@mail.com', N'+7(9262)85-47', N'Гражданин 262 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.262', NULL, NULL, CAST(N'2026-05-20T19:30:12.270' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (271, N'citizen263', N'03DDF3A62AC6C664FCCA9A537945ADAE3584CE844E9EE2B03A5235937998416B', N'citizen263@mail.com', N'+7(9263)33-40', N'Гражданин 263 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.263', NULL, NULL, CAST(N'2026-05-20T19:30:12.270' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (272, N'citizen264', N'7651215390F6B6E57ABB48387EEE053094D804C99BF27B87E55C20B0308F4DC7', N'citizen264@mail.com', N'+7(9264)59-35', N'Гражданин 264 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.264', NULL, NULL, CAST(N'2026-05-20T19:30:12.270' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (273, N'citizen265', N'A9391262A873100E95CB272E1D0EEE18B5C8F8E3E3834D862B88916F8681F8E4', N'citizen265@mail.com', N'+7(9265)02-49', N'Гражданин 265 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.265', NULL, NULL, CAST(N'2026-05-20T19:30:12.270' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (274, N'citizen266', N'F191D35A2AA9DADC6D00C16E9746F912D1D1457D7744BDA7CFF9AD7273A53FC0', N'citizen266@mail.com', N'+7(9266)33-77', N'Гражданин 266 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.266', NULL, NULL, CAST(N'2026-05-20T19:30:12.270' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (275, N'citizen267', N'4FEF1FE8C46E95FCBCC8DF648C13EEE1DDF28A2937D9B8E5C7213BE0EB711586', N'citizen267@mail.com', N'+7(9267)74-94', N'Гражданин 267 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.267', NULL, NULL, CAST(N'2026-05-20T19:30:12.270' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (276, N'citizen268', N'75D0FE3927A1496366E429F42211714D8D52FB7CF50C224EBA5A4CD6FDA86927', N'citizen268@mail.com', N'+7(9268)65-96', N'Гражданин 268 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.268', NULL, NULL, CAST(N'2026-05-20T19:30:12.270' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (277, N'citizen269', N'8C97FBF401A31C5959B5CE4EFD5CAE2D403522EF60E773B914ABED9BEA040139', N'citizen269@mail.com', N'+7(9269)64-21', N'Гражданин 269 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.269', NULL, NULL, CAST(N'2026-05-20T19:30:12.270' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (278, N'citizen270', N'4532959A651984BD02BD5466CAAE19ABA55C0432687860D97C4CE3A6DB88ED02', N'citizen270@mail.com', N'+7(9270)48-50', N'Гражданин 270 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.270', NULL, NULL, CAST(N'2026-05-20T19:30:12.270' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (279, N'citizen271', N'1D10F628A3945C915447CB01D6B6D296BDAA9ACD4129AC5EEF83286650E6F393', N'citizen271@mail.com', N'+7(9271)25-28', N'Гражданин 271 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.271', NULL, NULL, CAST(N'2026-05-20T19:30:12.270' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (280, N'citizen272', N'73F29A02F8CEC60D9DBA6EF5E0F8F0432BD763DBD12077A892C9B31BE74295BC', N'citizen272@mail.com', N'+7(9272)68-21', N'Гражданин 272 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.272', NULL, NULL, CAST(N'2026-05-20T19:30:12.270' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (281, N'citizen273', N'B1F54B1662B164433F03DCA9674947C59F31B3F88A0367C51E33E77E56AB29C4', N'citizen273@mail.com', N'+7(9273)83-80', N'Гражданин 273 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.273', NULL, NULL, CAST(N'2026-05-20T19:30:12.270' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (282, N'citizen274', N'3E53843805E605ADFDE8DCDF809FE3432DE7BEE77855FDD09726FCAE8A30FFB9', N'citizen274@mail.com', N'+7(9274)02-31', N'Гражданин 274 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.274', NULL, NULL, CAST(N'2026-05-20T19:30:12.270' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (283, N'citizen275', N'1F05203AFCB9AD72CC2BAA78339E94F5465B781ED5BECE5B42D89B09C413E25B', N'citizen275@mail.com', N'+7(9275)84-02', N'Гражданин 275 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.275', NULL, NULL, CAST(N'2026-05-20T19:30:12.270' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (284, N'citizen276', N'057B3B599717218E1243FCBD0A09C6323F97AAD4753B2843C4AF1C40931FDB48', N'citizen276@mail.com', N'+7(9276)68-77', N'Гражданин 276 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.276', NULL, NULL, CAST(N'2026-05-20T19:30:12.270' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (285, N'citizen277', N'FFE5EE7D035789052C9137EBCCC7661A06C311107160B7894840D973C84AD7CC', N'citizen277@mail.com', N'+7(9277)16-05', N'Гражданин 277 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.277', NULL, NULL, CAST(N'2026-05-20T19:30:12.270' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (286, N'citizen278', N'F500B174F441A80DE5AD218561D934CF6B7DF04EF5EE21F6DC02DDA1E13C6889', N'citizen278@mail.com', N'+7(9278)73-14', N'Гражданин 278 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.278', NULL, NULL, CAST(N'2026-05-20T19:30:12.270' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (287, N'citizen279', N'690BEA604654CFC686896EEFAB0D68866D8822B389F38CCB9F982BC225E8D8C3', N'citizen279@mail.com', N'+7(9279)76-68', N'Гражданин 279 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.279', NULL, NULL, CAST(N'2026-05-20T19:30:12.270' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (288, N'citizen280', N'D09D8C3284CC531FDDAC940A108EAFF5434EDDEEA7A501F5164AA6E5C5172270', N'citizen280@mail.com', N'+7(9280)94-81', N'Гражданин 280 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.280', NULL, NULL, CAST(N'2026-05-20T19:30:12.270' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (289, N'citizen281', N'453A3CA0F3810F5D6D10FC1207409883B12E9BC904B402CD518264E940D43636', N'citizen281@mail.com', N'+7(9281)79-40', N'Гражданин 281 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.281', NULL, NULL, CAST(N'2026-05-20T19:30:12.270' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (290, N'citizen282', N'A58B4377D89738BE0E4416A5A944C9363BD032BF07CA102500E341D3F54BAF54', N'citizen282@mail.com', N'+7(9282)85-86', N'Гражданин 282 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.282', NULL, NULL, CAST(N'2026-05-20T19:30:12.273' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (291, N'citizen283', N'3B9E1CF098F843CEA07DC6E55BF3E678265A22C9205F622A123631C8F6FF1A79', N'citizen283@mail.com', N'+7(9283)91-52', N'Гражданин 283 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.283', NULL, NULL, CAST(N'2026-05-20T19:30:12.273' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (292, N'citizen284', N'D32330758527E0CA234CC7BC35322A7B83B40B32F8C7A2F29D376C9E0B2EC403', N'citizen284@mail.com', N'+7(9284)20-56', N'Гражданин 284 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.284', NULL, NULL, CAST(N'2026-05-20T19:30:12.273' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (293, N'citizen285', N'C6FBED00191847FCBF136BB33062449B4A78C3980D750D6DCF6500C963AD6E9C', N'citizen285@mail.com', N'+7(9285)20-82', N'Гражданин 285 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.285', NULL, NULL, CAST(N'2026-05-20T19:30:12.273' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (294, N'citizen286', N'E19F5528742E5816B32F4405A02E97668A3DD4DA478EEAA058A84B78139B48C9', N'citizen286@mail.com', N'+7(9286)97-64', N'Гражданин 286 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.286', NULL, NULL, CAST(N'2026-05-20T19:30:12.273' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (295, N'citizen287', N'8EADEFE1401441F43F4C529CC614823528170B989990181C704D9674BA572F68', N'citizen287@mail.com', N'+7(9287)61-65', N'Гражданин 287 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.287', NULL, NULL, CAST(N'2026-05-20T19:30:12.273' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (296, N'citizen288', N'67820617B47FFF5DC37C2994D251DB7642F5A4F815CBDFC5D1F4A9298D0F5A5E', N'citizen288@mail.com', N'+7(9288)51-87', N'Гражданин 288 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.288', NULL, NULL, CAST(N'2026-05-20T19:30:12.273' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (297, N'citizen289', N'A081448FBC52F09A219E48A4754FD7F0082AE02232DE04034D001C134AC3CDB4', N'citizen289@mail.com', N'+7(9289)43-15', N'Гражданин 289 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.289', NULL, NULL, CAST(N'2026-05-20T19:30:12.273' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (298, N'citizen290', N'C7A3E2CC332D6814554CEFC27BA852C28652E775ED62981534B4278E46EBA0D3', N'citizen290@mail.com', N'+7(9290)16-89', N'Гражданин 290 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.290', NULL, NULL, CAST(N'2026-05-20T19:30:12.273' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (299, N'citizen291', N'ACDBFD526D66F1C04F79F0777FC73E7730AC71DC651FDEF759CDD016DB024BAD', N'citizen291@mail.com', N'+7(9291)46-05', N'Гражданин 291 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.291', NULL, NULL, CAST(N'2026-05-20T19:30:12.273' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (300, N'citizen292', N'5175822F2448950A3A6F5B0B0AD3D627B2440C1F961BCDD3E392809ED8AB5B6D', N'citizen292@mail.com', N'+7(9292)19-13', N'Гражданин 292 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.292', NULL, NULL, CAST(N'2026-05-20T19:30:12.273' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (301, N'citizen293', N'465B8582F113602E60F49C7CB6F05AA50E946C03FB0C5D31429FEA6407C045E7', N'citizen293@mail.com', N'+7(9293)00-03', N'Гражданин 293 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.293', NULL, NULL, CAST(N'2026-05-20T19:30:12.273' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (302, N'citizen294', N'E10FCA917DD1B84445CF561379241A20FCD1CB65C6A956A4A3C7B973D79A4BD3', N'citizen294@mail.com', N'+7(9294)65-53', N'Гражданин 294 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.294', NULL, NULL, CAST(N'2026-05-20T19:30:12.273' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (303, N'citizen295', N'7DC31CCF064C78EE2C36D2DB2207B8246BD697BC8EFC9953119ED4B6369E5980', N'citizen295@mail.com', N'+7(9295)85-81', N'Гражданин 295 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.295', NULL, NULL, CAST(N'2026-05-20T19:30:12.273' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (304, N'citizen296', N'2329D96DB1535D85BF8DDE1CC91035D4FCAD74B0BDE34A6FB9BA034A5E5E06AB', N'citizen296@mail.com', N'+7(9296)50-60', N'Гражданин 296 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.296', NULL, NULL, CAST(N'2026-05-20T19:30:12.273' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (305, N'citizen297', N'7F294318D3427F7EBE307D0C702D432FB301891417EF51E1BF992A338CD21BAA', N'citizen297@mail.com', N'+7(9297)60-54', N'Гражданин 297 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.297', NULL, NULL, CAST(N'2026-05-20T19:30:12.273' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (306, N'citizen298', N'F4156AAA4E61F34190C30529EA078491E43A13D67E82775A6987AA181C53314C', N'citizen298@mail.com', N'+7(9298)64-51', N'Гражданин 298 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.298', NULL, NULL, CAST(N'2026-05-20T19:30:12.277' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (307, N'citizen299', N'A42F3626BFEC6C50250B008D21560791D0B3C66AE5D6147A8715F45113158CB1', N'citizen299@mail.com', N'+7(9299)02-99', N'Гражданин 299 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.299', NULL, NULL, CAST(N'2026-05-20T19:30:12.277' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (308, N'citizen300', N'2EACFCC66E88B1FFDAC0377C32730778F743883912BFC5896A84EC6FE0CEA4BE', N'citizen300@mail.com', N'+7(9300)19-76', N'Гражданин 300 Тестовый', N'Гражданин', N'г. (Город), ул. Примерная, д.300', NULL, NULL, CAST(N'2026-05-20T19:30:12.277' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (309, N'test', N'9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', N'test@test.ru', N'98889097896', N'dsds dsds sd ds', N'Гражданин', N'd sfs dsd sd s', NULL, NULL, CAST(N'2026-05-20T21:25:23.867' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (310, N'tgf', N'7608677d18c1e73fc58a98d2496cf94a83d60a1a0649dc414669e8933856e6d0', NULL, NULL, N'dfgdfgfd', N'Оператор', NULL, N'fdgd', N'dfgdfgddffg', CAST(N'2026-05-20T21:27:45.503' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (1309, N'1', N'6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b', NULL, NULL, N'1', N'Исполнитель', NULL, N'1', N'1', CAST(N'2026-05-23T10:51:17.027' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (2309, N's1', N'6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b', N'2eefdf@mail.ru', N'8909', N'dfsfdfs fds fsd fs', N'Гражданин', N'ssdasd', NULL, NULL, CAST(N'2026-05-24T14:08:31.847' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (2310, N'o1', N'6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b', NULL, NULL, N'dsfdsfsdf', N'Оператор', NULL, N'sdffsdf', N'sfsdfsdf', CAST(N'2026-05-24T14:09:00.730' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (2311, N'e1', N'6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b', NULL, NULL, N'fsdf', N'Исполнитель', NULL, N'sffsdf', N'dfsdfs', CAST(N'2026-05-24T14:09:36.677' AS DateTime), 1)
GO
INSERT [dbo].[ApplicationUser] ([UserID], [Login], [PasswordHash], [Email], [Phone], [FullName], [Role], [Address], [Department], [Position], [CreatedAt], [IsActive]) VALUES (2312, N'a1', N'6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b', NULL, NULL, N'ssfsd', N'Администратор', NULL, N'fsdfs', N'fsdfs', CAST(N'2026-05-24T14:10:12.850' AS DateTime), 1)
GO
SET IDENTITY_INSERT [dbo].[ApplicationUser] OFF
GO
SET IDENTITY_INSERT [dbo].[Attachment] ON 
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (1, 4, N'file_4.pdf', N'/uploads/appeals/4/file.pdf', CAST(N'2026-03-22T19:30:12.867' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (2, 6, N'file_6.pdf', N'/uploads/appeals/6/file.pdf', CAST(N'2025-10-13T19:30:12.870' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (3, 19, N'file_19.pdf', N'/uploads/appeals/19/file.pdf', CAST(N'2025-08-02T19:30:12.877' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (4, 43, N'file_43.pdf', N'/uploads/appeals/43/file.pdf', CAST(N'2026-03-31T19:30:12.890' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (5, 46, N'file_46.pdf', N'/uploads/appeals/46/file.pdf', CAST(N'2025-07-04T19:30:12.890' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (6, 55, N'file_55.pdf', N'/uploads/appeals/55/file.pdf', CAST(N'2025-09-11T19:30:12.893' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (7, 57, N'file_57.pdf', N'/uploads/appeals/57/file.pdf', CAST(N'2026-04-17T19:30:12.897' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (8, 75, N'file_75.pdf', N'/uploads/appeals/75/file.pdf', CAST(N'2025-08-20T19:30:13.077' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (9, 81, N'file_81.pdf', N'/uploads/appeals/81/file.pdf', CAST(N'2026-01-14T19:30:13.080' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (10, 88, N'file_88.pdf', N'/uploads/appeals/88/file.pdf', CAST(N'2025-09-07T19:30:13.083' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (11, 100, N'file_100.pdf', N'/uploads/appeals/100/file.pdf', CAST(N'2026-05-09T19:30:13.090' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (12, 114, N'file_114.pdf', N'/uploads/appeals/114/file.pdf', CAST(N'2025-10-19T19:30:13.267' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (13, 115, N'file_115.pdf', N'/uploads/appeals/115/file.pdf', CAST(N'2025-06-29T19:30:13.267' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (14, 135, N'file_135.pdf', N'/uploads/appeals/135/file.pdf', CAST(N'2026-02-01T19:30:13.277' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (15, 140, N'file_140.pdf', N'/uploads/appeals/140/file.pdf', CAST(N'2025-09-26T19:30:13.280' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (16, 181, N'file_181.pdf', N'/uploads/appeals/181/file.pdf', CAST(N'2026-02-28T19:30:13.343' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (17, 185, N'file_185.pdf', N'/uploads/appeals/185/file.pdf', CAST(N'2026-01-12T19:30:13.347' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (18, 187, N'file_187.pdf', N'/uploads/appeals/187/file.pdf', CAST(N'2026-05-02T19:30:13.347' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (19, 197, N'file_197.pdf', N'/uploads/appeals/197/file.pdf', CAST(N'2025-08-24T19:30:13.350' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (20, 202, N'file_202.pdf', N'/uploads/appeals/202/file.pdf', CAST(N'2025-12-12T19:30:13.353' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (21, 212, N'file_212.pdf', N'/uploads/appeals/212/file.pdf', CAST(N'2025-09-10T19:30:13.360' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (22, 213, N'file_213.pdf', N'/uploads/appeals/213/file.pdf', CAST(N'2026-04-16T19:30:13.360' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (23, 243, N'file_243.pdf', N'/uploads/appeals/243/file.pdf', CAST(N'2025-06-12T19:30:13.377' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (24, 246, N'file_246.pdf', N'/uploads/appeals/246/file.pdf', CAST(N'2025-09-01T19:30:13.377' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (25, 250, N'file_250.pdf', N'/uploads/appeals/250/file.pdf', CAST(N'2025-06-29T19:30:13.380' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (26, 261, N'file_261.pdf', N'/uploads/appeals/261/file.pdf', CAST(N'2025-10-24T19:30:13.387' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (27, 266, N'file_266.pdf', N'/uploads/appeals/266/file.pdf', CAST(N'2025-05-23T19:30:13.387' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (28, 269, N'file_269.pdf', N'/uploads/appeals/269/file.pdf', CAST(N'2026-01-17T19:30:13.390' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (29, 279, N'file_279.pdf', N'/uploads/appeals/279/file.pdf', CAST(N'2026-04-26T19:30:13.393' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (30, 280, N'file_280.pdf', N'/uploads/appeals/280/file.pdf', CAST(N'2025-09-06T19:30:13.393' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (31, 281, N'file_281.pdf', N'/uploads/appeals/281/file.pdf', CAST(N'2025-11-17T19:30:13.397' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (32, 293, N'file_293.pdf', N'/uploads/appeals/293/file.pdf', CAST(N'2025-10-03T19:30:13.403' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (33, 301, N'file_301.pdf', N'/uploads/appeals/301/file.pdf', CAST(N'2025-11-29T19:30:13.407' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (34, 334, N'file_334.pdf', N'/uploads/appeals/334/file.pdf', CAST(N'2026-03-07T19:30:13.423' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (35, 344, N'file_344.pdf', N'/uploads/appeals/344/file.pdf', CAST(N'2025-07-27T19:30:13.430' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (36, 346, N'file_346.pdf', N'/uploads/appeals/346/file.pdf', CAST(N'2026-03-11T19:30:13.430' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (37, 349, N'file_349.pdf', N'/uploads/appeals/349/file.pdf', CAST(N'2026-04-04T19:30:13.430' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (38, 370, N'file_370.pdf', N'/uploads/appeals/370/file.pdf', CAST(N'2025-11-13T19:30:13.443' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (39, 380, N'file_380.pdf', N'/uploads/appeals/380/file.pdf', CAST(N'2026-01-02T19:30:13.447' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (40, 417, N'file_417.pdf', N'/uploads/appeals/417/file.pdf', CAST(N'2026-05-20T19:30:13.467' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (41, 425, N'file_425.pdf', N'/uploads/appeals/425/file.pdf', CAST(N'2025-11-01T19:30:13.470' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (42, 431, N'file_431.pdf', N'/uploads/appeals/431/file.pdf', CAST(N'2025-06-11T19:30:13.473' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (43, 434, N'file_434.pdf', N'/uploads/appeals/434/file.pdf', CAST(N'2025-09-18T19:30:13.477' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (44, 453, N'file_453.pdf', N'/uploads/appeals/453/file.pdf', CAST(N'2025-08-02T19:30:13.487' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (45, 456, N'file_456.pdf', N'/uploads/appeals/456/file.pdf', CAST(N'2025-08-12T19:30:13.487' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (46, 489, N'file_489.pdf', N'/uploads/appeals/489/file.pdf', CAST(N'2025-06-19T19:30:13.503' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (47, 491, N'file_491.pdf', N'/uploads/appeals/491/file.pdf', CAST(N'2025-11-09T19:30:13.503' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (48, 501, N'file_501.pdf', N'/uploads/appeals/501/file.pdf', CAST(N'2025-12-27T19:30:13.510' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (49, 505, N'file_505.pdf', N'/uploads/appeals/505/file.pdf', CAST(N'2025-12-04T19:30:13.513' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (50, 514, N'file_514.pdf', N'/uploads/appeals/514/file.pdf', CAST(N'2025-07-05T19:30:13.517' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (51, 516, N'file_516.pdf', N'/uploads/appeals/516/file.pdf', CAST(N'2025-11-21T19:30:13.517' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (52, 518, N'file_518.pdf', N'/uploads/appeals/518/file.pdf', CAST(N'2026-01-01T19:30:13.520' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (53, 521, N'file_521.pdf', N'/uploads/appeals/521/file.pdf', CAST(N'2026-03-20T19:30:13.520' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (54, 525, N'file_525.pdf', N'/uploads/appeals/525/file.pdf', CAST(N'2026-05-12T19:30:13.523' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (55, 539, N'file_539.pdf', N'/uploads/appeals/539/file.pdf', CAST(N'2025-07-30T19:30:13.530' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (56, 542, N'file_542.pdf', N'/uploads/appeals/542/file.pdf', CAST(N'2026-02-27T19:30:13.530' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (57, 544, N'file_544.pdf', N'/uploads/appeals/544/file.pdf', CAST(N'2026-02-17T19:30:13.530' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (58, 550, N'file_550.pdf', N'/uploads/appeals/550/file.pdf', CAST(N'2026-02-19T19:30:13.533' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (59, 571, N'file_571.pdf', N'/uploads/appeals/571/file.pdf', CAST(N'2025-11-18T19:30:13.543' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (60, 584, N'file_584.pdf', N'/uploads/appeals/584/file.pdf', CAST(N'2025-06-01T19:30:13.550' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (61, 594, N'file_594.pdf', N'/uploads/appeals/594/file.pdf', CAST(N'2025-12-21T19:30:13.557' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (62, 604, N'file_604.pdf', N'/uploads/appeals/604/file.pdf', CAST(N'2026-01-24T19:30:13.560' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (63, 619, N'file_619.pdf', N'/uploads/appeals/619/file.pdf', CAST(N'2025-07-15T19:30:13.567' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (64, 620, N'file_620.pdf', N'/uploads/appeals/620/file.pdf', CAST(N'2025-12-28T19:30:13.567' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (65, 630, N'file_630.pdf', N'/uploads/appeals/630/file.pdf', CAST(N'2025-06-28T19:30:13.573' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (66, 635, N'file_635.pdf', N'/uploads/appeals/635/file.pdf', CAST(N'2026-01-25T19:30:13.577' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (67, 638, N'file_638.pdf', N'/uploads/appeals/638/file.pdf', CAST(N'2025-05-21T19:30:13.577' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (68, 640, N'file_640.pdf', N'/uploads/appeals/640/file.pdf', CAST(N'2025-05-22T19:30:13.580' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (69, 646, N'file_646.pdf', N'/uploads/appeals/646/file.pdf', CAST(N'2025-06-07T19:30:13.610' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (70, 650, N'file_650.pdf', N'/uploads/appeals/650/file.pdf', CAST(N'2026-01-04T19:30:13.613' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (71, 652, N'file_652.pdf', N'/uploads/appeals/652/file.pdf', CAST(N'2026-02-18T19:30:13.613' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (72, 662, N'file_662.pdf', N'/uploads/appeals/662/file.pdf', CAST(N'2026-05-14T19:30:13.620' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (73, 667, N'file_667.pdf', N'/uploads/appeals/667/file.pdf', CAST(N'2026-01-08T19:30:13.620' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (74, 670, N'file_670.pdf', N'/uploads/appeals/670/file.pdf', CAST(N'2026-01-11T19:30:13.623' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (75, 677, N'file_677.pdf', N'/uploads/appeals/677/file.pdf', CAST(N'2025-05-30T19:30:13.627' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (76, 681, N'file_681.pdf', N'/uploads/appeals/681/file.pdf', CAST(N'2025-10-30T19:30:13.630' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (77, 688, N'file_688.pdf', N'/uploads/appeals/688/file.pdf', CAST(N'2025-08-25T19:30:13.633' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (78, 712, N'file_712.pdf', N'/uploads/appeals/712/file.pdf', CAST(N'2025-08-08T19:30:13.643' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (79, 720, N'file_720.pdf', N'/uploads/appeals/720/file.pdf', CAST(N'2025-06-22T19:30:13.647' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (80, 738, N'file_738.pdf', N'/uploads/appeals/738/file.pdf', CAST(N'2026-04-06T19:30:13.657' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (81, 750, N'file_750.pdf', N'/uploads/appeals/750/file.pdf', CAST(N'2025-10-17T19:30:13.663' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (82, 758, N'file_758.pdf', N'/uploads/appeals/758/file.pdf', CAST(N'2025-12-16T19:30:13.667' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (83, 761, N'file_761.pdf', N'/uploads/appeals/761/file.pdf', CAST(N'2025-06-13T19:30:13.670' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (84, 778, N'file_778.pdf', N'/uploads/appeals/778/file.pdf', CAST(N'2026-04-06T19:30:13.677' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (85, 788, N'file_788.pdf', N'/uploads/appeals/788/file.pdf', CAST(N'2026-04-22T19:30:13.680' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (86, 810, N'file_810.pdf', N'/uploads/appeals/810/file.pdf', CAST(N'2025-12-08T19:30:13.693' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (87, 813, N'file_813.pdf', N'/uploads/appeals/813/file.pdf', CAST(N'2025-10-30T19:30:13.693' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (88, 822, N'file_822.pdf', N'/uploads/appeals/822/file.pdf', CAST(N'2025-05-28T19:30:13.700' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (89, 834, N'file_834.pdf', N'/uploads/appeals/834/file.pdf', CAST(N'2025-07-12T19:30:13.703' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (90, 835, N'file_835.pdf', N'/uploads/appeals/835/file.pdf', CAST(N'2026-02-08T19:30:13.703' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (91, 839, N'file_839.pdf', N'/uploads/appeals/839/file.pdf', CAST(N'2025-08-28T19:30:13.707' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (92, 844, N'file_844.pdf', N'/uploads/appeals/844/file.pdf', CAST(N'2025-10-30T19:30:13.710' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (93, 856, N'file_856.pdf', N'/uploads/appeals/856/file.pdf', CAST(N'2025-09-23T19:30:13.713' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (94, 874, N'file_874.pdf', N'/uploads/appeals/874/file.pdf', CAST(N'2026-04-18T19:30:13.723' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (95, 878, N'file_878.pdf', N'/uploads/appeals/878/file.pdf', CAST(N'2026-05-16T19:30:13.727' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (96, 880, N'file_880.pdf', N'/uploads/appeals/880/file.pdf', CAST(N'2025-07-15T19:30:13.727' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (97, 882, N'file_882.pdf', N'/uploads/appeals/882/file.pdf', CAST(N'2025-07-15T19:30:13.727' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (98, 888, N'file_888.pdf', N'/uploads/appeals/888/file.pdf', CAST(N'2025-12-13T19:30:13.730' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (99, 893, N'file_893.pdf', N'/uploads/appeals/893/file.pdf', CAST(N'2025-09-28T19:30:13.733' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (100, 898, N'file_898.pdf', N'/uploads/appeals/898/file.pdf', CAST(N'2026-05-06T19:30:13.733' AS DateTime))
GO
INSERT [dbo].[Attachment] ([AttachmentID], [AppealID], [FileName], [FilePath], [UploadedAt]) VALUES (101, 1900, N'Grafik_PM02_23P-1_Sedov_Makhnev.docx', N'Attachments\443633ed-da01-4d34-9348-96b999ee00bc.docx', CAST(N'2026-05-23T14:54:16.017' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Attachment] OFF
GO
SET IDENTITY_INSERT [dbo].[Category] ON 
GO
INSERT [dbo].[Category] ([CategoryID], [Name], [Description]) VALUES (1, N'ЖКХ', N'Вопросы жилищно-коммунального хозяйства')
GO
INSERT [dbo].[Category] ([CategoryID], [Name], [Description]) VALUES (2, N'Благоустройство', N'Озеленение, уборка, освещение')
GO
INSERT [dbo].[Category] ([CategoryID], [Name], [Description]) VALUES (3, N'Социальная помощь', N'Выплаты, льготы, поддержка')
GO
INSERT [dbo].[Category] ([CategoryID], [Name], [Description]) VALUES (4, N'Дороги и транспорт', N'Ремонт дорог, общественный транспорт')
GO
INSERT [dbo].[Category] ([CategoryID], [Name], [Description]) VALUES (5, N'Образование', N'Школы, детсады, дополнительное образование')
GO
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[Status] ON 
GO
INSERT [dbo].[Status] ([StatusID], [Name], [IsFinal]) VALUES (1, N'Новое', 0)
GO
INSERT [dbo].[Status] ([StatusID], [Name], [IsFinal]) VALUES (2, N'В работе', 0)
GO
INSERT [dbo].[Status] ([StatusID], [Name], [IsFinal]) VALUES (3, N'Выполнено', 1)
GO
INSERT [dbo].[Status] ([StatusID], [Name], [IsFinal]) VALUES (4, N'Закрыто', 1)
GO
INSERT [dbo].[Status] ([StatusID], [Name], [IsFinal]) VALUES (5, N'Отклонено', 1)
GO
SET IDENTITY_INSERT [dbo].[Status] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Applicat__5E55825B0D2F5E12]    Script Date: 24.05.2026 14:14:04 ******/
ALTER TABLE [dbo].[ApplicationUser] ADD UNIQUE NONCLUSTERED 
(
	[Login] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Appeal] ADD  DEFAULT ((1)) FOR [StatusID]
GO
ALTER TABLE [dbo].[Appeal] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Appeal] ADD  DEFAULT (getdate()) FOR [UpdatedAt]
GO
ALTER TABLE [dbo].[AppealHistory] ADD  DEFAULT (getdate()) FOR [ActionDate]
GO
ALTER TABLE [dbo].[ApplicationUser] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[ApplicationUser] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Attachment] ADD  DEFAULT (getdate()) FOR [UploadedAt]
GO
ALTER TABLE [dbo].[Status] ADD  DEFAULT ((0)) FOR [IsFinal]
GO
ALTER TABLE [dbo].[Appeal]  WITH CHECK ADD  CONSTRAINT [FK_Appeal_AssignedTo] FOREIGN KEY([AssignedToID])
REFERENCES [dbo].[ApplicationUser] ([UserID])
GO
ALTER TABLE [dbo].[Appeal] CHECK CONSTRAINT [FK_Appeal_AssignedTo]
GO
ALTER TABLE [dbo].[Appeal]  WITH CHECK ADD  CONSTRAINT [FK_Appeal_Author] FOREIGN KEY([AuthorID])
REFERENCES [dbo].[ApplicationUser] ([UserID])
GO
ALTER TABLE [dbo].[Appeal] CHECK CONSTRAINT [FK_Appeal_Author]
GO
ALTER TABLE [dbo].[Appeal]  WITH CHECK ADD  CONSTRAINT [FK_Appeal_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([CategoryID])
GO
ALTER TABLE [dbo].[Appeal] CHECK CONSTRAINT [FK_Appeal_Category]
GO
ALTER TABLE [dbo].[Appeal]  WITH CHECK ADD  CONSTRAINT [FK_Appeal_Status] FOREIGN KEY([StatusID])
REFERENCES [dbo].[Status] ([StatusID])
GO
ALTER TABLE [dbo].[Appeal] CHECK CONSTRAINT [FK_Appeal_Status]
GO
ALTER TABLE [dbo].[AppealHistory]  WITH CHECK ADD  CONSTRAINT [FK_History_Appeal] FOREIGN KEY([AppealID])
REFERENCES [dbo].[Appeal] ([AppealID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AppealHistory] CHECK CONSTRAINT [FK_History_Appeal]
GO
ALTER TABLE [dbo].[AppealHistory]  WITH CHECK ADD  CONSTRAINT [FK_History_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[ApplicationUser] ([UserID])
GO
ALTER TABLE [dbo].[AppealHistory] CHECK CONSTRAINT [FK_History_User]
GO
ALTER TABLE [dbo].[Attachment]  WITH CHECK ADD  CONSTRAINT [FK_Attachment_Appeal] FOREIGN KEY([AppealID])
REFERENCES [dbo].[Appeal] ([AppealID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Attachment] CHECK CONSTRAINT [FK_Attachment_Appeal]
GO
ALTER TABLE [dbo].[ApplicationUser]  WITH CHECK ADD CHECK  (([Role]=N'Администратор' OR [Role]=N'Исполнитель' OR [Role]=N'Оператор' OR [Role]=N'Гражданин'))
GO
USE [master]
GO
ALTER DATABASE [PM11_FACTORY] SET  READ_WRITE 
GO
