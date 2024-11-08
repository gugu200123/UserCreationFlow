USE [master]
GO
/****** Object:  Database [UserManagementDB]    Script Date: 02/11/2024 03:35:04 ******/
CREATE DATABASE [UserManagementDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'UserManagementDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\UserManagementDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'UserManagementDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\UserManagementDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [UserManagementDB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [UserManagementDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [UserManagementDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [UserManagementDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [UserManagementDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [UserManagementDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [UserManagementDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [UserManagementDB] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [UserManagementDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [UserManagementDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [UserManagementDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [UserManagementDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [UserManagementDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [UserManagementDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [UserManagementDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [UserManagementDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [UserManagementDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [UserManagementDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [UserManagementDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [UserManagementDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [UserManagementDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [UserManagementDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [UserManagementDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [UserManagementDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [UserManagementDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [UserManagementDB] SET  MULTI_USER 
GO
ALTER DATABASE [UserManagementDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [UserManagementDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [UserManagementDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [UserManagementDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [UserManagementDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [UserManagementDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [UserManagementDB] SET QUERY_STORE = OFF
GO
USE [UserManagementDB]
GO
/****** Object:  User [UsuarioParaTeste]    Script Date: 02/11/2024 03:35:04 ******/
CREATE USER [UsuarioParaTeste] FOR LOGIN [UsuarioParaTeste] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [UsuarioParaTeste]
GO
ALTER ROLE [db_accessadmin] ADD MEMBER [UsuarioParaTeste]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [UsuarioParaTeste]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [UsuarioParaTeste]
GO
ALTER ROLE [db_backupoperator] ADD MEMBER [UsuarioParaTeste]
GO
ALTER ROLE [db_datareader] ADD MEMBER [UsuarioParaTeste]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [UsuarioParaTeste]
GO
ALTER ROLE [db_denydatareader] ADD MEMBER [UsuarioParaTeste]
GO
ALTER ROLE [db_denydatawriter] ADD MEMBER [UsuarioParaTeste]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 02/11/2024 03:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UserFirstName] [nvarchar](50) NOT NULL,
	[UserLastName] [nvarchar](50) NOT NULL,
	[PasswordHash] [nvarchar](255) NOT NULL,
	[Email] [nvarchar](100) NULL,
	[CreatedAt] [datetime] NULL,
	[UserLevel] [nvarchar](20) NULL,
	[salt] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ('user') FOR [UserLevel]
GO
/****** Object:  StoredProcedure [dbo].[AddUser]    Script Date: 02/11/2024 03:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddUser]
    @UserFirstName NVARCHAR(50),
    @UserLastName NVARCHAR(50),
    @PasswordHash NVARCHAR(255),
    @Email NVARCHAR(100),
    @UserLevel NVARCHAR(20) = 'user' -- Valor padrão
AS
BEGIN
    INSERT INTO Users (UserFirstName, UserLastName, PasswordHash, Email, UserLevel)
    VALUES (@UserFirstName, @UserLastName, @PasswordHash, @Email, @UserLevel);
END;
GO
USE [master]
GO
ALTER DATABASE [UserManagementDB] SET  READ_WRITE 
GO
