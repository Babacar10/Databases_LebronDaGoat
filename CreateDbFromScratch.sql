USE [master]
GO

/****** Object:  Database [NBAHistoricStats_S3G6]    Script Date: 5/19/2022 3:30:20 PM ******/
CREATE DATABASE [NBAHistoricStats_S3G6V5] --Step 1 Change Db Name--
 CONTAINMENT = NONE
 ON  PRIMARY 
 -- Step 2 Change file names--
( NAME = N'NBAHistoricStats_S3G6V5', FILENAME = N'D:\Database\MSSQL15.MSSQLSERVER\MSSQL\DATA\NBAHistoricStatsV5.mdf' , SIZE = 10240KB , MAXSIZE = 3145728KB , FILEGROWTH = 5%)
 LOG ON 
( NAME = N'NBAHistoricStatsV5_log', FILENAME = N'D:\Database\MSSQL15.MSSQLSERVER\MSSQL\DATA\NBAHistoricStatsV5_log.ldf' , SIZE = 307200KB , MAXSIZE = 307200KB , FILEGROWTH = 33%)
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
--Step 3 change exec name and all the other names--
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [NBAHistoricStats_S3G6V5].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [NBAHistoricStats_S3G6V5] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [NBAHistoricStats_S3G6V5] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [NBAHistoricStats_S3G6V5] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [NBAHistoricStats_S3G6V5] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [NBAHistoricStats_S3G6V5] SET ARITHABORT OFF 
GO

ALTER DATABASE [NBAHistoricStats_S3G6V5] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [NBAHistoricStats_S3G6V5] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [NBAHistoricStats_S3G6V5] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [NBAHistoricStats_S3G6V5] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [NBAHistoricStats_S3G6V5] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [NBAHistoricStats_S3G6V5] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [NBAHistoricStats_S3G6V5] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [NBAHistoricStats_S3G6V5] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [NBAHistoricStats_S3G6V5] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [NBAHistoricStats_S3G6V5] SET  ENABLE_BROKER 
GO

ALTER DATABASE [NBAHistoricStats_S3G6V5] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [NBAHistoricStats_S3G6V5] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
/**ALTER DATABASE [NBAHistoricStats_S3G6V5] SET TRUSTWORTHY OFF 
GO**/

ALTER DATABASE [NBAHistoricStats_S3G6V5] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [NBAHistoricStats_S3G6V5] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [NBAHistoricStats_S3G6V5] SET READ_COMMITTED_SNAPSHOT OFF 
GO

/**ALTER DATABASE [NBAHistoricStats_S3G6V5] SET HONOR_BROKER_PRIORITY OFF 
GO**/

ALTER DATABASE [NBAHistoricStats_S3G6V5] SET RECOVERY FULL 
GO

ALTER DATABASE [NBAHistoricStats_S3G6V5] SET  MULTI_USER 
GO

ALTER DATABASE [NBAHistoricStats_S3G6V5] SET PAGE_VERIFY CHECKSUM  
GO

/**ALTER DATABASE [NBAHistoricStats_S3G6V5] SET DB_CHAINING OFF 
GO**/

ALTER DATABASE [NBAHistoricStats_S3G6V5] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [NBAHistoricStats_S3G6V5] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [NBAHistoricStats_S3G6V5] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [NBAHistoricStats_S3G6V5] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO

ALTER DATABASE [NBAHistoricStats_S3G6V5] SET QUERY_STORE = OFF
GO

ALTER DATABASE [NBAHistoricStats_S3G6V5] SET  READ_WRITE 
GO
/**End Create DB**/ 
USE [NBAHistoricStats_S3G6V5]
GO

/****** Object:  Table [dbo].[Championship]    Script Date: 5/19/2022 2:13:47 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/** Team Table**/ 
CREATE TABLE [dbo].[Team](
	[Name] [varchar](75) NOT NULL,
	[State] [char](2) NOT NULL,
	[City] [varchar](50) NOT NULL,
	[TeamID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK__Team__123AE7B9C9C71C10] PRIMARY KEY CLUSTERED 
(
	[TeamID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/** Player Table**/ 
CREATE TABLE [dbo].[Player](
	[Name] [varchar](20) NOT NULL,
	[Height] [int] NULL,
	[Weight] [int] NULL,
	[Position] [varchar](2) NULL,
	[HOF] [bit] NULL,
	[YearBorn] [int] NULL,
	[PlayerID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK__Player__4A4E74A8CAB02F5E] PRIMARY KEY CLUSTERED 
(
	[PlayerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Player]  WITH CHECK ADD CHECK  (([Height]<(108)))
GO

ALTER TABLE [dbo].[Player]  WITH CHECK ADD CHECK  (([POSITION]='PG' OR [POSITION]='SG' OR [POSITION]='SF' OR [POSITION]='PF' OR [POSITION]='C' OR [POSITION] IS NULL))
GO

ALTER TABLE [dbo].[Player]  WITH CHECK ADD CHECK  (([Weight]<(1000)))
GO

ALTER TABLE [dbo].[Player]  WITH CHECK ADD CHECK  (([YearBorn]<datepart(year,getdate())))
GO
/** Played For Table**/ 
CREATE TABLE [dbo].[PlayedFor](
	[Year] [int] NOT NULL,
	[TeamID] [int] NOT NULL,
	[PlayerID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Year] ASC,
	[TeamID] ASC,
	[PlayerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[PlayedFor]  WITH CHECK ADD  CONSTRAINT [FK__PlayedFor__Playe__2E1BDC42] FOREIGN KEY([TeamID])
REFERENCES [dbo].[Team] ([TeamID])
GO

ALTER TABLE [dbo].[PlayedFor] CHECK CONSTRAINT [FK__PlayedFor__Playe__2E1BDC42]
GO

ALTER TABLE [dbo].[PlayedFor]  WITH CHECK ADD  CONSTRAINT [FK__PlayedFor__Playe__2F10007B] FOREIGN KEY([PlayerID])
REFERENCES [dbo].[Player] ([PlayerID])
GO

ALTER TABLE [dbo].[PlayedFor] CHECK CONSTRAINT [FK__PlayedFor__Playe__2F10007B]
GO

/**Player Per Year Table**/

CREATE TABLE [dbo].[PlayerPerYearStats](
	[PlayerID] [int] NOT NULL,
	[AssistsPG] [int] NULL,
	[ReboundsPG] [int] NULL,
	[PointsPG] [int] NULL,
	[TurnoversPG] [int] NULL,
	[FGPercent] [int] NULL,
	[ThreePtPercent] [int] NULL,
	[TrueShootingPercent] [int] NULL,
	[PlayerEfficiencyRating] [int] NULL,
	[Year] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PlayerID] ASC,
	[Year] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[PlayerPerYearStats]  WITH CHECK ADD  CONSTRAINT [FK__PlayerPerY__Year__5EBF139D] FOREIGN KEY([PlayerID])
REFERENCES [dbo].[Player] ([PlayerID])
GO

ALTER TABLE [dbo].[PlayerPerYearStats] CHECK CONSTRAINT [FK__PlayerPerY__Year__5EBF139D]
GO

ALTER TABLE [dbo].[PlayerPerYearStats]  WITH CHECK ADD CHECK  (([FGPercent]<=(100) AND [FGPercent]>=(0) OR [FGPercent] IS NULL))
GO

ALTER TABLE [dbo].[PlayerPerYearStats]  WITH CHECK ADD CHECK  (([ThreePtPercent]<=(100) AND [ThreePtPercent]>=(0) OR [ThreePtPercent] IS NULL))
GO

ALTER TABLE [dbo].[PlayerPerYearStats]  WITH CHECK ADD CHECK  (([TrueShootingPercent]<=(100) AND [TrueShootingPercent]>=(0) OR [TrueShootingPercent] IS NULL))
GO

/** Team Per Year Table**/ 
CREATE TABLE [dbo].[TeamPerYearStats](
	[TeamID] [int] NOT NULL,
	[Wins] [int] NULL,
	[Losses] [int] NULL,
	[Year] [int] NOT NULL,
	[FGPercent] [int] NULL,
	[PtsPG] [int] NULL,
	[ThreePtPercent] [int] NULL,
	[TurnoversPG] [int] NULL,
	[WinPercent]  AS (CONVERT([int],(CONVERT([decimal](7,2),[Wins])/([Wins]+[Losses]))*(100))),
PRIMARY KEY CLUSTERED 
(
	[TeamID] ASC,
	[Year] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TeamPerYearStats]  WITH CHECK ADD  CONSTRAINT [FK__TeamPerYe__Turno__619B8048] FOREIGN KEY([TeamID])
REFERENCES [dbo].[Team] ([TeamID])
GO

ALTER TABLE [dbo].[TeamPerYearStats] CHECK CONSTRAINT [FK__TeamPerYe__Turno__619B8048]
GO

ALTER TABLE [dbo].[TeamPerYearStats]  WITH CHECK ADD CHECK  (([FGPercent]<=(100) AND [FGPercent]>=(0) OR [FGPercent] IS NULL))
GO

ALTER TABLE [dbo].[TeamPerYearStats]  WITH CHECK ADD CHECK  (([ThreePtPercent]<=(100) AND [ThreePtPercent]>=(0) OR [ThreePtPercent] IS NULL))
GO


/**Championship Table**/
CREATE TABLE [dbo].[Championship](
	[Year] [int] NOT NULL,
	[TeamID] [int] NOT NULL,
 CONSTRAINT [PK__Champion__D4BD60557556E624] PRIMARY KEY CLUSTERED 
(
	[Year] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Championship]  WITH CHECK ADD  CONSTRAINT [FK__Champions__TeamI__34C8D9D1] FOREIGN KEY([TeamID])
REFERENCES [dbo].[Team] ([TeamID])
GO

ALTER TABLE [dbo].[Championship] CHECK CONSTRAINT [FK__Champions__TeamI__34C8D9D1]
GO

/**MVP Table**/
CREATE TABLE [dbo].[MVP](
	[Year] [int] NOT NULL,
	[PlayerID] [int] NOT NULL,
 CONSTRAINT [PK__MVP__D4BD6055E5B55713] PRIMARY KEY CLUSTERED 
(
	[Year] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[MVP]  WITH CHECK ADD  CONSTRAINT [FK__MVP__PlayerID__31EC6D26] FOREIGN KEY([PlayerID])
REFERENCES [dbo].[Player] ([PlayerID])
GO

ALTER TABLE [dbo].[MVP] CHECK CONSTRAINT [FK__MVP__PlayerID__31EC6D26]
GO

/**PROCEDURES START**/ 

/** add Team Procedure**/ 
CREATE PROCEDURE [dbo].[add_Team]
(@Name varchar(20),
@State char(2) = NULL,
@City varchar(50) = NULL
)
AS
BEGIN
INSERT Team([Name], State, City)
VALUES(@Name, @State, @City);
END
GO

/**Add team stats procedure**/ 
CREATE PROCEDURE [dbo].[add_TeamStats]
(@TeamID int,
@Wins int = NULL,
@Losses int = NULL,
@Year int,
@FGPercent int = NULL,
@PtsPG int = NULL,
@ThreePtPercent int = NULL,
@TurnoversPG int = NULL
)
AS
BEGIN
INSERT TeamPerYearStats(TeamID,Wins,Losses,[Year],FGPercent,PtsPG,ThreePtPercent,TurnoversPG)
VALUES(@TeamID,@Wins,@Losses,@Year,@FGPercent,@PtsPG,@ThreePtPercent,@TurnoversPG);
END
GO

/**Delete Team proceudure**/ 
CREATE PROCEDURE [dbo].[delete_Team]
(@TeamID int)
AS
--Delete the row with the given OrderID and ProductID in OrderDetails
DELETE [Team]
WHERE ( TeamID = @TeamID)

DELETE TeamPerYearStats
WHERE ( TeamID = @TeamID)

GO

/**Get Team Procedure**/ 
CREATE PROCEDURE [dbo].[GetTeam]
	-- Add the parameters for the stored procedure here
	@TeamID int
AS
BEGIN
	SELECT * FROM Team WHERE TeamID = @TeamID
END
GO

/**Get Team Stats Procedure**/ 
CREATE PROCEDURE [dbo].[GetTeamStats]
	-- Add the parameters for the stored procedure here
	@Year int,
	@TeamID int
AS
BEGIN
	SELECT * FROM TeamPerYearStats WHERE TeamID = @TeamID AND [Year] = @Year
END
GO

/** Add Player Proceudre**/ 
CREATE PROCEDURE [dbo].[add_Player]
(@Name varchar(20),
@Height int = NULL,
@Weight int = NULL,
@Position varchar(2) = NULL,
@HOF bit = NULL,
@YearBorn int = NULL
)
AS

BEGIN
INSERT Player([Name], Height, [Weight], Position, HOF, YearBorn)
VALUES(@Name, @Height, @Weight, @Position, @HOF, @YearBorn);
END
GO

/**Get Player by ID procedure**/ 
CREATE PROCEDURE [dbo].[GetPlayerByID](@PlayerID int)
AS 
SELECT * FROM Player WHERE PlayerID = @PlayerID
GO

/** Add Player Stats Procedure**/ 
CREATE PROCEDURE [dbo].[add_PlayerStats]
(@Name varchar(50),
@APG int = NULL,
@RPG int = NULL,
@PPG int = NULL,
@TOPG int = NULL,
@FGPCNT int = NULL,
@3PPCNT int = NULL,
@PER int = NULL,
@TSP int = NULL,
@Year int = NULL
)
AS

BEGIN
DECLARE @PID int
SET @PID = (SELECT PlayerID FROM Player WHERE [Name] = @Name)
IF(@PID is null)
BEGIN
	raiserror('Player not found',10,1);
	RETURN 0
END
INSERT INTO PlayerPerYearStats(PlayerID, AssistsPG, ReboundsPG, PointsPG, TurnoversPG, FGPercent, ThreePtPercent, TrueShootingPercent, PlayerEfficiencyRating, [Year])
VALUES(@PID, @APG, @RPG, @PPG, @TOPG, @FGPCNT, @3PPCNT, @TSP, @PER, @Year);
END
GO

/**Get Player Stats Procedure**/ 
CREATE PROCEDURE [dbo].[GetPlayerStats](@PlayerID int, @Year int)
AS 
SELECT * FROM PlayerPerYearStats WHERE PlayerID = @PlayerID 
GO

/** Delete Player Procedure**/ 
CREATE PROCEDURE [dbo].[delete_Player]
(@PlayerID int)
AS
--Delete the row with the given OrderID and ProductID in OrderDetails
DELETE [Player]
WHERE ( PlayerID = @PlayerID)

DELETE PlayerPerYearStats
WHERE (PlayerID = @PlayerID)

GO

/**PLayer Played For Procedure**/ 
CREATE PROCEDURE [dbo].[add_PlayedFor]
(@PlayerName varchar(50),
@TeamID varchar(50),
@Year int
)
AS

DECLARE @PID int
SET @PID = (SELECT PlayerID FROM Player WHERE [Name] = @PlayerName)
IF(@PID is null)
BEGIN
	raiserror('Player not found',10,1);
	RETURN 0
END

BEGIN
INSERT PlayedFor([Year], TeamID, PlayerID)
VALUES(@Year, @TeamID, @PID);
END
GO

/** Edit Player Procedure**/ 
CREATE PROCEDURE [dbo].[edit_Player]
(@PlayerID int,
@Name varchar(20) = NULL,
@Height int = NULL,
@Weight int = NULL,
@Position varchar(2) = NULL,
@HOF bit = NULL,
@YearBorn int = NULL
)
AS
BEGIN TRANSACTION
BEGIN

IF @Name is not null
BEGIN
	UPDATE Player
	SET [Name] = @Name
	WHERE (PlayerID = @PlayerID)
END

IF @Height is not null
BEGIN
	UPDATE Player
	SET Height = @Height
	WHERE (PlayerID = @PlayerID)
END

IF @Weight is not null
BEGIN
     UPDATE Player
     SET Weight = @Weight
     WHERE (PlayerID = @PlayerID)
END

IF @Position is not null
BEGIN
     UPDATE Player
     SET Position = @Position
     WHERE (PlayerID = @PlayerID)
END

IF @HOF is not null
BEGIN
     UPDATE Player
     SET HOF = @HOF
     WHERE (PlayerID = @PlayerID)
END

IF @YearBorn is not null
BEGIN
     UPDATE Player
     SET YearBorn = @YearBorn
     WHERE (PlayerID = @PlayerID)
END


COMMIT TRANSACTION
END
GO

/**Edit Player Position Procedure**/ 
CREATE PROCEDURE [dbo].[edit_PlayerPos]
(
@Name varchar(20) = NULL,
@Position varchar(2) = NULL
)
AS
BEGIN TRANSACTION
BEGIN

DECLARE @PID int
SET @PID = (SELECT PlayerID FROM Player WHERE [Name] = @Name)
IF(@PID is null)
BEGIN
	raiserror('Player not found',10,1);
	RETURN 0
END

IF @Name is not null
BEGIN
	UPDATE Player
	SET [Name] = @Name
	WHERE ([Name] = @Name)
END



IF @Position is not null
BEGIN
     UPDATE Player
     SET Position = @Position
     WHERE (PlayerID = @PID)
END


COMMIT TRANSACTION


END
GO

/**Edit Player Stats Procedure**/ 
CREATE PROCEDURE [dbo].[edit_PlayerStats]
(@PlayerID int,
@AssistsPG int = NULL,
@ReboundsPG int = NULL,
@PointsPG int = NULL,
@TurnoversPG int = NULL,
@FGPercent int = NULL,
@ThreePtPercent int = NULL,
@TrueShootingPercent int = NULL,
@PlayerEfficiencyRating int = NULL,
@Year int
)
AS
BEGIN TRANSACTION
BEGIN
IF @AssistsPG is not null
BEGIN
     UPDATE PlayerPerYearStats
     SET AssistsPG = @AssistsPG
     WHERE (PlayerID = @PlayerID AND Year = @Year)
END

IF @ReboundsPG is not null
BEGIN
     UPDATE PlayerPerYearStats
     SET ReboundsPG = @ReboundsPG
     WHERE (PlayerID = @PlayerID AND Year = @Year)
END

IF @PointsPG is not null
BEGIN
     UPDATE PlayerPerYearStats
     SET PointsPG = @PointsPG
     WHERE (PlayerID = @PlayerID AND Year = @Year)
END

IF @TurnoversPG is not null
BEGIN
     UPDATE PlayerPerYearStats
     SET TurnoversPG = @TurnoversPG
     WHERE (PlayerID = @PlayerID AND Year = @Year)
END

IF @FGPercent is not null
BEGIN
     UPDATE PlayerPerYearStats
     SET FGPercent = @FGPercent
     WHERE (PlayerID = @PlayerID AND Year = @Year)
END

IF @ThreePtPercent is not null
BEGIN
     UPDATE PlayerPerYearStats
     SET ThreePtPercent = @ThreePtPercent
     WHERE (PlayerID = @PlayerID AND Year = @Year)
END

IF @TrueShootingPercent is not null
BEGIN
     UPDATE PlayerPerYearStats
     SET TrueShootingPercent = @TrueShootingPercent
     WHERE (PlayerID = @PlayerID AND Year = @Year)
END

IF @PlayerEfficiencyRating is not null
BEGIN
     UPDATE PlayerPerYearStats
     SET PlayerEfficiencyRating = @PlayerEfficiencyRating
     WHERE (PlayerID = @PlayerID AND Year = @Year)
END

COMMIT TRANSACTION
END
GO

/**Get All Players**/ 
CREATE PROCEDURE [dbo].[GetAllPlayers]
AS 
SELECT * FROM PLAYER
GO

/** Get Teammates Procedure **/ 
CREATE PROCEDURE [dbo].[GetTeammates]
	-- Add the parameters for the stored procedure here
	@PlayerID int,
	@Year int
AS
BEGIN
	DECLARE @TeamID int
	SELECT @TeamID = TeamID FROM PlayedFor WHERE PlayerID = @PlayerID AND Year = @Year
	SELECT Name FROM Player WHERE PlayerID in (SELECT PlayerID FROM PlayedFor WHERE TeamID = @TeamID AND Year = @Year)
END
GO

/** Add Championship Procedure**/ 
CREATE PROCEDURE [dbo].[add_Championship]
(@Year int,
@TeamID int
)
AS

BEGIN
INSERT Championship([Year], TeamID)
VALUES(@Year, @TeamID);
END
GO

/**Add MVP Procedure **/ 
CREATE PROCEDURE [dbo].[add_MVP]
(@Year int,
@PlayerID int
)
AS
BEGIN
--DECLARE @PID int
--SET @PID = (SELECT PlayerID FROM Player WHERE [PlayerID] = @PlayerName)
--IF(@PID is null)
--BEGIN
	--raiserror('Player not found',10,1);
	--RETURN 0
--END

INSERT MVP([Year], PlayerID)
VALUES(@Year, @PlayerID);
END
GO

/**Get Champion Procedure**/ 
CREATE PROCEDURE [dbo].[GetChampion](@Year int)
AS 
SELECT * FROM Championship WHERE [Year] = @Year
GO

/**Get Championship by year Procedure**/ 
CREATE PROCEDURE [dbo].[GetChampionshipByYear]
	-- Add the parameters for the stored procedure here
	@Year int
AS
BEGIN
	SELECT Name FROM Team WHERE TeamID in (SELECT TeamID FROM Championship WHERE Year = @Year)
END
GO

/**Championship by Name Procedure**/ 

CREATE PROCEDURE [dbo].[add_ChampionshipByName]
(@Year int,
@TeamName varchar(50)
)
AS
DECLARE @TID int
SET @TID = (SELECT TeamID FROM Team WHERE [Name] = @TeamName)
BEGIN
IF @TID is not null
BEGIN
	INSERT Championship([Year], TeamID)
	VALUES(@Year, @TID);
END
END
GO

/**Get MVP Procedure**/ 
CREATE PROCEDURE [dbo].[GetMVP](@Year int)
AS 
SELECT Name, PlayerID FROM Player WHERE PlayerID in (SELECT PlayerID FROM MVP WHERE [Year] = @Year)
GO

/** Triggers and Indexes**/ 

CREATE NONCLUSTERED INDEX [WinPercent_index] ON [dbo].[TeamPerYearStats]
(
    [WinPercent] ASC
)
go 

CREATE TRIGGER [dbo].[DeleteTeam] ON [dbo].[Team]
INSTEAD OF DELETE
AS
DECLARE @TID int
SELECT @TID = TeamID FROM deleted
DELETE FROM TeamPerYearStats WHERE TeamID = @TID
DELETE FROM Team WHERE TeamID = @TID
go 

CREATE TRIGGER [dbo].[DeletePlayer] ON [dbo].[Player]
INSTEAD OF DELETE
AS
DECLARE @PID int
SELECT @PID = PlayerID FROM deleted
DELETE FROM PlayerPerYearStats WHERE PlayerID = @PID
DELETE FROM Player WHERE PlayerID = @PID
go 

/**mvp by name**/
CREATE PROCEDURE [dbo].[add_MVPByName]
(@Year int,
@PlayerName varchar(50)
)
AS
BEGIN
DECLARE @PID int
SET @PID = (SELECT PlayerID FROM Player WHERE Name = @PlayerName)
IF(@PID is null)
BEGIN
	raiserror('Player not found',10,1);
	RETURN 0
END

INSERT MVP([Year], PlayerID)
VALUES(@Year, @PID);
END
GO

/**Played for by Team Procedure**/ 
CREATE PROCEDURE [dbo].[add_PlayedForByTeamName]
(@PlayerName varchar(50),
@TeamName varchar(50),
@Year int
)
AS

DECLARE @TID int
SET @TID = (SELECT TeamID FROM Team WHERE [Name] = @TeamName)
DECLARE @PID int
SET @PID = (SELECT PlayerID FROM Player WHERE [Name] = @PlayerName)
IF(@PID is null)
BEGIN
	raiserror('Player not found',10,1);
	RETURN 0
END

BEGIN
INSERT PlayedFor([Year], TeamID, PlayerID)
VALUES(@Year, @TID, @PID);
END
GO

/**Player Stats by Name**/ 
CREATE PROCEDURE [dbo].[add_PlayerStatsByName]
(@PlayerName varchar(50),
@APG int = NULL,
@RPG int = NULL,
@PPG int = NULL,
@TOPG int = NULL,
@FGPCNT int = NULL,
@3PPCNT int = NULL,
@TSP int = NULL,
@PER int = NULL,
@Year int = NULL
)
AS

BEGIN
DECLARE @PID int
SELECT @PID = PlayerID FROM Player WHERE Name = @PlayerName
IF(@PID is null)
BEGIN
	raiserror('Player not found',10,1);
	RETURN 0
END
INSERT INTO PlayerPerYearStats(PlayerID, AssistsPG, ReboundsPG, PointsPG, TurnoversPG, FGPercent, ThreePtPercent, TrueShootingPercent, PlayerEfficiencyRating, [Year])
VALUES(@PID, @APG, @RPG, @PPG, @TOPG, @FGPCNT, @3PPCNT, @TSP, @PER, @Year);
END
GO



/**Team Stats by Name**/ 
CREATE PROCEDURE [dbo].[add_TeamStatsByName]
(@TeamName varchar(50),
@Wins int = NULL,
@Losses int = NULL,
@Year int,
@FGPercent int = NULL,
@PtsPG int = NULL,
@ThreePtPercent int = NULL,
@TurnoversPG int = NULL
)
AS
BEGIN
DECLARE @TID int
SELECT @TID = TeamID FROM Team WHERE Name = @TeamName
IF @TID is not null
BEGIN
INSERT TeamPerYearStats(TeamID,Wins,Losses,[Year],FGPercent,PtsPG,ThreePtPercent,TurnoversPG)
VALUES(@TID,@Wins,@Losses,@Year,@FGPercent,@PtsPG,@ThreePtPercent,@TurnoversPG);
END
END
GO



/**Players from Team **/ 
CREATE PROCEDURE [dbo].[GetPlayersFromTeam]
	-- Add the parameters for the stored procedure here
	@TeamID int,
	@Year int
AS
BEGIN
	SELECT Name FROM Player WHERE PlayerID in (SELECT PlayerID FROM PlayedFor WHERE TeamID = @TeamID AND Year = @Year)
END
GO

/**get plaer by name**/ 
CREATE PROCEDURE [dbo].[GetPlayersByName](@PlayerName varchar(50))
AS 
SELECT * FROM Player WHERE Name LIKE @PlayerName +'%'
GO

--ADD TEAMS

EXEC add_Team 'St.Louis Hawks', ' MO', ' St. Louis'
EXEC add_Team 'Fort Wayne Pistons', ' IN', ' FTW'
EXEC add_Team 'Atlanta Hawks', ' GA', ' ATL'
EXEC add_Team 'Boston Celtics', ' MA', ' BOS'
EXEC add_Team 'Brooklyn Nets', ' NY', ' BRK'
EXEC add_Team 'Chicago Bulls', ' IL', ' CHI'
EXEC add_Team 'Charlotte Hornets', ' NC', ' CHO'
EXEC add_Team 'Cleveland Cavaliers', ' OH', ' CLE'
EXEC add_Team 'Dallas Mavericks', ' TX', ' DAL'
EXEC add_Team 'Denver Nuggets', ' CO', ' DEN'
EXEC add_Team 'Detroit Pistons', ' MI', ' DET'
EXEC add_Team 'Golden State Warriors', ' CA', ' GSW'
EXEC add_Team 'Houston Rockets', ' TX', ' HOU'
EXEC add_Team 'Indiana Pacers', ' IN', ' IND'
EXEC add_Team 'Los Angeles Clippers', ' CA', ' LAC'
EXEC add_Team 'Los Angeles Lakers', ' CA', ' LAL'
EXEC add_Team 'Memphis Grizzlies', ' TN', ' MEM'
EXEC add_Team 'Miami Heat', ' FL', ' MIA'
EXEC add_Team 'Milwaukee Bucks', ' WI', ' MIL'
EXEC add_Team 'Minnesota Timberwolv', ' MN', ' MIN'
EXEC add_Team 'New Orleans Pelicans', ' LA', ' NOP'
EXEC add_Team 'New York Knicks', ' NY', ' NYK'
EXEC add_Team 'Oklahoma City Thunde', ' OK', ' OKC'
EXEC add_Team 'Orlando Magic', ' FL', ' ORL'
EXEC add_Team 'Philadelphia 76ers', ' PA', ' PHI'
EXEC add_Team 'Phoenix Suns', ' AZ', ' PHO'
EXEC add_Team 'Portland Trail Blaze', ' OR', ' POR'
EXEC add_Team 'Sacramento Kings', ' CA', ' SAC'
EXEC add_Team 'San Antonio Spurs', ' TX', ' SAS'
EXEC add_Team 'Toronto Raptors', ' ON', ' TOR'
EXEC add_Team 'Utah Jazz', ' UT', ' UTA'
EXEC add_Team 'Washington Wizards', ' WA', ' WAS'
EXEC add_Team 'New Orleans Hornets', ' LA', ' NOH'
EXEC add_Team 'New Jersey Nets', ' NJ', ' NJN'
EXEC add_Team 'Seattle SuperSonics', ' WA', ' SEA'
EXEC add_Team 'Vancouver Grizzlies', ' LA', ' VAN'
EXEC add_Team 'Washington Bullets', ' WA', ' WSB'
EXEC add_Team 'Kansas City Kings', ' KS', ' KCK'
EXEC add_Team 'San Diego Clippers', ' CA', ' SDC'
EXEC add_Team 'New Orleans Jazz', ' LA', ' NOJ'
EXEC add_Team 'Buffalo Braves', ' NY', ' BUF'
EXEC add_Team 'New York Nets', ' NY', ' NYN'
EXEC add_Team 'Kentucky Colonels', ' KY', ' KEN'
EXEC add_Team 'San Diego Sails', ' CA', ' SDS'
EXEC add_Team 'Spirits of St. Louis', ' MO', ' SSL'
EXEC add_Team 'Utah Stars', ' UT', ' UTS'
EXEC add_Team 'Virginia Squires', ' VA', ' VIR'
EXEC add_Team 'Kansas City-Omaha Ki', ' KS', ' KCO'
EXEC add_Team 'Memphis Sounds', ' TN', ' MMS'
EXEC add_Team 'San Diego Conquistad', ' CA', ' SDA'
EXEC add_Team 'Capital Bullets', ' DC', ' CAP'
EXEC add_Team 'Carolina Cougars', ' NC', ' CAR'
EXEC add_Team 'Denver Rockets', ' CO', ' DNR'
EXEC add_Team 'Memphis Tams', ' TN', ' MMT'
EXEC add_Team 'Baltimore Bullets', ' MD', ' BAL'
EXEC add_Team 'Dallas Chaparrals', ' TX', ' DLC'
EXEC add_Team 'Cincinnati Royals', ' OH', ' CIN'
EXEC add_Team 'The Floridians', ' FL', ' FLO'
EXEC add_Team 'Memphis Pros', ' TN', ' MMP'
EXEC add_Team 'Pittsburgh Condors', ' PA', ' PTC'
EXEC add_Team 'San Diego Rockets', ' CA', ' SDR'
EXEC add_Team 'San Francisco Warrio', ' CA', ' SFW'
EXEC add_Team 'Texas Chaparrals', ' TX', ' TEX'
EXEC add_Team 'Los Angeles Stars', ' LA', ' LAS'
EXEC add_Team 'Miami Floridians', ' FL', ' MMF'
EXEC add_Team 'New Orleans Buccanee', ' LA', ' NOB'
EXEC add_Team 'Pittsburgh Pipers', ' LA', ' PTP'
EXEC add_Team 'Washington Capitols', ' WA', ' WSA'
EXEC add_Team 'Houston Mavericks', ' TX', ' HSM'
EXEC add_Team 'Minnesota Pipers', ' MN', ' MNP'
EXEC add_Team 'Oakland Oaks', ' CA', ' OAK'
EXEC add_Team 'Anaheim Amigos', ' CA', ' ANA'
EXEC add_Team 'Minnesota Muskies', ' MN', ' MNM'
EXEC add_Team 'New Jersey Americans', ' NJ', ' NJA'
EXEC add_Team 'St. Louis Hawks', ' LA', ' STL'
EXEC add_Team 'Chicago Zephyrs', ' IL', ' CHZ'
EXEC add_Team 'Syracuse Nationals', ' OR', ' SYR'
EXEC add_Team 'Chicago Packers', ' IL', ' CHP'
EXEC add_Team 'Philadelphia Warriors', ' LA', ' PHW'
EXEC add_Team 'Minneapolis Lakers', ' MN', ' MNL'
EXEC add_Team 'Fort Wayne Pistons', ' IN', ' FTW'
EXEC add_Team 'Rochester Royals', ' NY', ' ROC'
EXEC add_Team 'Milwaukee Hawks', ' WI', ' MLH'
EXEC add_Team 'Indianapolis Olympia', ' IN', ' INO'
EXEC add_Team 'Tri-Cities Blackhawk', ' GA', ' TRI'
EXEC add_Team 'Anderson Packers', ' IN', ' AND'
EXEC add_Team 'Chicago Stags', ' IL', ' CHS'
EXEC add_Team 'St. Louis Bombers', ' MI', ' STB'
EXEC add_Team 'Waterloo Hawks', ' IA', ' WAT'
EXEC add_Team 'Indianapolis Jets', ' IN', ' INJ'
EXEC add_Team 'Providence Steamroll', ' RI', ' PRO'
EXEC add_Team 'Cleveland Rebels', ' OH', ' CLR'
EXEC add_Team 'Detroit Falcons', ' MI', ' DTF'
EXEC add_Team 'Pittsburgh Ironmen', ' PA', ' PIT'
EXEC add_Team 'Toronto Huskies', ' CD', ' TRH'


--ADD PLAYERS

EXEC add_Player 'Tom Boerwinkle', 60, 213, 'PG', 0, 1945
EXEC add_Player 'Jay Carty', 64, 203, 'PG', 0, 1941
EXEC add_Player 'Don Chaney', 62, 196, 'PG', 0, 1946
EXEC add_Player 'Dick Cunningham', 70, 208, 'PG', 0, 1946
EXEC add_Player 'Fred Foster', 62, 196, 'PG', 0, 1946
EXEC add_Player 'Pat Frink', 85, 193, 'PG', 0, 1945
EXEC add_Player 'Gary Gregor', 66, 201, 'PG', 0, 1945
EXEC add_Player 'Al Hairston', 77, 185, 'PG', 0, 1945
EXEC add_Player 'Shaler Halimon', 80, 196, 'PG', 0, 1945
EXEC add_Player 'Skip Harlicka', 83, 185, 'PG', 0, 1946
EXEC add_Player 'Art Harris', 83, 193, 'PG', 0, 1947
EXEC add_Player 'Elvin Hayes', 68, 206, 'PG', 0, 1945
EXEC add_Player 'Bill Hewitt', 62, 201, 'PG', 0, 1944
EXEC add_Player 'Bill Hosket', 66, 203, 'PG', 0, 1946
EXEC add_Player 'Rich Johnson', 62, 201, 'PG', 0, 1946
EXEC add_Player 'Bob Kauffman', 69, 203, 'PG', 0, 1946
EXEC add_Player 'Joe Kennedy', 62, 198, 'PG', 0, 1947
EXEC add_Player 'Rod Knowles', 63, 206, 'PG', 0, 1946
EXEC add_Player 'Stu Lantz', 79, 190, 'PG', 0, 1946
EXEC add_Player 'Don May', 80, 193, 'SG', 0, 1946
EXEC add_Player 'Otto Moore', 82, 211, 'SG', 0, 1946
EXEC add_Player 'Dave Newmark', 69, 213, 'SG', 0, 1946
EXEC add_Player 'Rich Niemann', 70, 213, 'SG', 0, 1946
EXEC add_Player 'Barry Orms', 83, 190, 'SG', 0, 1946
EXEC add_Player 'Charlie Paulk', 64, 203, 'SG', 0, 1946
EXEC add_Player 'Loy Petersen', 82, 196, 'SG', 0, 1945
EXEC add_Player 'Bob Quick', 63, 196, 'SG', 0, 1946
EXEC add_Player 'Craig Raymond', 68, 211, 'SG', 0, 1945
EXEC add_Player 'Mike Riordan', 80, 193, 'SG', 0, 1945
EXEC add_Player 'Dale Schlueter', 66, 208, 'SG', 0, 1945
EXEC add_Player 'Doug Sims', 85, 201, 'SG', 0, 1943
EXEC add_Player 'Greg Smith', 85, 196, 'SG', 0, 1947
EXEC add_Player 'John Trapp', 62, 201, 'SG', 0, 1945
EXEC add_Player 'Wes Unseld', 70, 201, 'SG', 0, 1946
EXEC add_Player 'Dwight Waller', 64, 198, 'SG', 0, 1945
EXEC add_Player 'Cliff Williams', 81, 190, 'SG', 0, 1945
EXEC add_Player 'Ron Williams', 85, 190, 'SG', 0, 1944
EXEC add_Player 'Sam Williams', 81, 190, 'SG', 0, 1945
EXEC add_Player 'Kareem Abdul-Jabbar', 66, 218, 'SG', 0, 1947
EXEC add_Player 'Lucius Allen', 79, 188, 'SF', 0, 1947
EXEC add_Player 'Wally Anderzunas', 64, 201, 'SF', 0, 1946
EXEC add_Player 'John Arthurs', 83, 193, 'SF', 0, 1947
EXEC add_Player 'Johnny Baum', 80, 196, 'SF', 0, 1946
EXEC add_Player 'Butch Beard', 83, 190, 'SF', 0, 1947
EXEC add_Player 'Fred Carter', 83, 190, 'SF', 0, 1945
EXEC add_Player 'Bob Dandridge', 85, 198, 'SF', 0, 1947
EXEC add_Player 'Mike Davis', 83, 190, 'SF', 0, 1946
EXEC add_Player 'Dick Garrett', 83, 190, 'SF', 0, 1947
EXEC add_Player 'Herm Gilliam', 83, 190, 'SF', 0, 1946
EXEC add_Player 'Bob Greacen', 83, 201, 'SF', 0, 1947
EXEC add_Player 'Lamar Green', 62, 201, 'SF', 0, 1947
EXEC add_Player 'Connie Hawkins', 62, 203, 'SF', 0, 1942
EXEC add_Player 'Brian Heaney', 81, 188, 'SF', 0, 1946
EXEC add_Player 'Steve Kuberski', 63, 203, 'SF', 0, 1947
EXEC add_Player 'Mike Lynn', 63, 201, 'SF', 0, 1945
EXEC add_Player 'Willie McCarter', 79, 190, 'SF', 0, 1946
EXEC add_Player 'Steve Mix', 63, 201, 'SF', 0, 1947
EXEC add_Player 'Grady O"Malley', 82, 196, 'SF', 0, 1948
EXEC add_Player 'Bud Ogden', 63, 198, 'SF', 0, 1946
EXEC add_Player 'Bob Portman', 80, 196, 'PF', 0, 1947
EXEC add_Player 'Luther Rackley', 64, 208, 'PF', 0, 1946
EXEC add_Player 'George Reynolds', 85, 193, 'PF', 0, 1947
EXEC add_Player 'Rick Roberson', 67, 206, 'PF', 0, 1947
EXEC add_Player 'Dave Scholz', 64, 203, 'PF', 0, 1948
EXEC add_Player 'Bingo Smith', 83, 196, 'PF', 0, 1939
EXEC add_Player 'Norm Van', 83, 196, 'PF', 0, 1939
EXEC add_Player 'Neal Walk', 64, 208, 'PF', 0, 1948
EXEC add_Player 'John Warren', 81, 190, 'PF', 0, 1947
EXEC add_Player 'Jo Jo', 81, 190, 'PF', 0, 1947
EXEC add_Player 'Bernie Williams', 79, 190, 'PF', 0, 1945
EXEC add_Player 'Lee Winfield', 78, 188, 'PF', 0, 1947
EXEC add_Player 'Don Adams', 62, 198, 'PF', 0, 1947
EXEC add_Player 'Tiny Archibald', 68, 185, 'PF', 0, 1948
EXEC add_Player 'Bob Arnzen', 82, 196, 'PF', 0, 1947
EXEC add_Player 'Dennis Awtrey', 68, 208, 'PF', 0, 1948
EXEC add_Player 'Moe Barr', 85, 193, 'PF', 0, 1944
EXEC add_Player 'Tom Black', 64, 208, 'PF', 0, 1941
EXEC add_Player 'Bob Christian', 72, 208, 'PF', 0, 1946
EXEC add_Player 'Jimmy Collins', 79, 188, 'PF', 0, 1946
EXEC add_Player 'Joe Cooke', 79, 190, 'C', 0, 1948
EXEC add_Player 'Dave Cowens', 67, 206, 'C', 0, 1948
EXEC add_Player 'Pete Cross', 67, 206, 'C', 0, 1948
EXEC add_Player 'Terry Driscoll', 63, 201, 'C', 0, 1947
EXEC add_Player 'Claude English', 83, 193, 'C', 0, 1946
EXEC add_Player 'Greg Fillmore', 69, 216, 'C', 0, 1947
EXEC add_Player 'Levi Fontaine', 83, 193, 'C', 0, 1948
EXEC add_Player 'Jake Ford', 81, 190, 'C', 0, 1946
EXEC add_Player 'Gary Freeman', 62, 206, 'C', 0, 1948
EXEC add_Player 'Walt Gilmore', 66, 198, 'C', 0, 1947
EXEC add_Player 'Spencer Haywood', 66, 203, 'C', 0, 1949
EXEC add_Player 'Gar Heard', 64, 198, 'C', 0, 1948
EXEC add_Player 'Al Henry', 83, 206, 'C', 0, 1949
EXEC add_Player 'A.W. Holt', 83, 206, 'C', 0, 1949
EXEC add_Player 'Greg Howard', 63, 206, 'C', 0, 1948
EXEC add_Player 'John Hummer', 67, 206, 'C', 0, 1948
EXEC add_Player 'Greg Hyder', 63, 198, 'C', 0, 1948
EXEC add_Player 'George Johnson', 70, 211, 'C', 0, 1947
EXEC add_Player 'John Johnson', 80, 201, 'C', 0, 1947
EXEC add_Player 'Earnie Killum', 81, 190, 'C', 0, 1948
EXEC add_Player 'Ron Knight', 63, 201, 'PG', 0, 1947
EXEC add_Player 'Sam Lacey', 68, 208, 'PG', 0, 1948
EXEC add_Player 'Bob Lanier', 71, 211, 'PG', 0, 1948
EXEC add_Player 'Pete Maravich', 86, 196, 'PG', 0, 1947
EXEC add_Player 'Harvey Marlatt', 83, 190, 'PG', 0, 1948
EXEC add_Player 'Eddie Mast', 64, 206, 'PG', 0, 1948
EXEC add_Player 'Jim McMillian', 63, 196, 'PG', 0, 1948
EXEC add_Player 'Larry Mikan', 62, 201, 'PG', 0, 1948
EXEC add_Player 'Rex Morgan', 83, 196, 'PG', 0, 1948
EXEC add_Player 'Calvin Murphy', 74, 175, 'PG', 0, 1948
EXEC add_Player 'Ralph Ogden', 82, 196, 'PG', 0, 1948
EXEC add_Player 'Curtis Perry', 64, 201, 'PG', 0, 1948
EXEC add_Player 'Geoff Petrie', 83, 193, 'PG', 0, 1948
EXEC add_Player 'Mike Price', 80, 190, 'PG', 0, 1948
EXEC add_Player 'Bob Riley', 68, 206, 'PG', 0, 1948
EXEC add_Player 'Paul Ruffner', 66, 208, 'PG', 0, 1948
EXEC add_Player 'Mike Silliman', 66, 198, 'PG', 0, 1944
EXEC add_Player 'Garfield Smith', 68, 206, 'PG', 0, 1945
EXEC add_Player 'Dave Sorenson', 66, 203, 'PG', 0, 1948
EXEC add_Player 'Dennis Stewart', 64, 198, 'PG', 0, 1947
EXEC add_Player 'Bill Stricker', 62, 206, 'SG', 0, 1948
EXEC add_Player 'Gary Suiter', 66, 206, 'SG', 0, 1945
EXEC add_Player 'Fred Taylor', 81, 196, 'SG', 0, 1948
EXEC add_Player 'Joe Thomas', 82, 198, 'SG', 0, 1948
EXEC add_Player 'Rudy Tomjanovich', 64, 203, 'SG', 0, 1948
EXEC add_Player 'John Vallely', 83, 190, 'SG', 0, 1948
EXEC add_Player 'Cornell Warner', 64, 206, 'SG', 0, 1948
EXEC add_Player 'Bobby Washington', 79, 180, 'SG', 0, 1947
EXEC add_Player 'Jeff Webb', 77, 193, 'SG', 0, 1948
EXEC add_Player 'Herb White', 85, 188, 'SG', 0, 1948
EXEC add_Player 'Milt Williams', 82, 188, 'SG', 0, 1945
EXEC add_Player 'Willie Williams', 80, 201, 'SG', 0, 1946
EXEC add_Player 'Marv Winkler', 74, 185, 'SG', 0, 1948
EXEC add_Player 'Gary Zeller', 82, 190, 'SG', 0, 1947
EXEC add_Player 'Bill Zopf', 77, 185, 'SG', 0, 1948
EXEC add_Player 'Odis Allison', 85, 198, 'SG', 0, 1949
EXEC add_Player 'Vic Bartolome', 67, 213, 'SG', 0, 1948
EXEC add_Player 'Fred Brown', 82, 190, 'SG', 0, 1948
EXEC add_Player 'Austin Carr', 80, 193, 'SG', 0, 1948
EXEC add_Player 'Sid Catlett', 67, 198, 'SG', 0, 1948
EXEC add_Player 'Phil Chenier', 81, 190, 'SF', 0, 1950
EXEC add_Player 'Jim Cleamons', 83, 190, 'SF', 0, 1949
EXEC add_Player 'Charlie Davis', 72, 188, 'SF', 0, 1949
EXEC add_Player 'Jackie Dinkins', 62, 196, 'SF', 0, 1950
EXEC add_Player 'Ken Durrett', 83, 201, 'SF', 0, 1948
EXEC add_Player 'Dick Gibbs', 62, 196, 'SF', 0, 1948
EXEC add_Player 'Clarence Glover', 62, 203, 'SF', 0, 1947
EXEC add_Player 'Jeff Halliburton', 84, 196, 'SF', 0, 1949
EXEC add_Player 'Fred Hilton', 83, 190, 'SF', 0, 1948
EXEC add_Player 'Jake Jones', 81, 190, 'SF', 0, 1949
EXEC add_Player 'Mo Layton', 81, 185, 'SF', 0, 1948
EXEC add_Player 'Stan Love', 63, 206, 'SF', 0, 1949
EXEC add_Player 'Charlie Lowery', 83, 190, 'SF', 0, 1949
EXEC add_Player 'Jim Marsh', 63, 201, 'SF', 0, 1946
EXEC add_Player 'Jim McDaniels', 66, 211, 'SF', 0, 1948
EXEC add_Player 'Gil McGregor', 69, 203, 'SF', 0, 1949
EXEC add_Player 'Kenny McIntosh', 66, 201, 'SF', 0, 1949
EXEC add_Player 'Cliff Meely', 63, 203, 'SF', 0, 1947
EXEC add_Player 'Dean Meminger', 79, 183, 'SF', 0, 1948
EXEC add_Player 'John Mengelt', 85, 188, 'SF', 0, 1949
EXEC add_Player 'Barry Nelson', 67, 208, 'PF', 0, 1949
EXEC add_Player 'Mike Newlin', 80, 193, 'PF', 0, 1949
EXEC add_Player 'Willie Norwood', 64, 201, 'PF', 0, 1947
EXEC add_Player 'Steve Patterson', 66, 206, 'PF', 0, 1948
EXEC add_Player 'Tom Payne', 69, 218, 'PF', 0, 1950
EXEC add_Player 'Howard Porter', 64, 203, 'PF', 0, 1948
EXEC add_Player 'Clifford Ray', 67, 206, 'PF', 0, 1949
EXEC add_Player 'Jackie Ridgle', 85, 193, 'PF', 0, 1948
EXEC add_Player 'Rich Rinaldi', 85, 190, 'PF', 0, 1949
EXEC add_Player 'Curtis Rowe', 66, 201, 'PF', 0, 1949
EXEC add_Player 'Charlie Scott', 79, 196, 'PF', 0, 1948
EXEC add_Player 'Elmore Smith', 71, 213, 'PF', 0, 1949
EXEC add_Player 'Randy Smith', 81, 190, 'PF', 0, 1948
EXEC add_Player 'William Smith', 64, 213, 'PF', 0, 1949
EXEC add_Player 'Larry Steele', 81, 196, 'PF', 0, 1949
EXEC add_Player 'George Trapp', 82, 203, 'PF', 0, 1948
EXEC add_Player 'Sidney Wicks', 66, 203, 'PF', 0, 1949
EXEC add_Player 'Nate Williams', 63, 196, 'PF', 0, 1950
EXEC add_Player 'Isaiah Wilson', 79, 188, 'PF', 0, 1948
EXEC add_Player 'Dave Wohl', 83, 188, 'PF', 0, 1949
EXEC add_Player 'Barry Yates', 63, 201, 'C', 0, 1946
EXEC add_Player 'Charlie Yelverton', 83, 188, 'C', 0, 1948
EXEC add_Player 'Henry Bibby', 83, 185, 'C', 0, 1949
EXEC add_Player 'Freddie Boyd', 81, 188, 'C', 0, 1950
EXEC add_Player 'Steve Bracey', 79, 185, 'C', 0, 1950
EXEC add_Player 'John Brisker', 62, 196, 'C', 0, 1947
EXEC add_Player 'Roger Brown', 82, 196, 'C', 0, 1942
EXEC add_Player 'Corky Calhoun', 62, 201, 'C', 0, 1950
EXEC add_Player 'Bob Davis', 63, 201, 'C', 0, 1950
EXEC add_Player 'Dwight Davis', 64, 203, 'C', 0, 1949
EXEC add_Player 'Mickey Davis', 83, 190, 'C', 0, 1946
EXEC add_Player 'Charles Dudley', 81, 188, 'C', 0, 1950
EXEC add_Player 'Scott English', 82, 198, 'C', 0, 1950
EXEC add_Player 'Chris Ford', 83, 196, 'C', 0, 1949
EXEC add_Player 'Harold Fox', 79, 188, 'C', 0, 1949
EXEC add_Player 'Rowland Garrett', 62, 198, 'C', 0, 1950
EXEC add_Player 'John Gianelli', 64, 208, 'C', 0, 1950
EXEC add_Player 'Travis Grant', 63, 201, 'C', 0, 1950
EXEC add_Player 'Luther Green', 83, 201, 'C', 0, 1946
EXEC add_Player 'Charles Johnson', 77, 183, 'C', 0, 1949
EXEC add_Player 'Ollie Johnson', 80, 198, 'PG', 0, 1949
EXEC add_Player 'Manny Leaks', 66, 203, 'PG', 0, 1945
EXEC add_Player 'Russ Lee', 83, 196, 'PG', 0, 1950
EXEC add_Player 'LaRue Martin', 62, 211, 'PG', 0, 1950
EXEC add_Player 'Bob McAdoo', 62, 206, 'PG', 0, 1951
EXEC add_Player 'Paul McCracken', 81, 193, 'PG', 0, 1950
EXEC add_Player 'Eric McWilliams', 80, 203, 'PG', 0, 1950
EXEC add_Player 'Mark Minor', 63, 198, 'PG', 0, 1950
EXEC add_Player 'Bob Nash', 85, 203, 'PG', 0, 1950
EXEC add_Player 'Lloyd Neal', 66, 201, 'PG', 0, 1950
EXEC add_Player 'Tom Patterson', 64, 198, 'PG', 0, 1948
EXEC add_Player 'Kevin Porter', 77, 183, 'PG', 0, 1950
EXEC add_Player 'Jim Price', 85, 190, 'PG', 0, 1949
EXEC add_Player 'Mike Ratliff', 67, 208, 'PG', 0, 1951
EXEC add_Player 'Tom Riker', 66, 208, 'PG', 0, 1950
EXEC add_Player 'Ron Riley', 85, 203, 'PG', 0, 1950
EXEC add_Player 'Frank Russell', 81, 190, 'PG', 0, 1949
EXEC add_Player 'Frank Schade', 77, 185, 'PG', 0, 1950
EXEC add_Player 'Sam Sibert', 63, 201, 'PG', 0, 1949
EXEC add_Player 'Bud Stallworth', 83, 196, 'PG', 0, 1950
EXEC add_Player 'Paul Stovall', 63, 193, 'SG', 0, 1948
EXEC add_Player 'Chuck Terry', 63, 198, 'SG', 0, 1950
EXEC add_Player 'Justus Thigpen', 72, 185, 'SG', 0, 1947
EXEC add_Player 'John Tschogl', 83, 198, 'SG', 0, 1950
EXEC add_Player 'Paul Westphal', 85, 193, 'SG', 0, 1950
EXEC add_Player 'Harthorne Wingo', 62, 198, 'SG', 0, 1947
EXEC add_Player 'Joby Wright', 64, 203, 'SG', 0, 1950
EXEC add_Player 'Mike Bantom', 80, 206, 'SG', 0, 1951
EXEC add_Player 'Ron Behagen', 83, 206, 'SG', 0, 1951
EXEC add_Player 'Dennis Bell', 83, 196, 'SG', 0, 1951
EXEC add_Player 'Jim Brewer', 62, 206, 'SG', 0, 1951
EXEC add_Player 'Allan Bristow', 62, 201, 'SG', 0, 1951
EXEC add_Player 'John Brown', 64, 201, 'SG', 0, 1951
EXEC add_Player 'Larry Cannon', 85, 193, 'SG', 0, 1947
EXEC add_Player 'Bill Chamberlain', 85, 198, 'SG', 0, 1949
EXEC add_Player 'Ken Charles', 81, 190, 'SG', 0, 1951
EXEC add_Player 'E.C. Coleman', 81, 190, 'SG', 0, 1951
EXEC add_Player 'Doug Collins', 81, 198, 'SG', 0, 1951
EXEC add_Player 'Mike D"Antoni', 83, 190, 'SG', 0, 1951
EXEC add_Player 'Mel Davis', 64, 198, 'SG', 0, 1950
EXEC add_Player 'Derrek Dickey', 64, 201, 'SF', 0, 1951
EXEC add_Player 'Ernie DiGregorio', 81, 183, 'SF', 0, 1951
EXEC add_Player 'Steve Downing', 66, 203, 'SF', 0, 1950
EXEC add_Player 'Rod Freeman', 66, 201, 'SF', 0, 1950
EXEC add_Player 'Bernie Fryer', 83, 190, 'SF', 0, 1949
EXEC add_Player 'Jim Garvin', 80, 201, 'SF', 0, 1950
EXEC add_Player 'Phil Hankinson', 85, 203, 'SF', 0, 1951
EXEC add_Player 'Nate Hawthorne', 83, 193, 'SF', 0, 1950
EXEC add_Player 'Tom Ingelsby', 81, 190, 'SF', 0, 1951
EXEC add_Player 'Dwight Jones', 62, 208, 'SF', 0, 1952
EXEC add_Player 'Ben Kelso', 85, 190, 'SF', 0, 1949
EXEC add_Player 'Tom Kozelko', 64, 203, 'SF', 0, 1951
EXEC add_Player 'Kevin Kunnert', 67, 213, 'SF', 0, 1951
EXEC add_Player 'Mike Macaluso', 62, 196, 'SF', 0, 1951
EXEC add_Player 'Ted Manakas', 81, 188, 'SF', 0, 1951
EXEC add_Player 'Vester Marshall', 80, 201, 'SF', 0, 1948
EXEC add_Player 'Allie McGuire', 81, 188, 'SF', 0, 1928
EXEC add_Player 'Larry McNeill', 85, 206, 'SF', 0, 1951
EXEC add_Player 'Gary Melchionni', 83, 188, 'SF', 0, 1951
EXEC add_Player 'Louie Nelson', 83, 190, 'SF', 0, 1951
EXEC add_Player 'Jim Owens', 80, 196, 'PF', 0, 1950
EXEC add_Player 'Ed Ratleff', 85, 198, 'PF', 0, 1950
EXEC add_Player 'Joe Reaves', 62, 196, 'PF', 0, 1950
EXEC add_Player 'Mark Sibley', 79, 188, 'PF', 0, 1950
EXEC add_Player 'Bob Verga', 83, 185, 'PF', 0, 1945
EXEC add_Player 'Kermit Washington', 67, 203, 'PF', 0, 1951
EXEC add_Player 'Slick Watts', 79, 185, 'PF', 0, 1951
EXEC add_Player 'Nick Weatherspoon', 85, 201, 'PF', 0, 1950
EXEC add_Player 'Luke Witte', 68, 213, 'PF', 0, 1950
EXEC add_Player 'Dan Anderson', 67, 208, 'PF', 0, 1943
EXEC add_Player 'Jim Ard', 63, 203, 'PF', 0, 1948
EXEC add_Player 'Gus Bailey', 83, 196, 'PF', 0, 1951
EXEC add_Player 'Leon Benbow', 83, 193, 'PF', 0, 1950
EXEC add_Player 'Ken Boyd', 85, 196, 'PF', 0, 1952
EXEC add_Player 'Gary Brokaw', 80, 193, 'PF', 0, 1954
EXEC add_Player 'Tom Burleson', 66, 218, 'PF', 0, 1952
EXEC add_Player 'Harvey Catchings', 64, 206, 'PF', 0, 1951
EXEC add_Player 'Jim Chones', 64, 211, 'PF', 0, 1949
EXEC add_Player 'Ben Clyde', 86, 201, 'PF', 0, 1951
EXEC add_Player 'Jesse Dark', 62, 196, 'PF', 0, 1951
EXEC add_Player 'Rod Derline', 79, 183, 'C', 0, 1952
EXEC add_Player 'John Drew', 82, 198, 'C', 0, 1954
EXEC add_Player 'Dennis DuVal', 79, 190, 'C', 0, 1952
EXEC add_Player 'Al Eberhard', 66, 198, 'C', 0, 1952
EXEC add_Player 'Leonard Gray', 69, 203, 'C', 0, 1951
EXEC add_Player 'Bernie Harris', 80, 208, 'C', 0, 1950
EXEC add_Player 'Steve Hawes', 64, 206, 'C', 0, 1950
EXEC add_Player 'Tom Henderson', 83, 190, 'C', 0, 1952
EXEC add_Player 'Greg Jackson', 81, 183, 'C', 0, 1952
EXEC add_Player 'Wardell Jackson', 80, 201, 'C', 0, 1951
EXEC add_Player 'Aaron James', 62, 203, 'C', 0, 1952
EXEC add_Player 'Mickey Johnson', 83, 208, 'C', 0, 1952
EXEC add_Player 'Jimmy Jones', 85, 193, 'C', 0, 1945
EXEC add_Player 'Frank Kendrick', 86, 198, 'C', 0, 1950
EXEC add_Player 'Len Kosmalski', 70, 213, 'C', 0, 1951
EXEC add_Player 'Bill Ligon', 81, 193, 'C', 0, 1952
EXEC add_Player 'Phil Lumpkin', 74, 183, 'C', 0, 1951
EXEC add_Player 'Glenn McDonald', 83, 198, 'C', 0, 1952
EXEC add_Player 'Eric Money', 77, 183, 'C', 0, 1955
EXEC add_Player 'Connie Norman', 79, 190, 'C', 0, 1953
EXEC add_Player 'Kevin Restani', 66, 206, 'PG', 0, 1951
EXEC add_Player 'Truck Robinson', 66, 201, 'PG', 0, 1951
EXEC add_Player 'Campy Russell', 64, 196, 'PG', 0, 1944
EXEC add_Player 'Fred Saunders', 62, 201, 'PG', 0, 1951
EXEC add_Player 'Tal Skinner', 85, 196, 'PG', 0, 1952
EXEC add_Player 'Don Smith', 83, 188, 'PG', 0, 1920
EXEC add_Player 'Phil Smith', 83, 193, 'PG', 0, 1952
EXEC add_Player 'Mike Sojourner', 66, 206, 'PG', 0, 1953
EXEC add_Player 'Kevin Stacom', 83, 190, 'PG', 0, 1951
EXEC add_Player 'George Thompson', 80, 188, 'PG', 0, 1947
EXEC add_Player 'Dean Tolson', 83, 203, 'PG', 0, 1951
EXEC add_Player 'Foots Walker', 83, 183, 'PG', 0, 1951
EXEC add_Player 'Bill Walton', 62, 211, 'PG', 0, 1952
EXEC add_Player 'Perry Warbington', 74, 188, 'PG', 0, 1952
EXEC add_Player 'Stan Washington', 83, 193, 'PG', 0, 1952
EXEC add_Player 'Scott Wedman', 63, 201, 'PG', 0, 1952
EXEC add_Player 'Owen Wells', 80, 201, 'PG', 0, 1950
EXEC add_Player 'Jamaal Wilkes', 83, 198, 'PG', 0, 1953
EXEC add_Player 'Earl Williams', 67, 201, 'PG', 0, 1951
EXEC add_Player 'Bobby Wilson', 83, 193, 'PG', 0, 1926
EXEC add_Player 'Brian Winters', 83, 193, 'SG', 0, 1952
EXEC add_Player 'Alvan Adams', 62, 206, 'SG', 0, 1954
EXEC add_Player 'Jerome Anderson', 85, 196, 'SG', 0, 1953
EXEC add_Player 'Jerry Baskerville', 83, 201, 'SG', 0, 1951
EXEC add_Player 'Bob Bigelow', 63, 201, 'SG', 0, 1953
EXEC add_Player 'Tom Boswell', 64, 206, 'SG', 0, 1953
EXEC add_Player 'Junior Bridgeman', 62, 196, 'SG', 0, 1953
EXEC add_Player 'Joe Bryant', 83, 206, 'SG', 0, 1954
EXEC add_Player 'Al Carlson', 68, 211, 'SG', 0, 1951
EXEC add_Player 'Jim Creighton', 80, 203, 'SG', 0, 1950
EXEC add_Player 'Darryl Dawkins', 71, 211, 'SG', 0, 1957
EXEC add_Player 'Henry Dickerson', 83, 193, 'SG', 0, 1951
EXEC add_Player 'Eric Fernsten', 82, 208, 'SG', 0, 1953
EXEC add_Player 'Larry Fogle', 82, 196, 'SG', 0, 1953
EXEC add_Player 'Don Ford', 63, 206, 'SG', 0, 1952
EXEC add_Player 'World B.', 63, 206, 'SG', 0, 1952
EXEC add_Player 'Donnie Freeman', 83, 190, 'SG', 0, 1944
EXEC add_Player 'Kevin Grevey', 62, 196, 'SG', 0, 1953
EXEC add_Player 'Bob Gross', 80, 198, 'SG', 0, 1953
EXEC add_Player 'Lindsay Hairston', 81, 201, 'SG', 0, 1951
EXEC add_Player 'Glenn Hansen', 82, 193, 'SF', 0, 1952
EXEC add_Player 'Robert Hawkins', 83, 193, 'SF', 0, 1954
EXEC add_Player 'Wilbur Holland', 79, 183, 'SF', 0, 1951
EXEC add_Player 'Lionel Hollins', 83, 190, 'SF', 0, 1953
EXEC add_Player 'Steve Jones', 82, 196, 'SF', 0, 1942
EXEC add_Player 'Rich Kelley', 68, 213, 'SF', 0, 1953
EXEC add_Player 'Tom Kropp', 82, 190, 'SF', 0, 1953
EXEC add_Player 'C.J. Kupec', 82, 190, 'SF', 0, 1953
EXEC add_Player 'John Lambert', 66, 208, 'SF', 0, 1953
EXEC add_Player 'John Laskowski', 83, 198, 'SF', 0, 1953
EXEC add_Player 'Greg Lee', 83, 190, 'SF', 0, 1951
EXEC add_Player 'Clyde Mayes', 66, 203, 'SF', 0, 1953
EXEC add_Player 'Ken Mayfield', 83, 188, 'SF', 0, 1948
EXEC add_Player 'Jim McElroy', 83, 190, 'SF', 0, 1953
EXEC add_Player 'George McGinnis', 68, 203, 'SF', 0, 1950
EXEC add_Player 'Tom McMillen', 63, 211, 'SF', 0, 1952
EXEC add_Player 'Joe Meriweather', 63, 208, 'SF', 0, 1953
EXEC add_Player 'Dave Meyers', 63, 203, 'SF', 0, 1953
EXEC add_Player 'Frank Oleynick', 83, 188, 'SF', 0, 1955
EXEC add_Player 'Cliff Pondexter', 67, 206, 'SF', 0, 1954
EXEC add_Player 'Bill Robinzine', 67, 201, 'PF', 0, 1953
EXEC add_Player 'John Roche', 77, 190, 'PF', 0, 1949
EXEC add_Player 'Bruce Seals', 62, 203, 'PF', 0, 1953
EXEC add_Player 'Ed Searcy', 62, 198, 'PF', 0, 1952
EXEC add_Player 'Gene Short', 80, 198, 'PF', 0, 1953
EXEC add_Player 'John Shumate', 68, 206, 'PF', 0, 1952
EXEC add_Player 'Ricky Sobers', 86, 190, 'PF', 0, 1953
EXEC add_Player 'Terry Thomas', 64, 203, 'PF', 0, 1953
EXEC add_Player 'Rudy White', 85, 188, 'PF', 0, 1953
EXEC add_Player 'Gus Williams', 79, 188, 'PF', 0, 1953
EXEC add_Player 'Bill Willoughby', 82, 203, 'PF', 0, 1957
EXEC add_Player 'Tom Abernethy', 64, 201, 'PF', 0, 1954
EXEC add_Player 'Bird Averitt', 77, 185, 'PF', 0, 1952
EXEC add_Player 'Tom Barker', 66, 211, 'PF', 0, 1955
EXEC add_Player 'Marvin Barnes', 62, 203, 'PF', 0, 1952
EXEC add_Player 'Norton Barnhill', 82, 193, 'PF', 0, 1953
EXEC add_Player 'Mike Barr', 81, 190, 'PF', 0, 1950
EXEC add_Player 'Tim Bassett', 66, 203, 'PF', 0, 1951
EXEC add_Player 'Byron Beck', 66, 206, 'PF', 0, 1945
EXEC add_Player 'Mel Bennett', 80, 201, 'PF', 0, 1955
EXEC add_Player 'Ron Boone', 80, 188, 'C', 0, 1946
EXEC add_Player 'Quinn Buckner', 83, 190, 'C', 0, 1954
EXEC add_Player 'Ticky Burden', 83, 188, 'C', 0, 1953
EXEC add_Player 'Don Buse', 83, 193, 'C', 0, 1950
EXEC add_Player 'Mack Calvin', 74, 183, 'C', 0, 1947
EXEC add_Player 'M.L. Carr', 74, 183, 'C', 0, 1947
EXEC add_Player 'Cornelius Cash', 63, 203, 'C', 0, 1952
EXEC add_Player 'Norm Cook', 62, 203, 'C', 0, 1955
EXEC add_Player 'Louie Dampier', 77, 183, 'C', 0, 1944
EXEC add_Player 'Mel Daniels', 64, 206, 'C', 0, 1944
EXEC add_Player 'Adrian Dantley', 62, 196, 'C', 0, 1956
EXEC add_Player 'Johnny Davis', 77, 188, 'C', 0, 1955
EXEC add_Player 'Ron Davis', 86, 198, 'C', 0, 1954
EXEC add_Player 'Randy Denton', 69, 208, 'C', 0, 1949
EXEC add_Player 'Coby Dietrick', 64, 208, 'C', 0, 1948
EXEC add_Player 'Leon Douglas', 67, 208, 'C', 0, 1954
EXEC add_Player 'Mike Dunleavy', 81, 190, 'C', 0, 1954
EXEC add_Player 'Jim Eakins', 63, 211, 'C', 0, 1946
EXEC add_Player 'Len Elmore', 64, 206, 'C', 0, 1952
EXEC add_Player 'Darrell Elston', 83, 193, 'C', 0, 1952
EXEC add_Player 'Alex English', 83, 201, 'PG', 0, 1954
EXEC add_Player 'Julius Erving', 62, 201, 'PG', 0, 1950
EXEC add_Player 'Butch Feher', 83, 193, 'PG', 0, 1954
EXEC add_Player 'Mike Flynn', 81, 188, 'PG', 0, 1953
EXEC add_Player 'Terry Furlow', 83, 193, 'PG', 0, 1954
EXEC add_Player 'Mike Gale', 83, 193, 'PG', 0, 1950
EXEC add_Player 'Gus Gerard', 80, 203, 'PG', 0, 1953
EXEC add_Player 'George Gervin', 81, 201, 'PG', 0, 1952
EXEC add_Player 'Artis Gilmore', 69, 218, 'PG', 0, 1949
EXEC add_Player 'Mike Green', 80, 208, 'PG', 0, 1951
EXEC add_Player 'Steve Green', 64, 201, 'PG', 0, 1953
EXEC add_Player 'Paul Griffin', 82, 206, 'PG', 0, 1954
EXEC add_Player 'Rudy Hackett', 62, 206, 'PG', 0, 1953
EXEC add_Player 'Phil Hicks', 82, 201, 'PG', 0, 1953
EXEC add_Player 'Armond Hill', 83, 193, 'PG', 0, 1953
EXEC add_Player 'Darnell Hillman', 63, 206, 'PG', 0, 1949
EXEC add_Player 'Mo Howard', 77, 188, 'PG', 0, 1954
EXEC add_Player 'Kim Hughes', 64, 211, 'PG', 0, 1952
EXEC add_Player 'Dan Issel', 68, 206, 'PG', 0, 1948
EXEC add_Player 'Dennis Johnson', 83, 193, 'PG', 0, 1954
EXEC add_Player 'Bobby Jones', 62, 206, 'SG', 0, 1951
EXEC add_Player 'Caldwell Jones', 64, 211, 'SG', 0, 1950
EXEC add_Player 'Rich Jones', 64, 198, 'SG', 0, 1946
EXEC add_Player 'Robin Jones', 66, 206, 'SG', 0, 1954
EXEC add_Player 'Wil Jones', 83, 190, 'SG', 0, 1936
EXEC add_Player 'George Karl', 83, 190, 'SG', 0, 1952
EXEC add_Player 'Goo Kennedy', 82, 196, 'SG', 0, 1949
EXEC add_Player 'Larry Kenon', 82, 206, 'SG', 0, 1952
EXEC add_Player 'Billy Knight', 85, 198, 'SG', 0, 1952
EXEC add_Player 'Mitch Kupchak', 67, 206, 'SG', 0, 1954
EXEC add_Player 'Bo Lamar', 81, 185, 'SG', 0, 1951
EXEC add_Player 'Ron Lee', 84, 193, 'SG', 0, 1952
EXEC add_Player 'Scott Lloyd', 67, 208, 'SG', 0, 1952
EXEC add_Player 'John Lucas', 79, 190, 'SG', 0, 1953
EXEC add_Player 'Maurice Lucas', 63, 206, 'SG', 0, 1952
EXEC add_Player 'Moses Malone', 63, 208, 'SG', 0, 1955
EXEC add_Player 'Scott May', 63, 201, 'SG', 0, 1954
EXEC add_Player 'Andre McCarter', 83, 190, 'SG', 0, 1953
EXEC add_Player 'Ted McClain', 81, 185, 'SG', 0, 1946
EXEC add_Player 'Allen Murphy', 83, 196, 'SG', 0, 1952
EXEC add_Player 'Swen Nater', 69, 211, 'SF', 0, 1950
EXEC add_Player 'Johnny Neumann', 80, 198, 'SF', 0, 1951
EXEC add_Player 'Mark Olberding', 66, 203, 'SF', 0, 1956
EXEC add_Player 'Tom Owens', 63, 208, 'SF', 0, 1949
EXEC add_Player 'Joe Pace', 64, 208, 'SF', 0, 1953
EXEC add_Player 'Robert Parish', 67, 213, 'SF', 0, 1953
EXEC add_Player 'Sonny Parker', 80, 198, 'SF', 0, 1955
EXEC add_Player 'Billy Paultz', 68, 211, 'SF', 0, 1948
EXEC add_Player 'Marv Roberts', 80, 203, 'SF', 0, 1950
EXEC add_Player 'Dave Robisch', 68, 208, 'SF', 0, 1949
EXEC add_Player 'Marshall Rogers', 83, 185, 'SF', 0, 1953
EXEC add_Player 'Dan Roundfield', 82, 203, 'SF', 0, 1953
EXEC add_Player 'Phil Sellers', 85, 193, 'SF', 0, 1953
EXEC add_Player 'Lonnie Shelton', 69, 203, 'SF', 0, 1955
EXEC add_Player 'James Silas', 81, 185, 'SF', 0, 1949
EXEC add_Player 'Ralph Simpson', 80, 196, 'SF', 0, 1949
EXEC add_Player 'Al Skinner', 83, 190, 'SF', 0, 1952
EXEC add_Player 'Willie Smith', 64, 213, 'SF', 0, 1949
EXEC add_Player 'Keith Starr', 83, 198, 'SF', 0, 1954
EXEC add_Player 'Earl Tatum', 83, 196, 'SF', 0, 1953
EXEC add_Player 'Brian Taylor', 83, 188, 'PF', 0, 1951
EXEC add_Player 'Fatty Taylor', 79, 183, 'PF', 0, 1946
EXEC add_Player 'Ira Terrell', 80, 203, 'PF', 0, 1954
EXEC add_Player 'Claude Terry', 85, 193, 'PF', 0, 1950
EXEC add_Player 'David Thompson', 85, 193, 'PF', 0, 1954
EXEC add_Player 'Monte Towe', 68, 170, 'PF', 0, 1953
EXEC add_Player 'Dave Twardzik', 79, 185, 'PF', 0, 1950
EXEC add_Player 'Jan Van', 79, 185, 'PF', 0, 1950
EXEC add_Player 'Andy Walker', 83, 193, 'PF', 0, 1955
EXEC add_Player 'Wally Walker', 83, 201, 'PF', 0, 1954
EXEC add_Player 'Lloyd Walton', 72, 183, 'PF', 0, 1953
EXEC add_Player 'Henry Ward', 85, 193, 'PF', 0, 1952
EXEC add_Player 'Richard Washington', 64, 211, 'PF', 0, 1955
EXEC add_Player 'Marvin Webster', 66, 216, 'PF', 0, 1952
EXEC add_Player 'Bob Wilkerson', 85, 198, 'PF', 0, 1954
EXEC add_Player 'Chuck Williams', 74, 183, 'PF', 0, 1943
EXEC add_Player 'Chuckie Williams', 74, 183, 'PF', 0, 1943
EXEC add_Player 'John Williamson', 83, 188, 'PF', 0, 1951
EXEC add_Player 'Willie Wise', 62, 196, 'PF', 0, 1947
EXEC add_Player 'Larry Wright', 72, 185, 'PF', 0, 1954
EXEC add_Player 'Tate Armstrong', 79, 190, 'C', 0, 1955
EXEC add_Player 'Greg Ballard', 63, 201, 'C', 0, 1955
EXEC add_Player 'Kent Benson', 68, 208, 'C', 0, 1954
EXEC add_Player 'Otis Birdsong', 83, 190, 'C', 0, 1955
EXEC add_Player 'Phil Bond', 79, 188, 'C', 0, 1954
EXEC add_Player 'Jim Bostic', 66, 201, 'C', 0, 1953
EXEC add_Player 'Alonzo Bradley', 83, 198, 'C', 0, 1953
EXEC add_Player 'Mike Bratz', 83, 188, 'C', 0, 1955
EXEC add_Player 'Wayman Britt', 83, 188, 'C', 0, 1952
EXEC add_Player 'Kenny Carr', 64, 201, 'C', 0, 1955
EXEC add_Player 'Bob Carrington', 85, 198, 'C', 0, 1953
EXEC add_Player 'Wesley Cox', 63, 198, 'C', 0, 1955
EXEC add_Player 'Charlie Criss', 74, 173, 'C', 0, 1948
EXEC add_Player 'Mark Crow', 62, 201, 'C', 0, 1954
EXEC add_Player 'Brad Davis', 81, 190, 'C', 0, 1955
EXEC add_Player 'Walter Davis', 82, 203, 'C', 0, 1931
EXEC add_Player 'Jacky Dorsey', 67, 201, 'C', 0, 1954
EXEC add_Player 'T.R. Dunn', 67, 201, 'C', 0, 1954
EXEC add_Player 'James Edwards', 66, 213, 'C', 0, 1955
EXEC add_Player 'Bo Ellis', 83, 196, 'C', 0, 1936
EXEC add_Player 'Al Fleming', 63, 201, 'PG', 0, 1954
EXEC add_Player 'Bayard Forrest', 68, 208, 'PG', 0, 1954
EXEC add_Player 'Mike Glenn', 79, 188, 'PG', 0, 1955
EXEC add_Player 'Glen Gondrezick', 64, 198, 'PG', 0, 1955
EXEC add_Player 'Rickey Green', 77, 183, 'PG', 0, 1954
EXEC add_Player 'Greg Griffin', 83, 201, 'PG', 0, 1952
EXEC add_Player 'Ernie Grunfeld', 62, 198, 'PG', 0, 1955
EXEC add_Player 'Joe Hassett', 81, 196, 'PG', 0, 1955
EXEC add_Player 'Eddie Johnson', 82, 203, 'PG', 0, 1944
EXEC add_Player 'Larry Johnson', 82, 190, 'PG', 0, 1954
EXEC add_Player 'Marques Johnson', 64, 201, 'PG', 0, 1956
EXEC add_Player 'Eddie Jordan', 77, 185, 'PG', 0, 1955
EXEC add_Player 'Bernard King', 82, 201, 'PG', 0, 1956
EXEC add_Player 'Toby Knight', 62, 206, 'PG', 0, 1955
EXEC add_Player 'John Kuester', 81, 188, 'PG', 0, 1955
EXEC add_Player 'Tom LaGarde', 64, 208, 'PG', 0, 1955
EXEC add_Player 'Mark Landsberger', 63, 203, 'PG', 0, 1955
EXEC add_Player 'Rich Laurel', 83, 198, 'PG', 0, 1954
EXEC add_Player 'Ricky Marsh', 80, 190, 'PG', 0, 1954
EXEC add_Player 'Cedric Maxwell', 82, 203, 'PG', 0, 1955
EXEC add_Player 'Larry Moffett', 62, 203, 'SG', 0, 1954
EXEC add_Player 'Glenn Mosley', 85, 203, 'SG', 0, 1955
EXEC add_Player 'Norm Nixon', 77, 188, 'SG', 0, 1955
EXEC add_Player 'Eddie Owens', 62, 201, 'SG', 0, 1953
EXEC add_Player 'Ben Poquette', 68, 206, 'SG', 0, 1955
EXEC add_Player 'Robert Reid', 82, 203, 'SG', 0, 1955
EXEC add_Player 'Anthony Roberts', 83, 196, 'SG', 0, 1955
EXEC add_Player 'Tony Robertson', 85, 193, 'SG', 0, 1956
EXEC add_Player 'Tree Rollins', 68, 216, 'SG', 0, 1955
EXEC add_Player 'Alvin Scott', 83, 201, 'SG', 0, 1955
EXEC add_Player 'Steve Sheppard', 63, 198, 'SG', 0, 1954
EXEC add_Player 'Jack Sikma', 67, 211, 'SG', 0, 1955
EXEC add_Player 'Scott Sims', 77, 185, 'SG', 0, 1955
EXEC add_Player 'Robert Smith', 74, 180, 'SG', 0, 1955
EXEC add_Player 'Phil Walker', 81, 190, 'SG', 0, 1956
EXEC add_Player 'Wilson Washington', 66, 206, 'SG', 0, 1955
EXEC add_Player 'Ray Williams', 85, 190, 'SG', 0, 1954
EXEC add_Player 'Kim Anderson', 80, 201, 'SG', 0, 1955
EXEC add_Player 'Del Beshore', 74, 180, 'SG', 0, 1956
EXEC add_Player 'Dennis Boyd', 79, 185, 'SG', 0, 1954
EXEC add_Player 'Winford Boynes', 83, 198, 'SF', 0, 1957
EXEC add_Player 'Ron Brewer', 81, 193, 'SF', 0, 1955
EXEC add_Player 'Greg Bunch', 83, 198, 'SF', 0, 1956
EXEC add_Player 'Marty Byrnes', 63, 201, 'SF', 0, 1956
EXEC add_Player 'Ron Carter', 83, 196, 'SF', 0, 1956
EXEC add_Player 'Maurice Cheeks', 81, 185, 'SF', 0, 1956
EXEC add_Player 'Michael Cooper', 77, 196, 'SF', 0, 1956
EXEC add_Player 'Wayne Cooper', 64, 208, 'SF', 0, 1956
EXEC add_Player 'Dave Corzine', 71, 211, 'SF', 0, 1956
EXEC add_Player 'Geoff Crompton', 63, 211, 'SF', 0, 1955
EXEC add_Player 'Harry Davis', 64, 201, 'SF', 0, 1956
EXEC add_Player 'Bob Elliott', 66, 206, 'SF', 0, 1955
EXEC add_Player 'Ray Epps', 85, 198, 'SF', 0, 1956
EXEC add_Player 'Phil Ford', 79, 188, 'SF', 0, 1956
EXEC add_Player 'Jack Givens', 82, 196, 'SF', 0, 1956
EXEC add_Player 'Tommie Green', 83, 188, 'SF', 0, 1956
EXEC add_Player 'Lars Hansen', 66, 208, 'SF', 0, 1954
EXEC add_Player 'James Hardy', 64, 203, 'SF', 0, 1956
EXEC add_Player 'Keith Herron', 85, 198, 'SF', 0, 1956
EXEC add_Player 'Kenny Higgs', 81, 183, 'SF', 0, 1955
EXEC add_Player 'Essie Hollis', 85, 198, 'PF', 0, 1955
EXEC add_Player 'Otis Howard', 64, 201, 'PF', 0, 1956
EXEC add_Player 'Clemon Johnson', 69, 208, 'PF', 0, 1956
EXEC add_Player 'Jeff Judkins', 83, 198, 'PF', 0, 1956
EXEC add_Player 'Joel Kramer', 82, 201, 'PF', 0, 1955
EXEC add_Player 'Butch Lee', 83, 183, 'PF', 0, 1956
EXEC add_Player 'John Long', 85, 196, 'PF', 0, 1956
EXEC add_Player 'Billy McKinney', 72, 183, 'PF', 0, 1955
EXEC add_Player 'Mike Mitchell', 63, 201, 'PF', 0, 1956
EXEC add_Player 'John Olive', 62, 201, 'PF', 0, 1955
EXEC add_Player 'Roger Phegley', 82, 198, 'PF', 0, 1956
EXEC add_Player 'Stan Pietkiewicz', 80, 196, 'PF', 0, 1956
EXEC add_Player 'Wayne Radford', 82, 190, 'PF', 0, 1956
EXEC add_Player 'Marlon Redmond', 85, 198, 'PF', 0, 1955
EXEC add_Player 'Micheal Ray', 85, 198, 'PF', 0, 1955
EXEC add_Player 'Rick Robey', 67, 211, 'PF', 0, 1956
EXEC add_Player 'Jackie Robinson', 62, 198, 'PF', 0, 1955
EXEC add_Player 'John Rudd', 67, 201, 'PF', 0, 1955
EXEC add_Player 'Frankie Sanders', 80, 198, 'PF', 0, 1957
EXEC add_Player 'Purvis Short', 62, 201, 'PF', 0, 1957
EXEC add_Player 'Sam Smith', 67, 201, 'C', 0, 1944
EXEC add_Player 'Reggie Theus', 83, 201, 'C', 0, 1957
EXEC add_Player 'Mychal Thompson', 66, 208, 'C', 0, 1955
EXEC add_Player 'Raymond Townsend', 79, 190, 'C', 0, 1955
EXEC add_Player 'Terry Tyler', 63, 201, 'C', 0, 1956
EXEC add_Player 'Andre Wakefield', 79, 190, 'C', 0, 1955
EXEC add_Player 'Jerome Whitehead', 64, 208, 'C', 0, 1956
EXEC add_Player 'Freeman Williams', 83, 193, 'C', 0, 1956
EXEC add_Player 'Rick Wilson', 80, 196, 'C', 0, 1956
EXEC add_Player 'James Bailey', 64, 206, 'C', 0, 1957
EXEC add_Player 'Billy Ray', 64, 206, 'C', 0, 1957
EXEC add_Player 'Larry Bird', 64, 206, 'C', 0, 1956
EXEC add_Player 'Lawrence Boston', 66, 203, 'C', 0, 1956
EXEC add_Player 'Dudley Bradley', 85, 198, 'C', 0, 1957
EXEC add_Player 'Bill Cartwright', 70, 216, 'C', 0, 1957
EXEC add_Player 'Jeff Cook', 63, 208, 'C', 0, 1956
EXEC add_Player 'Hollis Copeland', 81, 198, 'C', 0, 1955
EXEC add_Player 'John Coughran', 66, 201, 'C', 0, 1951
EXEC add_Player 'Terry Crosby', 85, 193, 'C', 0, 1957
EXEC add_Player 'Pat Cummings', 67, 206, 'C', 0, 1956
EXEC add_Player 'Paul Dawkins', 83, 196, 'PG', 0, 1957
EXEC add_Player 'Greg Deane', 83, 193, 'PG', 0, 1957
EXEC add_Player 'Larry Demic', 66, 206, 'PG', 0, 1957
EXEC add_Player 'Terry Duerod', 81, 188, 'PG', 0, 1956
EXEC add_Player 'Earl Evans', 81, 203, 'PG', 0, 1955
EXEC add_Player 'Mike Evans', 77, 185, 'PG', 0, 1955
EXEC add_Player 'Gary Garland', 81, 193, 'PG', 0, 1957
EXEC add_Player 'Dave Greenwood', 65, 206, 'PG', 0, 1957
EXEC add_Player 'Roy Hamilton', 81, 188, 'PG', 0, 1957
EXEC add_Player 'Gerald Henderson', 79, 188, 'PG', 0, 1956
EXEC add_Player 'Johnny High', 83, 190, 'PG', 0, 1957
EXEC add_Player 'Brad Holland', 81, 190, 'PG', 0, 1956
EXEC add_Player 'Phil Hubbard', 63, 203, 'PG', 0, 1956
EXEC add_Player 'Geoff Huston', 79, 188, 'PG', 0, 1957
EXEC add_Player 'Abdul Jeelani', 62, 203, 'PG', 0, 1954
EXEC add_Player 'Cheese Johnson', 77, 183, 'PG', 0, 1949
EXEC add_Player 'Magic Johnson', 64, 201, 'PG', 0, 1956
EXEC add_Player 'Vinnie Johnson', 80, 188, 'PG', 0, 1956
EXEC add_Player 'Major Jones', 66, 206, 'PG', 0, 1953
EXEC add_Player 'Greg Kelser', 83, 201, 'PG', 0, 1957
EXEC add_Player 'Irv Kiffin', 66, 206, 'SG', 0, 1951
EXEC add_Player 'Carl Kilpatrick', 67, 208, 'SG', 0, 1956
EXEC add_Player 'Reggie King', 66, 198, 'SG', 0, 1957
EXEC add_Player 'Arvid Kramer', 64, 206, 'SG', 0, 1956
EXEC add_Player 'Allen Leavell', 77, 185, 'SG', 0, 1957
EXEC add_Player 'Ollie Mack', 83, 190, 'SG', 0, 1957
EXEC add_Player 'Steve Malovic', 67, 208, 'SG', 0, 1956
EXEC add_Player 'Paul Mokeski', 71, 213, 'SG', 0, 1957
EXEC add_Player 'Sidney Moncrief', 81, 190, 'SG', 0, 1957
EXEC add_Player 'Calvin Natt', 64, 198, 'SG', 0, 1957
EXEC add_Player 'Sylvester Norris', 64, 211, 'SG', 0, 1957
EXEC add_Player 'Wiley Peck', 64, 201, 'SG', 0, 1957
EXEC add_Player 'Sam Pellom', 66, 206, 'SG', 0, 1951
EXEC add_Player 'Clint Richardson', 85, 190, 'SG', 0, 1956
EXEC add_Player 'Cliff Robinson', 64, 206, 'SG', 0, 1960
EXEC add_Player 'Jim Spanarkel', 83, 196, 'SG', 0, 1957
EXEC add_Player 'Bernard Toone', 62, 206, 'SG', 0, 1956
EXEC add_Player 'Duck Williams', 81, 188, 'SG', 0, 1956
EXEC add_Player 'Sly Williams', 62, 201, 'SG', 0, 1958
EXEC add_Player 'Bubba Wilson', 79, 190, 'SG', 0, 1955
EXEC add_Player 'Tony Zeno', 62, 203, 'SF', 0, 1957
EXEC add_Player 'Darrell Allums', 64, 206, 'SF', 0, 1958
EXEC add_Player 'Norman Black', 83, 196, 'SF', 0, 1957
EXEC add_Player 'Dave Britton', 81, 193, 'SF', 0, 1958
EXEC add_Player 'Michael Brooks', 64, 201, 'SF', 0, 1958
EXEC add_Player 'Lewis Brown', 83, 190, 'SF', 0, 1919
EXEC add_Player 'Rickey Brown', 63, 208, 'SF', 0, 1958
EXEC add_Player 'Joe Barry', 85, 193, 'SF', 0, 1969
EXEC add_Player 'Butch Carter', 81, 196, 'SF', 0, 1958
EXEC add_Player 'Reggie Carter', 79, 190, 'SF', 0, 1957
EXEC add_Player 'Art Collins', 83, 193, 'SF', 0, 1954
EXEC add_Player 'Don Collins', 81, 198, 'SF', 0, 1951
EXEC add_Player 'Darwin Cook', 83, 190, 'SF', 0, 1958
EXEC add_Player 'Earl Cureton', 62, 206, 'SF', 0, 1957
EXEC add_Player 'Monti Davis', 82, 201, 'SF', 0, 1958
EXEC add_Player 'James Donaldson', 62, 218, 'SF', 0, 1957
EXEC add_Player 'Larry Drew', 77, 185, 'SF', 0, 1958
EXEC add_Player 'Ralph Drollinger', 71, 218, 'SF', 0, 1954
EXEC add_Player 'John Duren', 85, 190, 'SF', 0, 1958
EXEC add_Player 'Tony Fuller', 81, 193, 'SF', 0, 1958
EXEC add_Player 'Calvin Garrett', 83, 201, 'PF', 0, 1956
EXEC add_Player 'Mike Gminski', 71, 211, 'PF', 0, 1959
EXEC add_Player 'Darrell Griffith', 83, 193, 'PF', 0, 1958
EXEC add_Player 'Bill Hanzlik', 83, 201, 'PF', 0, 1957
EXEC add_Player 'Alan Hardy', 85, 201, 'PF', 0, 1957
EXEC add_Player 'Mike Harper', 85, 208, 'PF', 0, 1957
EXEC add_Player 'Cedrick Hordges', 64, 203, 'PF', 0, 1957
EXEC add_Player 'Tony Jackson', 80, 193, 'PF', 0, 1942
EXEC add_Player 'Lee Johnson', 82, 211, 'PF', 0, 1957
EXEC add_Player 'Reggie Johnson', 82, 206, 'PF', 0, 1957
EXEC add_Player 'Edgar Jones', 66, 208, 'PF', 0, 1956
EXEC add_Player 'Walter Jordan', 86, 201, 'PF', 0, 1956
EXEC add_Player 'Clarence Kea', 64, 198, 'PF', 0, 1959
EXEC add_Player 'Chad Kinch', 83, 193, 'PF', 0, 1958
EXEC add_Player 'Wayne Kreklow', 79, 193, 'PF', 0, 1957
EXEC add_Player 'Bill Laimbeer', 70, 211, 'PF', 0, 1957
EXEC add_Player 'Edmund Lawrence', 66, 213, 'PF', 0, 1952
EXEC add_Player 'Ronnie Lester', 79, 188, 'PF', 0, 1959
EXEC add_Player 'Kyle Macy', 79, 190, 'PF', 0, 1957
EXEC add_Player 'Rick Mahorn', 69, 208, 'PF', 0, 1958
EXEC add_Player 'Wes Matthews', 77, 185, 'C', 0, 1959
EXEC add_Player 'Bill Mayfield', 82, 201, 'C', 0, 1957
EXEC add_Player 'Keith McCord', 62, 201, 'C', 0, 1957
EXEC add_Player 'Kevin McHale', 62, 208, 'C', 0, 1957
EXEC add_Player 'Dick Miller', 63, 198, 'C', 0, 1958
EXEC add_Player 'Johnny Moore', 79, 185, 'C', 0, 1958
EXEC add_Player 'Lowes Moore', 77, 185, 'C', 0, 1957
EXEC add_Player 'Kenny Natt', 83, 190, 'C', 0, 1958
EXEC add_Player 'Carl Nicks', 79, 185, 'C', 0, 1958
EXEC add_Player 'Mike Niles', 66, 198, 'C', 0, 1955
EXEC add_Player 'Mike O"Koren', 83, 201, 'C', 0, 1958
EXEC add_Player 'Jawann Oldham', 63, 213, 'C', 0, 1957
EXEC add_Player 'Louis Orr', 79, 203, 'C', 0, 1958
EXEC add_Player 'Myles Patrick', 64, 203, 'C', 0, 1954
EXEC add_Player 'Tony Price', 83, 198, 'C', 0, 1957
EXEC add_Player 'Wally Rank', 64, 198, 'C', 0, 1958
EXEC add_Player 'Kelvin Ransey', 77, 185, 'C', 0, 1958
EXEC add_Player 'James Ray', 63, 203, 'C', 0, 1957
EXEC add_Player 'Billy Reid', 83, 196, 'C', 0, 1957
EXEC add_Player 'Wayne Robinson', 64, 203, 'C', 0, 1958
EXEC add_Player 'Lorenzo Romar', 79, 185, 'PG', 0, 1958
EXEC add_Player 'DeWayne Scales', 62, 203, 'PG', 0, 1958
EXEC add_Player 'Craig Shelton', 62, 201, 'PG', 0, 1957
EXEC add_Player 'Jerry Sichting', 76, 185, 'PG', 0, 1956
EXEC add_Player 'Larry Smith', 63, 203, 'PG', 0, 1958
EXEC add_Player 'Rory Sparrow', 79, 188, 'PG', 0, 1958
EXEC add_Player 'John Stroud', 63, 201, 'PG', 0, 1957
EXEC add_Player 'Carlos Terry', 62, 196, 'PG', 0, 1956
EXEC add_Player 'Andrew Toney', 80, 190, 'PG', 0, 1957
EXEC add_Player 'Ronnie Valentine', 62, 201, 'PG', 0, 1957
EXEC add_Player 'Kiki Vandeweghe', 64, 203, 'PG', 0, 1958
EXEC add_Player 'Brett Vroman', 64, 213, 'PG', 0, 1955
EXEC add_Player 'Hawkeye Whitney', 67, 201, 'PG', 0, 1939
EXEC add_Player 'Michael Wiley', 80, 206, 'PG', 0, 1957
EXEC add_Player 'James Wilkes', 83, 198, 'PG', 0, 1953
EXEC add_Player 'Jeff Wilkins', 67, 211, 'PG', 0, 1955
EXEC add_Player 'Mike Woodson', 85, 196, 'PG', 0, 1958
EXEC add_Player 'Sam Worthen', 85, 196, 'PG', 0, 1958
EXEC add_Player 'Mark Aguirre', 67, 198, 'PG', 0, 1959
EXEC add_Player 'Danny Ainge', 79, 193, 'PG', 0, 1959
EXEC add_Player 'Carl Bailey', 62, 213, 'SG', 0, 1958
EXEC add_Player 'Gene Banks', 63, 201, 'SG', 0, 1959
EXEC add_Player 'Rolando Blackman', 83, 198, 'SG', 0, 1959
EXEC add_Player 'Ray Blume', 83, 193, 'SG', 0, 1958
EXEC add_Player 'Alex Bradley', 83, 198, 'SG', 0, 1953
EXEC add_Player 'Charles Bradley', 63, 196, 'SG', 0, 1959
EXEC add_Player 'Brad Branson', 64, 208, 'SG', 0, 1958
EXEC add_Player 'Jim Brogan', 83, 193, 'SG', 0, 1958
EXEC add_Player 'Roger Burkman', 79, 196, 'SG', 0, 1958
EXEC add_Player 'David Burns', 81, 188, 'SG', 0, 1958
EXEC add_Player 'Bobby Cattage', 71, 206, 'SG', 0, 1958
EXEC add_Player 'Tom Chambers', 64, 208, 'SG', 0, 1959
EXEC add_Player 'Joe Cooper', 67, 208, 'SG', 0, 1957
EXEC add_Player 'Charles Davis', 72, 188, 'SG', 0, 1949
EXEC add_Player 'Kenny Dennard', 64, 203, 'SG', 0, 1958
EXEC add_Player 'Mickey Dillard', 77, 190, 'SG', 0, 1958
EXEC add_Player 'John Douglas', 77, 188, 'SG', 0, 1956
EXEC add_Player 'Craig Dykema', 83, 203, 'SG', 0, 1959
EXEC add_Player 'Franklin Edwards', 77, 185, 'SG', 0, 1959
EXEC add_Player 'Petur Gudmundsson', 73, 218, 'SG', 0, 1958
EXEC add_Player 'Glenn Hagan', 77, 183, 'SF', 0, 1955
EXEC add_Player 'Steve Hayes', 82, 213, 'SF', 0, 1955
EXEC add_Player 'Tracy Jackson', 82, 198, 'SF', 0, 1959
EXEC add_Player 'Clay Johnson', 69, 208, 'SF', 0, 1956
EXEC add_Player 'Frank Johnson', 83, 185, 'SF', 0, 1958
EXEC add_Player 'Steve Johnson', 64, 203, 'SF', 0, 1944
EXEC add_Player 'Albert King', 83, 198, 'SF', 0, 1959
EXEC add_Player 'Jeff Lamp', 85, 198, 'SF', 0, 1959
EXEC add_Player 'Rock Lee', 84, 193, 'SF', 0, 1952
EXEC add_Player 'Alton Lister', 69, 213, 'SF', 0, 1958
EXEC add_Player 'Lewis Lloyd', 82, 198, 'SF', 0, 1959
EXEC add_Player 'Kevin Loder', 82, 198, 'SF', 0, 1959
EXEC add_Player 'Rudy Macklin', 82, 201, 'SF', 0, 1958
EXEC add_Player 'John McCullough', 83, 193, 'SF', 0, 1956
EXEC add_Player 'Hank McDowell', 63, 206, 'SF', 0, 1959
EXEC add_Player 'Mike McGee', 83, 196, 'SF', 0, 1959
EXEC add_Player 'Kevin McKenna', 85, 196, 'SF', 0, 1959
EXEC add_Player 'Larry Nance', 82, 208, 'SF', 0, 1959
EXEC add_Player 'Kurt Nimphius', 64, 208, 'SF', 0, 1958
EXEC add_Player 'Mark Radford', 83, 193, 'SF', 0, 1959
EXEC add_Player 'Ed Rains', 83, 201, 'PF', 0, 1956
EXEC add_Player 'Kurt Rambis', 63, 203, 'PF', 0, 1958
EXEC add_Player 'Jeff Ruland', 69, 208, 'PF', 0, 1958
EXEC add_Player 'Danny Schayes', 68, 211, 'PF', 0, 1959
EXEC add_Player 'Jim Smith', 66, 206, 'PF', 0, 1958
EXEC add_Player 'Larry Spriggs', 67, 201, 'PF', 0, 1959
EXEC add_Player 'Isiah Thomas', 81, 185, 'PF', 0, 1961
EXEC add_Player 'Ray Tolbert', 66, 206, 'PF', 0, 1958
EXEC add_Player 'Kelly Tripucka', 64, 198, 'PF', 0, 1959
EXEC add_Player 'Elston Turner', 83, 196, 'PF', 0, 1959
EXEC add_Player 'Darnell Valentine', 83, 185, 'PF', 0, 1959
EXEC add_Player 'Pete Verhoeven', 63, 206, 'PF', 0, 1959
EXEC add_Player 'Jay Vincent', 64, 201, 'PF', 0, 1959
EXEC add_Player 'Danny Vranes', 62, 201, 'PF', 0, 1958
EXEC add_Player 'Buck Williams', 63, 203, 'PF', 0, 1960
EXEC add_Player 'Herb Williams', 69, 208, 'PF', 0, 1958
EXEC add_Player 'Garry Witts', 83, 201, 'PF', 0, 1959
EXEC add_Player 'Al Wood', 84, 198, 'PF', 0, 1958
EXEC add_Player 'Howard Wood', 68, 201, 'PF', 0, 1959
EXEC add_Player 'Orlando Woolridge', 63, 206, 'PF', 0, 1959
EXEC add_Player 'Rich Yonakor', 64, 206, 'C', 0, 1958
EXEC add_Player 'Dwight Anderson', 83, 190, 'C', 0, 1960
EXEC add_Player 'J.J. Anderson', 83, 190, 'C', 0, 1960
EXEC add_Player 'Richard Anderson', 69, 208, 'C', 0, 1960
EXEC add_Player 'John Bagley', 83, 183, 'C', 0, 1960
EXEC add_Player 'Dave Batton', 69, 208, 'C', 0, 1956
EXEC add_Player 'Lester Conner', 81, 193, 'C', 0, 1959
EXEC add_Player 'Chubby Cox', 81, 188, 'C', 0, 1955
EXEC add_Player 'Terry Cummings', 64, 206, 'C', 0, 1961
EXEC add_Player 'Quintin Dailey', 81, 190, 'C', 0, 1961
EXEC add_Player 'Mark Eaton', 62, 224, 'C', 0, 1957
EXEC add_Player 'Jerry Eaves', 81, 193, 'C', 0, 1959
EXEC add_Player 'Keith Edmonson', 85, 196, 'C', 0, 1960
EXEC add_Player 'Chris Engler', 70, 211, 'C', 0, 1959
EXEC add_Player 'Bruce Flowers', 66, 203, 'C', 0, 1957
EXEC add_Player 'Sleepy Floyd', 77, 190, 'C', 0, 1960
EXEC add_Player 'Bill Garnett', 64, 208, 'C', 0, 1940
EXEC add_Player 'John Greig', 63, 201, 'C', 0, 1961
EXEC add_Player 'Scott Hastings', 68, 208, 'C', 0, 1960
EXEC add_Player 'Rod Higgins', 80, 201, 'C', 0, 1960
EXEC add_Player 'Craig Hodges', 83, 188, 'PG', 0, 1960
EXEC add_Player 'Marc Iavaroni', 62, 203, 'PG', 0, 1956
EXEC add_Player 'Jim Johnstone', 70, 211, 'PG', 0, 1960
EXEC add_Player 'Hutch Jones', 83, 203, 'PG', 0, 1959
EXEC add_Player 'Clark Kellogg', 66, 201, 'PG', 0, 1961
EXEC add_Player 'Joe Kopicki', 69, 206, 'PG', 0, 1960
EXEC add_Player 'Fat Lever', 77, 190, 'PG', 0, 1960
EXEC add_Player 'Cliff Levingston', 62, 203, 'PG', 0, 1961
EXEC add_Player 'Steve Lingenfelter', 66, 206, 'PG', 0, 1958
EXEC add_Player 'Dave Magley', 81, 203, 'PG', 0, 1959
EXEC add_Player 'Mark McNamara', 68, 211, 'PG', 0, 1959
EXEC add_Player 'Guy Morgan', 82, 203, 'PG', 0, 1960
EXEC add_Player 'Ed Nealy', 68, 201, 'PG', 0, 1960
EXEC add_Player 'Chuck Nevitt', 64, 226, 'PG', 0, 1959
EXEC add_Player 'Audie Norris', 67, 206, 'PG', 0, 1960
EXEC add_Player 'Eddie Phillips', 66, 201, 'PG', 0, 1961
EXEC add_Player 'Ricky Pierce', 82, 193, 'PG', 0, 1959
EXEC add_Player 'Charles Pittman', 64, 203, 'PG', 0, 1958
EXEC add_Player 'Paul Pressey', 83, 196, 'PG', 0, 1958
EXEC add_Player 'Oliver Robinson', 81, 193, 'PG', 0, 1960
EXEC add_Player 'Walker Russell', 85, 196, 'SG', 0, 1960
EXEC add_Player 'Mike Sanders', 62, 198, 'SG', 0, 1960
EXEC add_Player 'Russ Schoene', 62, 208, 'SG', 0, 1960
EXEC add_Player 'Ed Sherod', 77, 188, 'SG', 0, 1959
EXEC add_Player 'Jose Slaughter', 82, 196, 'SG', 0, 1960
EXEC add_Player 'Derek Smith', 81, 190, 'SG', 0, 1920
EXEC add_Player 'Brook Steppe', 85, 196, 'SG', 0, 1959
EXEC add_Player 'Jeff Taylor', 79, 193, 'SG', 0, 1960
EXEC add_Player 'Vince Taylor', 81, 196, 'SG', 0, 1960
EXEC add_Player 'Terry Teagle', 85, 196, 'SG', 0, 1960
EXEC add_Player 'David Thirdkill', 85, 201, 'SG', 0, 1960
EXEC add_Player 'Corny Thompson', 66, 203, 'SG', 0, 1960
EXEC add_Player 'LaSalle Thompson', 70, 208, 'SG', 0, 1961
EXEC add_Player 'Darren Tillis', 63, 211, 'SG', 0, 1960
EXEC add_Player 'Linton Townes', 83, 201, 'SG', 0, 1959
EXEC add_Player 'Trent Tucker', 84, 196, 'SG', 0, 1959
EXEC add_Player 'Bryan Warrick', 85, 196, 'SG', 0, 1959
EXEC add_Player 'Rory White', 62, 203, 'SG', 0, 1959
EXEC add_Player 'Dominique Wilkins', 80, 201, 'SG', 0, 1960
EXEC add_Player 'Rickey Williams', 79, 185, 'SG', 0, 1957
EXEC add_Player 'Rob Williams', 85, 190, 'SF', 0, 1944
EXEC add_Player 'James Worthy', 66, 206, 'SF', 0, 1961
EXEC add_Player 'Jim Zoet', 69, 216, 'SF', 0, 1953
EXEC add_Player 'Ken Austin', 82, 206, 'SF', 0, 1961
EXEC add_Player 'Thurl Bailey', 63, 211, 'SF', 0, 1961
EXEC add_Player 'Randy Breuer', 67, 221, 'SF', 0, 1960
EXEC add_Player 'Wallace Bryant', 70, 213, 'SF', 0, 1959
EXEC add_Player 'Howard Carter', 63, 196, 'SF', 0, 1961
EXEC add_Player 'Carlos Clark', 62, 193, 'SF', 0, 1960
EXEC add_Player 'Leroy Combs', 62, 203, 'SF', 0, 1961
EXEC add_Player 'Russell Cross', 63, 208, 'SF', 0, 1961
EXEC add_Player 'Darren Daye', 64, 203, 'SF', 0, 1960
EXEC add_Player 'Clyde Drexler', 62, 201, 'SF', 0, 1962
EXEC add_Player 'Craig Ehlo', 81, 198, 'SF', 0, 1961
EXEC add_Player 'Dale Ellis', 82, 201, 'SF', 0, 1960
EXEC add_Player 'Rod Foster', 72, 185, 'SF', 0, 1960
EXEC add_Player 'John Garris', 82, 203, 'SF', 0, 1959
EXEC add_Player 'Mike Gibson', 82, 208, 'SF', 0, 1960
EXEC add_Player 'Stewart Granger', 83, 190, 'SF', 0, 1961
EXEC add_Player 'Sidney Green', 83, 188, 'SF', 0, 1933
EXEC add_Player 'Bob Hansen', 83, 198, 'PF', 0, 1961
EXEC add_Player 'Derek Harper', 83, 193, 'PF', 0, 1961
EXEC add_Player 'Roy Hinson', 62, 206, 'PF', 0, 1961
EXEC add_Player 'Charles Jones', 63, 206, 'PF', 0, 1957
EXEC add_Player 'Mark Jones', 66, 206, 'PF', 0, 1953
EXEC add_Player 'Greg Kite', 71, 211, 'PF', 0, 1961
EXEC add_Player 'Bruce Kuczenski', 67, 208, 'PF', 0, 1961
EXEC add_Player 'Darrell Lockhart', 70, 206, 'PF', 0, 1960
EXEC add_Player 'Sidney Lowe', 85, 183, 'PF', 0, 1960
EXEC add_Player 'Jeff Malone', 82, 193, 'PF', 0, 1961
EXEC add_Player 'Pace Mannion', 83, 201, 'PF', 0, 1960
EXEC add_Player 'Rodney McCray', 64, 201, 'PF', 0, 1961
EXEC add_Player 'Scooter McCray', 63, 206, 'PF', 0, 1960
EXEC add_Player 'Larry Micheaux', 64, 206, 'PF', 0, 1960
EXEC add_Player 'Bob Miller', 67, 208, 'PF', 0, 1956
EXEC add_Player 'John Paxson', 83, 188, 'PF', 0, 1960
EXEC add_Player 'John Pinone', 67, 203, 'PF', 0, 1961
EXEC add_Player 'Tom Piotrowski', 69, 216, 'PF', 0, 1960
EXEC add_Player 'Leo Rautins', 63, 203, 'PF', 0, 1960
EXEC add_Player 'Doc Rivers', 83, 193, 'PF', 0, 1961
EXEC add_Player 'Fred Roberts', 64, 208, 'C', 0, 1960
EXEC add_Player 'Ralph Sampson', 66, 224, 'C', 0, 1960
EXEC add_Player 'Byron Scott', 85, 190, 'C', 0, 1961
EXEC add_Player 'Steve Stipanovich', 70, 211, 'C', 0, 1960
EXEC add_Player 'Jon Sundvold', 77, 188, 'C', 0, 1961
EXEC add_Player 'Dane Suttle', 83, 190, 'C', 0, 1961
EXEC add_Player 'Jim Thomas', 83, 190, 'C', 0, 1960
EXEC add_Player 'Paul Thompson', 62, 198, 'C', 0, 1961
EXEC add_Player 'Sedale Threatt', 79, 188, 'C', 0, 1961
EXEC add_Player 'Granville Waiters', 66, 211, 'C', 0, 1961
EXEC add_Player 'Darrell Walker', 81, 193, 'C', 0, 1961
EXEC add_Player 'Brant Weidner', 67, 206, 'C', 0, 1960
EXEC add_Player 'Mark West', 67, 208, 'C', 0, 1960
EXEC add_Player 'Ennis Whatley', 80, 190, 'C', 0, 1962
EXEC add_Player 'Mitchell Wiggins', 83, 193, 'C', 0, 1959
EXEC add_Player 'Kevin Williams', 79, 188, 'C', 0, 1961
EXEC add_Player 'Michael Wilson', 79, 193, 'C', 0, 1959
EXEC add_Player 'Randy Wittman', 62, 198, 'C', 0, 1959
EXEC add_Player 'Chuck Aleksinas', 73, 211, 'C', 0, 1959
EXEC add_Player 'Ron Anderson', 63, 201, 'C', 0, 1958
EXEC add_Player 'Ken Bannister', 68, 206, 'PG', 0, 1960
EXEC add_Player 'Charles Barkley', 72, 198, 'PG', 0, 1963
EXEC add_Player 'Cory Blackwell', 62, 198, 'PG', 0, 1963
EXEC add_Player 'Sam Bowie', 68, 216, 'PG', 0, 1961
EXEC add_Player 'Frank Brickowski', 69, 206, 'PG', 0, 1959
EXEC add_Player 'Tony Brown', 83, 198, 'PG', 0, 1960
EXEC add_Player 'Steve Burtt', 83, 188, 'PG', 0, 1962
EXEC add_Player 'Michael Cage', 65, 206, 'PG', 0, 1962
EXEC add_Player 'Tony Campbell', 63, 201, 'PG', 0, 1962
EXEC add_Player 'Rick Carlisle', 62, 196, 'PG', 0, 1959
EXEC add_Player 'Antoine Carr', 66, 206, 'PG', 0, 1961
EXEC add_Player 'Ron Cavenall', 67, 216, 'PG', 0, 1959
EXEC add_Player 'Steve Colter', 74, 190, 'PG', 0, 1962
EXEC add_Player 'Devin Durrant', 80, 201, 'PG', 0, 1960
EXEC add_Player 'Kenton Edelin', 82, 203, 'PG', 0, 1962
EXEC add_Player 'Kenny Fields', 64, 196, 'PG', 0, 1962
EXEC add_Player 'Vern Fleming', 83, 196, 'PG', 0, 1962
EXEC add_Player 'Lancaster Gordon', 83, 190, 'PG', 0, 1962
EXEC add_Player 'Butch Graves', 80, 190, 'PG', 0, 1962
EXEC add_Player 'Stuart Gray', 68, 213, 'PG', 0, 1963
EXEC add_Player 'Mike Holton', 83, 193, 'SG', 0, 1961
EXEC add_Player 'Jay Humphries', 83, 190, 'SG', 0, 1962
EXEC add_Player 'Ralph Jackson', 83, 188, 'SG', 0, 1962
EXEC add_Player 'Earl Jones', 62, 213, 'SG', 0, 1961
EXEC add_Player 'Ozell Jones', 68, 211, 'SG', 0, 1960
EXEC add_Player 'Michael Jordan', 85, 198, 'SG', 0, 1963
EXEC add_Player 'Jerome Kersey', 63, 201, 'SG', 0, 1962
EXEC add_Player 'Tim McCormick', 69, 211, 'SG', 0, 1962
EXEC add_Player 'Jay Murphy', 64, 206, 'SG', 0, 1962
EXEC add_Player 'Hakeem Olajuwon', 72, 213, 'SG', 0, 1963
EXEC add_Player 'Sam Perkins', 68, 206, 'SG', 0, 1961
EXEC add_Player 'Jim Petersen', 68, 208, 'SG', 0, 1962
EXEC add_Player 'Gary Plummer', 63, 206, 'SG', 0, 1962
EXEC add_Player 'David Pope', 64, 201, 'SG', 0, 1962
EXEC add_Player 'Alvin Robertson', 83, 190, 'SG', 0, 1962
EXEC add_Player 'Wayne Sappleton', 63, 206, 'SG', 0, 1960
EXEC add_Player 'Tom Scheffler', 69, 211, 'SG', 0, 1954
EXEC add_Player 'John Schweitz', 62, 198, 'SG', 0, 1960
EXEC add_Player 'Tom Sewell', 83, 196, 'SG', 0, 1962
EXEC add_Player 'Charlie Sitton', 62, 203, 'SG', 0, 1962
EXEC add_Player 'Tom Sluby', 80, 193, 'SF', 0, 1962
EXEC add_Player 'Terence Stansbury', 77, 196, 'SF', 0, 1961
EXEC add_Player 'John Stockton', 77, 185, 'SF', 0, 1962
EXEC add_Player 'Peter Thibeaux', 62, 201, 'SF', 0, 1961
EXEC add_Player 'Bernard Thompson', 62, 198, 'SF', 0, 1962
EXEC add_Player 'Otis Thorpe', 66, 206, 'SF', 0, 1962
EXEC add_Player 'Jeff Turner', 67, 206, 'SF', 0, 1962
EXEC add_Player 'Melvin Turpin', 69, 211, 'SF', 0, 1960
EXEC add_Player 'Willie White', 85, 190, 'SF', 0, 1962
EXEC add_Player 'Eddie Lee', 85, 190, 'SF', 0, 1962
EXEC add_Player 'Dale Wilkinson', 64, 208, 'SF', 0, 1960
EXEC add_Player 'Guy Williams', 79, 188, 'SF', 0, 1953
EXEC add_Player 'Kevin Willis', 79, 188, 'SF', 0, 1961
EXEC add_Player 'Othell Wilson', 83, 183, 'SF', 0, 1961
EXEC add_Player 'Leon Wood', 83, 190, 'SF', 0, 1962
EXEC add_Player 'Danny Young', 79, 190, 'SF', 0, 1962
EXEC add_Player 'Michael Young', 64, 201, 'SF', 0, 1961
EXEC add_Player 'Michael Adams', 73, 178, 'SF', 0, 1963
EXEC add_Player 'John Battle', 79, 188, 'SF', 0, 1962
EXEC add_Player 'Benoit Benjamin', 71, 213, 'SF', 0, 1964
EXEC add_Player 'Uwe Blab', 72, 216, 'PF', 0, 1962
EXEC add_Player 'Manute Bol', 80, 231, 'PF', 0, 1962
EXEC add_Player 'Mike Brittain', 68, 213, 'PF', 0, 1963
EXEC add_Player 'Terry Catledge', 64, 203, 'PF', 0, 1963
EXEC add_Player 'Lorenzo Charles', 66, 201, 'PF', 0, 1963
EXEC add_Player 'Fred Cofield', 83, 190, 'PF', 0, 1962
EXEC add_Player 'David Cooke', 67, 203, 'PF', 0, 1963
EXEC add_Player 'Tyrone Corbin', 62, 198, 'PF', 0, 1962
EXEC add_Player 'Ron Crevier', 68, 213, 'PF', 0, 1958
EXEC add_Player 'Jeff Cross', 69, 208, 'PF', 0, 1961
EXEC add_Player 'Joe Dumars', 83, 190, 'PF', 0, 1963
EXEC add_Player 'Georgi Glouchkov', 68, 203, 'PF', 0, 1960
EXEC add_Player 'A.C. Green', 68, 203, 'PF', 0, 1960
EXEC add_Player 'Ken Green', 63, 203, 'PF', 0, 1959
EXEC add_Player 'Kenny Green', 63, 203, 'PF', 0, 1959
EXEC add_Player 'Claude Gregory', 82, 203, 'PF', 0, 1958
EXEC add_Player 'Steve Harris', 85, 196, 'PF', 0, 1963
EXEC add_Player 'Jerome Henderson', 67, 211, 'PF', 0, 1959
EXEC add_Player 'Carl Henry', 82, 198, 'PF', 0, 1960
EXEC add_Player 'Alfredrick Hughes', 82, 198, 'C', 0, 1960
EXEC add_Player 'Ken Johnson', 69, 203, 'C', 0, 1962
EXEC add_Player 'Yvon Joseph', 70, 211, 'C', 0, 1957
EXEC add_Player 'Harold Keeling', 83, 193, 'C', 0, 1963
EXEC add_Player 'Joe Kleine', 72, 211, 'C', 0, 1962
EXEC add_Player 'Jon Koncak', 71, 213, 'C', 0, 1963
EXEC add_Player 'Keith Lee', 63, 208, 'C', 0, 1962
EXEC add_Player 'Karl Malone', 71, 206, 'C', 0, 1963
EXEC add_Player 'Bill Martin', 82, 201, 'C', 0, 1962
EXEC add_Player 'Brian Martin', 63, 206, 'C', 0, 1962
EXEC add_Player 'Dwayne McClain', 83, 198, 'C', 0, 1963
EXEC add_Player 'Xavier McDaniel', 82, 201, 'C', 0, 1963
EXEC add_Player 'Ben McDonald', 62, 203, 'C', 0, 1962
EXEC add_Player 'Chris McNealy', 62, 201, 'C', 0, 1961
EXEC add_Player 'Dirk Minniefield', 81, 190, 'C', 0, 1961
EXEC add_Player 'Perry Moss', 83, 188, 'C', 0, 1958
EXEC add_Player 'Chris Mullin', 80, 198, 'C', 0, 1963
EXEC add_Player 'Charles Oakley', 66, 203, 'C', 0, 1963
EXEC add_Player 'Michael Phelps', 81, 193, 'C', 0, 1961
EXEC add_Player 'Ed Pinckney', 85, 206, 'C', 0, 1963
EXEC add_Player 'Terry Porter', 85, 190, 'PG', 0, 1963
EXEC add_Player 'Blair Rasmussen', 71, 213, 'PG', 0, 1962
EXEC add_Player 'Jerry Reynolds', 80, 203, 'PG', 0, 1962
EXEC add_Player 'Derrick Rowland', 85, 196, 'PG', 0, 1959
EXEC add_Player 'Detlef Schrempf', 63, 206, 'PG', 0, 1963
EXEC add_Player 'Carey Scurry', 85, 201, 'PG', 0, 1962
EXEC add_Player 'Mike Smrek', 71, 213, 'PG', 0, 1962
EXEC add_Player 'Alex Stivrins', 64, 203, 'PG', 0, 1962
EXEC add_Player 'Greg Stokes', 64, 208, 'PG', 0, 1963
EXEC add_Player 'Bob Thornton', 66, 208, 'PG', 0, 1962
EXEC add_Player 'Wayman Tisdale', 69, 206, 'PG', 0, 1964
EXEC add_Player 'Sedric Toney', 80, 188, 'PG', 0, 1962
EXEC add_Player 'Nick Vanos', 72, 216, 'PG', 0, 1963
EXEC add_Player 'Sam Vincent', 83, 188, 'PG', 0, 1963
EXEC add_Player 'Spud Webb', 60, 168, 'PG', 0, 1963
EXEC add_Player 'Bill Wennington', 70, 213, 'PG', 0, 1963
EXEC add_Player 'Gerald Wilkins', 83, 198, 'PG', 0, 1963
EXEC add_Player 'Pete Williams', 83, 201, 'PG', 0, 1965
EXEC add_Player 'Voise Winters', 80, 203, 'PG', 0, 1962
EXEC add_Player 'Rafael Addison', 63, 201, 'PG', 0, 1964
EXEC add_Player 'Mark Alarie', 64, 203, 'SG', 0, 1963
EXEC add_Player 'William Bedford', 66, 213, 'SG', 0, 1963
EXEC add_Player 'Walter Berry', 63, 203, 'SG', 0, 1964
EXEC add_Player 'Joe Binion', 68, 203, 'SG', 0, 1961
EXEC add_Player 'Adrian Branch', 83, 201, 'SG', 0, 1963
EXEC add_Player 'Mike Brown', 73, 206, 'SG', 0, 1963
EXEC add_Player 'Ben Coleman', 68, 206, 'SG', 0, 1961
EXEC add_Player 'Dell Curry', 83, 193, 'SG', 0, 1965
EXEC add_Player 'Brad Daugherty', 70, 213, 'SG', 0, 1965
EXEC add_Player 'Johnny Dawkins', 74, 188, 'SG', 0, 1963
EXEC add_Player 'Bruce Douglas', 85, 190, 'SG', 0, 1964
EXEC add_Player 'Greg Dreiling', 71, 216, 'SG', 0, 1962
EXEC add_Player 'Kevin Duckworth', 62, 213, 'SG', 0, 1964
EXEC add_Player 'Dave Feitl', 68, 211, 'SG', 0, 1962
EXEC add_Player 'Kenny Gattison', 66, 203, 'SG', 0, 1964
EXEC add_Player 'Grant Gondrezick', 82, 196, 'SG', 0, 1963
EXEC add_Player 'Ron Harper', 83, 198, 'SG', 0, 1964
EXEC add_Player 'Cedric Henderson', 62, 203, 'SG', 0, 1965
EXEC add_Player 'Kevin Henderson', 85, 193, 'SG', 0, 1964
EXEC add_Player 'Conner Henry', 85, 201, 'SG', 0, 1963
EXEC add_Player 'Jeff Hornacek', 83, 190, 'SF', 0, 1963
EXEC add_Player 'Myron Jackson', 83, 190, 'SF', 0, 1964
EXEC add_Player 'Buck Johnson', 83, 201, 'SF', 0, 1964
EXEC add_Player 'Steffond Johnson', 64, 203, 'SF', 0, 1944
EXEC add_Player 'Anthony Jones', 85, 198, 'SF', 0, 1962
EXEC add_Player 'Tim Kempton', 70, 208, 'SF', 0, 1964
EXEC add_Player 'Curtis Kitchen', 68, 206, 'SF', 0, 1964
EXEC add_Player 'Larry Krystkowiak', 64, 206, 'SF', 0, 1964
EXEC add_Player 'Jim Lampley', 67, 208, 'SF', 0, 1960
EXEC add_Player 'Fernando Martin', 64, 206, 'SF', 0, 1962
EXEC add_Player 'Maurice Martin', 80, 198, 'SF', 0, 1964
EXEC add_Player 'Forrest McKenzie', 80, 201, 'SF', 0, 1963
EXEC add_Player 'Nate McMillan', 85, 196, 'SF', 0, 1964
EXEC add_Player 'Cozell McQueen', 68, 211, 'SF', 0, 1962
EXEC add_Player 'Pete Myers', 81, 198, 'SF', 0, 1963
EXEC add_Player 'Johnny Newman', 83, 201, 'SF', 0, 1963
EXEC add_Player 'Dennis Nutt', 77, 188, 'SF', 0, 1963
EXEC add_Player 'Chuck Person', 64, 203, 'SF', 0, 1964
EXEC add_Player 'Dwayne Polee', 81, 196, 'SF', 0, 1963
EXEC add_Player 'Harold Pressley', 62, 201, 'SF', 0, 1963
EXEC add_Player 'Mark Price', 77, 183, 'PF', 0, 1964
EXEC add_Player 'Dennis Rodman', 62, 201, 'PF', 0, 1961
EXEC add_Player 'Johnny Rogers', 66, 208, 'PF', 0, 1963
EXEC add_Player 'Ron Rowan', 80, 196, 'PF', 0, 1962
EXEC add_Player 'John Salley', 67, 211, 'PF', 0, 1964
EXEC add_Player 'Brad Sellers', 62, 213, 'PF', 0, 1962
EXEC add_Player 'McKinley Singleton', 79, 196, 'PF', 0, 1961
EXEC add_Player 'Scott Skiles', 81, 185, 'PF', 0, 1964
EXEC add_Player 'Clinton Smith', 62, 198, 'PF', 0, 1964
EXEC add_Player 'Keith Smith', 77, 190, 'PF', 0, 1965
EXEC add_Player 'Otis Smith', 62, 196, 'PF', 0, 1964
EXEC add_Player 'Roy Tarpley', 67, 211, 'PF', 0, 1964
EXEC add_Player 'Billy Thompson', 85, 201, 'PF', 0, 1963
EXEC add_Player 'Andre Turner', 72, 180, 'PF', 0, 1964
EXEC add_Player 'Kenny Walker', 62, 203, 'PF', 0, 1964
EXEC add_Player 'Chris Washburn', 66, 211, 'PF', 0, 1965
EXEC add_Player 'Pearl Washington', 83, 188, 'PF', 0, 1964
EXEC add_Player 'John Williams', 83, 188, 'PF', 0, 1951
EXEC add_Player 'David Wingate', 83, 196, 'PF', 0, 1963
EXEC add_Player 'Brad Wright', 66, 211, 'PF', 0, 1962
EXEC add_Player 'Perry Young', 62, 196, 'C', 0, 1963
EXEC add_Player 'Mark Acres', 64, 211, 'C', 0, 1962
EXEC add_Player 'Steve Alford', 83, 188, 'C', 0, 1964
EXEC add_Player 'Greg Anderson', 67, 208, 'C', 0, 1964
EXEC add_Player 'Joe Arlauckas', 67, 206, 'C', 0, 1965
EXEC add_Player 'Vincent Askew', 62, 198, 'C', 0, 1966
EXEC add_Player 'Nate Blackwell', 77, 193, 'C', 0, 1965
EXEC add_Player 'Muggsy Bogues', 61, 160, 'C', 0, 1965
EXEC add_Player 'Norris Coleman', 62, 203, 'C', 0, 1961
EXEC add_Player 'Dallas Comegys', 82, 206, 'C', 0, 1964
EXEC add_Player 'Winston Crite', 67, 201, 'C', 0, 1965
EXEC add_Player 'Billy Donovan', 77, 180, 'C', 0, 1965
EXEC add_Player 'Chris Dudley', 81, 188, 'C', 0, 1950
EXEC add_Player 'Jim Farmer', 83, 193, 'C', 0, 1964
EXEC add_Player 'Tellis Frank', 66, 208, 'C', 0, 1965
EXEC add_Player 'Kevin Gamble', 62, 196, 'C', 0, 1965
EXEC add_Player 'Winston Garland', 77, 188, 'C', 0, 1964
EXEC add_Player 'Armen Gilliam', 67, 206, 'C', 0, 1964
EXEC add_Player 'Horace Grant', 63, 208, 'C', 0, 1965
EXEC add_Player 'Dave Henderson', 85, 196, 'C', 0, 1964
EXEC add_Player 'Dave Hoppen', 68, 211, 'PG', 0, 1964
EXEC add_Player 'Dennis Hopson', 80, 196, 'PG', 0, 1965
EXEC add_Player 'Eddie Hughes', 74, 178, 'PG', 0, 1960
EXEC add_Player 'Mark Jackson', 81, 185, 'PG', 0, 1965
EXEC add_Player 'Michael Jackson', 63, 201, 'PG', 0, 1949
EXEC add_Player 'Kannard Johnson', 64, 206, 'PG', 0, 1965
EXEC add_Player 'Kevin Johnson', 69, 203, 'PG', 0, 1962
EXEC add_Player 'Bart Kofoed', 62, 193, 'PG', 0, 1964
EXEC add_Player 'Ralph Lewis', 80, 198, 'PG', 0, 1963
EXEC add_Player 'Reggie Lewis', 85, 201, 'PG', 0, 1965
EXEC add_Player 'Brad Lohaus', 67, 211, 'PG', 0, 1964
EXEC add_Player 'Derrick McKey', 82, 206, 'PG', 0, 1966
EXEC add_Player 'Reggie Miller', 83, 201, 'PG', 0, 1965
EXEC add_Player 'Andre Moore', 63, 206, 'PG', 0, 1964
EXEC add_Player 'Ron Moore', 73, 213, 'PG', 0, 1962
EXEC add_Player 'Ronnie Murphy', 66, 196, 'PG', 0, 1964
EXEC add_Player 'Tod Murphy', 64, 206, 'PG', 0, 1963
EXEC add_Player 'Martin Nessley', 73, 218, 'PG', 0, 1965
EXEC add_Player 'Ken Norman', 63, 203, 'PG', 0, 1964
EXEC add_Player 'Scottie Pippen', 62, 203, 'PG', 0, 1965
EXEC add_Player 'Olden Polynice', 64, 211, 'SG', 0, 1964
EXEC add_Player 'Richard Rellford', 67, 198, 'SG', 0, 1964
EXEC add_Player 'Scott Roth', 63, 203, 'SG', 0, 1963
EXEC add_Player 'Brian Rowsom', 64, 206, 'SG', 0, 1965
EXEC add_Player 'Kenny Smith', 77, 190, 'SG', 0, 1965
EXEC add_Player 'John Stroeder', 73, 208, 'SG', 0, 1958
EXEC add_Player 'Mark Wade', 72, 180, 'SG', 0, 1965
EXEC add_Player 'Milt Wagner', 83, 196, 'SG', 0, 1963
EXEC add_Player 'Jamie Waller', 63, 193, 'SG', 0, 1964
EXEC add_Player 'Duane Washington', 85, 193, 'SG', 0, 1964
EXEC add_Player 'Chris Welp', 70, 213, 'SG', 0, 1964
EXEC add_Player 'Clinton Wheeler', 83, 185, 'SG', 0, 1959
EXEC add_Player 'Eric White', 80, 203, 'SG', 0, 1965
EXEC add_Player 'Tony White', 77, 188, 'SG', 0, 1965
EXEC add_Player 'Reggie Williams', 83, 201, 'SG', 0, 1964
EXEC add_Player 'Nikita Wilson', 80, 203, 'SG', 0, 1964
EXEC add_Player 'Ricky Wilson', 80, 196, 'SG', 0, 1956
EXEC add_Player 'Rickie Winslow', 66, 203, 'SG', 0, 1964
EXEC add_Player 'Joe Wolf', 67, 211, 'SG', 0, 1964
EXEC add_Player 'Phil Zevenbergen', 67, 208, 'SG', 0, 1964
EXEC add_Player 'Randy Allen', 64, 203, 'SF', 0, 1965
EXEC add_Player 'Michael Anderson', 83, 180, 'SF', 0, 1966
EXEC add_Player 'Willie Anderson', 83, 201, 'SF', 0, 1967
EXEC add_Player 'Ricky Berry', 82, 203, 'SF', 0, 1964
EXEC add_Player 'Anthony Bowie', 83, 198, 'SF', 0, 1963
EXEC add_Player 'Scott Brooks', 74, 180, 'SF', 0, 1965
EXEC add_Player 'Mark Bryant', 70, 206, 'SF', 0, 1965
EXEC add_Player 'Greg Butler', 69, 211, 'SF', 0, 1966
EXEC add_Player 'Mike Champion', 67, 208, 'SF', 0, 1964
EXEC add_Player 'Rex Chapman', 83, 193, 'SF', 0, 1967
EXEC add_Player 'Derrick Chievous', 85, 201, 'SF', 0, 1967
EXEC add_Player 'Mark Davis', 85, 198, 'SF', 0, 1963
EXEC add_Player 'Vinny Del', 85, 198, 'SF', 0, 1963
EXEC add_Player 'Fennis Dembo', 63, 196, 'SF', 0, 1966
EXEC add_Player 'Ledell Eackles', 64, 196, 'SF', 0, 1966
EXEC add_Player 'Kevin Edwards', 83, 190, 'SF', 0, 1965
EXEC add_Player 'Wayne Englestad', 70, 203, 'SF', 0, 1966
EXEC add_Player 'Rolando Ferreira', 69, 216, 'SF', 0, 1964
EXEC add_Player 'Duane Ferrell', 62, 201, 'SF', 0, 1965
EXEC add_Player 'Anthony Frederick', 82, 201, 'SF', 0, 1964
EXEC add_Player 'Corey Gaines', 85, 190, 'PF', 0, 1965
EXEC add_Player 'Tom Garrick', 83, 188, 'PF', 0, 1966
EXEC add_Player 'Ben Gillery', 68, 213, 'PF', 0, 1965
EXEC add_Player 'Orlando Graham', 64, 203, 'PF', 0, 1965
EXEC add_Player 'Ron Grandison', 63, 198, 'PF', 0, 1964
EXEC add_Player 'Gary Grant', 83, 190, 'PF', 0, 1965
EXEC add_Player 'Harvey Grant', 85, 203, 'PF', 0, 1965
EXEC add_Player 'Sylvester Gray', 67, 198, 'PF', 0, 1967
EXEC add_Player 'Jeff Grayer', 80, 196, 'PF', 0, 1965
EXEC add_Player 'Jack Haley', 69, 208, 'PF', 0, 1964
EXEC add_Player 'Hersey Hawkins', 83, 190, 'PF', 0, 1966
EXEC add_Player 'Tito Horford', 70, 216, 'PF', 0, 1966
EXEC add_Player 'Avery Johnson', 79, 178, 'PF', 0, 1965
EXEC add_Player 'Bill Jones', 79, 201, 'PF', 0, 1966
EXEC add_Player 'Shelton Jones', 62, 206, 'PF', 0, 1966
EXEC add_Player 'Steve Kerr', 79, 190, 'PF', 0, 1965
EXEC add_Player 'Randolph Keys', 85, 201, 'PF', 0, 1966
EXEC add_Player 'Jerome Lane', 67, 198, 'PF', 0, 1966
EXEC add_Player 'Andrew Lang', 70, 211, 'PF', 0, 1966
EXEC add_Player 'Eric Leckner', 60, 211, 'PF', 0, 1966
EXEC add_Player 'Jim Les', 74, 180, 'C', 0, 1963
EXEC add_Player 'Rob Lock', 66, 206, 'C', 0, 1966
EXEC add_Player 'Grant Long', 66, 203, 'C', 0, 1966
EXEC add_Player 'Dan Majerle', 63, 198, 'C', 0, 1965
EXEC add_Player 'Danny Manning', 67, 208, 'C', 0, 1966
EXEC add_Player 'Vernon Maxwell', 81, 193, 'C', 0, 1965
EXEC add_Player 'Todd Mitchell', 82, 201, 'C', 0, 1966
EXEC add_Player 'Chris Morris', 62, 203, 'C', 0, 1966
EXEC add_Player 'Richard Morton', 83, 190, 'C', 0, 1966
EXEC add_Player 'Craig Neal', 74, 196, 'C', 0, 1964
EXEC add_Player 'Jose Ortiz', 66, 208, 'C', 0, 1963
EXEC add_Player 'Will Perdue', 69, 213, 'C', 0, 1965
EXEC add_Player 'Tim Perry', 80, 206, 'C', 0, 1965
EXEC add_Player 'Dave Popson', 64, 208, 'C', 0, 1964
EXEC add_Player 'Dominic Pressley', 77, 188, 'C', 0, 1964
EXEC add_Player 'Mitch Richmond', 63, 196, 'C', 0, 1965
EXEC add_Player 'Ramon Rivas', 73, 208, 'C', 0, 1966
EXEC add_Player 'David Rivers', 77, 183, 'C', 0, 1965
EXEC add_Player 'Rob Rose', 81, 196, 'C', 0, 1964
EXEC add_Player 'Jim Rowinski', 71, 203, 'C', 0, 1961
EXEC add_Player 'Rony Seikaly', 67, 211, 'PG', 0, 1965
EXEC add_Player 'Charles Shackleford', 66, 208, 'PG', 0, 1966
EXEC add_Player 'John Shasky', 68, 211, 'PG', 0, 1964
EXEC add_Player 'Brian Shaw', 83, 198, 'PG', 0, 1966
EXEC add_Player 'Keith Smart', 79, 185, 'PG', 0, 1964
EXEC add_Player 'Charles Smith', 67, 208, 'PG', 0, 1965
EXEC add_Player 'Rik Smits', 71, 224, 'PG', 0, 1966
EXEC add_Player 'John Starks', 81, 190, 'PG', 0, 1965
EXEC add_Player 'Everette Stephens', 79, 188, 'PG', 0, 1966
EXEC add_Player 'Rod Strickland', 80, 196, 'PG', 0, 1940
EXEC add_Player 'Barry Sumpter', 63, 211, 'PG', 0, 1965
EXEC add_Player 'Anthony Taylor', 79, 193, 'PG', 0, 1965
EXEC add_Player 'Tom Tolbert', 68, 201, 'PG', 0, 1965
EXEC add_Player 'Kelvin Upshaw', 81, 188, 'PG', 0, 1963
EXEC add_Player 'Morlon Wiley', 83, 193, 'PG', 0, 1966
EXEC add_Player 'Micheal Williams', 82, 188, 'PG', 0, 1945
EXEC add_Player 'David Wood', 66, 206, 'PG', 0, 1964
EXEC add_Player 'Nick Anderson', 82, 198, 'PG', 0, 1968
EXEC add_Player 'Michael Ansley', 66, 201, 'PG', 0, 1967
EXEC add_Player 'B.J. Armstrong', 66, 201, 'PG', 0, 1967
EXEC add_Player 'Dana Barros', 73, 180, 'SG', 0, 1967
EXEC add_Player 'Kenny Battle', 62, 198, 'SG', 0, 1964
EXEC add_Player 'Winston Bennett', 62, 201, 'SG', 0, 1965
EXEC add_Player 'Mookie Blaylock', 81, 183, 'SG', 0, 1967
EXEC add_Player 'Chucky Brown', 63, 201, 'SG', 0, 1968
EXEC add_Player 'Raymond Brown', 64, 203, 'SG', 0, 1965
EXEC add_Player 'Stanley Brundy', 62, 198, 'SG', 0, 1967
EXEC add_Player 'Torgeir Bryn', 71, 206, 'SG', 0, 1964
EXEC add_Player 'Steve Bucknall', 63, 198, 'SG', 0, 1966
EXEC add_Player 'Adrian Caldwell', 60, 203, 'SG', 0, 1966
EXEC add_Player 'Lanard Copeland', 83, 198, 'SG', 0, 1965
EXEC add_Player 'Terry Davis', 66, 206, 'SG', 0, 1967
EXEC add_Player 'Byron Dinkins', 77, 185, 'SG', 0, 1967
EXEC add_Player 'Vlade Divac', 70, 216, 'SG', 0, 1968
EXEC add_Player 'Sherman Douglas', 81, 183, 'SG', 0, 1966
EXEC add_Player 'Terry Dozier', 62, 206, 'SG', 0, 1966
EXEC add_Player 'Blue Edwards', 80, 193, 'SG', 0, 1965
EXEC add_Player 'Jay Edwards', 66, 213, 'SG', 0, 1955
EXEC add_Player 'Sean Elliott', 82, 203, 'SG', 0, 1968
EXEC add_Player 'Pervis Ellison', 62, 206, 'SG', 0, 1967
EXEC add_Player 'Derrick Gervin', 80, 203, 'SF', 0, 1963
EXEC add_Player 'Greg Grant', 63, 170, 'SF', 0, 1966
EXEC add_Player 'Scott Haffner', 81, 190, 'SF', 0, 1966
EXEC add_Player 'Tom Hammonds', 63, 206, 'SF', 0, 1967
EXEC add_Player 'Tim Hardaway', 79, 183, 'SF', 0, 1966
EXEC add_Player 'Mike Higgins', 64, 206, 'SF', 0, 1967
EXEC add_Player 'Ed Horton', 67, 203, 'SF', 0, 1967
EXEC add_Player 'Byron Irvin', 83, 196, 'SF', 0, 1966
EXEC add_Player 'Jaren Jackson', 83, 193, 'SF', 0, 1967
EXEC add_Player 'Eric Johnson', 82, 188, 'SF', 0, 1966
EXEC add_Player 'Nate Johnston', 62, 203, 'SF', 0, 1966
EXEC add_Player 'Shawn Kemp', 67, 208, 'SF', 0, 1969
EXEC add_Player 'Stan Kimbrough', 69, 180, 'SF', 0, 1966
EXEC add_Player 'Stacey King', 67, 211, 'SF', 0, 1967
EXEC add_Player 'Frank Kornet', 66, 206, 'SF', 0, 1967
EXEC add_Player 'Jeff Lebo', 81, 188, 'SF', 0, 1966
EXEC add_Player 'Tim Legler', 80, 193, 'SF', 0, 1966
EXEC add_Player 'Gary Leonard', 71, 216, 'SF', 0, 1967
EXEC add_Player 'Clifford Lett', 77, 190, 'SF', 0, 1965
EXEC add_Player 'Todd Lichti', 82, 193, 'SF', 0, 1967
EXEC add_Player 'Roy Marble', 83, 198, 'PF', 0, 1966
EXEC add_Player 'Sarunas Marciulionis', 80, 196, 'PF', 0, 1964
EXEC add_Player 'Jeff Martin', 85, 196, 'PF', 0, 1967
EXEC add_Player 'Anthony Mason', 71, 201, 'PF', 0, 1966
EXEC add_Player 'Bob McCann', 70, 198, 'PF', 0, 1964
EXEC add_Player 'Mel McCants', 69, 203, 'PF', 0, 1967
EXEC add_Player 'George McCloud', 82, 198, 'PF', 0, 1967
EXEC add_Player 'Carlton McKinney', 83, 193, 'PF', 0, 1964
EXEC add_Player 'Scott Meents', 66, 208, 'PF', 0, 1964
EXEC add_Player 'Sam Mitchell', 62, 198, 'PF', 0, 1963
EXEC add_Player 'Mike Morrison', 85, 193, 'PF', 0, 1967
EXEC add_Player 'John Morton', 81, 190, 'PF', 0, 1967
EXEC add_Player 'Dyron Nix', 62, 201, 'PF', 0, 1967
EXEC add_Player 'Zarko Paspalj', 63, 206, 'PF', 0, 1966
EXEC add_Player 'Kenny Payne', 85, 203, 'PF', 0, 1966
EXEC add_Player 'Drazen Petrovic', 85, 196, 'PF', 0, 1964
EXEC add_Player 'Brian Quinnett', 68, 203, 'PF', 0, 1966
EXEC add_Player 'J.R. Reid', 68, 203, 'PF', 0, 1966
EXEC add_Player 'Glen Rice', 63, 201, 'PF', 0, 1967
EXEC add_Player 'Pooh Richardson', 81, 185, 'PF', 0, 1966
EXEC add_Player 'Clifford Robinson', 64, 206, 'C', 0, 1960
EXEC add_Player 'David Robinson', 68, 216, 'C', 0, 1965
EXEC add_Player 'Doug Roth', 72, 211, 'C', 0, 1967
EXEC add_Player 'Donald Royal', 62, 203, 'C', 0, 1966
EXEC add_Player 'Delaney Rudd', 81, 188, 'C', 0, 1962
EXEC add_Player 'Jeff Sanders', 66, 203, 'C', 0, 1966
EXEC add_Player 'Dexter Shouse', 80, 188, 'C', 0, 1963
EXEC add_Player 'Michael Smith', 66, 208, 'C', 0, 1965
EXEC add_Player 'Jay Taylor', 83, 190, 'C', 0, 1967
EXEC add_Player 'Leonard Taylor', 64, 203, 'C', 0, 1966
EXEC add_Player 'Henry Turner', 85, 188, 'C', 0, 1938
EXEC add_Player 'Gary Voce', 69, 206, 'C', 0, 1965
EXEC add_Player 'Alexander Volkov', 64, 208, 'C', 0, 1964
EXEC add_Player 'Doug West', 80, 198, 'C', 0, 1967
EXEC add_Player 'Randy White', 69, 203, 'C', 0, 1967
EXEC add_Player 'Mike Williams', 82, 188, 'C', 0, 1945
EXEC add_Player 'Haywoode Workman', 81, 188, 'C', 0, 1966
EXEC add_Player 'Alaa Abdelnaby', 69, 208, 'C', 0, 1968
EXEC add_Player 'Mahmoud Abdul-Rauf', 83, 188, 'C', 0, 1942
EXEC add_Player 'Keith Askins', 86, 201, 'C', 0, 1967
EXEC add_Player 'Milos Babic', 69, 213, 'PG', 0, 1968
EXEC add_Player 'Cedric Ball', 62, 203, 'PG', 0, 1968
EXEC add_Player 'Lance Blanks', 83, 193, 'PG', 0, 1966
EXEC add_Player 'Anthony Bonner', 63, 203, 'PG', 0, 1968
EXEC add_Player 'Dee Brown', 72, 185, 'PG', 0, 1968
EXEC add_Player 'Jud Buechler', 64, 198, 'PG', 0, 1968
EXEC add_Player 'Matt Bullard', 63, 208, 'PG', 0, 1967
EXEC add_Player 'Willie Burton', 62, 203, 'PG', 0, 1968
EXEC add_Player 'Rick Calloway', 81, 198, 'PG', 0, 1966
EXEC add_Player 'Elden Campbell', 63, 211, 'PG', 0, 1968
EXEC add_Player 'Duane Causwell', 69, 213, 'PG', 0, 1968
EXEC add_Player 'Cedric Ceballos', 83, 198, 'PG', 0, 1969
EXEC add_Player 'Richard Coffey', 63, 198, 'PG', 0, 1965
EXEC add_Player 'Derrick Coleman', 67, 208, 'PG', 0, 1967
EXEC add_Player 'Bimbo Coles', 81, 185, 'PG', 0, 1968
EXEC add_Player 'Anthony Cook', 82, 206, 'PG', 0, 1967
EXEC add_Player 'Tony Dawson', 63, 201, 'PG', 0, 1967
EXEC add_Player 'Mario Elie', 62, 196, 'PG', 0, 1963
EXEC add_Player 'A.J. English', 62, 196, 'PG', 0, 1963
EXEC add_Player 'Danny Ferry', 67, 208, 'PG', 0, 1966
EXEC add_Player 'Greg Foster', 69, 211, 'SG', 0, 1968
EXEC add_Player 'Tate George', 83, 196, 'SG', 0, 1968
EXEC add_Player 'Kendall Gill', 85, 196, 'SG', 0, 1968
EXEC add_Player 'Gerald Glass', 65, 196, 'SG', 0, 1967
EXEC add_Player 'Dan Godfread', 71, 208, 'SG', 0, 1967
EXEC add_Player 'Jim Grandholm', 68, 213, 'SG', 0, 1960
EXEC add_Player 'Tony Harris', 83, 190, 'SG', 0, 1967
EXEC add_Player 'Steve Henson', 80, 180, 'SG', 0, 1968
EXEC add_Player 'Sean Higgins', 82, 206, 'SG', 0, 1968
EXEC add_Player 'Tyrone Hill', 69, 206, 'SG', 0, 1968
EXEC add_Player 'Dave Jamerson', 83, 196, 'SG', 0, 1967
EXEC add_Player 'Henry James', 64, 203, 'SG', 0, 1965
EXEC add_Player 'Les Jepsen', 68, 213, 'SG', 0, 1967
EXEC add_Player 'Alec Kessler', 67, 211, 'SG', 0, 1967
EXEC add_Player 'Bo Kimble', 83, 193, 'SG', 0, 1966
EXEC add_Player 'Negele Knight', 79, 185, 'SG', 0, 1967
EXEC add_Player 'Kurk Lee', 83, 190, 'SG', 0, 1967
EXEC add_Player 'Marcus Liberty', 82, 203, 'SG', 0, 1968
EXEC add_Player 'Ian Lockhart', 69, 203, 'SG', 0, 1967
EXEC add_Player 'Tony Massenburg', 64, 206, 'SG', 0, 1967
EXEC add_Player 'Travis Mays', 83, 188, 'SF', 0, 1968
EXEC add_Player 'Terry Mills', 67, 208, 'SF', 0, 1967
EXEC add_Player 'Chris Munk', 66, 206, 'SF', 0, 1967
EXEC add_Player 'Jerrod Mustaf', 68, 208, 'SF', 0, 1969
EXEC add_Player 'Dan O"Sullivan', 71, 208, 'SF', 0, 1968
EXEC add_Player 'Alan Ogg', 69, 218, 'SF', 0, 1967
EXEC add_Player 'Brian Oliver', 62, 193, 'SF', 0, 1968
EXEC add_Player 'Gerald Paddio', 82, 201, 'SF', 0, 1965
EXEC add_Player 'Walter Palmer', 63, 216, 'SF', 0, 1968
EXEC add_Player 'Kevin Pritchard', 81, 190, 'SF', 0, 1967
EXEC add_Player 'Larry Robinson', 81, 190, 'SF', 0, 1968
EXEC add_Player 'Rumeal Robinson', 85, 188, 'SF', 0, 1966
EXEC add_Player 'Steve Scheffler', 71, 206, 'SF', 0, 1967
EXEC add_Player 'Dwayne Schintzius', 73, 216, 'SF', 0, 1968
EXEC add_Player 'Dennis Scott', 66, 203, 'SF', 0, 1968
EXEC add_Player 'Lionel Simmons', 62, 201, 'SF', 0, 1968
EXEC add_Player 'Tony Smith', 62, 201, 'SF', 0, 1968
EXEC add_Player 'Felton Spencer', 60, 213, 'SF', 0, 1968
EXEC add_Player 'Irving Thomas', 66, 203, 'SF', 0, 1966
EXEC add_Player 'Andy Toolson', 62, 198, 'PF', 0, 1966
EXEC add_Player 'Loy Vaught', 67, 206, 'PF', 0, 1968
EXEC add_Player 'Stojko Vrankovic', 73, 218, 'PF', 0, 1964
EXEC add_Player 'Jayson Williams', 69, 206, 'PF', 0, 1968
EXEC add_Player 'Kenny Williams', 79, 188, 'PF', 0, 1961
EXEC add_Player 'Scott Williams', 67, 208, 'PF', 0, 1968
EXEC add_Player 'Trevor Wilson', 62, 201, 'PF', 0, 1968
EXEC add_Player 'Kennard Winchester', 62, 196, 'PF', 0, 1966
EXEC add_Player 'Howard Wright', 83, 190, 'PF', 0, 1947
EXEC add_Player 'A.J. Wynder', 83, 190, 'PF', 0, 1947
EXEC add_Player 'Victor Alexander', 60, 206, 'PF', 0, 1969
EXEC add_Player 'Kenny Anderson', 76, 183, 'PF', 0, 1970
EXEC add_Player 'Greg Anthony', 79, 183, 'PF', 0, 1967
EXEC add_Player 'Stacey Augmon', 82, 203, 'PF', 0, 1968
EXEC add_Player 'Isaac Austin', 72, 208, 'PF', 0, 1969
EXEC add_Player 'Steve Bardo', 83, 196, 'PF', 0, 1968
EXEC add_Player 'David Benoit', 64, 203, 'PF', 0, 1968
EXEC add_Player 'Terrell Brandon', 81, 180, 'PF', 0, 1970
EXEC add_Player 'Kevin Brooks', 80, 198, 'PF', 0, 1969
EXEC add_Player 'Myron Brown', 81, 190, 'PF', 0, 1969
EXEC add_Player 'Randy Brown', 64, 203, 'C', 0, 1965
EXEC add_Player 'Demetrius Calip', 74, 185, 'C', 0, 1969
EXEC add_Player 'Pete Chilcutt', 67, 208, 'C', 0, 1968
EXEC add_Player 'Marty Conlon', 65, 208, 'C', 0, 1968
EXEC add_Player 'Tom Copa', 62, 208, 'C', 0, 1964
EXEC add_Player 'Chris Corchiani', 83, 183, 'C', 0, 1968
EXEC add_Player 'Corey Crowder', 63, 196, 'C', 0, 1969
EXEC add_Player 'Dale Davis', 67, 211, 'C', 0, 1969
EXEC add_Player 'Bison Dele', 68, 206, 'C', 0, 1969
EXEC add_Player 'Patrick Eddie', 69, 211, 'C', 0, 1967
EXEC add_Player 'LeRon Ellis', 62, 208, 'C', 0, 1940
EXEC add_Player 'Rick Fox', 67, 201, 'C', 0, 1969
EXEC add_Player 'Chris Gatling', 64, 208, 'C', 0, 1967
EXEC add_Player 'Paul Graham', 80, 198, 'C', 0, 1967
EXEC add_Player 'Sean Green', 62, 196, 'C', 0, 1970
EXEC add_Player 'Carl Herrera', 63, 206, 'C', 0, 1966
EXEC add_Player 'Donald Hodge', 67, 213, 'C', 0, 1969
EXEC add_Player 'Brian Howard', 82, 198, 'C', 0, 1967
EXEC add_Player 'Cedric Hunter', 81, 183, 'C', 0, 1965
EXEC add_Player 'Mike Iuzzolino', 79, 178, 'C', 0, 1968
EXEC add_Player 'Rich King', 73, 218, 'PG', 0, 1969
EXEC add_Player 'Doug Lee', 80, 196, 'PG', 0, 1964
EXEC add_Player 'Luc Longley', 60, 218, 'PG', 0, 1969
EXEC add_Player 'Kevin Lynch', 85, 196, 'PG', 0, 1968
EXEC add_Player 'Mark Macon', 83, 196, 'PG', 0, 1969
EXEC add_Player 'Tharon Mayes', 79, 190, 'PG', 0, 1968
EXEC add_Player 'Rodney Monroe', 83, 190, 'PG', 0, 1968
EXEC add_Player 'Tracy Moore', 80, 193, 'PG', 0, 1965
EXEC add_Player 'Eric Murdock', 83, 185, 'PG', 0, 1968
EXEC add_Player 'Dikembe Mutombo', 70, 218, 'PG', 0, 1966
EXEC add_Player 'Jimmy Oliver', 82, 196, 'PG', 0, 1969
EXEC add_Player 'Billy Owens', 64, 203, 'PG', 0, 1969
EXEC add_Player 'Keith Owens', 66, 201, 'PG', 0, 1969
EXEC add_Player 'Robert Pack', 81, 188, 'PG', 0, 1969
EXEC add_Player 'Elliot Perry', 68, 183, 'PG', 0, 1969
EXEC add_Player 'Bobby Phills', 62, 196, 'PG', 0, 1969
EXEC add_Player 'Mark Randall', 68, 203, 'PG', 0, 1967
EXEC add_Player 'Stanley Roberts', 64, 213, 'PG', 0, 1970
EXEC add_Player 'Doug Smith', 83, 188, 'PG', 0, 1920
EXEC add_Player 'LaBradford Smith', 63, 203, 'PG', 0, 1958
EXEC add_Player 'Steve Smith', 80, 201, 'SG', 0, 1969
EXEC add_Player 'Larry Stewart', 64, 203, 'SG', 0, 1968
EXEC add_Player 'Derek Strong', 64, 203, 'SG', 0, 1968
EXEC add_Player 'Lamont Strothers', 83, 193, 'SG', 0, 1968
EXEC add_Player 'Greg Sutton', 77, 188, 'SG', 0, 1967
EXEC add_Player 'Carl Thomas', 79, 193, 'SG', 0, 1969
EXEC add_Player 'Charles Thomas', 79, 190, 'SG', 0, 1969
EXEC add_Player 'Stephen Thompson', 83, 193, 'SG', 0, 1968
EXEC add_Player 'John Turner', 70, 203, 'SG', 0, 1967
EXEC add_Player 'Joao Vianna', 63, 206, 'SG', 0, 1966
EXEC add_Player 'Eric Anderson', 64, 206, 'SG', 0, 1970
EXEC add_Player 'Anthony Avent', 68, 206, 'SG', 0, 1969
EXEC add_Player 'Jon Barry', 85, 193, 'SG', 0, 1969
EXEC add_Player 'Tony Bennett', 79, 183, 'SG', 0, 1969
EXEC add_Player 'Alex Blackwell', 71, 198, 'SG', 0, 1970
EXEC add_Player 'Ricky Blanton', 63, 201, 'SG', 0, 1966
EXEC add_Player 'Walter Bond', 80, 196, 'SG', 0, 1969
EXEC add_Player 'Dexter Cambridge', 65, 201, 'SG', 0, 1970
EXEC add_Player 'Doug Christie', 80, 198, 'SG', 0, 1970
EXEC add_Player 'Duane Cooper', 83, 185, 'SG', 0, 1969
EXEC add_Player 'Joe Courtney', 68, 203, 'SF', 0, 1969
EXEC add_Player 'John Crotty', 83, 185, 'SF', 0, 1969
EXEC add_Player 'Radisav Curcic', 62, 208, 'SF', 0, 1965
EXEC add_Player 'Lloyd Daniels', 82, 201, 'SF', 0, 1967
EXEC add_Player 'Hubert Davis', 83, 196, 'SF', 0, 1970
EXEC add_Player 'Todd Day', 85, 198, 'SF', 0, 1970
EXEC add_Player 'Richard Dumas', 77, 190, 'SF', 0, 1970
EXEC add_Player 'Pat Durham', 62, 201, 'SF', 0, 1967
EXEC add_Player 'LaPhonso Ellis', 69, 203, 'SF', 0, 1970
EXEC add_Player 'Matt Geiger', 70, 213, 'SF', 0, 1969
EXEC add_Player 'Litterial Green', 83, 185, 'SF', 0, 1970
EXEC add_Player 'Tom Gugliotta', 69, 208, 'SF', 0, 1969
EXEC add_Player 'Jay Guidinger', 72, 208, 'SF', 0, 1969
EXEC add_Player 'Robert Horry', 64, 206, 'SF', 0, 1970
EXEC add_Player 'Byron Houston', 71, 196, 'SF', 0, 1969
EXEC add_Player 'Stephen Howard', 66, 206, 'SF', 0, 1970
EXEC add_Player 'Jim Jackson', 64, 198, 'SF', 0, 1970
EXEC add_Player 'Keith Jennings', 72, 170, 'SF', 0, 1968
EXEC add_Player 'Dave Johnson', 62, 201, 'SF', 0, 1970
EXEC add_Player 'Thomas Jordan', 64, 208, 'SF', 0, 1968
EXEC add_Player 'Adam Keefe', 67, 206, 'PF', 0, 1970
EXEC add_Player 'Christian Laettner', 68, 211, 'PF', 0, 1969
EXEC add_Player 'Sam Mack', 64, 201, 'PF', 0, 1970
EXEC add_Player 'Don MacLean', 68, 208, 'PF', 0, 1970
EXEC add_Player 'Marlon Maxey', 71, 203, 'PF', 0, 1969
EXEC add_Player 'Lee Mayberry', 78, 185, 'PF', 0, 1970
EXEC add_Player 'Oliver Miller', 63, 206, 'PF', 0, 1970
EXEC add_Player 'Harold Miner', 62, 196, 'PF', 0, 1971
EXEC add_Player 'Isaiah Morris', 66, 203, 'PF', 0, 1969
EXEC add_Player 'Alonzo Mourning', 69, 208, 'PF', 0, 1970
EXEC add_Player 'Tracy Murray', 66, 201, 'PF', 0, 1971
EXEC add_Player 'Melvin Newbern', 80, 193, 'PF', 0, 1967
EXEC add_Player 'Shaquille O"Neal', 73, 216, 'PF', 0, 1972
EXEC add_Player 'Matt Othick', 74, 188, 'PF', 0, 1969
EXEC add_Player 'Doug Overton', 83, 190, 'PF', 0, 1969
EXEC add_Player 'Anthony Peeler', 62, 193, 'PF', 0, 1969
EXEC add_Player 'Brent Price', 74, 185, 'PF', 0, 1968
EXEC add_Player 'Anthony Pullard', 70, 208, 'PF', 0, 1966
EXEC add_Player 'Sean Rooks', 71, 208, 'PF', 0, 1969
EXEC add_Player 'Malik Sealy', 83, 203, 'PF', 0, 1970
EXEC add_Player 'Chris Smith', 67, 208, 'C', 0, 1965
EXEC add_Player 'Reggie Smith', 69, 208, 'C', 0, 1970
EXEC add_Player 'Andre Spencer', 62, 198, 'C', 0, 1964
EXEC add_Player 'Elmore Spencer', 61, 213, 'C', 0, 1969
EXEC add_Player 'Latrell Sprewell', 83, 196, 'C', 0, 1970
EXEC add_Player 'Barry Stevens', 85, 196, 'C', 0, 1963
EXEC add_Player 'Bryant Stith', 62, 196, 'C', 0, 1970
EXEC add_Player 'Gundars Vetra', 85, 198, 'C', 0, 1967
EXEC add_Player 'Clarence Weatherspoo', 69, 198, 'C', 0, 1970
EXEC add_Player 'Marcus Webb', 72, 206, 'C', 0, 1970
EXEC add_Player 'Robert Werdann', 71, 211, 'C', 0, 1970
EXEC add_Player 'Corey Williams', 83, 188, 'C', 0, 1970
EXEC add_Player 'Lorenzo Williams', 80, 206, 'C', 0, 1969
EXEC add_Player 'Walt Williams', 85, 193, 'C', 0, 1923
EXEC add_Player 'Randy Woods', 83, 178, 'C', 0, 1970
EXEC add_Player 'Gary Alexander', 69, 201, 'C', 0, 1969
EXEC add_Player 'Vin Baker', 67, 211, 'C', 0, 1971
EXEC add_Player 'Corie Blount', 69, 206, 'C', 0, 1969
EXEC add_Player 'Shawn Bradley', 68, 229, 'C', 0, 1972
EXEC add_Player 'P.J. Brown', 68, 229, 'C', 0, 1972
EXEC add_Player 'Evers Burns', 73, 203, 'PG', 0, 1971
EXEC add_Player 'Scott Burrell', 64, 201, 'PG', 0, 1971
EXEC add_Player 'Mitchell Butler', 77, 188, 'PG', 0, 1946
EXEC add_Player 'Sam Cassell', 83, 190, 'PG', 0, 1969
EXEC add_Player 'Calbert Cheaney', 62, 201, 'PG', 0, 1971
EXEC add_Player 'Michael Curry', 62, 196, 'PG', 0, 1968
EXEC add_Player 'Antonio Davis', 63, 206, 'PG', 0, 1968
EXEC add_Player 'Brian Davis', 81, 190, 'PG', 0, 1955
EXEC add_Player 'Terry Dehere', 83, 188, 'PG', 0, 1971
EXEC add_Player 'Dell Demps', 82, 190, 'PG', 0, 1970
EXEC add_Player 'Acie Earl', 69, 208, 'PG', 0, 1970
EXEC add_Player 'Bill Edwards', 63, 203, 'PG', 0, 1971
EXEC add_Player 'Doug Edwards', 64, 201, 'PG', 0, 1971
EXEC add_Player 'Harold Ellis', 80, 196, 'PG', 0, 1970
EXEC add_Player 'Alphonso Ford', 83, 185, 'PG', 0, 1971
EXEC add_Player 'Chad Gallagher', 72, 208, 'PG', 0, 1969
EXEC add_Player 'Andrew Gaze', 82, 201, 'PG', 0, 1965
EXEC add_Player 'Ricky Grace', 81, 185, 'PG', 0, 1967
EXEC add_Player 'Greg Graham', 78, 193, 'PG', 0, 1970
EXEC add_Player 'Josh Grant', 65, 206, 'PG', 0, 1967
EXEC add_Player 'Andres Guibert', 66, 208, 'SG', 0, 1968
EXEC add_Player 'Geert Hammink', 74, 213, 'SG', 0, 1969
EXEC add_Player 'Anfernee Hardaway', 85, 201, 'SG', 0, 1971
EXEC add_Player 'Lucious Harris', 83, 196, 'SG', 0, 1970
EXEC add_Player 'Antonio Harvey', 66, 211, 'SG', 0, 1970
EXEC add_Player 'Scott Haskin', 71, 211, 'SG', 0, 1970
EXEC add_Player 'Skeeter Henry', 83, 201, 'SG', 0, 1967
EXEC add_Player 'Allan Houston', 80, 198, 'SG', 0, 1971
EXEC add_Player 'Lindsey Hunter', 77, 188, 'SG', 0, 1970
EXEC add_Player 'Bobby Hurley', 74, 183, 'SG', 0, 1971
EXEC add_Player 'Stanley Jackson', 83, 190, 'SG', 0, 1970
EXEC add_Player 'Chris Jent', 64, 201, 'SG', 0, 1970
EXEC add_Player 'Ervin Johnson', 82, 188, 'SG', 0, 1966
EXEC add_Player 'Popeye Jones', 71, 203, 'SG', 0, 1970
EXEC add_Player 'Adonis Jordan', 77, 180, 'SG', 0, 1970
EXEC add_Player 'Reggie Jordan', 85, 193, 'SG', 0, 1968
EXEC add_Player 'Warren Kidd', 68, 206, 'SG', 0, 1970
EXEC add_Player 'Chris King', 63, 203, 'SG', 0, 1969
EXEC add_Player 'Toni Kukoc', 84, 208, 'SG', 0, 1968
EXEC add_Player 'George Lynch', 64, 203, 'SG', 0, 1970
EXEC add_Player 'Malcolm Mackey', 71, 206, 'SF', 0, 1970
EXEC add_Player 'Gerald Madkins', 80, 193, 'SF', 0, 1969
EXEC add_Player 'Bob Martin', 71, 213, 'SF', 0, 1969
EXEC add_Player 'Jamal Mashburn', 69, 203, 'SF', 0, 1972
EXEC add_Player 'Darnell Mee', 79, 196, 'SF', 0, 1971
EXEC add_Player 'Chris Mills', 63, 198, 'SF', 0, 1970
EXEC add_Player 'Darren Morningstar', 68, 208, 'SF', 0, 1969
EXEC add_Player 'Gheorghe Muresan', 68, 231, 'SF', 0, 1971
EXEC add_Player 'Bo Outlaw', 62, 203, 'SF', 0, 1971
EXEC add_Player 'Mike Peplowski', 61, 208, 'SF', 0, 1970
EXEC add_Player 'Richard Petruska', 73, 208, 'SF', 0, 1969
EXEC add_Player 'Dino Radja', 66, 211, 'SF', 0, 1967
EXEC add_Player 'Isaiah Rider', 63, 196, 'SF', 0, 1971
EXEC add_Player 'Eric Riley', 70, 213, 'SF', 0, 1970
EXEC add_Player 'James Robinson', 62, 198, 'SF', 0, 1955
EXEC add_Player 'Rodney Rogers', 68, 201, 'SF', 0, 1971
EXEC add_Player 'Bryon Russell', 66, 201, 'SF', 0, 1970
EXEC add_Player 'Kevin Thompson', 73, 211, 'SF', 0, 1971
EXEC add_Player 'Keith Tower', 71, 211, 'SF', 0, 1970
EXEC add_Player 'Nick Van', 71, 211, 'SF', 0, 1970
EXEC add_Player 'Rex Walters', 83, 193, 'PF', 0, 1970
EXEC add_Player 'Chris Webber', 70, 206, 'PF', 0, 1973
EXEC add_Player 'Matt Wenstrom', 71, 216, 'PF', 0, 1970
EXEC add_Player 'David Wesley', 83, 183, 'PF', 0, 1970
EXEC add_Player 'Chris Whitney', 76, 183, 'PF', 0, 1971
EXEC add_Player 'Aaron Williams', 64, 206, 'PF', 0, 1971
EXEC add_Player 'Luther Wright', 61, 218, 'PF', 0, 1971
EXEC add_Player 'Derrick Alston', 66, 211, 'PF', 0, 1972
EXEC add_Player 'Darrell Armstrong', 77, 183, 'PF', 0, 1968
EXEC add_Player 'Sergei Bazarevich', 76, 188, 'PF', 0, 1965
EXEC add_Player 'Elmer Bennett', 77, 183, 'PF', 0, 1970
EXEC add_Player 'James Blackwell', 83, 183, 'PF', 0, 1968
EXEC add_Player 'Tim Breaux', 63, 201, 'PF', 0, 1970
EXEC add_Player 'Chris Childs', 85, 190, 'PF', 0, 1967
EXEC add_Player 'Bill Curley', 64, 206, 'PF', 0, 1972
EXEC add_Player 'Yinka Dare', 60, 213, 'PF', 0, 1972
EXEC add_Player 'Tony Dumas', 83, 198, 'PF', 0, 1972
EXEC add_Player 'Howard Eisley', 80, 188, 'PF', 0, 1972
EXEC add_Player 'Matt Fish', 68, 211, 'PF', 0, 1969
EXEC add_Player 'Brian Grant', 72, 206, 'PF', 0, 1972
EXEC add_Player 'Darrin Hancock', 82, 201, 'C', 0, 1971
EXEC add_Player 'Jerome Harmon', 83, 193, 'C', 0, 1969
EXEC add_Player 'Grant Hill', 66, 203, 'C', 0, 1972
EXEC add_Player 'Tom Hovasse', 82, 203, 'C', 0, 1967
EXEC add_Player 'Juwan Howard', 69, 206, 'C', 0, 1973
EXEC add_Player 'Askia Jones', 80, 196, 'C', 0, 1971
EXEC add_Player 'Eddie Jones', 66, 208, 'C', 0, 1956
EXEC add_Player 'Jason Kidd', 82, 193, 'C', 0, 1973
EXEC add_Player 'Antonio Lang', 70, 211, 'C', 0, 1966
EXEC add_Player 'Ryan Lorthridge', 83, 193, 'C', 0, 1972
EXEC add_Player 'Donyell Marshall', 64, 206, 'C', 0, 1973
EXEC add_Player 'Darrick Martin', 77, 180, 'C', 0, 1971
EXEC add_Player 'Jim McIlvaine', 69, 216, 'C', 0, 1972
EXEC add_Player 'Aaron McKie', 62, 196, 'C', 0, 1972
EXEC add_Player 'Anthony Miller', 66, 206, 'C', 0, 1971
EXEC add_Player 'Greg Minor', 62, 198, 'C', 0, 1971
EXEC add_Player 'Eric Mobley', 68, 211, 'C', 0, 1970
EXEC add_Player 'Eric Montross', 61, 213, 'C', 0, 1971
EXEC add_Player 'Dwayne Morton', 85, 201, 'C', 0, 1971
EXEC add_Player 'Lamond Murray', 68, 201, 'C', 0, 1973
EXEC add_Player 'Ivano Newbill', 70, 206, 'PG', 0, 1970
EXEC add_Player 'Julius Nwosu', 72, 208, 'PG', 0, 1971
EXEC add_Player 'Wesley Person', 85, 198, 'PG', 0, 1971
EXEC add_Player 'Derrick Phelps', 82, 193, 'PG', 0, 1972
EXEC add_Player 'Eric Piatkowski', 63, 201, 'PG', 0, 1970
EXEC add_Player 'Eldridge Recasner', 83, 190, 'PG', 0, 1967
EXEC add_Player 'Khalid Reeves', 80, 190, 'PG', 0, 1972
EXEC add_Player 'Glenn Robinson', 66, 201, 'PG', 0, 1973
EXEC add_Player 'Carlos Rogers', 64, 211, 'PG', 0, 1971
EXEC add_Player 'Jalen Rose', 62, 203, 'PG', 0, 1973
EXEC add_Player 'Clifford Rozier', 70, 211, 'PG', 0, 1972
EXEC add_Player 'Trevor Ruffin', 83, 185, 'PG', 0, 1970
EXEC add_Player 'Dickey Simpkins', 71, 206, 'PG', 0, 1972
EXEC add_Player 'Reggie Slater', 63, 201, 'PG', 0, 1970
EXEC add_Player 'Mark Strickland', 62, 206, 'PG', 0, 1970
EXEC add_Player 'Aaron Swinson', 67, 196, 'PG', 0, 1971
EXEC add_Player 'Zan Tabak', 70, 213, 'PG', 0, 1970
EXEC add_Player 'Brooks Thompson', 84, 193, 'PG', 0, 1970
EXEC add_Player 'Anthony Tucker', 64, 203, 'PG', 0, 1969
EXEC add_Player 'B.J. Tyler', 64, 203, 'PG', 0, 1969
EXEC add_Player 'Fred Vinson', 83, 193, 'SG', 0, 1971
EXEC add_Player 'Charlie Ward', 83, 188, 'SG', 0, 1970
EXEC add_Player 'Jamie Watson', 83, 201, 'SG', 0, 1972
EXEC add_Player 'Monty Williams', 66, 203, 'SG', 0, 1971
EXEC add_Player 'Dontonio Wingfield', 73, 203, 'SG', 0, 1974
EXEC add_Player 'Sharone Wright', 73, 211, 'SG', 0, 1973
EXEC add_Player 'Cory Alexander', 83, 185, 'SG', 0, 1973
EXEC add_Player 'Jerome Allen', 83, 193, 'SG', 0, 1973
EXEC add_Player 'John Amaechi', 61, 208, 'SG', 0, 1970
EXEC add_Player 'Ashraf Amaya', 67, 203, 'SG', 0, 1971
EXEC add_Player 'Brent Barry', 83, 198, 'SG', 0, 1971
EXEC add_Player 'Corey Beck', 83, 185, 'SG', 0, 1971
EXEC add_Player 'Mario Bennett', 68, 198, 'SG', 0, 1973
EXEC add_Player 'Travis Best', 82, 180, 'SG', 0, 1972
EXEC add_Player 'Melvin Booker', 83, 185, 'SG', 0, 1972
EXEC add_Player 'Donnie Boyce', 85, 196, 'SG', 0, 1973
EXEC add_Player 'Marques Bragg', 67, 203, 'SG', 0, 1970
EXEC add_Player 'Junior Burrough', 69, 203, 'SG', 0, 1973
EXEC add_Player 'Jason Caffey', 72, 203, 'SG', 0, 1973
EXEC add_Player 'Chris Carr', 83, 196, 'SG', 0, 1974
EXEC add_Player 'Randolph Childress', 85, 188, 'SF', 0, 1972
EXEC add_Player 'Robert Churchwell', 85, 198, 'SF', 0, 1972
EXEC add_Player 'Charles Claxton', 60, 213, 'SF', 0, 1970
EXEC add_Player 'John Coker', 72, 213, 'SF', 0, 1971
EXEC add_Player 'Rastko Cvetkovic', 73, 216, 'SF', 0, 1970
EXEC add_Player 'Sasha Danilovic', 80, 196, 'SF', 0, 1970
EXEC add_Player 'Andrew DeClercq', 67, 208, 'SF', 0, 1973
EXEC add_Player 'Tyus Edney', 68, 178, 'SF', 0, 1973
EXEC add_Player 'Vincenzo Esposito', 86, 190, 'SF', 0, 1969
EXEC add_Player 'Michael Finley', 63, 201, 'SF', 0, 1973
EXEC add_Player 'Sherell Ford', 62, 201, 'SF', 0, 1972
EXEC add_Player 'Kevin Garnett', 69, 211, 'SF', 0, 1976
EXEC add_Player 'Anthony Goldwire', 82, 185, 'SF', 0, 1971
EXEC add_Player 'Thomas Hamilton', 74, 218, 'SF', 0, 1975
EXEC add_Player 'Alvin Heggs', 66, 203, 'SF', 0, 1967
EXEC add_Player 'Alan Henderson', 68, 206, 'SF', 0, 1972
EXEC add_Player 'Fred Hoiberg', 82, 193, 'SF', 0, 1972
EXEC add_Player 'Darryl Johnson', 62, 201, 'SF', 0, 1970
EXEC add_Player 'Frankie King', 83, 185, 'SF', 0, 1972
EXEC add_Player 'Jimmy King', 79, 188, 'SF', 0, 1941
EXEC add_Player 'Voshon Lenard', 82, 193, 'PF', 0, 1973
EXEC add_Player 'Cedric Lewis', 68, 208, 'PF', 0, 1969
EXEC add_Player 'Martin Lewis', 62, 196, 'PF', 0, 1975
EXEC add_Player 'Rich Manning', 72, 211, 'PF', 0, 1970
EXEC add_Player 'Donny Marshall', 64, 206, 'PF', 0, 1973
EXEC add_Player 'Cuonzo Martin', 63, 196, 'PF', 0, 1971
EXEC add_Player 'Clint McDaniel', 81, 193, 'PF', 0, 1972
EXEC add_Player 'Antonio McDyess', 64, 206, 'PF', 0, 1974
EXEC add_Player 'Loren Meyer', 73, 208, 'PF', 0, 1972
EXEC add_Player 'Lawrence Moten', 83, 196, 'PF', 0, 1972
EXEC add_Player 'Todd Mundt', 71, 213, 'PF', 0, 1970
EXEC add_Player 'Howard Nathan', 79, 180, 'PF', 0, 1972
EXEC add_Player 'Ed O"Bannon', 65, 203, 'PF', 0, 1972
EXEC add_Player 'Greg Ostertag', 63, 218, 'PF', 0, 1973
EXEC add_Player 'Cherokee Parks', 62, 196, 'PF', 0, 1973
EXEC add_Player 'Theo Ratliff', 66, 208, 'PF', 0, 1973
EXEC add_Player 'Bryant Reeves', 62, 213, 'PF', 0, 1973
EXEC add_Player 'Don Reid', 71, 203, 'PF', 0, 1973
EXEC add_Player 'Terrence Rencher', 83, 190, 'PF', 0, 1973
EXEC add_Player 'Shawn Respert', 85, 185, 'PF', 0, 1972
EXEC add_Player 'Lou Roe', 64, 201, 'C', 0, 1972
EXEC add_Player 'Stefano Rusconi', 69, 206, 'C', 0, 1968
EXEC add_Player 'Arvydas Sabonis', 63, 221, 'C', 0, 1964
EXEC add_Player 'Joe Smith', 68, 213, 'C', 0, 1944
EXEC add_Player 'Eric Snow', 83, 190, 'C', 0, 1973
EXEC add_Player 'Jerry Stackhouse', 64, 198, 'C', 0, 1974
EXEC add_Player 'Damon Stoudamire', 77, 178, 'C', 0, 1973
EXEC add_Player 'Bob Sura', 80, 196, 'C', 0, 1973
EXEC add_Player 'Larry Sykes', 72, 206, 'C', 0, 1973
EXEC add_Player 'Kurt Thomas', 67, 206, 'C', 0, 1972
EXEC add_Player 'Gary Trent', 71, 203, 'C', 0, 1974
EXEC add_Player 'Logan Vander', 63, 203, 'C', 0, 1971
EXEC add_Player 'David Vaughn', 64, 211, 'C', 0, 1952
EXEC add_Player 'Rasheed Wallace', 66, 208, 'C', 0, 1974
EXEC add_Player 'Jeff Webster', 67, 203, 'C', 0, 1971
EXEC add_Player 'Dwayne Whitfield', 69, 206, 'C', 0, 1972
EXEC add_Player 'Eric Williams', 64, 203, 'C', 0, 1972
EXEC add_Player 'Corliss Williamson', 83, 188, 'C', 0, 1970
EXEC add_Player 'George Zidek', 71, 213, 'C', 0, 1973
EXEC add_Player 'Shareef Abdur-Rahim', 66, 206, 'C', 0, 1976
EXEC add_Player 'Ray Allen', 64, 203, 'PG', 0, 1965
EXEC add_Player 'Shandon Anderson', 62, 198, 'PG', 0, 1973
EXEC add_Player 'Dexter Boney', 83, 193, 'PG', 0, 1970
EXEC add_Player 'Bruce Bowen', 83, 201, 'PG', 0, 1971
EXEC add_Player 'Mark Bradtke', 60, 208, 'PG', 0, 1968
EXEC add_Player 'Marcus Brown', 83, 190, 'PG', 0, 1974
EXEC add_Player 'Kobe Bryant', 63, 198, 'PG', 0, 1978
EXEC add_Player 'Marcus Camby', 64, 211, 'PG', 0, 1974
EXEC add_Player 'Jimmy Carruth', 60, 208, 'PG', 0, 1969
EXEC add_Player 'Erick Dampier', 60, 211, 'PG', 0, 1975
EXEC add_Player 'Ben Davis', 69, 206, 'PG', 0, 1972
EXEC add_Player 'Emanual Davis', 85, 193, 'PG', 0, 1968
EXEC add_Player 'Tony Delk', 85, 185, 'PG', 0, 1974
EXEC add_Player 'Aleksandar Djordjevi', 86, 188, 'PG', 0, 1967
EXEC add_Player 'Nate Driggers', 63, 196, 'PG', 0, 1973
EXEC add_Player 'Brian Evans', 64, 203, 'PG', 0, 1973
EXEC add_Player 'Jamie Feick', 72, 206, 'PG', 0, 1974
EXEC add_Player 'Derek Fisher', 80, 185, 'PG', 0, 1974
EXEC add_Player 'Todd Fuller', 81, 193, 'PG', 0, 1958
EXEC add_Player 'Dean Garrett', 66, 208, 'PG', 0, 1966
EXEC add_Player 'Reggie Geary', 84, 188, 'SG', 0, 1973
EXEC add_Player 'Devin Gray', 69, 201, 'SG', 0, 1972
EXEC add_Player 'Evric Gray', 68, 201, 'SG', 0, 1969
EXEC add_Player 'Darvin Ham', 64, 201, 'SG', 0, 1973
EXEC add_Player 'Steve Hamer', 70, 213, 'SG', 0, 1973
EXEC add_Player 'Othella Harrington', 68, 206, 'SG', 0, 1974
EXEC add_Player 'Michael Hawkins', 80, 183, 'SG', 0, 1972
EXEC add_Player 'Shane Heal', 81, 183, 'SG', 0, 1970
EXEC add_Player 'Mark Hendrickson', 64, 206, 'SG', 0, 1974
EXEC add_Player 'Allen Iverson', 74, 183, 'SG', 0, 1975
EXEC add_Player 'Kerry Kittles', 81, 196, 'SG', 0, 1974
EXEC add_Player 'Travis Knight', 68, 213, 'SG', 0, 1974
EXEC add_Player 'Priest Lauderdale', 73, 224, 'SG', 0, 1973
EXEC add_Player 'Randy Livingston', 62, 193, 'SG', 0, 1975
EXEC add_Player 'Horacio Llamas', 64, 211, 'SG', 0, 1973
EXEC add_Player 'Matt Maloney', 84, 190, 'SG', 0, 1971
EXEC add_Player 'Stephon Marbury', 81, 188, 'SG', 0, 1977
EXEC add_Player 'Walter McCarty', 67, 208, 'SG', 0, 1974
EXEC add_Player 'Amal McCaskill', 68, 211, 'SG', 0, 1973
EXEC add_Player 'Jeff McInnis', 83, 193, 'SG', 0, 1974
EXEC add_Player 'Martin Muursepp', 68, 206, 'SF', 0, 1974
EXEC add_Player 'Steve Nash', 85, 190, 'SF', 0, 1974
EXEC add_Player 'Ruben Nembhard', 62, 190, 'SF', 0, 1972
EXEC add_Player 'Gaylon Nickerson', 83, 190, 'SF', 0, 1969
EXEC add_Player 'Moochie Norris', 79, 185, 'SF', 0, 1973
EXEC add_Player 'Jermaine O"Neal', 66, 211, 'SF', 0, 1978
EXEC add_Player 'Ray Owes', 65, 206, 'SF', 0, 1972
EXEC add_Player 'Vitaly Potapenko', 63, 208, 'SF', 0, 1975
EXEC add_Player 'Chris Robinson', 80, 196, 'SF', 0, 1974
EXEC add_Player 'Roy Rogers', 68, 201, 'SF', 0, 1971
EXEC add_Player 'Malik Rose', 71, 201, 'SF', 0, 1974
EXEC add_Player 'Kevin Salvadori', 67, 213, 'SF', 0, 1970
EXEC add_Player 'Jason Sasser', 66, 201, 'SF', 0, 1974
EXEC add_Player 'Brent Scott', 71, 208, 'SF', 0, 1971
EXEC add_Player 'James Scott', 81, 198, 'SF', 0, 1972
EXEC add_Player 'Shawnelle Scott', 71, 208, 'SF', 0, 1972
EXEC add_Player 'Stevin Smith', 80, 201, 'SF', 0, 1969
EXEC add_Player 'Matt Steigenga', 66, 201, 'SF', 0, 1970
EXEC add_Player 'Joe Stephens', 62, 201, 'SF', 0, 1973
EXEC add_Player 'Erick Strickland', 62, 190, 'SF', 0, 1973
EXEC add_Player 'Brett Szabo', 67, 211, 'PF', 0, 1968
EXEC add_Player 'Antoine Walker', 83, 193, 'PF', 0, 1955
EXEC add_Player 'Samaki Walker', 69, 206, 'PF', 0, 1976
EXEC add_Player 'Ben Wallace', 69, 206, 'PF', 0, 1974
EXEC add_Player 'John Wallace', 66, 203, 'PF', 0, 1974
EXEC add_Player 'Donald Whiteside', 72, 178, 'PF', 0, 1969
EXEC add_Player 'Jerome Williams', 83, 206, 'PF', 0, 1973
EXEC add_Player 'Lorenzen Wright', 82, 188, 'PF', 0, 1945
EXEC add_Player 'Tariq Abdul-Wahad', 65, 198, 'PF', 0, 1974
EXEC add_Player 'Derek Anderson', 84, 196, 'PF', 0, 1974
EXEC add_Player 'Chris Anstey', 71, 213, 'PF', 0, 1975
EXEC add_Player 'Drew Barry', 83, 196, 'PF', 0, 1973
EXEC add_Player 'Tony Battie', 67, 211, 'PF', 0, 1976
EXEC add_Player 'Chauncey Billups', 81, 190, 'PF', 0, 1976
EXEC add_Player 'Etdrick Bohannon', 64, 206, 'PF', 0, 1973
EXEC add_Player 'Keith Booth', 66, 198, 'PF', 0, 1974
EXEC add_Player 'Rick Brunson', 83, 193, 'PF', 0, 1972
EXEC add_Player 'Kelvin Cato', 72, 211, 'PF', 0, 1974
EXEC add_Player 'Keith Closs', 63, 221, 'PF', 0, 1976
EXEC add_Player 'James Collins', 85, 193, 'PF', 0, 1973
EXEC add_Player 'James Cotton', 80, 201, 'C', 0, 1924
EXEC add_Player 'Chris Crawford', 68, 206, 'C', 0, 1975
EXEC add_Player 'Austin Croshere', 68, 206, 'C', 0, 1975
EXEC add_Player 'William Cunningham', 71, 211, 'C', 0, 1974
EXEC add_Player 'Antonio Daniels', 85, 193, 'C', 0, 1975
EXEC add_Player 'Tim Duncan', 71, 211, 'C', 0, 1976
EXEC add_Player 'Tony Farmer', 70, 206, 'C', 0, 1970
EXEC add_Player 'Danny Fortson', 73, 201, 'C', 0, 1976
EXEC add_Player 'Adonal Foyle', 71, 208, 'C', 0, 1975
EXEC add_Player 'Lawrence Funderburke', 67, 206, 'C', 0, 1970
EXEC add_Player 'Chris Garner', 70, 178, 'C', 0, 1975
EXEC add_Player 'Kiwane Garris', 83, 188, 'C', 0, 1974
EXEC add_Player 'Ed Gray', 62, 190, 'C', 0, 1975
EXEC add_Player 'Derek Grimm', 67, 206, 'C', 0, 1974
EXEC add_Player 'Reggie Hanson', 85, 203, 'C', 0, 1968
EXEC add_Player 'Jerald Honeycutt', 70, 206, 'C', 0, 1974
EXEC add_Player 'Troy Hudson', 77, 185, 'C', 0, 1976
EXEC add_Player 'Zydrunas Ilgauskas', 68, 221, 'C', 0, 1975
EXEC add_Player 'Bobby Jackson', 83, 185, 'C', 0, 1973
EXEC add_Player 'Anthony Johnson', 63, 196, 'C', 0, 1932
EXEC add_Player 'Dontae" Jones', 64, 203, 'PG', 0, 1975
EXEC add_Player 'Brevin Knight', 78, 178, 'PG', 0, 1975
EXEC add_Player 'Rusty LaRue', 62, 188, 'PG', 0, 1973
EXEC add_Player 'Jason Lawson', 69, 211, 'PG', 0, 1974
EXEC add_Player 'Michael McDonald', 67, 208, 'PG', 0, 1969
EXEC add_Player 'Tracy McGrady', 62, 203, 'PG', 0, 1979
EXEC add_Player 'Ron Mercer', 62, 201, 'PG', 0, 1976
EXEC add_Player 'Marko Milic', 68, 198, 'PG', 0, 1977
EXEC add_Player 'Jeff Nordgaard', 66, 201, 'PG', 0, 1973
EXEC add_Player 'Charles O"Bannon', 62, 196, 'PG', 0, 1975
EXEC add_Player 'Kevin Ollie', 85, 193, 'PG', 0, 1972
EXEC add_Player 'Anthony Parker', 63, 198, 'PG', 0, 1975
EXEC add_Player 'Scot Pollard', 60, 211, 'PG', 0, 1975
EXEC add_Player 'Mark Pope', 68, 208, 'PG', 0, 1972
EXEC add_Player 'Rodrick Rhodes', 66, 198, 'PG', 0, 1973
EXEC add_Player 'Shea Seals', 62, 196, 'PG', 0, 1975
EXEC add_Player 'God Shammgod', 76, 183, 'PG', 0, 1976
EXEC add_Player 'Kebu Stewart', 69, 203, 'PG', 0, 1973
EXEC add_Player 'Michael Stewart', 67, 208, 'PG', 0, 1975
EXEC add_Player 'Ed Stokes', 74, 213, 'PG', 0, 1971
EXEC add_Player 'Johnny Taylor', 64, 206, 'SG', 0, 1974
EXEC add_Player 'Maurice Taylor', 73, 206, 'SG', 0, 1976
EXEC add_Player 'John Thomas', 82, 198, 'SG', 0, 1948
EXEC add_Player 'Tim Thomas', 67, 208, 'SG', 0, 1977
EXEC add_Player 'Keith Van', 67, 208, 'SG', 0, 1977
EXEC add_Player 'Jacque Vaughn', 83, 185, 'SG', 0, 1975
EXEC add_Player 'Eric Washington', 83, 193, 'SG', 0, 1974
EXEC add_Player 'Bubba Wells', 67, 196, 'SG', 0, 1974
EXEC add_Player 'DeJuan Wheat', 74, 183, 'SG', 0, 1973
EXEC add_Player 'Alvin Williams', 80, 198, 'SG', 0, 1948
EXEC add_Player 'Brandon Williams', 63, 198, 'SG', 0, 1975
EXEC add_Player 'Travis Williams', 63, 198, 'SG', 0, 1969
EXEC add_Player 'Peter Aluma', 73, 208, 'SG', 0, 1973
EXEC add_Player 'Toby Bailey', 63, 198, 'SG', 0, 1975
EXEC add_Player 'LaMark Baker', 79, 185, 'SG', 0, 1969
EXEC add_Player 'Corey Benjamin', 80, 198, 'SG', 0, 1978
EXEC add_Player 'Mike Bibby', 83, 185, 'SG', 0, 1978
EXEC add_Player 'Earl Boykins', 61, 165, 'SG', 0, 1976
EXEC add_Player 'Gerald Brown', 83, 198, 'SG', 0, 1935
EXEC add_Player 'Cory Carr', 62, 190, 'SG', 0, 1975
EXEC add_Player 'Vince Carter', 64, 198, 'SF', 0, 1977
EXEC add_Player 'Keon Clark', 64, 211, 'SF', 0, 1975
EXEC add_Player 'Kornel David', 68, 206, 'SF', 0, 1971
EXEC add_Player 'Ricky Davis', 85, 198, 'SF', 0, 1979
EXEC add_Player 'Michael Dickerson', 83, 196, 'SF', 0, 1975
EXEC add_Player 'Michael Doleac', 74, 211, 'SF', 0, 1977
EXEC add_Player 'Bryce Drew', 83, 188, 'SF', 0, 1974
EXEC add_Player 'Marlon Garnett', 84, 188, 'SF', 0, 1975
EXEC add_Player 'Pat Garrity', 68, 206, 'SF', 0, 1976
EXEC add_Player 'Paul Grant', 70, 213, 'SF', 0, 1974
EXEC add_Player 'Matt Harpring', 67, 201, 'SF', 0, 1976
EXEC add_Player 'Al Harrington', 67, 206, 'SF', 0, 1980
EXEC add_Player 'J.R. Henderson', 67, 206, 'SF', 0, 1980
EXEC add_Player 'Larry Hughes', 83, 196, 'SF', 0, 1979
EXEC add_Player 'Randell Jackson', 83, 188, 'SF', 0, 1962
EXEC add_Player 'Sam Jacobson', 63, 193, 'SF', 0, 1975
EXEC add_Player 'Jerome James', 68, 213, 'SF', 0, 1975
EXEC add_Player 'Antawn Jamison', 65, 203, 'SF', 0, 1976
EXEC add_Player 'Damon Jones', 83, 190, 'SF', 0, 1976
EXEC add_Player 'Jonathan Kerner', 70, 211, 'SF', 0, 1974
EXEC add_Player 'Gerard King', 79, 183, 'PF', 0, 1928
EXEC add_Player 'Raef LaFrentz', 69, 211, 'PF', 0, 1976
EXEC add_Player 'Rashard Lewis', 80, 198, 'PF', 0, 1963
EXEC add_Player 'Felipe Lopez', 80, 196, 'PF', 0, 1974
EXEC add_Player 'Tyronn Lue', 79, 183, 'PF', 0, 1977
EXEC add_Player 'Sean Marks', 71, 208, 'PF', 0, 1975
EXEC add_Player 'Kelly McCarty', 80, 201, 'PF', 0, 1975
EXEC add_Player 'Jelani McCoy', 70, 208, 'PF', 0, 1977
EXEC add_Player 'Roshown McLeod', 65, 203, 'PF', 0, 1975
EXEC add_Player 'Brad Miller', 70, 211, 'PF', 0, 1976
EXEC add_Player 'Cuttino Mobley', 83, 193, 'PF', 0, 1975
EXEC add_Player 'Nazr Mohammed', 65, 208, 'PF', 0, 1977
EXEC add_Player 'Mikki Moore', 66, 211, 'PF', 0, 1975
EXEC add_Player 'Makhtar N"Diaye', 70, 203, 'PF', 0, 1973
EXEC add_Player 'Tyrone Nesby', 66, 198, 'PF', 0, 1976
EXEC add_Player 'Rasho Nesterovic', 71, 213, 'PF', 0, 1976
EXEC add_Player 'Dirk Nowitzki', 70, 213, 'PF', 0, 1978
EXEC add_Player 'Michael Olowokandi', 61, 213, 'PF', 0, 1975
EXEC add_Player 'Andrae Patterson', 68, 206, 'PF', 0, 1975
EXEC add_Player 'Ruben Patterson', 65, 196, 'PF', 0, 1975
EXEC add_Player 'Paul Pierce', 68, 201, 'C', 0, 1977
EXEC add_Player 'Casey Shaw', 73, 211, 'C', 0, 1975
EXEC add_Player 'Jeffrey Sheppard', 83, 190, 'C', 0, 1974
EXEC add_Player 'Miles Simon', 81, 190, 'C', 0, 1975
EXEC add_Player 'Alvin Sims', 68, 193, 'C', 0, 1974
EXEC add_Player 'Brian Skinner', 72, 206, 'C', 0, 1976
EXEC add_Player 'Ryan Stack', 63, 211, 'C', 0, 1975
EXEC add_Player 'Vladimir Stepania', 68, 213, 'C', 0, 1976
EXEC add_Player 'Peja Stojakovic', 64, 206, 'C', 0, 1977
EXEC add_Player 'Bruno Sundov', 64, 218, 'C', 0, 1980
EXEC add_Player 'Robert Traylor', 64, 203, 'C', 0, 1977
EXEC add_Player 'Bonzi Wells', 62, 196, 'C', 0, 1976
EXEC add_Player 'Tyson Wheeler', 74, 178, 'C', 0, 1975
EXEC add_Player 'Jahidi White', 65, 206, 'C', 0, 1976
EXEC add_Player 'Jason Williams', 69, 206, 'C', 0, 1968
EXEC add_Player 'Shammond Williams', 81, 185, 'C', 0, 1975
EXEC add_Player 'Trevor Winter', 62, 213, 'C', 0, 1974
EXEC add_Player 'Korleone Young', 63, 201, 'C', 0, 1978
EXEC add_Player 'Rafer Alston', 77, 188, 'C', 0, 1976
EXEC add_Player 'Chucky Atkins', 72, 180, 'C', 0, 1974
EXEC add_Player 'William Avery', 86, 188, 'PG', 0, 1979
EXEC add_Player 'Jonathan Bender', 81, 211, 'PG', 0, 1981
EXEC add_Player 'Calvin Booth', 67, 211, 'PG', 0, 1976
EXEC add_Player 'Lazaro Borrell', 64, 203, 'PG', 0, 1972
EXEC add_Player 'Cal Bowdler', 70, 208, 'PG', 0, 1977
EXEC add_Player 'Ryan Bowen', 63, 201, 'PG', 0, 1975
EXEC add_Player 'Ira Bowman', 85, 196, 'PG', 0, 1973
EXEC add_Player 'A.J. Bramlett', 85, 196, 'PG', 0, 1973
EXEC add_Player 'Elton Brand', 62, 203, 'PG', 0, 1979
EXEC add_Player 'Greg Buckner', 62, 193, 'PG', 0, 1976
EXEC add_Player 'Rodney Buford', 85, 196, 'PG', 0, 1977
EXEC add_Player 'Anthony Carter', 83, 185, 'PG', 0, 1975
EXEC add_Player 'John Celestand', 80, 193, 'PG', 0, 1977
EXEC add_Player 'Vonteego Cummings', 83, 190, 'PG', 0, 1976
EXEC add_Player 'Baron Davis', 62, 190, 'PG', 0, 1979
EXEC add_Player 'Derrick Dial', 83, 193, 'PG', 0, 1975
EXEC add_Player 'Obinna Ekezie', 61, 206, 'PG', 0, 1975
EXEC add_Player 'Evan Eschmeyer', 72, 211, 'PG', 0, 1975
EXEC add_Player 'Jeff Foster', 68, 211, 'PG', 0, 1977
EXEC add_Player 'Steve Francis', 85, 190, 'PG', 0, 1977
EXEC add_Player 'Devean George', 64, 203, 'SG', 0, 1977
EXEC add_Player 'Dion Glover', 66, 196, 'SG', 0, 1978
EXEC add_Player 'Adrian Griffin', 64, 196, 'SG', 0, 1974
EXEC add_Player 'Richard Hamilton', 83, 198, 'SG', 0, 1978
EXEC add_Player 'Chris Herren', 86, 188, 'SG', 0, 1975
EXEC add_Player 'Derek Hood', 65, 203, 'SG', 0, 1976
EXEC add_Player 'Rick Hughes', 63, 196, 'SG', 0, 1962
EXEC add_Player 'Jermaine Jackson', 82, 193, 'SG', 0, 1976
EXEC add_Player 'Tim James', 63, 201, 'SG', 0, 1976
EXEC add_Player 'Harold Jamison', 73, 203, 'SG', 0, 1976
EXEC add_Player 'DeMarco Johnson', 83, 193, 'SG', 0, 1954
EXEC add_Player 'Jumaine Jones', 64, 203, 'SG', 0, 1979
EXEC add_Player 'Lari Ketner', 62, 206, 'SG', 0, 1977
EXEC add_Player 'Trajan Langdon', 86, 190, 'SG', 0, 1976
EXEC add_Player 'Quincy Lewis', 63, 201, 'SG', 0, 1977
EXEC add_Player 'Todd MacCulloch', 63, 213, 'SG', 0, 1976
EXEC add_Player 'Corey Maggette', 64, 198, 'SG', 0, 1979
EXEC add_Player 'Shawn Marion', 64, 201, 'SG', 0, 1978
EXEC add_Player 'Andre Miller', 66, 206, 'SG', 0, 1971
EXEC add_Player 'Jason Miskiri', 79, 188, 'SG', 0, 1975
EXEC add_Player 'Lamar Odom', 64, 208, 'SF', 0, 1979
EXEC add_Player 'Scott Padgett', 69, 206, 'SF', 0, 1976
EXEC add_Player 'Milt Palacio', 85, 190, 'SF', 0, 1978
EXEC add_Player 'James Posey', 63, 203, 'SF', 0, 1977
EXEC add_Player 'Laron Profit', 82, 196, 'SF', 0, 1977
EXEC add_Player 'Aleksandar Radojevic', 71, 221, 'SF', 0, 1976
EXEC add_Player 'Ryan Robertson', 83, 196, 'SF', 0, 1976
EXEC add_Player 'Eddie Robinson', 62, 203, 'SF', 0, 1976
EXEC add_Player 'Michael Ruffin', 70, 206, 'SF', 0, 1977
EXEC add_Player 'Wally Szczerbiak', 62, 198, 'SF', 0, 1949
EXEC add_Player 'Jason Terry', 83, 188, 'SF', 0, 1977
EXEC add_Player 'Jamel Thomas', 63, 198, 'SF', 0, 1973
EXEC add_Player 'Kenny Thomas', 74, 201, 'SF', 0, 1977
EXEC add_Player 'Mirsad Turkcan', 68, 206, 'SF', 0, 1976
EXEC add_Player 'Wayne Turner', 83, 188, 'SF', 0, 1976
EXEC add_Player 'Dedric Willoughby', 81, 190, 'SF', 0, 1974
EXEC add_Player 'Metta World', 81, 190, 'SF', 0, 1974
EXEC add_Player 'Tim Young', 64, 213, 'SF', 0, 1976
EXEC add_Player 'Courtney Alexander', 83, 185, 'SF', 0, 1973
EXEC add_Player 'Dalibor Bagaric', 72, 216, 'SF', 0, 1980
EXEC add_Player 'Erick Barkley', 80, 185, 'PF', 0, 1978
EXEC add_Player 'Raja Bell', 82, 196, 'PF', 0, 1976
EXEC add_Player 'Mark Blount', 67, 213, 'PF', 0, 1975
EXEC add_Player 'Brian Cardinal', 70, 203, 'PF', 0, 1977
EXEC add_Player 'Mateen Cleaves', 82, 188, 'PF', 0, 1977
EXEC add_Player 'Jason Collier', 85, 193, 'PF', 0, 1973
EXEC add_Player 'Sean Colson', 79, 183, 'PF', 0, 1975
EXEC add_Player 'Jamal Crawford', 80, 196, 'PF', 0, 1980
EXEC add_Player 'Keyon Dooling', 85, 190, 'PF', 0, 1980
EXEC add_Player 'Khalid El-Amin', 80, 178, 'PF', 0, 1979
EXEC add_Player 'Marcus Fizer', 74, 206, 'PF', 0, 1978
EXEC add_Player 'Ruben Garces', 70, 206, 'PF', 0, 1973
EXEC add_Player 'Eddie Gill', 83, 183, 'PF', 0, 1978
EXEC add_Player 'Steve Goodrich', 64, 208, 'PF', 0, 1976
EXEC add_Player 'A.J. Guyton', 64, 208, 'PF', 0, 1976
EXEC add_Player 'Zendon Hamilton', 71, 211, 'PF', 0, 1975
EXEC add_Player 'Jason Hart', 83, 190, 'PF', 0, 1978
EXEC add_Player 'Donnell Harvey', 64, 203, 'PF', 0, 1980
EXEC add_Player 'Eddie House', 81, 185, 'PF', 0, 1978
EXEC add_Player 'Marc Jackson', 81, 185, 'PF', 0, 1965
EXEC add_Player 'Stephen Jackson', 83, 190, 'C', 0, 1970
EXEC add_Player 'DerMarr Johnson', 83, 193, 'C', 0, 1954
EXEC add_Player 'Garth Joseph', 71, 218, 'C', 0, 1973
EXEC add_Player 'Dan Langhi', 64, 211, 'C', 0, 1977
EXEC add_Player 'Art Long', 71, 206, 'C', 0, 1972
EXEC add_Player 'Mark Madsen', 69, 206, 'C', 0, 1976
EXEC add_Player 'Jamaal Magloire', 73, 211, 'C', 0, 1978
EXEC add_Player 'Kenyon Martin', 68, 206, 'C', 0, 1977
EXEC add_Player 'Desmond Mason', 65, 201, 'C', 0, 1977
EXEC add_Player 'Dan McClintock', 61, 213, 'C', 0, 1977
EXEC add_Player 'Paul McPherson', 62, 193, 'C', 0, 1978
EXEC add_Player 'Stanislav Medvedenko', 71, 208, 'C', 0, 1979
EXEC add_Player 'Chris Mihm', 60, 213, 'C', 0, 1979
EXEC add_Player 'Darius Miles', 62, 206, 'C', 0, 1981
EXEC add_Player 'Mike Miller', 64, 203, 'C', 0, 1980
EXEC add_Player 'Jerome Moiso', 68, 208, 'C', 0, 1978
EXEC add_Player 'Hanno Mottola', 71, 211, 'C', 0, 1976
EXEC add_Player 'Mamadou N"Diaye', 70, 203, 'C', 0, 1973
EXEC add_Player 'Lee Nailon', 68, 206, 'C', 0, 1975
EXEC add_Player 'Eduardo Najera', 69, 203, 'C', 0, 1976
EXEC add_Player 'Ira Newble', 64, 201, 'PG', 0, 1975
EXEC add_Player 'Olumide Oyedeji', 69, 208, 'PG', 0, 1981
EXEC add_Player 'Andy Panko', 65, 206, 'PG', 0, 1977
EXEC add_Player 'Mike Penberthy', 83, 190, 'PG', 0, 1974
EXEC add_Player 'Morris Peterson', 64, 201, 'PG', 0, 1977
EXEC add_Player 'Chris Porter', 64, 201, 'PG', 0, 1978
EXEC add_Player 'Lavor Postell', 63, 196, 'PG', 0, 1978
EXEC add_Player 'Joel Przybilla', 72, 216, 'PG', 0, 1979
EXEC add_Player 'Michael Redd', 64, 198, 'PG', 0, 1979
EXEC add_Player 'Quentin Richardson', 65, 198, 'PG', 0, 1980
EXEC add_Player 'Terrance Roberson', 63, 201, 'PG', 0, 1976
EXEC add_Player 'Jamal Robinson', 62, 198, 'PG', 0, 1955
EXEC add_Player 'Soumaila Samake', 67, 213, 'PG', 0, 1978
EXEC add_Player 'Pepe Sanchez', 85, 193, 'PG', 0, 1977
EXEC add_Player 'Daniel Santiago', 73, 216, 'PG', 0, 1976
EXEC add_Player 'Jabari Smith', 71, 211, 'PG', 0, 1977
EXEC add_Player 'Mike Smith', 66, 208, 'PG', 0, 1965
EXEC add_Player 'DeShawn Stevenson', 62, 196, 'PG', 0, 1981
EXEC add_Player 'Stromile Swift', 66, 206, 'PG', 0, 1979
EXEC add_Player 'Dragan Tarlac', 73, 208, 'PG', 0, 1973
EXEC add_Player 'Jake Tsakalidis', 64, 218, 'SG', 0, 1979
EXEC add_Player 'Hedo Turkoglu', 64, 208, 'SG', 0, 1979
EXEC add_Player 'David Vanterpool', 80, 196, 'SG', 0, 1973
EXEC add_Player 'Jake Voskuhl', 70, 211, 'SG', 0, 1977
EXEC add_Player 'Ruben Wolkowyski', 61, 208, 'SG', 0, 1973
EXEC add_Player 'Wang Zhizhi', 72, 213, 'SG', 0, 1977
EXEC add_Player 'Malik Allen', 72, 208, 'SG', 0, 1978
EXEC add_Player 'Chris Andersen', 70, 208, 'SG', 0, 1978
EXEC add_Player 'Gilbert Arenas', 83, 190, 'SG', 0, 1982
EXEC add_Player 'Brandon Armstrong', 85, 196, 'SG', 0, 1980
EXEC add_Player 'Carlos Arroyo', 81, 188, 'SG', 0, 1979
EXEC add_Player 'Mengke Bateer', 65, 211, 'SG', 0, 1975
EXEC add_Player 'Shane Battier', 64, 203, 'SG', 0, 1978
EXEC add_Player 'Charlie Bell', 80, 190, 'SG', 0, 1979
EXEC add_Player 'Ruben Boumtje-Boumtj', 73, 213, 'SG', 0, 1978
EXEC add_Player 'Michael Bradley', 70, 208, 'SG', 0, 1979
EXEC add_Player 'Jamison Brewer', 83, 193, 'SG', 0, 1980
EXEC add_Player 'Primoz Brezec', 72, 218, 'SG', 0, 1979
EXEC add_Player 'Damone Brown', 79, 188, 'SG', 0, 1923
EXEC add_Player 'Ernest Brown', 70, 213, 'SG', 0, 1979
EXEC add_Player 'Kedrick Brown', 65, 201, 'SF', 0, 1981
EXEC add_Player 'Kwame Brown', 61, 211, 'SF', 0, 1982
EXEC add_Player 'Tierre Brown', 85, 188, 'SF', 0, 1979
EXEC add_Player 'Tyson Chandler', 69, 216, 'SF', 0, 1982
EXEC add_Player 'Speedy Claxton', 75, 180, 'SF', 0, 1978
EXEC add_Player 'Jarron Collins', 85, 193, 'SF', 0, 1973
EXEC add_Player 'Jason Collins', 85, 193, 'SF', 0, 1973
EXEC add_Player 'Joe Crispin', 83, 183, 'SF', 0, 1979
EXEC add_Player 'Eddy Curry', 66, 213, 'SF', 0, 1982
EXEC add_Player 'Samuel Dalembert', 72, 211, 'SF', 0, 1981
EXEC add_Player 'DeSagana Diop', 68, 213, 'SF', 0, 1982
EXEC add_Player 'Predrag Drobnjak', 61, 211, 'SF', 0, 1975
EXEC add_Player 'Maurice Evans', 64, 196, 'SF', 0, 1978
EXEC add_Player 'Isaac Fontaine', 62, 193, 'SF', 0, 1975
EXEC add_Player 'Alton Ford', 83, 185, 'SF', 0, 1971
EXEC add_Player 'Joseph Forte', 84, 193, 'SF', 0, 1981
EXEC add_Player 'Antonis Fotsis', 64, 208, 'SF', 0, 1981
EXEC add_Player 'Tremaine Fowlkes', 64, 203, 'SF', 0, 1976
EXEC add_Player 'Pau Gasol', 71, 213, 'SF', 0, 1980
EXEC add_Player 'Eddie Griffin', 64, 208, 'SF', 0, 1982
EXEC add_Player 'Tang Hamilton', 64, 203, 'PF', 0, 1978
EXEC add_Player 'Trenton Hassell', 80, 196, 'PF', 0, 1979
EXEC add_Player 'Kirk Haston', 69, 206, 'PF', 0, 1979
EXEC add_Player 'Brendan Haywood', 60, 213, 'PF', 0, 1979
EXEC add_Player 'Steven Hunter', 64, 213, 'PF', 0, 1981
EXEC add_Player 'Mike James', 85, 188, 'PF', 0, 1975
EXEC add_Player 'Richard Jefferson', 67, 201, 'PF', 0, 1980
EXEC add_Player 'Joe Johnson', 80, 201, 'PF', 0, 1947
EXEC add_Player 'Alvin Jones', 60, 211, 'PF', 0, 1978
EXEC add_Player 'Andrei Kirilenko', 64, 206, 'PF', 0, 1981
EXEC add_Player 'Terence Morris', 65, 206, 'PF', 0, 1979
EXEC add_Player 'Troy Murphy', 70, 211, 'PF', 0, 1980
EXEC add_Player 'Dean Oliver', 81, 180, 'PF', 0, 1978
EXEC add_Player 'Tony Parker', 83, 188, 'PF', 0, 1982
EXEC add_Player 'Vladimir Radmanovic', 66, 208, 'PF', 0, 1980
EXEC add_Player 'Zach Randolph', 73, 206, 'PF', 0, 1981
EXEC add_Player 'Zeljko Rebraca', 73, 213, 'PF', 0, 1972
EXEC add_Player 'Jason Richardson', 64, 198, 'PF', 0, 1981
EXEC add_Player 'Norm Richardson', 83, 196, 'PF', 0, 1979
EXEC add_Player 'Jeryl Sasser', 80, 198, 'PF', 0, 1979
EXEC add_Player 'Kenny Satterfield', 84, 188, 'C', 0, 1981
EXEC add_Player 'Brian Scalabrine', 69, 206, 'C', 0, 1978
EXEC add_Player 'Ansu Sesay', 66, 206, 'C', 0, 1976
EXEC add_Player 'Bobby Simmons', 62, 201, 'C', 0, 1980
EXEC add_Player 'Leon Smith', 68, 208, 'C', 0, 1980
EXEC add_Player 'Will Solomon', 83, 185, 'C', 0, 1978
EXEC add_Player 'Etan Thomas', 73, 206, 'C', 0, 1978
EXEC add_Player 'Jamaal Tinsley', 85, 190, 'C', 0, 1978
EXEC add_Player 'Oscar Torres', 62, 198, 'C', 0, 1976
EXEC add_Player 'Jeff Trepagnier', 80, 193, 'C', 0, 1979
EXEC add_Player 'Ratko Varda', 73, 216, 'C', 0, 1979
EXEC add_Player 'Gerald Wallace', 63, 201, 'C', 0, 1982
EXEC add_Player 'Earl Watson', 85, 185, 'C', 0, 1979
EXEC add_Player 'Rodney White', 62, 203, 'C', 0, 1959
EXEC add_Player 'Loren Woods', 70, 216, 'C', 0, 1978
EXEC add_Player 'Robert Archibald', 71, 211, 'C', 0, 1980
EXEC add_Player 'Maceo Baston', 63, 206, 'C', 0, 1975
EXEC add_Player 'Mike Batiste', 66, 203, 'C', 0, 1977
EXEC add_Player 'Lonny Baxter', 73, 203, 'C', 0, 1979
EXEC add_Player 'Carlos Boozer', 73, 206, 'C', 0, 1981
EXEC add_Player 'J.R. Bremer', 73, 206, 'PG', 0, 1981
EXEC add_Player 'Devin Brown', 72, 185, 'PG', 0, 1968
EXEC add_Player 'Pat Burke', 71, 211, 'PG', 0, 1973
EXEC add_Player 'Caron Butler', 66, 201, 'PG', 0, 1980
EXEC add_Player 'Rasual Butler', 63, 201, 'PG', 0, 1979
EXEC add_Player 'Dan Dickau', 83, 183, 'PG', 0, 1978
EXEC add_Player 'Juan Dixon', 74, 190, 'PG', 0, 1978
EXEC add_Player 'Melvin Ely', 73, 208, 'PG', 0, 1978
EXEC add_Player 'Reggie Evans', 70, 203, 'PG', 0, 1980
EXEC add_Player 'Dan Gadzuric', 69, 211, 'PG', 0, 1978
EXEC add_Player 'Manu Ginobili', 82, 198, 'PG', 0, 1977
EXEC add_Player 'Gordan Giricek', 62, 198, 'PG', 0, 1977
EXEC add_Player 'Drew Gooden', 71, 208, 'PG', 0, 1981
EXEC add_Player 'Marcus Haislip', 67, 208, 'PG', 0, 1980
EXEC add_Player 'Adam Harrington', 80, 196, 'PG', 0, 1980
EXEC add_Player 'Junior Harrington', 81, 193, 'PG', 0, 1980
EXEC add_Player 'Juaquin Hawkins', 64, 201, 'PG', 0, 1973
EXEC add_Player 'Nene Hilario', 71, 211, 'PG', 0, 1982
EXEC add_Player 'Nate Huffman', 70, 216, 'PG', 0, 1975
EXEC add_Player 'Ryan Humphrey', 68, 203, 'PG', 0, 1979
EXEC add_Player 'Casey Jacobsen', 63, 198, 'SG', 0, 1981
EXEC add_Player 'Marko Jaric', 86, 201, 'SG', 0, 1978
EXEC add_Player 'Chris Jefferies', 66, 203, 'SG', 0, 1980
EXEC add_Player 'Jared Jeffries', 67, 211, 'SG', 0, 1981
EXEC add_Player 'Fred Jones', 62, 193, 'SG', 0, 1979
EXEC add_Player 'Sean Lampley', 66, 201, 'SG', 0, 1979
EXEC add_Player 'Tito Maddox', 83, 193, 'SG', 0, 1981
EXEC add_Player 'Roger Mason', 80, 196, 'SG', 0, 1980
EXEC add_Player 'Yao Ming', 70, 229, 'SG', 0, 1980
EXEC add_Player 'Ronald Murray', 83, 193, 'SG', 0, 1979
EXEC add_Player 'Bostjan Nachbar', 65, 206, 'SG', 0, 1980
EXEC add_Player 'Mehmet Okur', 71, 211, 'SG', 0, 1979
EXEC add_Player 'Chris Owens', 70, 201, 'SG', 0, 1979
EXEC add_Player 'Jannero Pargo', 79, 185, 'SG', 0, 1979
EXEC add_Player 'Smush Parker', 83, 193, 'SG', 0, 1981
EXEC add_Player 'Tayshaun Prince', 63, 206, 'SG', 0, 1980
EXEC add_Player 'Igor Rakocevic', 83, 190, 'SG', 0, 1978
EXEC add_Player 'Efthimi Rentzias', 71, 211, 'SG', 0, 1976
EXEC add_Player 'Antoine Rigaudeau', 62, 201, 'SG', 0, 1971
EXEC add_Player 'Guy Rucker', 60, 211, 'SG', 0, 1977
EXEC add_Player 'Kareem Rush', 63, 198, 'SF', 0, 1980
EXEC add_Player 'John Salmons', 62, 201, 'SF', 0, 1979
EXEC add_Player 'Jamal Sampson', 68, 211, 'SF', 0, 1983
EXEC add_Player 'Predrag Savovic', 66, 198, 'SF', 0, 1976
EXEC add_Player 'Paul Shirley', 67, 208, 'SF', 0, 1977
EXEC add_Player 'Tamar Slay', 63, 203, 'SF', 0, 1980
EXEC add_Player 'Amar"e Stoudemire', 70, 208, 'SF', 0, 1982
EXEC add_Player 'Cezary Trybanski', 69, 218, 'SF', 0, 1979
EXEC add_Player 'Nikoloz Tskitishvili', 66, 213, 'SF', 0, 1983
EXEC add_Player 'Dajuan Wagner', 77, 183, 'SF', 0, 1922
EXEC add_Player 'Jiri Welsch', 62, 201, 'SF', 0, 1980
EXEC add_Player 'Chris Wilcox', 65, 208, 'SF', 0, 1982
EXEC add_Player 'Mike Wilks', 83, 178, 'SF', 0, 1979
EXEC add_Player 'Frank Williams', 83, 193, 'SF', 0, 1956
EXEC add_Player 'Jay Williams', 69, 206, 'SF', 0, 1968
EXEC add_Player 'Qyntel Woods', 65, 203, 'SF', 0, 1981
EXEC add_Player 'Vincent Yarbrough', 62, 201, 'SF', 0, 1981
EXEC add_Player 'Carmelo Anthony', 69, 203, 'SF', 0, 1984
EXEC add_Player 'Marcus Banks', 80, 188, 'SF', 0, 1981
EXEC add_Player 'Leandro Barbosa', 84, 190, 'SF', 0, 1982
EXEC add_Player 'Matt Barnes', 62, 203, 'PF', 0, 1952
EXEC add_Player 'Jerome Beasley', 68, 208, 'PF', 0, 1980
EXEC add_Player 'Troy Bell', 81, 185, 'PF', 0, 1980
EXEC add_Player 'Steve Blake', 78, 190, 'PF', 0, 1980
EXEC add_Player 'Keith Bogans', 63, 196, 'PF', 0, 1980
EXEC add_Player 'Curtis Borchardt', 69, 213, 'PF', 0, 1980
EXEC add_Player 'Chris Bosh', 68, 211, 'PF', 0, 1984
EXEC add_Player 'Torraye Braggs', 70, 203, 'PF', 0, 1976
EXEC add_Player 'Zarko Cabarkapa', 68, 211, 'PF', 0, 1981
EXEC add_Player 'Matt Carroll', 63, 198, 'PF', 0, 1980
EXEC add_Player 'Maurice Carter', 62, 196, 'PF', 0, 1976
EXEC add_Player 'Brian Cook', 68, 206, 'PF', 0, 1980
EXEC add_Player 'Omar Cook', 83, 185, 'PF', 0, 1982
EXEC add_Player 'Marquis Daniels', 80, 198, 'PF', 0, 1981
EXEC add_Player 'Josh Davis', 77, 188, 'PF', 0, 1955
EXEC add_Player 'Boris Diaw', 71, 203, 'PF', 0, 1982
EXEC add_Player 'Kaniel Dickens', 63, 203, 'PF', 0, 1978
EXEC add_Player 'Ronald Dupree', 62, 201, 'PF', 0, 1981
EXEC add_Player 'Ndudi Ebi', 80, 206, 'PF', 0, 1984
EXEC add_Player 'Francisco Elson', 68, 213, 'PF', 0, 1976
EXEC add_Player 'Desmond Ferguson', 82, 201, 'C', 0, 1977
EXEC add_Player 'T.J. Ford', 82, 201, 'C', 0, 1977
EXEC add_Player 'Richie Frahm', 62, 196, 'C', 0, 1977
EXEC add_Player 'Hiram Fuller', 69, 206, 'C', 0, 1981
EXEC add_Player 'Reece Gaines', 82, 198, 'C', 0, 1981
EXEC add_Player 'Alex Garcia', 64, 190, 'C', 0, 1980
EXEC add_Player 'Willie Green', 80, 193, 'C', 0, 1981
EXEC add_Player 'Ben Handlogten', 69, 208, 'C', 0, 1973
EXEC add_Player 'Travis Hansen', 82, 198, 'C', 0, 1978
EXEC add_Player 'Udonis Haslem', 68, 203, 'C', 0, 1980
EXEC add_Player 'Jarvis Hayes', 64, 201, 'C', 0, 1981
EXEC add_Player 'Kirk Hinrich', 83, 193, 'C', 0, 1981
EXEC add_Player 'Josh Howard', 62, 201, 'C', 0, 1980
EXEC add_Player 'Brandon Hunter', 73, 201, 'C', 0, 1980
EXEC add_Player 'LeBron James', 71, 203, 'C', 0, 1984
EXEC add_Player 'Britton Johnsen', 62, 208, 'C', 0, 1979
EXEC add_Player 'Linton Johnson', 82, 203, 'C', 0, 1980
EXEC add_Player 'Dahntay Jones', 83, 190, 'C', 0, 1976
EXEC add_Player 'James Jones', 81, 190, 'C', 0, 1949
EXEC add_Player 'Chris Kaman', 60, 213, 'C', 0, 1982
EXEC add_Player 'Jason Kapono', 63, 203, 'PG', 0, 1981
EXEC add_Player 'Kyle Korver', 63, 201, 'PG', 0, 1981
EXEC add_Player 'Maciej Lampe', 62, 211, 'PG', 0, 1985
EXEC add_Player 'Raul Lopez', 77, 185, 'PG', 0, 1980
EXEC add_Player 'Keith McLeod', 85, 188, 'PG', 0, 1979
EXEC add_Player 'Darko Milicic', 71, 213, 'PG', 0, 1985
EXEC add_Player 'Travis Outlaw', 62, 206, 'PG', 0, 1984
EXEC add_Player 'Zaza Pachulia', 61, 211, 'PG', 0, 1984
EXEC add_Player 'Sasha Pavlovic', 61, 211, 'PG', 0, 1984
EXEC add_Player 'Desmond Penigar', 70, 201, 'PG', 0, 1981
EXEC add_Player 'Kirk Penney', 64, 196, 'PG', 0, 1980
EXEC add_Player 'Kendrick Perkins', 61, 208, 'PG', 0, 1984
EXEC add_Player 'Mickael Pietrus', 63, 198, 'PG', 0, 1982
EXEC add_Player 'Zoran Planinic', 85, 201, 'PG', 0, 1982
EXEC add_Player 'Luke Ridnour', 79, 188, 'PG', 0, 1981
EXEC add_Player 'Theron Smith', 66, 203, 'PG', 0, 1980
EXEC add_Player 'Darius Songaila', 71, 206, 'PG', 0, 1978
EXEC add_Player 'Mike Sweetney', 62, 203, 'PG', 0, 1982
EXEC add_Player 'Ime Udoka', 63, 198, 'PG', 0, 1977
EXEC add_Player 'Slavko Vranes', 62, 226, 'PG', 0, 1983
EXEC add_Player 'Dwyane Wade', 64, 193, 'SG', 0, 1982
EXEC add_Player 'Luke Walton', 68, 203, 'SG', 0, 1980
EXEC add_Player 'David West', 71, 206, 'SG', 0, 1980
EXEC add_Player 'Mo Williams', 66, 203, 'SG', 0, 1971
EXEC add_Player 'Tony Allen', 63, 193, 'SG', 0, 1982
EXEC add_Player 'Rafael Araujo', 63, 211, 'SG', 0, 1980
EXEC add_Player 'Trevor Ariza', 63, 203, 'SG', 0, 1985
EXEC add_Player 'Maurice Baker', 79, 185, 'SG', 0, 1979
EXEC add_Player 'Andre Barrett', 78, 178, 'SG', 0, 1982
EXEC add_Player 'Andris Biedrins', 69, 211, 'SG', 0, 1986
EXEC add_Player 'Tony Bobbitt', 83, 193, 'SG', 0, 1979
EXEC add_Player 'Matt Bonner', 68, 208, 'SG', 0, 1980
EXEC add_Player 'Antonio Burks', 80, 185, 'SG', 0, 1980
EXEC add_Player 'Jackie Butler', 71, 208, 'SG', 0, 1985
EXEC add_Player 'Geno Carlisle', 81, 190, 'SG', 0, 1976
EXEC add_Player 'Lionel Chalmers', 81, 183, 'SG', 0, 1980
EXEC add_Player 'Josh Childress', 62, 203, 'SG', 0, 1983
EXEC add_Player 'Nick Collison', 72, 208, 'SG', 0, 1980
EXEC add_Player 'Erik Daniels', 63, 203, 'SG', 0, 1982
EXEC add_Player 'Carlos Delfino', 67, 198, 'SG', 0, 1982
EXEC add_Player 'Luol Deng', 64, 206, 'SF', 0, 1985
EXEC add_Player 'Chris Duhon', 83, 185, 'SF', 0, 1982
EXEC add_Player 'Corsley Edwards', 62, 206, 'SF', 0, 1979
EXEC add_Player 'John Edwards', 62, 213, 'SF', 0, 1981
EXEC add_Player 'Andre Emmett', 67, 196, 'SF', 0, 1982
EXEC add_Player 'Luis Flores', 80, 188, 'SF', 0, 1981
EXEC add_Player 'Matt Freije', 69, 208, 'SF', 0, 1981
EXEC add_Player 'Ben Gordon', 80, 190, 'SF', 0, 1983
EXEC add_Player 'Devin Harris', 84, 190, 'SF', 0, 1983
EXEC add_Player 'David Harrison', 63, 213, 'SF', 0, 1982
EXEC add_Player 'Dwight Howard', 60, 211, 'SF', 0, 1985
EXEC add_Player 'Kris Humphries', 68, 206, 'SF', 0, 1985
EXEC add_Player 'Andre Iguodala', 63, 198, 'SF', 0, 1984
EXEC add_Player 'Didier Ilunga-Mbenga', 63, 198, 'SF', 0, 1984
EXEC add_Player 'Royal Ivey', 80, 190, 'SF', 0, 1981
EXEC add_Player 'Al Jefferson', 65, 208, 'SF', 0, 1985
EXEC add_Player 'Horace Jenkins', 81, 185, 'SF', 0, 1974
EXEC add_Player 'Mario Kasun', 73, 216, 'SF', 0, 1980
EXEC add_Player 'Viktor Khryapa', 62, 206, 'SF', 0, 1982
EXEC add_Player 'Brandin Knight', 78, 178, 'SF', 0, 1975
EXEC add_Player 'Nenad Krstic', 69, 213, 'PF', 0, 1983
EXEC add_Player 'Ibo Kutluay', 80, 198, 'PF', 0, 1974
EXEC add_Player 'Shaun Livingston', 84, 201, 'PF', 0, 1985
EXEC add_Player 'Kevin Martin', 68, 206, 'PF', 0, 1977
EXEC add_Player 'Jameer Nelson', 83, 183, 'PF', 0, 1982
EXEC add_Player 'Andres Nocioni', 66, 201, 'PF', 0, 1979
EXEC add_Player 'Emeka Okafor', 72, 208, 'PF', 0, 1982
EXEC add_Player 'Pavel Podkolzin', 73, 226, 'PF', 0, 1985
EXEC add_Player 'Peter John', 73, 226, 'PF', 0, 1985
EXEC add_Player 'Justin Reed', 69, 203, 'PF', 0, 1982
EXEC add_Player 'Jared Reiner', 72, 211, 'PF', 0, 1982
EXEC add_Player 'Bernard Robinson', 62, 198, 'PF', 0, 1980
EXEC add_Player 'Quinton Ross', 85, 198, 'PF', 0, 1981
EXEC add_Player 'Ha Seung-Jin', 69, 221, 'PF', 0, 1985
EXEC add_Player 'Donta Smith', 83, 188, 'PF', 0, 1920
EXEC add_Player 'J.R. Smith', 83, 188, 'PF', 0, 1920
EXEC add_Player 'Josh Smith', 68, 213, 'PF', 0, 1944
EXEC add_Player 'Kirk Snyder', 66, 198, 'PF', 0, 1983
EXEC add_Player 'Pape Sow', 71, 208, 'PF', 0, 1981
EXEC add_Player 'Awvee Storey', 65, 198, 'PF', 0, 1977
EXEC add_Player 'Robert Swift', 70, 213, 'C', 0, 1985
EXEC add_Player 'Yuta Tabuse', 74, 175, 'C', 0, 1980
EXEC add_Player 'Sebastian Telfair', 74, 183, 'C', 0, 1985
EXEC add_Player 'Billy Thomas', 62, 193, 'C', 0, 1975
EXEC add_Player 'James Thomas', 63, 198, 'C', 0, 1973
EXEC add_Player 'Beno Udrih', 82, 190, 'C', 0, 1982
EXEC add_Player 'Anderson Varejao', 61, 208, 'C', 0, 1982
EXEC add_Player 'Jackson Vroman', 64, 208, 'C', 0, 1981
EXEC add_Player 'Sasha Vujacic', 85, 201, 'C', 0, 1984
EXEC add_Player 'Delonte West', 81, 193, 'C', 0, 1983
EXEC add_Player 'Damien Wilkins', 64, 208, 'C', 0, 1960
EXEC add_Player 'Dorell Wright', 82, 206, 'C', 0, 1985
EXEC add_Player 'Alex Acker', 83, 196, 'C', 0, 1983
EXEC add_Player 'Alan Anderson', 64, 198, 'C', 0, 1982
EXEC add_Player 'Martynas Andriuskevi', 69, 218, 'C', 0, 1986
EXEC add_Player 'Earl Barron', 71, 213, 'C', 0, 1981
EXEC add_Player 'Eddie Basden', 63, 196, 'C', 0, 1983
EXEC add_Player 'Brandon Bass', 71, 203, 'C', 0, 1985
EXEC add_Player 'Esteban Batista', 61, 208, 'C', 0, 1983
EXEC add_Player 'Andray Blatche', 68, 211, 'C', 0, 1986
EXEC add_Player 'Andrew Bogut', 73, 213, 'PG', 0, 1984
EXEC add_Player 'Kevin Burleson', 82, 190, 'PG', 0, 1979
EXEC add_Player 'Andrew Bynum', 64, 213, 'PG', 0, 1987
EXEC add_Player 'Will Bynum', 83, 183, 'PG', 0, 1983
EXEC add_Player 'Jose Calderon', 80, 190, 'PG', 0, 1981
EXEC add_Player 'Travis Diener', 79, 185, 'PG', 0, 1982
EXEC add_Player 'Ike Diogu', 71, 203, 'PG', 0, 1983
EXEC add_Player 'Monta Ellis', 83, 190, 'PG', 0, 1985
EXEC add_Player 'Daniel Ewing', 83, 190, 'PG', 0, 1983
EXEC add_Player 'Noel Felix', 66, 206, 'PG', 0, 1981
EXEC add_Player 'Raymond Felton', 82, 185, 'PG', 0, 1984
EXEC add_Player 'Gerald Fitch', 85, 190, 'PG', 0, 1982
EXEC add_Player 'Sharrod Ford', 62, 201, 'PG', 0, 1972
EXEC add_Player 'Channing Frye', 72, 211, 'PG', 0, 1983
EXEC add_Player 'Deng Gai', 71, 206, 'PG', 0, 1982
EXEC add_Player 'Francisco Garcia', 85, 201, 'PG', 0, 1981
EXEC add_Player 'Ryan Gomes', 71, 201, 'PG', 0, 1982
EXEC add_Player 'Joey Graham', 66, 201, 'PG', 0, 1982
EXEC add_Player 'Stephen Graham', 63, 198, 'PG', 0, 1982
EXEC add_Player 'Danny Granger', 65, 206, 'PG', 0, 1983
EXEC add_Player 'Devin Green', 62, 201, 'SG', 0, 1982
EXEC add_Player 'Gerald Green', 82, 201, 'SG', 0, 1986
EXEC add_Player 'Orien Greene', 62, 193, 'SG', 0, 1982
EXEC add_Player 'Anthony Grundy', 81, 190, 'SG', 0, 1979
EXEC add_Player 'Chuck Hayes', 69, 198, 'SG', 0, 1983
EXEC add_Player 'Luther Head', 83, 190, 'SG', 0, 1982
EXEC add_Player 'Julius Hodge', 62, 201, 'SG', 0, 1983
EXEC add_Player 'Randy Holcomb', 66, 206, 'SG', 0, 1979
EXEC add_Player 'Jarrett Jack', 80, 190, 'SG', 0, 1983
EXEC add_Player 'Sarunas Jasikevicius', 85, 193, 'SG', 0, 1976
EXEC add_Player 'Amir Johnson', 69, 206, 'SG', 0, 1987
EXEC add_Player 'Dwayne Jones', 62, 208, 'SG', 0, 1952
EXEC add_Player 'Linas Kleiza', 70, 203, 'SG', 0, 1985
EXEC add_Player 'Yaroslav Korolev', 82, 206, 'SG', 0, 1987
EXEC add_Player 'David Lee', 66, 201, 'SG', 0, 1942
EXEC add_Player 'Arvydas Macijauskas', 63, 193, 'SG', 0, 1980
EXEC add_Player 'Rawle Marshall', 83, 206, 'SG', 0, 1982
EXEC add_Player 'Jason Maxiell', 73, 201, 'SG', 0, 1983
EXEC add_Player 'Sean May', 60, 206, 'SG', 0, 1984
EXEC add_Player 'Rashad McCants', 83, 193, 'SG', 0, 1984
EXEC add_Player 'Aaron Miles', 79, 185, 'SF', 0, 1983
EXEC add_Player 'C.J. Miles', 79, 185, 'SF', 0, 1983
EXEC add_Player 'Sergei Monia', 64, 203, 'SF', 0, 1983
EXEC add_Player 'Boniface N"Dong', 86, 213, 'SF', 0, 1977
EXEC add_Player 'Fabricio Oberto', 70, 208, 'SF', 0, 1975
EXEC add_Player 'Andre Owens', 80, 193, 'SF', 0, 1980
EXEC add_Player 'Chris Paul', 79, 183, 'SF', 0, 1985
EXEC add_Player 'Johan Petro', 71, 213, 'SF', 0, 1986
EXEC add_Player 'Josh Powell', 66, 206, 'SF', 0, 1983
EXEC add_Player 'Ronnie Price', 83, 188, 'SF', 0, 1983
EXEC add_Player 'Shavlik Randolph', 69, 208, 'SF', 0, 1983
EXEC add_Player 'Anthony Roberson', 83, 196, 'SF', 0, 1955
EXEC add_Player 'Lawrence Roberts', 69, 206, 'SF', 0, 1982
EXEC add_Player 'Nate Robinson', 81, 175, 'SF', 0, 1984
EXEC add_Player 'Melvin Sanders', 62, 196, 'SF', 0, 1981
EXEC add_Player 'Alex Scales', 83, 193, 'SF', 0, 1978
EXEC add_Player 'Luke Schenscher', 72, 216, 'SF', 0, 1982
EXEC add_Player 'Wayne Simien', 72, 206, 'SF', 0, 1983
EXEC add_Player 'James Singleton', 63, 203, 'SF', 0, 1981
EXEC add_Player 'Salim Stoudamire', 81, 185, 'SF', 0, 1982
EXEC add_Player 'Chris Taft', 73, 208, 'PF', 0, 1985
EXEC add_Player 'Donell Taylor', 81, 198, 'PF', 0, 1982
EXEC add_Player 'Dijon Thompson', 85, 201, 'PF', 0, 1983
EXEC add_Player 'Ronny Turiaf', 71, 208, 'PF', 0, 1983
EXEC add_Player 'Charlie Villanueva', 67, 211, 'PF', 0, 1984
EXEC add_Player 'Von Wafer', 62, 196, 'PF', 0, 1985
EXEC add_Player 'Matt Walsh', 82, 198, 'PF', 0, 1982
EXEC add_Player 'Hakim Warrick', 64, 206, 'PF', 0, 1982
EXEC add_Player 'Martell Webster', 66, 216, 'PF', 0, 1952
EXEC add_Player 'Robert Whaley', 73, 208, 'PF', 0, 1982
EXEC add_Player 'Deron Williams', 80, 190, 'PF', 0, 1984
EXEC add_Player 'Lou Williams', 80, 206, 'PF', 0, 1969
EXEC add_Player 'Marvin Williams', 86, 185, 'PF', 0, 1982
EXEC add_Player 'Antoine Wright', 62, 201, 'PF', 0, 1984
EXEC add_Player 'Bracey Wright', 66, 211, 'PF', 0, 1962
EXEC add_Player 'Derrick Zimmerman', 85, 190, 'PF', 0, 1981
EXEC add_Player 'Hassan Adams', 64, 193, 'PF', 0, 1984
EXEC add_Player 'Maurice Ager', 81, 196, 'PF', 0, 1984
EXEC add_Player 'LaMarcus Aldridge', 73, 211, 'PF', 0, 1985
EXEC add_Player 'Lou Amundson', 64, 206, 'PF', 0, 1982
EXEC add_Player 'Hilton Armstrong', 68, 211, 'C', 0, 1984
EXEC add_Player 'James Augustine', 68, 208, 'C', 0, 1984
EXEC add_Player 'Kelenna Azubuike', 64, 196, 'C', 0, 1983
EXEC add_Player 'Renaldo Balkman', 62, 203, 'C', 0, 1984
EXEC add_Player 'J.J. Barea', 62, 203, 'C', 0, 1984
EXEC add_Player 'Andrea Bargnani', 70, 213, 'C', 0, 1985
EXEC add_Player 'Will Blalock', 82, 183, 'C', 0, 1983
EXEC add_Player 'Josh Boone', 68, 208, 'C', 0, 1984
EXEC add_Player 'Cedric Bozeman', 83, 198, 'C', 0, 1983
EXEC add_Player 'Ronnie Brewer', 81, 193, 'C', 0, 1955
EXEC add_Player 'Andre Brown', 70, 206, 'C', 0, 1981
EXEC add_Player 'Shannon Brown', 82, 193, 'C', 0, 1985
EXEC add_Player 'Rodney Carney', 82, 201, 'C', 0, 1984
EXEC add_Player 'Mardy Collins', 64, 198, 'C', 0, 1984
EXEC add_Player 'Will Conroy', 85, 188, 'C', 0, 1982
EXEC add_Player 'Paul Davis', 61, 211, 'C', 0, 1984
EXEC add_Player 'Yakhouba Diawara', 66, 201, 'C', 0, 1982
EXEC add_Player 'Quincy Douby', 79, 190, 'C', 0, 1984
EXEC add_Player 'Jordan Farmar', 81, 188, 'C', 0, 1986
EXEC add_Player 'Desmon Farmer', 64, 196, 'C', 0, 1981
EXEC add_Player 'Randy Foye', 63, 193, 'PG', 0, 1983
EXEC add_Player 'Jorge Garbajosa', 70, 206, 'PG', 0, 1977
EXEC add_Player 'Rudy Gay', 67, 203, 'PG', 0, 1986
EXEC add_Player 'Mickael Gelabale', 63, 201, 'PG', 0, 1983
EXEC add_Player 'Daniel Gibson', 83, 188, 'PG', 0, 1986
EXEC add_Player 'Andreas Glyniadakis', 63, 216, 'PG', 0, 1981
EXEC add_Player 'Lynn Greer', 79, 188, 'PG', 0, 1979
EXEC add_Player 'Mike Hall', 67, 203, 'PG', 0, 1984
EXEC add_Player 'Walter Herrmann', 66, 206, 'PG', 0, 1979
EXEC add_Player 'Robert Hite', 83, 188, 'PG', 0, 1984
EXEC add_Player 'Ryan Hollins', 69, 213, 'PG', 0, 1984
EXEC add_Player 'Mile Ilic', 67, 216, 'PG', 0, 1984
EXEC add_Player 'Ersan Ilyasova', 68, 208, 'PG', 0, 1987
EXEC add_Player 'Alexander Johnson', 69, 206, 'PG', 0, 1983
EXEC add_Player 'Solomon Jones', 67, 208, 'PG', 0, 1984
EXEC add_Player 'Tarence Kinsey', 83, 198, 'PG', 0, 1984
EXEC add_Player 'James Lang', 64, 208, 'PG', 0, 1983
EXEC add_Player 'Kyle Lowry', 82, 183, 'PG', 0, 1986
EXEC add_Player 'Renaldo Major', 80, 201, 'PG', 0, 1982
EXEC add_Player 'Damir Markota', 66, 208, 'PG', 0, 1985
EXEC add_Player 'Chris McCray', 84, 196, 'SG', 0, 1984
EXEC add_Player 'Ivan McFarlin', 69, 203, 'SG', 0, 1982
EXEC add_Player 'Pops Mensah-Bonsu', 69, 206, 'SG', 0, 1983
EXEC add_Player 'Paul Millsap', 70, 203, 'SG', 0, 1985
EXEC add_Player 'Randolph Morris', 60, 208, 'SG', 0, 1986
EXEC add_Player 'Adam Morrison', 82, 203, 'SG', 0, 1984
EXEC add_Player 'David Noel', 67, 198, 'SG', 0, 1984
EXEC add_Player 'Steve Novak', 66, 208, 'SG', 0, 1983
EXEC add_Player 'Patrick O"Bryant', 73, 213, 'SG', 0, 1986
EXEC add_Player 'Kevinn Pinkney', 70, 208, 'SG', 0, 1983
EXEC add_Player 'Leon Powe', 69, 203, 'SG', 0, 1984
EXEC add_Player 'Roger Powell', 68, 198, 'SG', 0, 1983
EXEC add_Player 'Chris Quinn', 83, 188, 'SG', 0, 1983
EXEC add_Player 'Allan Ray', 83, 188, 'SG', 0, 1984
EXEC add_Player 'J.J. Redick', 83, 188, 'SG', 0, 1984
EXEC add_Player 'Jeremy Richardson', 83, 198, 'SG', 0, 1984
EXEC add_Player 'Sergio Rodriguez', 79, 190, 'SG', 0, 1986
EXEC add_Player 'Rajon Rondo', 84, 185, 'SG', 0, 1986
EXEC add_Player 'Brandon Roy', 63, 198, 'SG', 0, 1984
EXEC add_Player 'Thabo Sefolosha', 64, 201, 'SG', 0, 1984
EXEC add_Player 'Mouhamed Sene', 64, 201, 'SF', 0, 1984
EXEC add_Player 'Cedric Simmons', 68, 206, 'SF', 0, 1986
EXEC add_Player 'Uros Slokar', 68, 208, 'SF', 0, 1983
EXEC add_Player 'Craig Smith', 71, 201, 'SF', 0, 1983
EXEC add_Player 'Steven Smith', 80, 201, 'SF', 0, 1969
EXEC add_Player 'Vassilis Spanoulis', 85, 193, 'SF', 0, 1982
EXEC add_Player 'Tyrus Thomas', 63, 206, 'SF', 0, 1986
EXEC add_Player 'P.J. Tucker', 63, 206, 'SF', 0, 1986
EXEC add_Player 'Marcus Vinicius', 63, 206, 'SF', 0, 1986
EXEC add_Player 'James White', 65, 206, 'SF', 0, 1976
EXEC add_Player 'Justin Williams', 66, 208, 'SF', 0, 1984
EXEC add_Player 'Marcus Williams', 86, 185, 'SF', 0, 1982
EXEC add_Player 'Shawne Williams', 81, 185, 'SF', 0, 1975
EXEC add_Player 'Shelden Williams', 81, 185, 'SF', 0, 1975
EXEC add_Player 'Arron Afflalo', 62, 196, 'SF', 0, 1985
EXEC add_Player 'Blake Ahearn', 83, 188, 'SF', 0, 1984
EXEC add_Player 'Lance Allred', 71, 211, 'SF', 0, 1981
EXEC add_Player 'Morris Almond', 66, 198, 'SF', 0, 1985
EXEC add_Player 'Joel Anthony', 70, 206, 'SF', 0, 1982
EXEC add_Player 'Marco Belinelli', 62, 196, 'SF', 0, 1986
EXEC add_Player 'Corey Brewer', 84, 206, 'PF', 0, 1986
EXEC add_Player 'Aaron Brooks', 73, 183, 'PF', 0, 1985
EXEC add_Player 'Wilson Chandler', 66, 203, 'PF', 0, 1987
EXEC add_Player 'Mike Conley', 79, 185, 'PF', 0, 1987
EXEC add_Player 'Daequan Cook', 83, 190, 'PF', 0, 1958
EXEC add_Player 'Javaris Crittenton', 80, 196, 'PF', 0, 1987
EXEC add_Player 'Jermareo Davidson', 67, 208, 'PF', 0, 1984
EXEC add_Player 'Glen Davis', 65, 206, 'PF', 0, 1986
EXEC add_Player 'Guillermo Diaz', 84, 188, 'PF', 0, 1985
EXEC add_Player 'Jared Dudley', 66, 201, 'PF', 0, 1985
EXEC add_Player 'Kevin Durant', 69, 206, 'PF', 0, 1988
EXEC add_Player 'Nick Fazekas', 68, 211, 'PF', 0, 1985
EXEC add_Player 'Kyrylo Fesenko', 65, 216, 'PF', 0, 1986
EXEC add_Player 'Thomas Gardner', 66, 196, 'PF', 0, 1985
EXEC add_Player 'Marcin Gortat', 69, 211, 'PF', 0, 1984
EXEC add_Player 'Aaron Gray', 61, 213, 'PF', 0, 1984
EXEC add_Player 'Jeff Green', 85, 196, 'PF', 0, 1941
EXEC add_Player 'Taurean Green', 80, 183, 'PF', 0, 1986
EXEC add_Player 'Mike Harris', 69, 198, 'PF', 0, 1983
EXEC add_Player 'Spencer Hawes', 70, 216, 'PF', 0, 1988
EXEC add_Player 'Al Horford', 70, 208, 'C', 0, 1986
EXEC add_Player 'Yi Jianlian', 69, 213, 'C', 0, 1987
EXEC add_Player 'Coby Karl', 63, 196, 'C', 0, 1983
EXEC add_Player 'Carl Landry', 71, 206, 'C', 0, 1983
EXEC add_Player 'Keith Langford', 63, 193, 'C', 0, 1983
EXEC add_Player 'Stephane Lasme', 63, 203, 'C', 0, 1982
EXEC add_Player 'Acie Law', 85, 190, 'C', 0, 1985
EXEC add_Player 'Ian Mahinmi', 71, 211, 'C', 0, 1986
EXEC add_Player 'Dominic McGuire', 64, 206, 'C', 0, 1985
EXEC add_Player 'Josh McRoberts', 69, 208, 'C', 0, 1987
EXEC add_Player 'Jamario Moon', 82, 203, 'C', 0, 1980
EXEC add_Player 'Juan Carlos', 82, 203, 'C', 0, 1980
EXEC add_Player 'Demetris Nichols', 63, 203, 'C', 0, 1984
EXEC add_Player 'Joakim Noah', 67, 211, 'C', 0, 1985
EXEC add_Player 'Oleksiy Pecherov', 67, 213, 'C', 0, 1985
EXEC add_Player 'Kosta Perovic', 69, 218, 'C', 0, 1985
EXEC add_Player 'Kasib Powell', 63, 201, 'C', 0, 1981
EXEC add_Player 'Gabe Pruitt', 77, 193, 'C', 0, 1986
EXEC add_Player 'Chris Richard', 61, 206, 'C', 0, 1984
EXEC add_Player 'Cheikh Samb', 70, 216, 'C', 0, 1984
EXEC add_Player 'Luis Scola', 69, 206, 'PG', 0, 1980
EXEC add_Player 'Ramon Sessions', 83, 190, 'PG', 0, 1986
EXEC add_Player 'Courtney Sims', 70, 208, 'PG', 0, 1983
EXEC add_Player 'Jason Smith', 71, 211, 'PG', 0, 1977
EXEC add_Player 'D.J. Strawberry', 71, 211, 'PG', 0, 1977
EXEC add_Player 'Rodney Stuckey', 62, 196, 'PG', 0, 1986
EXEC add_Player 'Al Thornton', 64, 203, 'PG', 0, 1983
EXEC add_Player 'Alando Tucker', 83, 203, 'PG', 0, 1943
EXEC add_Player 'Darius Washington', 85, 188, 'PG', 0, 1985
EXEC add_Player 'Darryl Watkins', 73, 211, 'PG', 0, 1984
EXEC add_Player 'C.J. Watson', 73, 211, 'PG', 0, 1984
EXEC add_Player 'Mario West', 67, 208, 'PG', 0, 1960
EXEC add_Player 'Sean Williams', 68, 208, 'PG', 0, 1986
EXEC add_Player 'Brandan Wright', 66, 211, 'PG', 0, 1962
EXEC add_Player 'Julian Wright', 66, 203, 'PG', 0, 1987
EXEC add_Player 'Nick Young', 62, 201, 'PG', 0, 1985
EXEC add_Player 'Thaddeus Young', 65, 203, 'PG', 0, 1988
EXEC add_Player 'Alexis Ajinca', 71, 218, 'PG', 0, 1988
EXEC add_Player 'Joe Alexander', 67, 203, 'PG', 0, 1986
EXEC add_Player 'Ryan Anderson', 69, 208, 'PG', 0, 1988
EXEC add_Player 'Darrell Arthur', 68, 206, 'SG', 0, 1988
EXEC add_Player 'D.J. Augustin', 68, 206, 'SG', 0, 1988
EXEC add_Player 'Nicolas Batum', 80, 203, 'SG', 0, 1988
EXEC add_Player 'Jerryd Bayless', 80, 190, 'SG', 0, 1988
EXEC add_Player 'Michael Beasley', 68, 206, 'SG', 0, 1989
EXEC add_Player 'Bobby Brown', 82, 193, 'SG', 0, 1923
EXEC add_Player 'Mario Chalmers', 83, 188, 'SG', 0, 1986
EXEC add_Player 'Joe Crawford', 62, 196, 'SG', 0, 1986
EXEC add_Player 'Joey Dorsey', 60, 203, 'SG', 0, 1983
EXEC add_Player 'Chris Douglas-Robert', 80, 201, 'SG', 0, 1987
EXEC add_Player 'Goran Dragic', 83, 190, 'SG', 0, 1986
EXEC add_Player 'Rudy Fernandez', 83, 198, 'SG', 0, 1985
EXEC add_Player 'Danilo Gallinari', 66, 208, 'SG', 0, 1988
EXEC add_Player 'Marc Gasol', 72, 216, 'SG', 0, 1985
EXEC add_Player 'J.R. Giddens', 72, 216, 'SG', 0, 1985
EXEC add_Player 'Eric Gordon', 63, 193, 'SG', 0, 1988
EXEC add_Player 'Donte Greene', 66, 211, 'SG', 0, 1988
EXEC add_Player 'Hamed Haddadi', 72, 218, 'SG', 0, 1985
EXEC add_Player 'Malik Hairston', 64, 198, 'SG', 0, 1987
EXEC add_Player 'Roy Hibbert', 61, 218, 'SG', 0, 1986
EXEC add_Player 'J.J. Hickson', 61, 218, 'SF', 0, 1986
EXEC add_Player 'George Hill', 85, 190, 'SF', 0, 1986
EXEC add_Player 'Steven Hill', 71, 213, 'SF', 0, 1985
EXEC add_Player 'Othello Hunter', 66, 203, 'SF', 0, 1986
EXEC add_Player 'Darnell Jackson', 72, 206, 'SF', 0, 1985
EXEC add_Player 'Nathan Jawai', 63, 208, 'SF', 0, 1986
EXEC add_Player 'Dontell Jefferson', 85, 196, 'SF', 0, 1983
EXEC add_Player 'Trey Johnson', 64, 196, 'SF', 0, 1984
EXEC add_Player 'DeAndre Jordan', 60, 211, 'SF', 0, 1988
EXEC add_Player 'Kosta Koufos', 60, 213, 'SF', 0, 1989
EXEC add_Player 'Rob Kurz', 67, 206, 'SF', 0, 1985
EXEC add_Player 'Courtney Lee', 80, 196, 'SF', 0, 1985
EXEC add_Player 'Brook Lopez', 62, 213, 'SF', 0, 1988
EXEC add_Player 'Robin Lopez', 72, 213, 'SF', 0, 1988
EXEC add_Player 'Kevin Love', 71, 208, 'SF', 0, 1988
EXEC add_Player 'Cartier Martin', 64, 201, 'SF', 0, 1984
EXEC add_Player 'O.J. Mayo', 64, 201, 'SF', 0, 1984
EXEC add_Player 'Luc Mbah', 64, 201, 'SF', 0, 1984
EXEC add_Player 'JaVale McGee', 61, 213, 'SF', 0, 1988
EXEC add_Player 'Anthony Morrow', 62, 196, 'SF', 0, 1985
EXEC add_Player 'DeMarcus Nelson', 80, 193, 'PF', 0, 1985
EXEC add_Player 'Greg Oden', 71, 213, 'PF', 0, 1988
EXEC add_Player 'Anthony Randolph', 82, 208, 'PF', 0, 1989
EXEC add_Player 'Derrick Rose', 83, 190, 'PF', 0, 1988
EXEC add_Player 'Brandon Rush', 64, 198, 'PF', 0, 1985
EXEC add_Player 'Walter Sharpe', 70, 206, 'PF', 0, 1986
EXEC add_Player 'Sean Singletary', 83, 183, 'PF', 0, 1985
EXEC add_Player 'Marreese Speights', 72, 208, 'PF', 0, 1987
EXEC add_Player 'Mike Taylor', 74, 188, 'PF', 0, 1986
EXEC add_Player 'Jason Thompson', 83, 185, 'PF', 0, 1946
EXEC add_Player 'Anthony Tolliver', 69, 203, 'PF', 0, 1985
EXEC add_Player 'Roko Ukic', 83, 196, 'PF', 0, 1984
EXEC add_Player 'Henry Walker', 83, 196, 'PF', 0, 1984
EXEC add_Player 'Kyle Weaver', 81, 198, 'PF', 0, 1986
EXEC add_Player 'Sonny Weems', 82, 198, 'PF', 0, 1986
EXEC add_Player 'Russell Westbrook', 80, 190, 'PF', 0, 1988
EXEC add_Player 'D.J. White', 80, 190, 'PF', 0, 1988
EXEC add_Player 'Jawad Williams', 69, 206, 'PF', 0, 1968
EXEC add_Player 'Sun Yue', 82, 206, 'PF', 0, 1985
EXEC add_Player 'David Andersen', 67, 208, 'PF', 0, 1943
EXEC add_Player 'Antonio Anderson', 83, 188, 'C', 0, 1945
EXEC add_Player 'Jeff Ayres', 83, 188, 'C', 0, 1945
EXEC add_Player 'Rodrigue Beaubois', 77, 183, 'C', 0, 1988
EXEC add_Player 'DeJuan Blair', 61, 201, 'C', 0, 1989
EXEC add_Player 'Jon Brockman', 72, 201, 'C', 0, 1987
EXEC add_Player 'Derrick Brown', 72, 185, 'C', 0, 1968
EXEC add_Player 'Chase Budinger', 62, 201, 'C', 0, 1988
EXEC add_Player 'DeMarre Carroll', 63, 203, 'C', 0, 1986
EXEC add_Player 'Omri Casspi', 66, 206, 'C', 0, 1988
EXEC add_Player 'Earl Clark', 66, 208, 'C', 0, 1988
EXEC add_Player 'Darren Collison', 79, 183, 'C', 0, 1987
EXEC add_Player 'Dante Cunningham', 67, 203, 'C', 0, 1987
EXEC add_Player 'JamesOn Curry', 83, 190, 'C', 0, 1986
EXEC add_Player 'Stephen Curry', 83, 190, 'C', 0, 1988
EXEC add_Player 'Austin Daye', 64, 211, 'C', 0, 1988
EXEC add_Player 'DeMar DeRozan', 65, 201, 'C', 0, 1989
EXEC add_Player 'Toney Douglas', 85, 188, 'C', 0, 1986
EXEC add_Player 'Wayne Ellington', 80, 193, 'C', 0, 1987
EXEC add_Player 'Tyreke Evans', 64, 198, 'C', 0, 1989
EXEC add_Player 'Jonny Flynn', 83, 183, 'C', 0, 1989
EXEC add_Player 'Sundiata Gaines', 83, 185, 'PG', 0, 1986
EXEC add_Player 'Alonzo Gee', 66, 198, 'PG', 0, 1987
EXEC add_Player 'Taj Gibson', 66, 206, 'PG', 0, 1985
EXEC add_Player 'Trey Gilder', 83, 206, 'PG', 0, 1985
EXEC add_Player 'Danny Green', 65, 206, 'PG', 0, 1957
EXEC add_Player 'Taylor Griffin', 68, 201, 'PG', 0, 1986
EXEC add_Player 'Tyler Hansbrough', 71, 206, 'PG', 0, 1985
EXEC add_Player 'James Harden', 64, 196, 'PG', 0, 1989
EXEC add_Player 'Jordan Hill', 68, 208, 'PG', 0, 1987
EXEC add_Player 'Jrue Holiday', 82, 193, 'PG', 0, 1990
EXEC add_Player 'Lester Hudson', 83, 190, 'PG', 0, 1984
EXEC add_Player 'Chris Hunter', 69, 211, 'PG', 0, 1984
EXEC add_Player 'Serge Ibaka', 68, 208, 'PG', 0, 1989
EXEC add_Player 'Cedric Jackson', 83, 190, 'PG', 0, 1986
EXEC add_Player 'Othyus Jeffers', 80, 196, 'PG', 0, 1985
EXEC add_Player 'Brandon Jennings', 77, 185, 'PG', 0, 1989
EXEC add_Player 'Jonas Jerebko', 67, 208, 'PG', 0, 1987
EXEC add_Player 'James Johnson', 71, 206, 'PG', 0, 1987
EXEC add_Player 'Oliver Lafayette', 83, 188, 'PG', 0, 1984
EXEC add_Player 'Marcus Landry', 67, 201, 'PG', 0, 1985
EXEC add_Player 'Ty Lawson', 85, 180, 'SG', 0, 1987
EXEC add_Player 'Wesley Matthews', 77, 185, 'SG', 0, 1959
EXEC add_Player 'Eric Maynor', 79, 190, 'SG', 0, 1987
EXEC add_Player 'Jodie Meeks', 62, 193, 'SG', 0, 1987
EXEC add_Player 'Patty Mills', 70, 203, 'SG', 0, 1985
EXEC add_Player 'Byron Mullens', 62, 213, 'SG', 0, 1989
EXEC add_Player 'A.J. Price', 62, 213, 'SG', 0, 1989
EXEC add_Player 'DaJuan Summers', 67, 203, 'SG', 0, 1988
EXEC add_Player 'Jermaine Taylor', 79, 193, 'SG', 0, 1960
EXEC add_Player 'Jeff Teague', 84, 188, 'SG', 0, 1988
EXEC add_Player 'Garrett Temple', 85, 198, 'SG', 0, 1986
EXEC add_Player 'Hasheem Thabeet', 74, 221, 'SG', 0, 1987
EXEC add_Player 'Marcus Thornton', 82, 193, 'SG', 0, 1987
EXEC add_Player 'Terrence Williams', 64, 198, 'SG', 0, 1987
EXEC add_Player 'Sam Young', 64, 198, 'SG', 0, 1985
EXEC add_Player 'Jeff Adrien', 70, 201, 'SG', 0, 1986
EXEC add_Player 'Solomon Alabi', 71, 216, 'SG', 0, 1988
EXEC add_Player 'Cole Aldrich', 71, 211, 'SG', 0, 1988
EXEC add_Player 'Al-Farouq Aminu', 64, 206, 'SG', 0, 1990
EXEC add_Player 'James Anderson', 63, 198, 'SG', 0, 1989
EXEC add_Player 'Omer Asik', 72, 213, 'SF', 0, 1986
EXEC add_Player 'Luke Babbitt', 66, 206, 'SF', 0, 1989
EXEC add_Player 'Eric Bledsoe', 83, 185, 'SF', 0, 1989
EXEC add_Player 'Trevor Booker', 66, 203, 'SF', 0, 1987
EXEC add_Player 'Craig Brackins', 67, 208, 'SF', 0, 1987
EXEC add_Player 'Avery Bradley', 81, 188, 'SF', 0, 1990
EXEC add_Player 'Derrick Caracter', 62, 206, 'SF', 0, 1988
EXEC add_Player 'Sherron Collins', 82, 180, 'SF', 0, 1987
EXEC add_Player 'Marcus Cousin', 70, 211, 'SF', 0, 1986
EXEC add_Player 'DeMarcus Cousins', 61, 211, 'SF', 0, 1990
EXEC add_Player 'Jordan Crawford', 62, 196, 'SF', 0, 1986
EXEC add_Player 'Ed Davis', 69, 208, 'SF', 0, 1989
EXEC add_Player 'Zabian Dowdell', 83, 190, 'SF', 0, 1984
EXEC add_Player 'Devin Ebanks', 63, 206, 'SF', 0, 1989
EXEC add_Player 'Semih Erden', 69, 213, 'SF', 0, 1986
EXEC add_Player 'Jeremy Evans', 80, 206, 'SF', 0, 1987
EXEC add_Player 'Christian Eyenga', 62, 196, 'SF', 0, 1989
EXEC add_Player 'Derrick Favors', 60, 208, 'SF', 0, 1991
EXEC add_Player 'Landry Fields', 62, 201, 'SF', 0, 1988
EXEC add_Player 'Gary Forbes', 64, 201, 'PF', 0, 1985
EXEC add_Player 'Paul George', 64, 206, 'PF', 0, 1990
EXEC add_Player 'Blake Griffin', 71, 208, 'PF', 0, 1989
EXEC add_Player 'Luke Harangody', 70, 203, 'PF', 0, 1988
EXEC add_Player 'Manny Harris', 83, 196, 'PF', 0, 1989
EXEC add_Player 'Gordon Hayward', 66, 203, 'PF', 0, 1990
EXEC add_Player 'Lazar Hayward', 66, 198, 'PF', 0, 1986
EXEC add_Player 'Xavier Henry', 64, 198, 'PF', 0, 1991
EXEC add_Player 'Damion James', 66, 201, 'PF', 0, 1987
EXEC add_Player 'Eugene Jeter', 79, 180, 'PF', 0, 1983
EXEC add_Player 'Armon Johnson', 68, 196, 'PF', 0, 1920
EXEC add_Player 'Chris Johnson', 77, 183, 'PF', 0, 1949
EXEC add_Player 'Wesley Johnson', 63, 201, 'PF', 0, 1987
EXEC add_Player 'Dominique Jones', 64, 203, 'PF', 0, 1975
EXEC add_Player 'Gani Lawal', 68, 206, 'PF', 0, 1988
EXEC add_Player 'Jeremy Lin', 80, 190, 'PF', 0, 1988
EXEC add_Player 'Greg Monroe', 60, 211, 'PF', 0, 1990
EXEC add_Player 'Timofey Mozgov', 62, 216, 'PF', 0, 1986
EXEC add_Player 'Hamady N"Diaye', 68, 213, 'PF', 0, 1987
EXEC add_Player 'Gary Neal', 62, 193, 'PF', 0, 1984
EXEC add_Player 'Larry Owens', 62, 201, 'C', 0, 1983
EXEC add_Player 'Patrick Patterson', 67, 206, 'C', 0, 1989
EXEC add_Player 'Nikola Pekovic', 69, 211, 'C', 0, 1986
EXEC add_Player 'Dexter Pittman', 69, 211, 'C', 0, 1988
EXEC add_Player 'Quincy Pondexter', 64, 201, 'C', 0, 1988
EXEC add_Player 'Andy Rautins', 83, 193, 'C', 0, 1986
EXEC add_Player 'Samardo Samuels', 73, 206, 'C', 0, 1989
EXEC add_Player 'Larry Sanders', 68, 211, 'C', 0, 1988
EXEC add_Player 'Kevin Seraphin', 64, 206, 'C', 0, 1989
EXEC add_Player 'Mustafa Shakur', 83, 190, 'C', 0, 1984
EXEC add_Player 'Garret Siler', 69, 211, 'C', 0, 1986
EXEC add_Player 'Ish Smith', 79, 183, 'C', 0, 1988
EXEC add_Player 'Tiago Splitter', 70, 211, 'C', 0, 1985
EXEC add_Player 'Lance Stephenson', 67, 196, 'C', 0, 1990
EXEC add_Player 'Pape Sy', 66, 201, 'C', 0, 1988
EXEC add_Player 'Evan Turner', 64, 201, 'C', 0, 1988
EXEC add_Player 'Ekpe Udoh', 69, 208, 'C', 0, 1987
EXEC add_Player 'Ben Uzoh', 82, 190, 'C', 0, 1988
EXEC add_Player 'Greivis Vasquez', 64, 198, 'C', 0, 1987
EXEC add_Player 'John Wall', 85, 193, 'C', 0, 1990
EXEC add_Player 'Willie Warren', 82, 193, 'PG', 0, 1989
EXEC add_Player 'Hassan Whiteside', 60, 213, 'PG', 0, 1989
EXEC add_Player 'Lavoy Allen', 73, 206, 'PG', 0, 1989
EXEC add_Player 'Gustavo Ayon', 71, 208, 'PG', 0, 1985
EXEC add_Player 'Keith Benson', 68, 208, 'PG', 0, 1954
EXEC add_Player 'Bismack Biyombo', 72, 206, 'PG', 0, 1992
EXEC add_Player 'MarShon Brooks', 80, 196, 'PG', 0, 1989
EXEC add_Player 'Alec Burks', 63, 198, 'PG', 0, 1991
EXEC add_Player 'Jimmy Butler', 64, 201, 'PG', 0, 1989
EXEC add_Player 'Derrick Byars', 64, 201, 'PG', 0, 1984
EXEC add_Player 'Norris Cole', 79, 188, 'PG', 0, 1988
EXEC add_Player 'Eric Dawson', 71, 206, 'PG', 0, 1984
EXEC add_Player 'Justin Dentmon', 83, 180, 'PG', 0, 1985
EXEC add_Player 'Jerome Dyson', 81, 190, 'PG', 0, 1987
EXEC add_Player 'Kenneth Faried', 66, 203, 'PG', 0, 1989
EXEC add_Player 'Jeff Foote', 60, 213, 'PG', 0, 1987
EXEC add_Player 'Courtney Fortson', 83, 180, 'PG', 0, 1988
EXEC add_Player 'Jimmer Fredette', 85, 188, 'PG', 0, 1989
EXEC add_Player 'Mickell Gladness', 64, 211, 'PG', 0, 1986
EXEC add_Player 'Andrew Goudelock', 80, 190, 'PG', 0, 1988
EXEC add_Player 'Jordan Hamilton', 72, 178, 'SG', 0, 1948
EXEC add_Player 'Justin Harper', 66, 208, 'SG', 0, 1989
EXEC add_Player 'Josh Harrellson', 62, 208, 'SG', 0, 1989
EXEC add_Player 'Terrel Harris', 83, 196, 'SG', 0, 1987
EXEC add_Player 'Tobias Harris', 83, 190, 'SG', 0, 1967
EXEC add_Player 'Cory Higgins', 81, 196, 'SG', 0, 1989
EXEC add_Player 'Darington Hobson', 62, 201, 'SG', 0, 1987
EXEC add_Player 'Tyler Honeycutt', 85, 203, 'SG', 0, 1990
EXEC add_Player 'Dennis Horner', 67, 206, 'SG', 0, 1988
EXEC add_Player 'Kyrie Irving', 84, 190, 'SG', 0, 1992
EXEC add_Player 'Reggie Jackson', 62, 190, 'SG', 0, 1990
EXEC add_Player 'Charles Jenkins', 64, 190, 'SG', 0, 1989
EXEC add_Player 'Carldell Johnson', 81, 178, 'SG', 0, 1983
EXEC add_Player 'Ivan Johnson', 67, 203, 'SG', 0, 1984
EXEC add_Player 'JaJuan Johnson', 71, 206, 'SG', 0, 1987
EXEC add_Player 'Jerome Jordan', 72, 213, 'SG', 0, 1986
EXEC add_Player 'Cory Joseph', 84, 190, 'SG', 0, 1991
EXEC add_Player 'Enes Kanter', 70, 211, 'SG', 0, 1992
EXEC add_Player 'D.J. Kennedy', 70, 211, 'SG', 0, 1992
EXEC add_Player 'Brandon Knight', 78, 178, 'SG', 0, 1975
EXEC add_Player 'Malcolm Lee', 80, 196, 'SF', 0, 1990
EXEC add_Player 'Kawhi Leonard', 67, 201, 'SF', 0, 1991
EXEC add_Player 'Travis Leslie', 82, 193, 'SF', 0, 1990
EXEC add_Player 'Jon Leuer', 66, 208, 'SF', 0, 1989
EXEC add_Player 'DeAndre Liggins', 62, 198, 'SF', 0, 1988
EXEC add_Player 'Shelvin Mack', 82, 190, 'SF', 0, 1990
EXEC add_Player 'Vernon Macklin', 66, 208, 'SF', 0, 1986
EXEC add_Player 'E"Twaun Moore', 66, 208, 'SF', 0, 1986
EXEC add_Player 'Darius Morris', 83, 193, 'SF', 0, 1991
EXEC add_Player 'Marcus Morris', 85, 188, 'SF', 0, 1925
EXEC add_Player 'Markieff Morris', 85, 188, 'SF', 0, 1925
EXEC add_Player 'Daniel Orton', 72, 208, 'SF', 0, 1990
EXEC add_Player 'Jeremy Pargo', 64, 188, 'SF', 0, 1986
EXEC add_Player 'Chandler Parsons', 67, 208, 'SF', 0, 1988
EXEC add_Player 'Ryan Reid', 67, 203, 'SF', 0, 1986
EXEC add_Player 'Ricky Rubio', 84, 193, 'SF', 0, 1990
EXEC add_Player 'Josh Selby', 83, 188, 'SF', 0, 1991
EXEC add_Player 'Iman Shumpert', 64, 196, 'SF', 0, 1990
EXEC add_Player 'Xavier Silas', 82, 196, 'SF', 0, 1988
EXEC add_Player 'Chris Singleton', 67, 203, 'SF', 0, 1989
EXEC add_Player 'Donald Sloan', 82, 190, 'PF', 0, 1988
EXEC add_Player 'Jerry Smith', 83, 188, 'PF', 0, 1987
EXEC add_Player 'Nolan Smith', 83, 188, 'PF', 0, 1988
EXEC add_Player 'Greg Stiemsma', 73, 211, 'PF', 0, 1985
EXEC add_Player 'Julyan Stone', 80, 198, 'PF', 0, 1988
EXEC add_Player 'Isaiah Thomas', 81, 185, 'PF', 0, 1961
EXEC add_Player 'Lance Thomas', 68, 203, 'PF', 0, 1988
EXEC add_Player 'Malcolm Thomas', 66, 206, 'PF', 0, 1988
EXEC add_Player 'Trey Thompkins', 68, 206, 'PF', 0, 1991
EXEC add_Player 'Klay Thompson', 63, 201, 'PF', 0, 1990
EXEC add_Player 'Mychel Thompson', 66, 208, 'PF', 0, 1955
EXEC add_Player 'Tristan Thompson', 68, 206, 'PF', 0, 1991
EXEC add_Player 'Jeremy Tyler', 73, 208, 'PF', 0, 1991
EXEC add_Player 'Edwin Ubiles', 82, 198, 'PF', 0, 1986
EXEC add_Player 'Jan Vesely', 69, 211, 'PF', 0, 1990
EXEC add_Player 'Nikola Vucevic', 73, 213, 'PF', 0, 1990
EXEC add_Player 'Kemba Walker', 62, 203, 'PF', 0, 1964
EXEC add_Player 'Derrick Williams', 80, 190, 'PF', 0, 1984
EXEC add_Player 'Elliot Williams', 83, 196, 'PF', 0, 1989
EXEC add_Player 'Jordan Williams', 83, 188, 'PF', 0, 1951
EXEC add_Player 'Chris Wright', 66, 203, 'C', 0, 1988
EXEC add_Player 'Quincy Acy', 69, 201, 'C', 0, 1990
EXEC add_Player 'Josh Akognon', 83, 180, 'C', 0, 1986
EXEC add_Player 'Harrison Barnes', 82, 190, 'C', 0, 1945
EXEC add_Player 'Will Barton', 79, 198, 'C', 0, 1991
EXEC add_Player 'Aron Baynes', 73, 208, 'C', 0, 1986
EXEC add_Player 'Kent Bazemore', 81, 196, 'C', 0, 1989
EXEC add_Player 'Bradley Beal', 83, 196, 'C', 0, 1993
EXEC add_Player 'Patrick Beverley', 83, 185, 'C', 0, 1988
EXEC add_Player 'Victor Claver', 65, 206, 'C', 0, 1988
EXEC add_Player 'Chris Copeland', 69, 206, 'C', 0, 1984
EXEC add_Player 'Jae Crowder', 68, 198, 'C', 0, 1990
EXEC add_Player 'Jared Cunningham', 85, 193, 'C', 0, 1991
EXEC add_Player 'Anthony Davis', 63, 206, 'C', 0, 1968
EXEC add_Player 'Nando De', 63, 206, 'C', 0, 1968
EXEC add_Player 'Andre Drummond', 63, 211, 'C', 0, 1993
EXEC add_Player 'Kim English', 80, 198, 'C', 0, 1988
EXEC add_Player 'Festus Ezeli', 72, 211, 'C', 0, 1989
EXEC add_Player 'Evan Fournier', 82, 201, 'C', 0, 1992
EXEC add_Player 'Joel Freeland', 71, 208, 'C', 0, 1987
EXEC add_Player 'Diante Garrett', 83, 190, 'PG', 0, 1947
EXEC add_Player 'Draymond Green', 67, 201, 'PG', 0, 1990
EXEC add_Player 'Ben Hansbrough', 82, 190, 'PG', 0, 1987
EXEC add_Player 'Maurice Harkless', 63, 206, 'PG', 0, 1993
EXEC add_Player 'John Henson', 66, 211, 'PG', 0, 1990
EXEC add_Player 'Justin Holiday', 83, 198, 'PG', 0, 1989
EXEC add_Player 'Bernard James', 69, 208, 'PG', 0, 1985
EXEC add_Player 'John Jenkins', 63, 193, 'PG', 0, 1991
EXEC add_Player 'Orlando Johnson', 64, 196, 'PG', 0, 1989
EXEC add_Player 'Darius Johnson-Odom', 62, 201, 'PG', 0, 1970
EXEC add_Player 'DeQuan Jones', 65, 203, 'PG', 0, 1990
EXEC add_Player 'Kevin Jones', 71, 203, 'PG', 0, 1989
EXEC add_Player 'Perry Jones', 68, 211, 'PG', 0, 1991
EXEC add_Player 'Terrence Jones', 72, 206, 'PG', 0, 1992
EXEC add_Player 'Kris Joseph', 62, 201, 'PG', 0, 1988
EXEC add_Player 'Michael Kidd-Gilchri', 67, 201, 'PG', 0, 1993
EXEC add_Player 'Viacheslav Kravtsov', 73, 213, 'PG', 0, 1987
EXEC add_Player 'Doron Lamb', 62, 193, 'PG', 0, 1991
EXEC add_Player 'Jeremy Lamb', 83, 196, 'PG', 0, 1992
EXEC add_Player 'Meyers Leonard', 70, 216, 'PG', 0, 1992
EXEC add_Player 'Damian Lillard', 85, 190, 'SG', 0, 1990
EXEC add_Player 'Scott Machado', 82, 185, 'SG', 0, 1990
EXEC add_Player 'Kendall Marshall', 80, 193, 'SG', 0, 1991
EXEC add_Player 'Fab Melo', 72, 213, 'SG', 0, 1990
EXEC add_Player 'Khris Middleton', 68, 203, 'SG', 0, 1991
EXEC add_Player 'Darius Miller', 68, 203, 'SG', 0, 1990
EXEC add_Player 'Quincy Miller', 62, 206, 'SG', 0, 1992
EXEC add_Player 'Donatas Motiejunas', 65, 213, 'SG', 0, 1990
EXEC add_Player 'Arnett Moultrie', 71, 211, 'SG', 0, 1990
EXEC add_Player 'Kevin Murphy', 83, 196, 'SG', 0, 1990
EXEC add_Player 'Andrew Nicholson', 71, 206, 'SG', 0, 1989
EXEC add_Player 'Kyle O"Quinn', 71, 208, 'SG', 0, 1990
EXEC add_Player 'Tim Ohlbrecht', 72, 211, 'SG', 0, 1988
EXEC add_Player 'Miles Plumlee', 71, 211, 'SG', 0, 1988
EXEC add_Player 'Pablo Prigioni', 83, 190, 'SG', 0, 1977
EXEC add_Player 'Austin Rivers', 80, 193, 'SG', 0, 1992
EXEC add_Player 'Brian Roberts', 78, 185, 'SG', 0, 1985
EXEC add_Player 'Thomas Robinson', 68, 208, 'SG', 0, 1991
EXEC add_Player 'Terrence Ross', 83, 201, 'SG', 0, 1991
EXEC add_Player 'Robert Sacre', 61, 213, 'SG', 0, 1989
EXEC add_Player 'Mike Scott', 68, 203, 'SF', 0, 1988
EXEC add_Player 'Tornike Shengelia', 64, 206, 'SF', 0, 1991
EXEC add_Player 'Alexey Shved', 83, 198, 'SF', 0, 1988
EXEC add_Player 'Henry Sims', 71, 208, 'SF', 0, 1990
EXEC add_Player 'Kyle Singler', 66, 203, 'SF', 0, 1988
EXEC add_Player 'Jared Sullinger', 73, 206, 'SF', 0, 1992
EXEC add_Player 'Jeffery Taylor', 79, 193, 'SF', 0, 1960
EXEC add_Player 'Tyshawn Taylor', 83, 190, 'SF', 0, 1990
EXEC add_Player 'Marquis Teague', 85, 188, 'SF', 0, 1993
EXEC add_Player 'Mirza Teletovic', 69, 206, 'SF', 0, 1985
EXEC add_Player 'Jonas Valanciunas', 60, 213, 'SF', 0, 1992
EXEC add_Player 'Jarvis Varnado', 67, 206, 'SF', 0, 1988
EXEC add_Player 'Dion Waiters', 66, 193, 'SF', 0, 1991
EXEC add_Player 'Maalik Wayns', 80, 188, 'SF', 0, 1991
EXEC add_Player 'Tony Wroten', 82, 198, 'SF', 0, 1993
EXEC add_Player 'Luke Zeller', 70, 211, 'SF', 0, 1987
EXEC add_Player 'Tyler Zeller', 72, 213, 'SF', 0, 1990
EXEC add_Player 'Steven Adams', 72, 213, 'SF', 0, 1993
EXEC add_Player 'Giannis Antetokounmp', 65, 211, 'SF', 0, 1994
EXEC add_Player 'Pero Antic', 73, 211, 'SF', 0, 1982
EXEC add_Player 'Chris Babb', 66, 196, 'PF', 0, 1990
EXEC add_Player 'Anthony Bennett', 70, 203, 'PF', 0, 1993
EXEC add_Player 'Vander Blue', 80, 193, 'PF', 0, 1992
EXEC add_Player 'Lorenzo Brown', 85, 196, 'PF', 0, 1990
EXEC add_Player 'Reggie Bullock', 82, 201, 'PF', 0, 1991
EXEC add_Player 'Trey Burke', 83, 185, 'PF', 0, 1992
EXEC add_Player 'Dwight Buycks', 83, 190, 'PF', 0, 1989
EXEC add_Player 'Nick Calathes', 63, 198, 'PF', 0, 1989
EXEC add_Player 'Kentavious Caldwell-', 82, 196, 'PF', 0, 1993
EXEC add_Player 'Isaiah Canaan', 81, 183, 'PF', 0, 1991
EXEC add_Player 'Michael Carter-Willi', 83, 198, 'PF', 0, 1991
EXEC add_Player 'Dionte Christmas', 82, 196, 'PF', 0, 1986
EXEC add_Player 'Ian Clark', 79, 190, 'PF', 0, 1991
EXEC add_Player 'Robert Covington', 63, 206, 'PF', 0, 1990
EXEC add_Player 'Allen Crabbe', 62, 198, 'PF', 0, 1992
EXEC add_Player 'Seth Curry', 83, 188, 'PF', 0, 1990
EXEC add_Player 'Troy Daniels', 82, 193, 'PF', 0, 1991
EXEC add_Player 'Luigi Datome', 63, 203, 'PF', 0, 1987
EXEC add_Player 'Brandon Davies', 69, 208, 'PF', 0, 1991
EXEC add_Player 'Dewayne Dedmon', 70, 213, 'PF', 0, 1989
EXEC add_Player 'Matthew Dellavedova', 86, 193, 'C', 0, 1990
EXEC add_Player 'Gorgui Dieng', 69, 211, 'C', 0, 1990
EXEC add_Player 'Shane Edwards', 64, 201, 'C', 0, 1987
EXEC add_Player 'Vitor Faverani', 73, 211, 'C', 0, 1988
EXEC add_Player 'Carrick Felix', 81, 198, 'C', 0, 1990
EXEC add_Player 'Jamaal Franklin', 83, 196, 'C', 0, 1991
EXEC add_Player 'Rudy Gobert', 70, 216, 'C', 0, 1992
EXEC add_Player 'Archie Goodwin', 80, 196, 'C', 0, 1994
EXEC add_Player 'Jorge Gutierrez', 83, 190, 'C', 0, 1988
EXEC add_Player 'Justin Hamilton', 73, 213, 'C', 0, 1990
EXEC add_Player 'Elias Harris', 69, 203, 'C', 0, 1989
EXEC add_Player 'Solomon Hill', 66, 201, 'C', 0, 1991
EXEC add_Player 'Scotty Hopson', 82, 201, 'C', 0, 1989
EXEC add_Player 'Robbie Hummel', 63, 203, 'C', 0, 1989
EXEC add_Player 'Sergey Karasev', 62, 201, 'C', 0, 1993
EXEC add_Player 'Ryan Kelly', 67, 211, 'C', 0, 1991
EXEC add_Player 'Ognjen Kuzmic', 71, 216, 'C', 0, 1990
EXEC add_Player 'Shane Larkin', 79, 180, 'C', 0, 1992
EXEC add_Player 'Ricky Ledo', 85, 201, 'C', 0, 1992
EXEC add_Player 'Alex Len', 73, 216, 'C', 0, 1993
EXEC add_Player 'Ray McCallum', 83, 190, 'PG', 0, 1991
EXEC add_Player 'C.J. McCollum', 83, 190, 'PG', 0, 1991
EXEC add_Player 'Ben McLemore', 85, 196, 'PG', 0, 1993
EXEC add_Player 'Gal Mekel', 83, 190, 'PG', 0, 1988
EXEC add_Player 'Tony Mitchell', 82, 201, 'PG', 0, 1966
EXEC add_Player 'Shabazz Muhammad', 65, 198, 'PG', 0, 1992
EXEC add_Player 'Erik Murphy', 67, 208, 'PG', 0, 1990
EXEC add_Player 'Toure" Murry', 85, 196, 'PG', 0, 1989
EXEC add_Player 'Mike Muscala', 69, 211, 'PG', 0, 1991
EXEC add_Player 'Nemanja Nedovic', 84, 190, 'PG', 0, 1991
EXEC add_Player 'James Nunnally', 82, 201, 'PG', 0, 1990
EXEC add_Player 'Victor Oladipo', 62, 193, 'PG', 0, 1992
EXEC add_Player 'Kelly Olynyk', 68, 213, 'PG', 0, 1991
EXEC add_Player 'Arinze Onuaku', 72, 206, 'PG', 0, 1987
EXEC add_Player 'Mason Plumlee', 70, 211, 'PG', 0, 1990
EXEC add_Player 'Otto Porter', 86, 203, 'PG', 0, 1993
EXEC add_Player 'Phil Pressey', 79, 180, 'PG', 0, 1991
EXEC add_Player 'Miroslav Raduljica', 71, 213, 'PG', 0, 1988
EXEC add_Player 'Andre Roberson', 83, 196, 'PG', 0, 1955
EXEC add_Player 'Dennis Schroder', 78, 185, 'PG', 0, 1993
EXEC add_Player 'Peyton Siva', 83, 183, 'SG', 0, 1990
EXEC add_Player 'Tony Snell', 80, 201, 'SG', 0, 1991
EXEC add_Player 'James Southerland', 63, 203, 'SG', 0, 1990
EXEC add_Player 'D.J. Stephens', 63, 203, 'SG', 0, 1990
EXEC add_Player 'Adonis Thomas', 80, 201, 'SG', 0, 1993
EXEC add_Player 'Hollis Thompson', 83, 203, 'SG', 0, 1991
EXEC add_Player 'Casper Ware', 79, 178, 'SG', 0, 1990
EXEC add_Player 'Royce White', 62, 203, 'SG', 0, 1959
EXEC add_Player 'Jeff Withey', 67, 213, 'SG', 0, 1990
EXEC add_Player 'Nate Wolters', 83, 193, 'SG', 0, 1991
EXEC add_Player 'Cody Zeller', 69, 213, 'SG', 0, 1992
EXEC add_Player 'Jordan Adams', 62, 196, 'SG', 0, 1994
EXEC add_Player 'Furkan Aldemir', 69, 208, 'SG', 0, 1991
EXEC add_Player 'Kyle Anderson', 67, 206, 'SG', 0, 1993
EXEC add_Player 'Cameron Bairstow', 71, 206, 'SG', 0, 1990
EXEC add_Player 'Jerrelle Benimon', 70, 203, 'SG', 0, 1991
EXEC add_Player 'Sim Bhullar', 81, 226, 'SG', 0, 1992
EXEC add_Player 'Tarik Black', 71, 206, 'SG', 0, 1991
EXEC add_Player 'Bojan Bogdanovic', 82, 198, 'SG', 0, 1992
EXEC add_Player 'Jabari Brown', 63, 193, 'SG', 0, 1992
EXEC add_Player 'Markel Brown', 83, 190, 'SF', 0, 1974
EXEC add_Player 'Bruno Caboclo', 64, 206, 'SF', 0, 1995
EXEC add_Player 'Clint Capela', 64, 206, 'SF', 0, 1995
EXEC add_Player 'Will Cherry', 83, 183, 'SF', 0, 1991
EXEC add_Player 'Patrick Christopher', 62, 196, 'SF', 0, 1988
EXEC add_Player 'Jordan Clarkson', 84, 196, 'SF', 0, 1992
EXEC add_Player 'Jack Cooley', 73, 206, 'SF', 0, 1991
EXEC add_Player 'Bryce Cotton', 74, 185, 'SF', 0, 1992
EXEC add_Player 'Andre Dawkins', 63, 196, 'SF', 0, 1991
EXEC add_Player 'Spencer Dinwiddie', 80, 198, 'SF', 0, 1993
EXEC add_Player 'Zoran Dragic', 80, 196, 'SF', 0, 1989
EXEC add_Player 'Cleanthony Early', 62, 203, 'SF', 0, 1991
EXEC add_Player 'James Ennis', 62, 201, 'SF', 0, 1990
EXEC add_Player 'Tyler Ennis', 84, 190, 'SF', 0, 1994
EXEC add_Player 'Dante Exum', 83, 198, 'SF', 0, 1995
EXEC add_Player 'Tim Frazier', 77, 185, 'SF', 0, 1990
EXEC add_Player 'Langston Galloway', 80, 188, 'SF', 0, 1991
EXEC add_Player 'Aaron Gordon', 64, 206, 'SF', 0, 1995
EXEC add_Player 'Drew Gordon', 70, 206, 'SF', 0, 1990
EXEC add_Player 'Jerami Grant', 62, 203, 'SF', 0, 1994
EXEC add_Player 'Erick Green', 83, 193, 'PF', 0, 1991
EXEC add_Player 'JaMychal Green', 66, 206, 'PF', 0, 1990
EXEC add_Player 'P.J. Hairston', 66, 206, 'PF', 0, 1990
EXEC add_Player 'Gary Harris', 62, 193, 'PF', 0, 1994
EXEC add_Player 'Joe Harris', 64, 198, 'PF', 0, 1991
EXEC add_Player 'Rodney Hood', 83, 203, 'PF', 0, 1992
EXEC add_Player 'Joe Ingles', 66, 203, 'PF', 0, 1987
EXEC add_Player 'Cory Jefferson', 64, 206, 'PF', 0, 1990
EXEC add_Player 'Grant Jerrett', 68, 208, 'PF', 0, 1993
EXEC add_Player 'Nick Johnson', 81, 190, 'PF', 0, 1992
EXEC add_Player 'Tyler Johnson', 84, 193, 'PF', 0, 1992
EXEC add_Player 'Sean Kilpatrick', 62, 193, 'PF', 0, 1990
EXEC add_Player 'Alex Kirk', 70, 213, 'PF', 0, 1991
EXEC add_Player 'Joffrey Lauvergne', 64, 211, 'PF', 0, 1991
EXEC add_Player 'Zach LaVine', 85, 196, 'PF', 0, 1995
EXEC add_Player 'Kalin Lucas', 85, 185, 'PF', 0, 1989
EXEC add_Player 'Devyn Marble', 80, 198, 'PF', 0, 1992
EXEC add_Player 'James Michael', 80, 198, 'PF', 0, 1992
EXEC add_Player 'K.J. McDaniels', 80, 198, 'PF', 0, 1992
EXEC add_Player 'Doug McDermott', 66, 203, 'PF', 0, 1992
EXEC add_Player 'Mitch McGary', 72, 208, 'C', 0, 1992
EXEC add_Player 'Jerel McNeal', 80, 190, 'C', 0, 1987
EXEC add_Player 'Elijah Millsap', 66, 198, 'C', 0, 1987
EXEC add_Player 'Nikola Mirotic', 64, 208, 'C', 0, 1991
EXEC add_Player 'Eric Moreland', 68, 208, 'C', 0, 1991
EXEC add_Player 'Shabazz Napier', 79, 185, 'C', 0, 1991
EXEC add_Player 'Nerlens Noel', 66, 211, 'C', 0, 1994
EXEC add_Player 'Lucas Nogueira', 69, 213, 'C', 0, 1992
EXEC add_Player 'Jusuf Nurkic', 63, 213, 'C', 0, 1994
EXEC add_Player 'Johnny O"Bryant', 73, 206, 'C', 0, 1993
EXEC add_Player 'Kostas Papanikolaou', 66, 203, 'C', 0, 1990
EXEC add_Player 'Jabari Parker', 71, 203, 'C', 0, 1995
EXEC add_Player 'Adreian Payne', 68, 208, 'C', 0, 1991
EXEC add_Player 'Elfrid Payton', 83, 193, 'C', 0, 1994
EXEC add_Player 'Dwight Powell', 69, 211, 'C', 0, 1991
EXEC add_Player 'Julius Randle', 71, 206, 'C', 0, 1994
EXEC add_Player 'Damjan Rudez', 66, 208, 'C', 0, 1986
EXEC add_Player 'JaKarr Sampson', 68, 211, 'C', 0, 1983
EXEC add_Player 'Marcus Smart', 64, 193, 'C', 0, 1994
EXEC add_Player 'Russ Smith', 74, 183, 'C', 0, 1991



/**ADD PLAYEDFOR**/

EXEC add_PlayedForByTeamName 'Mike Dunleavy', 'Atlanta Hawks',  2017
EXEC add_PlayedForByTeamName 'Mike Dunleavy', 'Cleveland Cavaliers',  2017
EXEC add_PlayedForByTeamName 'Gerald Henderson', 'Philadelphia 76ers',  2017
EXEC add_PlayedForByTeamName 'Vince Carter', 'Sacramento Kings',  2018
EXEC add_PlayedForByTeamName 'Vince Carter', 'Atlanta Hawks',  2019
EXEC add_PlayedForByTeamName 'Vince Carter', 'Atlanta Hawks',  2020
EXEC add_PlayedForByTeamName 'Dirk Nowitzki', 'Dallas Mavericks',  2017
EXEC add_PlayedForByTeamName 'Dirk Nowitzki', 'Dallas Mavericks',  2018
EXEC add_PlayedForByTeamName 'Dirk Nowitzki', 'Dallas Mavericks',  2019
EXEC add_PlayedForByTeamName 'Jason Terry', 'Milwaukee Bucks',  2017
EXEC add_PlayedForByTeamName 'Jason Terry', 'Milwaukee Bucks',  2018
EXEC add_PlayedForByTeamName 'Jamal Crawford', 'Los Angeles Clippers',  2017
EXEC add_PlayedForByTeamName 'Jamal Crawford', 'Phoenix Suns',  2019
EXEC add_PlayedForByTeamName 'Jamal Crawford', 'Brooklyn Nets',  2020
EXEC add_PlayedForByTeamName 'Mike Miller', 'Denver Nuggets',  2017
EXEC add_PlayedForByTeamName 'Chris Andersen', 'Cleveland Cavaliers',  2017
EXEC add_PlayedForByTeamName 'Tyson Chandler', 'Phoenix Suns',  2018
EXEC add_PlayedForByTeamName 'Tyson Chandler', 'Los Angeles Lakers',  2019
EXEC add_PlayedForByTeamName 'Tyson Chandler', 'Phoenix Suns',  2019
EXEC add_PlayedForByTeamName 'Tyson Chandler', 'Houston Rockets',  2020
EXEC add_PlayedForByTeamName 'Pau Gasol', 'San Antonio Spurs',  2018
EXEC add_PlayedForByTeamName 'Pau Gasol', 'Milwaukee Bucks',  2019
EXEC add_PlayedForByTeamName 'Pau Gasol', 'San Antonio Spurs',  2019
EXEC add_PlayedForByTeamName 'Mike James', 'New Orleans Pelicans',  2018
EXEC add_PlayedForByTeamName 'Mike James', 'Phoenix Suns',  2018
EXEC add_PlayedForByTeamName 'Mike James', 'Brooklyn Nets',  2021
EXEC add_PlayedForByTeamName 'Richard Jefferson', 'Denver Nuggets',  2018
EXEC add_PlayedForByTeamName 'Joe Johnson', 'Utah Jazz',  2017
EXEC add_PlayedForByTeamName 'Joe Johnson', 'Houston Rockets',  2018
EXEC add_PlayedForByTeamName 'Joe Johnson', 'Utah Jazz',  2018
EXEC add_PlayedForByTeamName 'Joe Johnson', 'Boston Celtics',  2022
EXEC add_PlayedForByTeamName 'Tony Parker', 'San Antonio Spurs',  2018
EXEC add_PlayedForByTeamName 'Tony Parker', 'Charlotte Hornets',  2019
EXEC add_PlayedForByTeamName 'Zach Randolph', 'Sacramento Kings',  2018
EXEC add_PlayedForByTeamName 'Carmelo Anthony', 'New York Knicks',  2017
EXEC add_PlayedForByTeamName 'Carmelo Anthony', 'Houston Rockets',  2019
EXEC add_PlayedForByTeamName 'Carmelo Anthony', 'Los Angeles Lakers',  2022
EXEC add_PlayedForByTeamName 'Leandro Barbosa', 'Phoenix Suns',  2017
EXEC add_PlayedForByTeamName 'Matt Barnes', 'Sacramento Kings',  2017
EXEC add_PlayedForByTeamName 'Boris Diaw', 'Utah Jazz',  2017
EXEC add_PlayedForByTeamName 'Udonis Haslem', 'Miami Heat',  2018
EXEC add_PlayedForByTeamName 'Udonis Haslem', 'Miami Heat',  2019
EXEC add_PlayedForByTeamName 'Udonis Haslem', 'Miami Heat',  2020
EXEC add_PlayedForByTeamName 'Udonis Haslem', 'Miami Heat',  2021
EXEC add_PlayedForByTeamName 'Udonis Haslem', 'Miami Heat',  2022
EXEC add_PlayedForByTeamName 'LeBron James', 'Cleveland Cavaliers',  2017
EXEC add_PlayedForByTeamName 'LeBron James', 'Cleveland Cavaliers',  2018
EXEC add_PlayedForByTeamName 'LeBron James', 'Los Angeles Lakers',  2019
EXEC add_PlayedForByTeamName 'LeBron James', 'Los Angeles Lakers',  2020
EXEC add_PlayedForByTeamName 'LeBron James', 'Los Angeles Lakers',  2021
EXEC add_PlayedForByTeamName 'LeBron James', 'Los Angeles Lakers',  2022
EXEC add_PlayedForByTeamName 'Dahntay Jones', 'Cleveland Cavaliers',  2017
EXEC add_PlayedForByTeamName 'James Jones', 'Cleveland Cavaliers',  2017
EXEC add_PlayedForByTeamName 'Kyle Korver', 'Atlanta Hawks',  2017
EXEC add_PlayedForByTeamName 'Kyle Korver', 'Cleveland Cavaliers',  2017
EXEC add_PlayedForByTeamName 'Kyle Korver', 'Cleveland Cavaliers',  2018
EXEC add_PlayedForByTeamName 'Kyle Korver', 'Cleveland Cavaliers',  2019
EXEC add_PlayedForByTeamName 'Kyle Korver', 'Utah Jazz',  2019
EXEC add_PlayedForByTeamName 'Kyle Korver', 'Milwaukee Bucks',  2020
EXEC add_PlayedForByTeamName 'Zaza Pachulia', 'Detroit Pistons',  2019
EXEC add_PlayedForByTeamName 'Kendrick Perkins', 'Cleveland Cavaliers',  2018
EXEC add_PlayedForByTeamName 'Dwyane Wade', 'Chicago Bulls',  2017
EXEC add_PlayedForByTeamName 'Dwyane Wade', 'Cleveland Cavaliers',  2018
EXEC add_PlayedForByTeamName 'Dwyane Wade', 'Miami Heat',  2018
EXEC add_PlayedForByTeamName 'Dwyane Wade', 'Miami Heat',  2019
EXEC add_PlayedForByTeamName 'Tony Allen', 'New Orleans Pelicans',  2018
EXEC add_PlayedForByTeamName 'Trevor Ariza', 'Houston Rockets',  2018
EXEC add_PlayedForByTeamName 'Trevor Ariza', 'Phoenix Suns',  2019
EXEC add_PlayedForByTeamName 'Trevor Ariza', 'Washington Wizards',  2019
EXEC add_PlayedForByTeamName 'Trevor Ariza', 'Sacramento Kings',  2020
EXEC add_PlayedForByTeamName 'Trevor Ariza', 'Miami Heat',  2021
EXEC add_PlayedForByTeamName 'Trevor Ariza', 'Los Angeles Lakers',  2022
EXEC add_PlayedForByTeamName 'Luol Deng', 'Los Angeles Lakers',  2017
EXEC add_PlayedForByTeamName 'Luol Deng', 'Los Angeles Lakers',  2018
EXEC add_PlayedForByTeamName 'Devin Harris', 'Dallas Mavericks',  2017
EXEC add_PlayedForByTeamName 'Devin Harris', 'Dallas Mavericks',  2018
EXEC add_PlayedForByTeamName 'Devin Harris', 'Denver Nuggets',  2018
EXEC add_PlayedForByTeamName 'Devin Harris', 'Dallas Mavericks',  2019
EXEC add_PlayedForByTeamName 'Dwight Howard', 'Atlanta Hawks',  2017
EXEC add_PlayedForByTeamName 'Dwight Howard', 'Charlotte Hornets',  2018
EXEC add_PlayedForByTeamName 'Dwight Howard', 'Washington Wizards',  2019
EXEC add_PlayedForByTeamName 'Dwight Howard', 'Los Angeles Lakers',  2020
EXEC add_PlayedForByTeamName 'Dwight Howard', 'Philadelphia 76ers',  2021
EXEC add_PlayedForByTeamName 'Dwight Howard', 'Los Angeles Lakers',  2022
EXEC add_PlayedForByTeamName 'Kris Humphries', 'Atlanta Hawks',  2017
EXEC add_PlayedForByTeamName 'Andre Iguodala', 'Miami Heat',  2020
EXEC add_PlayedForByTeamName 'Andre Iguodala', 'Miami Heat',  2021
EXEC add_PlayedForByTeamName 'Al Jefferson', 'Indiana Pacers',  2017
EXEC add_PlayedForByTeamName 'Al Jefferson', 'Indiana Pacers',  2018
EXEC add_PlayedForByTeamName 'Jameer Nelson', 'Denver Nuggets',  2017
EXEC add_PlayedForByTeamName 'Jameer Nelson', 'Detroit Pistons',  2018
EXEC add_PlayedForByTeamName 'Jameer Nelson', 'New Orleans Pelicans',  2018
EXEC add_PlayedForByTeamName 'Emeka Okafor', 'New Orleans Pelicans',  2018
EXEC add_PlayedForByTeamName 'J.R. Smith', 'Cleveland Cavaliers',  2017
EXEC add_PlayedForByTeamName 'J.R. Smith', 'Cleveland Cavaliers',  2018
EXEC add_PlayedForByTeamName 'J.R. Smith', 'Cleveland Cavaliers',  2019
EXEC add_PlayedForByTeamName 'J.R. Smith', 'Los Angeles Lakers',  2020
EXEC add_PlayedForByTeamName 'Josh Smith', 'New Orleans Pelicans',  2018
EXEC add_PlayedForByTeamName 'Beno Udrih', 'Detroit Pistons',  2017
EXEC add_PlayedForByTeamName 'Damien Wilkins', 'Indiana Pacers',  2018
EXEC add_PlayedForByTeamName 'Alan Anderson', 'Los Angeles Clippers',  2017
EXEC add_PlayedForByTeamName 'Brandon Bass', 'Los Angeles Clippers',  2017
EXEC add_PlayedForByTeamName 'Andrew Bogut', 'Cleveland Cavaliers',  2017
EXEC add_PlayedForByTeamName 'Andrew Bogut', 'Dallas Mavericks',  2017
EXEC add_PlayedForByTeamName 'Andrew Bogut', 'Los Angeles Lakers',  2018
EXEC add_PlayedForByTeamName 'Monta Ellis', 'Indiana Pacers',  2017
EXEC add_PlayedForByTeamName 'Channing Frye', 'Cleveland Cavaliers',  2017
EXEC add_PlayedForByTeamName 'Channing Frye', 'Cleveland Cavaliers',  2018
EXEC add_PlayedForByTeamName 'Channing Frye', 'Los Angeles Lakers',  2018
EXEC add_PlayedForByTeamName 'Channing Frye', 'Cleveland Cavaliers',  2019
EXEC add_PlayedForByTeamName 'Gerald Green', 'Boston Celtics',  2017
EXEC add_PlayedForByTeamName 'Gerald Green', 'Houston Rockets',  2018
EXEC add_PlayedForByTeamName 'Gerald Green', 'Houston Rockets',  2019
EXEC add_PlayedForByTeamName 'Jarrett Jack', 'New Orleans Pelicans',  2017
EXEC add_PlayedForByTeamName 'Jarrett Jack', 'New York Knicks',  2018
EXEC add_PlayedForByTeamName 'Amir Johnson', 'Boston Celtics',  2017
EXEC add_PlayedForByTeamName 'Amir Johnson', 'Philadelphia 76ers',  2018
EXEC add_PlayedForByTeamName 'Amir Johnson', 'Philadelphia 76ers',  2019
EXEC add_PlayedForByTeamName 'David Lee', 'San Antonio Spurs',  2017
EXEC add_PlayedForByTeamName 'C.J. Miles', 'Indiana Pacers',  2017
EXEC add_PlayedForByTeamName 'C.J. Miles', 'Toronto Raptors',  2018
EXEC add_PlayedForByTeamName 'C.J. Miles', 'Memphis Grizzlies',  2019
EXEC add_PlayedForByTeamName 'C.J. Miles', 'Toronto Raptors',  2019
EXEC add_PlayedForByTeamName 'C.J. Miles', 'Washington Wizards',  2020
EXEC add_PlayedForByTeamName 'C.J. Miles', 'Boston Celtics',  2022
EXEC add_PlayedForByTeamName 'Chris Paul', 'Los Angeles Clippers',  2017
EXEC add_PlayedForByTeamName 'Chris Paul', 'Houston Rockets',  2018
EXEC add_PlayedForByTeamName 'Chris Paul', 'Houston Rockets',  2019
EXEC add_PlayedForByTeamName 'Chris Paul', 'Phoenix Suns',  2021
EXEC add_PlayedForByTeamName 'Chris Paul', 'Phoenix Suns',  2022
EXEC add_PlayedForByTeamName 'Deron Williams', 'Cleveland Cavaliers',  2017
EXEC add_PlayedForByTeamName 'Deron Williams', 'Dallas Mavericks',  2017
EXEC add_PlayedForByTeamName 'Lou Williams', 'Houston Rockets',  2017
EXEC add_PlayedForByTeamName 'Lou Williams', 'Los Angeles Lakers',  2017
EXEC add_PlayedForByTeamName 'Lou Williams', 'Los Angeles Clippers',  2018
EXEC add_PlayedForByTeamName 'Lou Williams', 'Los Angeles Clippers',  2019
EXEC add_PlayedForByTeamName 'Lou Williams', 'Los Angeles Clippers',  2020
EXEC add_PlayedForByTeamName 'Lou Williams', 'Atlanta Hawks',  2021
EXEC add_PlayedForByTeamName 'Lou Williams', 'Los Angeles Clippers',  2021
EXEC add_PlayedForByTeamName 'Lou Williams', 'Atlanta Hawks',  2022
EXEC add_PlayedForByTeamName 'Marvin Williams', 'Charlotte Hornets',  2017
EXEC add_PlayedForByTeamName 'Marvin Williams', 'Charlotte Hornets',  2018
EXEC add_PlayedForByTeamName 'Marvin Williams', 'Charlotte Hornets',  2019
EXEC add_PlayedForByTeamName 'Marvin Williams', 'Charlotte Hornets',  2020
EXEC add_PlayedForByTeamName 'Marvin Williams', 'Milwaukee Bucks',  2020
EXEC add_PlayedForByTeamName 'LaMarcus Aldridge', 'San Antonio Spurs',  2017
EXEC add_PlayedForByTeamName 'LaMarcus Aldridge', 'San Antonio Spurs',  2018
EXEC add_PlayedForByTeamName 'LaMarcus Aldridge', 'San Antonio Spurs',  2019
EXEC add_PlayedForByTeamName 'LaMarcus Aldridge', 'San Antonio Spurs',  2020
EXEC add_PlayedForByTeamName 'LaMarcus Aldridge', 'Brooklyn Nets',  2021
EXEC add_PlayedForByTeamName 'LaMarcus Aldridge', 'San Antonio Spurs',  2021
EXEC add_PlayedForByTeamName 'LaMarcus Aldridge', 'Brooklyn Nets',  2022
EXEC add_PlayedForByTeamName 'J.J. Barea', 'Dallas Mavericks',  2017
EXEC add_PlayedForByTeamName 'J.J. Barea', 'Dallas Mavericks',  2018
EXEC add_PlayedForByTeamName 'J.J. Barea', 'Dallas Mavericks',  2019
EXEC add_PlayedForByTeamName 'J.J. Barea', 'Dallas Mavericks',  2020
EXEC add_PlayedForByTeamName 'Jordan Farmar', 'Sacramento Kings',  2017
EXEC add_PlayedForByTeamName 'Rudy Gay', 'San Antonio Spurs',  2018
EXEC add_PlayedForByTeamName 'Rudy Gay', 'San Antonio Spurs',  2019
EXEC add_PlayedForByTeamName 'Rudy Gay', 'San Antonio Spurs',  2020
EXEC add_PlayedForByTeamName 'Rudy Gay', 'San Antonio Spurs',  2021
EXEC add_PlayedForByTeamName 'Rudy Gay', 'Utah Jazz',  2022
EXEC add_PlayedForByTeamName 'Ersan Ilyasova', 'Atlanta Hawks',  2017
EXEC add_PlayedForByTeamName 'Ersan Ilyasova', 'Philadelphia 76ers',  2017
EXEC add_PlayedForByTeamName 'Ersan Ilyasova', 'Atlanta Hawks',  2018
EXEC add_PlayedForByTeamName 'Ersan Ilyasova', 'Milwaukee Bucks',  2020
EXEC add_PlayedForByTeamName 'Ersan Ilyasova', 'Utah Jazz',  2021
EXEC add_PlayedForByTeamName 'Ersan Ilyasova', 'Philadelphia 76ers',  2018
EXEC add_PlayedForByTeamName 'Ersan Ilyasova', 'Milwaukee Bucks',  2019
EXEC add_PlayedForByTeamName 'Kyle Lowry', 'Toronto Raptors',  2017
EXEC add_PlayedForByTeamName 'Kyle Lowry', 'Toronto Raptors',  2018
EXEC add_PlayedForByTeamName 'Kyle Lowry', 'Toronto Raptors',  2019
EXEC add_PlayedForByTeamName 'Kyle Lowry', 'Miami Heat',  2022
EXEC add_PlayedForByTeamName 'Kyle Lowry', 'Toronto Raptors',  2020
EXEC add_PlayedForByTeamName 'Kyle Lowry', 'Toronto Raptors',  2021
EXEC add_PlayedForByTeamName 'Paul Millsap', 'Denver Nuggets',  2018
EXEC add_PlayedForByTeamName 'Paul Millsap', 'Denver Nuggets',  2019
EXEC add_PlayedForByTeamName 'Paul Millsap', 'Philadelphia 76ers',  2022
EXEC add_PlayedForByTeamName 'Paul Millsap', 'Denver Nuggets',  2020
EXEC add_PlayedForByTeamName 'Paul Millsap', 'Denver Nuggets',  2021
EXEC add_PlayedForByTeamName 'Paul Millsap', 'Brooklyn Nets',  2022
EXEC add_PlayedForByTeamName 'J.J. Redick', 'Los Angeles Clippers',  2017
EXEC add_PlayedForByTeamName 'J.J. Redick', 'Philadelphia 76ers',  2018
EXEC add_PlayedForByTeamName 'J.J. Redick', 'Philadelphia 76ers',  2019
EXEC add_PlayedForByTeamName 'J.J. Redick', 'New Orleans Pelicans',  2020
EXEC add_PlayedForByTeamName 'J.J. Redick', 'Dallas Mavericks',  2021
EXEC add_PlayedForByTeamName 'J.J. Redick', 'New Orleans Pelicans',  2021
EXEC add_PlayedForByTeamName 'Rajon Rondo', 'New Orleans Pelicans',  2018
EXEC add_PlayedForByTeamName 'Rajon Rondo', 'Los Angeles Lakers',  2019
EXEC add_PlayedForByTeamName 'Rajon Rondo', 'Los Angeles Lakers',  2020
EXEC add_PlayedForByTeamName 'Rajon Rondo', 'Atlanta Hawks',  2021
EXEC add_PlayedForByTeamName 'Rajon Rondo', 'Los Angeles Clippers',  2021
EXEC add_PlayedForByTeamName 'Rajon Rondo', 'Cleveland Cavaliers',  2022
EXEC add_PlayedForByTeamName 'Rajon Rondo', 'Los Angeles Lakers',  2022
EXEC add_PlayedForByTeamName 'Thabo Sefolosha', 'Utah Jazz',  2018
EXEC add_PlayedForByTeamName 'Thabo Sefolosha', 'Utah Jazz',  2019
EXEC add_PlayedForByTeamName 'Thabo Sefolosha', 'Houston Rockets',  2020
EXEC add_PlayedForByTeamName 'P.J. Tucker', 'Houston Rockets',  2018
EXEC add_PlayedForByTeamName 'P.J. Tucker', 'Houston Rockets',  2019
EXEC add_PlayedForByTeamName 'P.J. Tucker', 'Houston Rockets',  2020
EXEC add_PlayedForByTeamName 'P.J. Tucker', 'Houston Rockets',  2021
EXEC add_PlayedForByTeamName 'P.J. Tucker', 'Milwaukee Bucks',  2021
EXEC add_PlayedForByTeamName 'P.J. Tucker', 'Miami Heat',  2022
EXEC add_PlayedForByTeamName 'Arron Afflalo', 'Sacramento Kings',  2017
EXEC add_PlayedForByTeamName 'Arron Afflalo', 'Orlando Magic',  2018
EXEC add_PlayedForByTeamName 'Joel Anthony', 'San Antonio Spurs',  2017
EXEC add_PlayedForByTeamName 'Marco Belinelli', 'Charlotte Hornets',  2017
EXEC add_PlayedForByTeamName 'Marco Belinelli', 'Atlanta Hawks',  2018
EXEC add_PlayedForByTeamName 'Marco Belinelli', 'Philadelphia 76ers',  2018
EXEC add_PlayedForByTeamName 'Marco Belinelli', 'San Antonio Spurs',  2019
EXEC add_PlayedForByTeamName 'Marco Belinelli', 'San Antonio Spurs',  2020
EXEC add_PlayedForByTeamName 'Corey Brewer', 'Houston Rockets',  2017
EXEC add_PlayedForByTeamName 'Corey Brewer', 'Los Angeles Lakers',  2017
EXEC add_PlayedForByTeamName 'Corey Brewer', 'Los Angeles Lakers',  2018
EXEC add_PlayedForByTeamName 'Corey Brewer', 'Philadelphia 76ers',  2019
EXEC add_PlayedForByTeamName 'Corey Brewer', 'Sacramento Kings',  2019
EXEC add_PlayedForByTeamName 'Corey Brewer', 'Sacramento Kings',  2020
EXEC add_PlayedForByTeamName 'Aaron Brooks', 'Indiana Pacers',  2017
EXEC add_PlayedForByTeamName 'Wilson Chandler', 'Denver Nuggets',  2018
EXEC add_PlayedForByTeamName 'Wilson Chandler', 'Los Angeles Clippers',  2019
EXEC add_PlayedForByTeamName 'Wilson Chandler', 'Philadelphia 76ers',  2019
EXEC add_PlayedForByTeamName 'Wilson Chandler', 'Brooklyn Nets',  2020
EXEC add_PlayedForByTeamName 'Mike Conley', 'Memphis Grizzlies',  2017
EXEC add_PlayedForByTeamName 'Mike Conley', 'Memphis Grizzlies',  2018
EXEC add_PlayedForByTeamName 'Mike Conley', 'Memphis Grizzlies',  2019
EXEC add_PlayedForByTeamName 'Mike Conley', 'Utah Jazz',  2022
EXEC add_PlayedForByTeamName 'Mike Conley', 'Utah Jazz',  2020
EXEC add_PlayedForByTeamName 'Mike Conley', 'Utah Jazz',  2021
EXEC add_PlayedForByTeamName 'Jared Dudley', 'Phoenix Suns',  2017
EXEC add_PlayedForByTeamName 'Jared Dudley', 'Phoenix Suns',  2018
EXEC add_PlayedForByTeamName 'Jared Dudley', 'Brooklyn Nets',  2019
EXEC add_PlayedForByTeamName 'Jared Dudley', 'Los Angeles Lakers',  2020
EXEC add_PlayedForByTeamName 'Jared Dudley', 'Los Angeles Lakers',  2021
EXEC add_PlayedForByTeamName 'Kevin Durant', 'Brooklyn Nets',  2021
EXEC add_PlayedForByTeamName 'Kevin Durant', 'Brooklyn Nets',  2022
EXEC add_PlayedForByTeamName 'Marcin Gortat', 'Washington Wizards',  2017
EXEC add_PlayedForByTeamName 'Marcin Gortat', 'Washington Wizards',  2018
EXEC add_PlayedForByTeamName 'Marcin Gortat', 'Los Angeles Clippers',  2019
EXEC add_PlayedForByTeamName 'Jeff Green', 'Orlando Magic',  2017
EXEC add_PlayedForByTeamName 'Jeff Green', 'Cleveland Cavaliers',  2018
EXEC add_PlayedForByTeamName 'Jeff Green', 'Washington Wizards',  2019
EXEC add_PlayedForByTeamName 'Jeff Green', 'Houston Rockets',  2020
EXEC add_PlayedForByTeamName 'Jeff Green', 'Utah Jazz',  2020
EXEC add_PlayedForByTeamName 'Jeff Green', 'Brooklyn Nets',  2021
EXEC add_PlayedForByTeamName 'Jeff Green', 'Denver Nuggets',  2022
EXEC add_PlayedForByTeamName 'Al Horford', 'Boston Celtics',  2017
EXEC add_PlayedForByTeamName 'Al Horford', 'Boston Celtics',  2018
EXEC add_PlayedForByTeamName 'Al Horford', 'Boston Celtics',  2019
EXEC add_PlayedForByTeamName 'Al Horford', 'Philadelphia 76ers',  2020
EXEC add_PlayedForByTeamName 'Al Horford', 'Boston Celtics',  2022
EXEC add_PlayedForByTeamName 'Ian Mahinmi', 'Washington Wizards',  2017
EXEC add_PlayedForByTeamName 'Ian Mahinmi', 'Washington Wizards',  2018
EXEC add_PlayedForByTeamName 'Ian Mahinmi', 'Washington Wizards',  2019
EXEC add_PlayedForByTeamName 'Ian Mahinmi', 'Washington Wizards',  2020
EXEC add_PlayedForByTeamName 'Josh McRoberts', 'Miami Heat',  2017
EXEC add_PlayedForByTeamName 'Josh McRoberts', 'Dallas Mavericks',  2018
EXEC add_PlayedForByTeamName 'Joakim Noah', 'New York Knicks',  2017
EXEC add_PlayedForByTeamName 'Joakim Noah', 'New York Knicks',  2018
EXEC add_PlayedForByTeamName 'Joakim Noah', 'Memphis Grizzlies',  2019
EXEC add_PlayedForByTeamName 'Joakim Noah', 'Los Angeles Clippers',  2020
EXEC add_PlayedForByTeamName 'Luis Scola', 'Brooklyn Nets',  2017
EXEC add_PlayedForByTeamName 'Ramon Sessions', 'New York Knicks',  2018
EXEC add_PlayedForByTeamName 'Ramon Sessions', 'Washington Wizards',  2018
EXEC add_PlayedForByTeamName 'Jason Smith', 'Washington Wizards',  2017
EXEC add_PlayedForByTeamName 'Jason Smith', 'Washington Wizards',  2018
EXEC add_PlayedForByTeamName 'Jason Smith', 'Milwaukee Bucks',  2019
EXEC add_PlayedForByTeamName 'Jason Smith', 'New Orleans Pelicans',  2019
EXEC add_PlayedForByTeamName 'Jason Smith', 'Washington Wizards',  2019
EXEC add_PlayedForByTeamName 'C.J. Watson', 'Orlando Magic',  2017
EXEC add_PlayedForByTeamName 'Brandan Wright', 'Memphis Grizzlies',  2017
EXEC add_PlayedForByTeamName 'Brandan Wright', 'Houston Rockets',  2018
EXEC add_PlayedForByTeamName 'Brandan Wright', 'Memphis Grizzlies',  2018
EXEC add_PlayedForByTeamName 'Nick Young', 'Los Angeles Lakers',  2017
EXEC add_PlayedForByTeamName 'Nick Young', 'Denver Nuggets',  2019
EXEC add_PlayedForByTeamName 'Thaddeus Young', 'Indiana Pacers',  2018
EXEC add_PlayedForByTeamName 'Thaddeus Young', 'Indiana Pacers',  2019
EXEC add_PlayedForByTeamName 'Thaddeus Young', 'San Antonio Spurs',  2022
EXEC add_PlayedForByTeamName 'Thaddeus Young', 'Toronto Raptors',  2022
EXEC add_PlayedForByTeamName 'Thaddeus Young', 'Chicago Bulls',  2020
EXEC add_PlayedForByTeamName 'Thaddeus Young', 'Chicago Bulls',  2021
EXEC add_PlayedForByTeamName 'Ryan Anderson', 'Houston Rockets',  2018
EXEC add_PlayedForByTeamName 'Ryan Anderson', 'Miami Heat',  2019
EXEC add_PlayedForByTeamName 'Ryan Anderson', 'Phoenix Suns',  2019
EXEC add_PlayedForByTeamName 'Ryan Anderson', 'Houston Rockets',  2020
EXEC add_PlayedForByTeamName 'Darrell Arthur', 'Denver Nuggets',  2017
EXEC add_PlayedForByTeamName 'Darrell Arthur', 'Denver Nuggets',  2018
EXEC add_PlayedForByTeamName 'D.J. Augustin', 'Orlando Magic',  2017
EXEC add_PlayedForByTeamName 'D.J. Augustin', 'Orlando Magic',  2018
EXEC add_PlayedForByTeamName 'D.J. Augustin', 'Orlando Magic',  2019
EXEC add_PlayedForByTeamName 'D.J. Augustin', 'Orlando Magic',  2020
EXEC add_PlayedForByTeamName 'D.J. Augustin', 'Houston Rockets',  2021
EXEC add_PlayedForByTeamName 'D.J. Augustin', 'Milwaukee Bucks',  2021
EXEC add_PlayedForByTeamName 'D.J. Augustin', 'Houston Rockets',  2022
EXEC add_PlayedForByTeamName 'Nicolas Batum', 'Charlotte Hornets',  2017
EXEC add_PlayedForByTeamName 'Nicolas Batum', 'Charlotte Hornets',  2018
EXEC add_PlayedForByTeamName 'Nicolas Batum', 'Charlotte Hornets',  2019
EXEC add_PlayedForByTeamName 'Nicolas Batum', 'Charlotte Hornets',  2020
EXEC add_PlayedForByTeamName 'Nicolas Batum', 'Los Angeles Clippers',  2021
EXEC add_PlayedForByTeamName 'Nicolas Batum', 'Los Angeles Clippers',  2022
EXEC add_PlayedForByTeamName 'Jerryd Bayless', 'Philadelphia 76ers',  2017
EXEC add_PlayedForByTeamName 'Jerryd Bayless', 'Philadelphia 76ers',  2018
EXEC add_PlayedForByTeamName 'Michael Beasley', 'Milwaukee Bucks',  2017
EXEC add_PlayedForByTeamName 'Michael Beasley', 'New York Knicks',  2018
EXEC add_PlayedForByTeamName 'Michael Beasley', 'Los Angeles Lakers',  2019
EXEC add_PlayedForByTeamName 'Bobby Brown', 'Houston Rockets',  2017
EXEC add_PlayedForByTeamName 'Bobby Brown', 'Houston Rockets',  2018
EXEC add_PlayedForByTeamName 'Mario Chalmers', 'Memphis Grizzlies',  2018
EXEC add_PlayedForByTeamName 'Goran Dragic', 'Miami Heat',  2017
EXEC add_PlayedForByTeamName 'Goran Dragic', 'Miami Heat',  2018
EXEC add_PlayedForByTeamName 'Goran Dragic', 'Miami Heat',  2019
EXEC add_PlayedForByTeamName 'Goran Dragic', 'Toronto Raptors',  2022
EXEC add_PlayedForByTeamName 'Goran Dragic', 'Miami Heat',  2020
EXEC add_PlayedForByTeamName 'Goran Dragic', 'Miami Heat',  2021
EXEC add_PlayedForByTeamName 'Goran Dragic', 'Brooklyn Nets',  2022
EXEC add_PlayedForByTeamName 'Danilo Gallinari', 'Denver Nuggets',  2017
EXEC add_PlayedForByTeamName 'Danilo Gallinari', 'Los Angeles Clippers',  2018
EXEC add_PlayedForByTeamName 'Danilo Gallinari', 'Los Angeles Clippers',  2019
EXEC add_PlayedForByTeamName 'Danilo Gallinari', 'Atlanta Hawks',  2021
EXEC add_PlayedForByTeamName 'Danilo Gallinari', 'Atlanta Hawks',  2022
EXEC add_PlayedForByTeamName 'Marc Gasol', 'Memphis Grizzlies',  2017
EXEC add_PlayedForByTeamName 'Marc Gasol', 'Memphis Grizzlies',  2018
EXEC add_PlayedForByTeamName 'Marc Gasol', 'Memphis Grizzlies',  2019
EXEC add_PlayedForByTeamName 'Marc Gasol', 'Toronto Raptors',  2019
EXEC add_PlayedForByTeamName 'Marc Gasol', 'Toronto Raptors',  2020
EXEC add_PlayedForByTeamName 'Marc Gasol', 'Los Angeles Lakers',  2021
EXEC add_PlayedForByTeamName 'Eric Gordon', 'Houston Rockets',  2017
EXEC add_PlayedForByTeamName 'Eric Gordon', 'Houston Rockets',  2018
EXEC add_PlayedForByTeamName 'Eric Gordon', 'Houston Rockets',  2019
EXEC add_PlayedForByTeamName 'Eric Gordon', 'Houston Rockets',  2020
EXEC add_PlayedForByTeamName 'Eric Gordon', 'Houston Rockets',  2021
EXEC add_PlayedForByTeamName 'Eric Gordon', 'Houston Rockets',  2022
EXEC add_PlayedForByTeamName 'George Hill', 'Utah Jazz',  2017
EXEC add_PlayedForByTeamName 'George Hill', 'Cleveland Cavaliers',  2018
EXEC add_PlayedForByTeamName 'George Hill', 'Sacramento Kings',  2018
EXEC add_PlayedForByTeamName 'George Hill', 'Cleveland Cavaliers',  2019
EXEC add_PlayedForByTeamName 'George Hill', 'Milwaukee Bucks',  2019
EXEC add_PlayedForByTeamName 'George Hill', 'Milwaukee Bucks',  2020
EXEC add_PlayedForByTeamName 'George Hill', 'Philadelphia 76ers',  2021
EXEC add_PlayedForByTeamName 'George Hill', 'Milwaukee Bucks',  2022
EXEC add_PlayedForByTeamName 'DeAndre Jordan', 'Los Angeles Clippers',  2017
EXEC add_PlayedForByTeamName 'DeAndre Jordan', 'Los Angeles Clippers',  2018
EXEC add_PlayedForByTeamName 'DeAndre Jordan', 'Dallas Mavericks',  2019
EXEC add_PlayedForByTeamName 'DeAndre Jordan', 'New York Knicks',  2019
EXEC add_PlayedForByTeamName 'DeAndre Jordan', 'Brooklyn Nets',  2020
EXEC add_PlayedForByTeamName 'DeAndre Jordan', 'Brooklyn Nets',  2021
EXEC add_PlayedForByTeamName 'DeAndre Jordan', 'Los Angeles Lakers',  2022
EXEC add_PlayedForByTeamName 'Kosta Koufos', 'Sacramento Kings',  2017
EXEC add_PlayedForByTeamName 'Kosta Koufos', 'Sacramento Kings',  2018
EXEC add_PlayedForByTeamName 'Kosta Koufos', 'Sacramento Kings',  2019
EXEC add_PlayedForByTeamName 'Courtney Lee', 'New York Knicks',  2017
EXEC add_PlayedForByTeamName 'Courtney Lee', 'New York Knicks',  2018
EXEC add_PlayedForByTeamName 'Courtney Lee', 'Dallas Mavericks',  2019
EXEC add_PlayedForByTeamName 'Courtney Lee', 'New York Knicks',  2019
EXEC add_PlayedForByTeamName 'Courtney Lee', 'Dallas Mavericks',  2020
EXEC add_PlayedForByTeamName 'Brook Lopez', 'Brooklyn Nets',  2017
EXEC add_PlayedForByTeamName 'Brook Lopez', 'Los Angeles Lakers',  2018
EXEC add_PlayedForByTeamName 'Brook Lopez', 'Milwaukee Bucks',  2019
EXEC add_PlayedForByTeamName 'Brook Lopez', 'Milwaukee Bucks',  2020
EXEC add_PlayedForByTeamName 'Brook Lopez', 'Milwaukee Bucks',  2021
EXEC add_PlayedForByTeamName 'Brook Lopez', 'Milwaukee Bucks',  2022
EXEC add_PlayedForByTeamName 'Robin Lopez', 'Chicago Bulls',  2018
EXEC add_PlayedForByTeamName 'Robin Lopez', 'Chicago Bulls',  2019
EXEC add_PlayedForByTeamName 'Robin Lopez', 'Milwaukee Bucks',  2020
EXEC add_PlayedForByTeamName 'Robin Lopez', 'Washington Wizards',  2021
EXEC add_PlayedForByTeamName 'Robin Lopez', 'Orlando Magic',  2022
EXEC add_PlayedForByTeamName 'Kevin Love', 'Cleveland Cavaliers',  2017
EXEC add_PlayedForByTeamName 'Kevin Love', 'Cleveland Cavaliers',  2018
EXEC add_PlayedForByTeamName 'Kevin Love', 'Cleveland Cavaliers',  2019
EXEC add_PlayedForByTeamName 'Kevin Love', 'Cleveland Cavaliers',  2020
EXEC add_PlayedForByTeamName 'Kevin Love', 'Cleveland Cavaliers',  2021
EXEC add_PlayedForByTeamName 'Kevin Love', 'Cleveland Cavaliers',  2022
EXEC add_PlayedForByTeamName 'JaVale McGee', 'Los Angeles Lakers',  2019
EXEC add_PlayedForByTeamName 'JaVale McGee', 'Los Angeles Lakers',  2020
EXEC add_PlayedForByTeamName 'JaVale McGee', 'Cleveland Cavaliers',  2021
EXEC add_PlayedForByTeamName 'JaVale McGee', 'Denver Nuggets',  2021
EXEC add_PlayedForByTeamName 'JaVale McGee', 'Phoenix Suns',  2022
EXEC add_PlayedForByTeamName 'Anthony Morrow', 'Chicago Bulls',  2017
EXEC add_PlayedForByTeamName 'Derrick Rose', 'New York Knicks',  2017
EXEC add_PlayedForByTeamName 'Derrick Rose', 'Cleveland Cavaliers',  2018
EXEC add_PlayedForByTeamName 'Derrick Rose', 'Detroit Pistons',  2020
EXEC add_PlayedForByTeamName 'Derrick Rose', 'Detroit Pistons',  2021
EXEC add_PlayedForByTeamName 'Derrick Rose', 'New York Knicks',  2021
EXEC add_PlayedForByTeamName 'Derrick Rose', 'New York Knicks',  2022
EXEC add_PlayedForByTeamName 'Marreese Speights', 'Los Angeles Clippers',  2017
EXEC add_PlayedForByTeamName 'Marreese Speights', 'Orlando Magic',  2018
EXEC add_PlayedForByTeamName 'Anthony Tolliver', 'Sacramento Kings',  2017
EXEC add_PlayedForByTeamName 'Anthony Tolliver', 'Detroit Pistons',  2018
EXEC add_PlayedForByTeamName 'Anthony Tolliver', 'Memphis Grizzlies',  2020
EXEC add_PlayedForByTeamName 'Anthony Tolliver', 'Sacramento Kings',  2020
EXEC add_PlayedForByTeamName 'Anthony Tolliver', 'Philadelphia 76ers',  2021
EXEC add_PlayedForByTeamName 'Russell Westbrook', 'Houston Rockets',  2020
EXEC add_PlayedForByTeamName 'Russell Westbrook', 'Washington Wizards',  2021
EXEC add_PlayedForByTeamName 'Russell Westbrook', 'Los Angeles Lakers',  2022
EXEC add_PlayedForByTeamName 'DeMarre Carroll', 'Toronto Raptors',  2017
EXEC add_PlayedForByTeamName 'DeMarre Carroll', 'Brooklyn Nets',  2018
EXEC add_PlayedForByTeamName 'DeMarre Carroll', 'Brooklyn Nets',  2019
EXEC add_PlayedForByTeamName 'DeMarre Carroll', 'Houston Rockets',  2020
EXEC add_PlayedForByTeamName 'DeMarre Carroll', 'San Antonio Spurs',  2020
EXEC add_PlayedForByTeamName 'Omri Casspi', 'Memphis Grizzlies',  2019
EXEC add_PlayedForByTeamName 'Darren Collison', 'Sacramento Kings',  2017
EXEC add_PlayedForByTeamName 'Darren Collison', 'Indiana Pacers',  2018
EXEC add_PlayedForByTeamName 'Darren Collison', 'Indiana Pacers',  2019
EXEC add_PlayedForByTeamName 'Darren Collison', 'Los Angeles Lakers',  2022
EXEC add_PlayedForByTeamName 'Dante Cunningham', 'New Orleans Pelicans',  2017
EXEC add_PlayedForByTeamName 'Dante Cunningham', 'Brooklyn Nets',  2018
EXEC add_PlayedForByTeamName 'Dante Cunningham', 'New Orleans Pelicans',  2018
EXEC add_PlayedForByTeamName 'Dante Cunningham', 'San Antonio Spurs',  2019
EXEC add_PlayedForByTeamName 'DeMar DeRozan', 'Toronto Raptors',  2017
EXEC add_PlayedForByTeamName 'DeMar DeRozan', 'Toronto Raptors',  2018
EXEC add_PlayedForByTeamName 'DeMar DeRozan', 'San Antonio Spurs',  2019
EXEC add_PlayedForByTeamName 'DeMar DeRozan', 'San Antonio Spurs',  2020
EXEC add_PlayedForByTeamName 'DeMar DeRozan', 'San Antonio Spurs',  2021
EXEC add_PlayedForByTeamName 'DeMar DeRozan', 'Chicago Bulls',  2022
EXEC add_PlayedForByTeamName 'Wayne Ellington', 'Miami Heat',  2018
EXEC add_PlayedForByTeamName 'Wayne Ellington', 'Detroit Pistons',  2019
EXEC add_PlayedForByTeamName 'Wayne Ellington', 'Miami Heat',  2019
EXEC add_PlayedForByTeamName 'Wayne Ellington', 'New York Knicks',  2020
EXEC add_PlayedForByTeamName 'Wayne Ellington', 'Detroit Pistons',  2021
EXEC add_PlayedForByTeamName 'Wayne Ellington', 'Los Angeles Lakers',  2022
EXEC add_PlayedForByTeamName 'Tyreke Evans', 'Memphis Grizzlies',  2018
EXEC add_PlayedForByTeamName 'Tyreke Evans', 'Indiana Pacers',  2019
EXEC add_PlayedForByTeamName 'Alonzo Gee', 'Denver Nuggets',  2017
EXEC add_PlayedForByTeamName 'Taj Gibson', 'New York Knicks',  2020
EXEC add_PlayedForByTeamName 'Taj Gibson', 'New York Knicks',  2021
EXEC add_PlayedForByTeamName 'Taj Gibson', 'New York Knicks',  2022
EXEC add_PlayedForByTeamName 'Danny Green', 'San Antonio Spurs',  2017
EXEC add_PlayedForByTeamName 'Danny Green', 'San Antonio Spurs',  2018
EXEC add_PlayedForByTeamName 'Danny Green', 'Toronto Raptors',  2019
EXEC add_PlayedForByTeamName 'Danny Green', 'Los Angeles Lakers',  2020
EXEC add_PlayedForByTeamName 'Danny Green', 'Philadelphia 76ers',  2021
EXEC add_PlayedForByTeamName 'Danny Green', 'Philadelphia 76ers',  2022
EXEC add_PlayedForByTeamName 'James Harden', 'Houston Rockets',  2017
EXEC add_PlayedForByTeamName 'James Harden', 'Houston Rockets',  2018
EXEC add_PlayedForByTeamName 'James Harden', 'Houston Rockets',  2019
EXEC add_PlayedForByTeamName 'James Harden', 'Houston Rockets',  2020
EXEC add_PlayedForByTeamName 'James Harden', 'Brooklyn Nets',  2021
EXEC add_PlayedForByTeamName 'James Harden', 'Houston Rockets',  2021
EXEC add_PlayedForByTeamName 'James Harden', 'Brooklyn Nets',  2022
EXEC add_PlayedForByTeamName 'James Harden', 'Philadelphia 76ers',  2022
EXEC add_PlayedForByTeamName 'Jrue Holiday', 'New Orleans Pelicans',  2017
EXEC add_PlayedForByTeamName 'Jrue Holiday', 'New Orleans Pelicans',  2018
EXEC add_PlayedForByTeamName 'Jrue Holiday', 'New Orleans Pelicans',  2019
EXEC add_PlayedForByTeamName 'Jrue Holiday', 'New Orleans Pelicans',  2020
EXEC add_PlayedForByTeamName 'Jrue Holiday', 'Milwaukee Bucks',  2021
EXEC add_PlayedForByTeamName 'Jrue Holiday', 'Milwaukee Bucks',  2022
EXEC add_PlayedForByTeamName 'Serge Ibaka', 'Toronto Raptors',  2018
EXEC add_PlayedForByTeamName 'Serge Ibaka', 'Toronto Raptors',  2019
EXEC add_PlayedForByTeamName 'Serge Ibaka', 'Toronto Raptors',  2020
EXEC add_PlayedForByTeamName 'Serge Ibaka', 'Los Angeles Clippers',  2021
EXEC add_PlayedForByTeamName 'Serge Ibaka', 'Los Angeles Clippers',  2022
EXEC add_PlayedForByTeamName 'Serge Ibaka', 'Milwaukee Bucks',  2022
EXEC add_PlayedForByTeamName 'Brandon Jennings', 'New York Knicks',  2017
EXEC add_PlayedForByTeamName 'Brandon Jennings', 'Washington Wizards',  2017
EXEC add_PlayedForByTeamName 'Brandon Jennings', 'Milwaukee Bucks',  2018
EXEC add_PlayedForByTeamName 'Jonas Jerebko', 'Boston Celtics',  2017
EXEC add_PlayedForByTeamName 'Jonas Jerebko', 'Utah Jazz',  2018
EXEC add_PlayedForByTeamName 'James Johnson', 'Miami Heat',  2017
EXEC add_PlayedForByTeamName 'James Johnson', 'Miami Heat',  2018
EXEC add_PlayedForByTeamName 'James Johnson', 'Miami Heat',  2019
EXEC add_PlayedForByTeamName 'James Johnson', 'Miami Heat',  2020
EXEC add_PlayedForByTeamName 'James Johnson', 'Dallas Mavericks',  2021
EXEC add_PlayedForByTeamName 'James Johnson', 'New Orleans Pelicans',  2021
EXEC add_PlayedForByTeamName 'James Johnson', 'Brooklyn Nets',  2022
EXEC add_PlayedForByTeamName 'Wesley Matthews', 'Dallas Mavericks',  2018
EXEC add_PlayedForByTeamName 'Wesley Matthews', 'Milwaukee Bucks',  2022
EXEC add_PlayedForByTeamName 'Wesley Matthews', 'Milwaukee Bucks',  2020
EXEC add_PlayedForByTeamName 'Wesley Matthews', 'Los Angeles Lakers',  2021
EXEC add_PlayedForByTeamName 'Wesley Matthews', 'Dallas Mavericks',  2019
EXEC add_PlayedForByTeamName 'Wesley Matthews', 'Indiana Pacers',  2019
EXEC add_PlayedForByTeamName 'Wesley Matthews', 'New York Knicks',  2019
EXEC add_PlayedForByTeamName 'Jodie Meeks', 'Orlando Magic',  2017
EXEC add_PlayedForByTeamName 'Jodie Meeks', 'Washington Wizards',  2018
EXEC add_PlayedForByTeamName 'Jodie Meeks', 'Toronto Raptors',  2019
EXEC add_PlayedForByTeamName 'Patty Mills', 'San Antonio Spurs',  2018
EXEC add_PlayedForByTeamName 'Patty Mills', 'San Antonio Spurs',  2020
EXEC add_PlayedForByTeamName 'Patty Mills', 'San Antonio Spurs',  2021
EXEC add_PlayedForByTeamName 'Patty Mills', 'Brooklyn Nets',  2022
EXEC add_PlayedForByTeamName 'Patty Mills', 'San Antonio Spurs',  2019
EXEC add_PlayedForByTeamName 'Jeff Teague', 'Indiana Pacers',  2017
EXEC add_PlayedForByTeamName 'Jeff Teague', 'Atlanta Hawks',  2020
EXEC add_PlayedForByTeamName 'Jeff Teague', 'Boston Celtics',  2021
EXEC add_PlayedForByTeamName 'Jeff Teague', 'Milwaukee Bucks',  2021
EXEC add_PlayedForByTeamName 'Garrett Temple', 'Sacramento Kings',  2017
EXEC add_PlayedForByTeamName 'Garrett Temple', 'Sacramento Kings',  2018
EXEC add_PlayedForByTeamName 'Garrett Temple', 'Los Angeles Clippers',  2019
EXEC add_PlayedForByTeamName 'Garrett Temple', 'Memphis Grizzlies',  2019
EXEC add_PlayedForByTeamName 'Garrett Temple', 'Brooklyn Nets',  2020
EXEC add_PlayedForByTeamName 'Garrett Temple', 'Chicago Bulls',  2021
EXEC add_PlayedForByTeamName 'Garrett Temple', 'New Orleans Pelicans',  2022
EXEC add_PlayedForByTeamName 'Marcus Thornton', 'Washington Wizards',  2017
EXEC add_PlayedForByTeamName 'Al-Farouq Aminu', 'Orlando Magic',  2020
EXEC add_PlayedForByTeamName 'Al-Farouq Aminu', 'Chicago Bulls',  2021
EXEC add_PlayedForByTeamName 'Al-Farouq Aminu', 'Orlando Magic',  2021
EXEC add_PlayedForByTeamName 'Luke Babbitt', 'Miami Heat',  2017
EXEC add_PlayedForByTeamName 'Luke Babbitt', 'Atlanta Hawks',  2018
EXEC add_PlayedForByTeamName 'Luke Babbitt', 'Miami Heat',  2018
EXEC add_PlayedForByTeamName 'Eric Bledsoe', 'Phoenix Suns',  2017
EXEC add_PlayedForByTeamName 'Eric Bledsoe', 'Milwaukee Bucks',  2018
EXEC add_PlayedForByTeamName 'Eric Bledsoe', 'Phoenix Suns',  2018
EXEC add_PlayedForByTeamName 'Eric Bledsoe', 'Milwaukee Bucks',  2019
EXEC add_PlayedForByTeamName 'Eric Bledsoe', 'Milwaukee Bucks',  2020
EXEC add_PlayedForByTeamName 'Eric Bledsoe', 'New Orleans Pelicans',  2021
EXEC add_PlayedForByTeamName 'Eric Bledsoe', 'Los Angeles Clippers',  2022
EXEC add_PlayedForByTeamName 'Trevor Booker', 'Brooklyn Nets',  2018
EXEC add_PlayedForByTeamName 'Trevor Booker', 'Indiana Pacers',  2018
EXEC add_PlayedForByTeamName 'Trevor Booker', 'Philadelphia 76ers',  2018
EXEC add_PlayedForByTeamName 'Avery Bradley', 'Boston Celtics',  2017
EXEC add_PlayedForByTeamName 'Avery Bradley', 'Detroit Pistons',  2018
EXEC add_PlayedForByTeamName 'Avery Bradley', 'Los Angeles Clippers',  2018
EXEC add_PlayedForByTeamName 'Avery Bradley', 'Los Angeles Clippers',  2019
EXEC add_PlayedForByTeamName 'Avery Bradley', 'Memphis Grizzlies',  2019
EXEC add_PlayedForByTeamName 'Avery Bradley', 'Los Angeles Lakers',  2020
EXEC add_PlayedForByTeamName 'Avery Bradley', 'Houston Rockets',  2021
EXEC add_PlayedForByTeamName 'Avery Bradley', 'Miami Heat',  2021
EXEC add_PlayedForByTeamName 'Avery Bradley', 'Los Angeles Lakers',  2022
EXEC add_PlayedForByTeamName 'DeMarcus Cousins', 'New Orleans Pelicans',  2017
EXEC add_PlayedForByTeamName 'DeMarcus Cousins', 'Sacramento Kings',  2017
EXEC add_PlayedForByTeamName 'DeMarcus Cousins', 'New Orleans Pelicans',  2018
EXEC add_PlayedForByTeamName 'DeMarcus Cousins', 'Houston Rockets',  2021
EXEC add_PlayedForByTeamName 'DeMarcus Cousins', 'Los Angeles Clippers',  2021
EXEC add_PlayedForByTeamName 'DeMarcus Cousins', 'Denver Nuggets',  2022
EXEC add_PlayedForByTeamName 'DeMarcus Cousins', 'Milwaukee Bucks',  2022
EXEC add_PlayedForByTeamName 'Jordan Crawford', 'New Orleans Pelicans',  2017
EXEC add_PlayedForByTeamName 'Jordan Crawford', 'New Orleans Pelicans',  2018
EXEC add_PlayedForByTeamName 'Ed Davis', 'Brooklyn Nets',  2019
EXEC add_PlayedForByTeamName 'Ed Davis', 'Utah Jazz',  2020
EXEC add_PlayedForByTeamName 'Ed Davis', 'Cleveland Cavaliers',  2022
EXEC add_PlayedForByTeamName 'Jeremy Evans', 'Atlanta Hawks',  2018
EXEC add_PlayedForByTeamName 'Derrick Favors', 'Utah Jazz',  2017
EXEC add_PlayedForByTeamName 'Derrick Favors', 'Utah Jazz',  2021
EXEC add_PlayedForByTeamName 'Derrick Favors', 'Utah Jazz',  2019
EXEC add_PlayedForByTeamName 'Derrick Favors', 'New Orleans Pelicans',  2020
EXEC add_PlayedForByTeamName 'Derrick Favors', 'Utah Jazz',  2018
EXEC add_PlayedForByTeamName 'Paul George', 'Los Angeles Clippers',  2020
EXEC add_PlayedForByTeamName 'Paul George', 'Los Angeles Clippers',  2021
EXEC add_PlayedForByTeamName 'Paul George', 'Los Angeles Clippers',  2022
EXEC add_PlayedForByTeamName 'Blake Griffin', 'Los Angeles Clippers',  2017
EXEC add_PlayedForByTeamName 'Blake Griffin', 'Detroit Pistons',  2018
EXEC add_PlayedForByTeamName 'Blake Griffin', 'Los Angeles Clippers',  2018
EXEC add_PlayedForByTeamName 'Blake Griffin', 'Detroit Pistons',  2019
EXEC add_PlayedForByTeamName 'Blake Griffin', 'Detroit Pistons',  2020
EXEC add_PlayedForByTeamName 'Blake Griffin', 'Brooklyn Nets',  2021
EXEC add_PlayedForByTeamName 'Blake Griffin', 'Detroit Pistons',  2021
EXEC add_PlayedForByTeamName 'Blake Griffin', 'Brooklyn Nets',  2022
EXEC add_PlayedForByTeamName 'Manny Harris', 'Dallas Mavericks',  2017
EXEC add_PlayedForByTeamName 'Gordon Hayward', 'Utah Jazz',  2017
EXEC add_PlayedForByTeamName 'Gordon Hayward', 'Boston Celtics',  2018
EXEC add_PlayedForByTeamName 'Gordon Hayward', 'Charlotte Hornets',  2022
EXEC add_PlayedForByTeamName 'Gordon Hayward', 'Boston Celtics',  2019
EXEC add_PlayedForByTeamName 'Gordon Hayward', 'Boston Celtics',  2020
EXEC add_PlayedForByTeamName 'Gordon Hayward', 'Charlotte Hornets',  2021
EXEC add_PlayedForByTeamName 'Wesley Johnson', 'Los Angeles Clippers',  2018
EXEC add_PlayedForByTeamName 'Wesley Johnson', 'New Orleans Pelicans',  2019
EXEC add_PlayedForByTeamName 'Wesley Johnson', 'Washington Wizards',  2019
EXEC add_PlayedForByTeamName 'Jeremy Lin', 'Brooklyn Nets',  2017
EXEC add_PlayedForByTeamName 'Jeremy Lin', 'Brooklyn Nets',  2018
EXEC add_PlayedForByTeamName 'Jeremy Lin', 'Atlanta Hawks',  2019
EXEC add_PlayedForByTeamName 'Jeremy Lin', 'Toronto Raptors',  2019
EXEC add_PlayedForByTeamName 'Greg Monroe', 'Milwaukee Bucks',  2017
EXEC add_PlayedForByTeamName 'Greg Monroe', 'Boston Celtics',  2018
EXEC add_PlayedForByTeamName 'Greg Monroe', 'Milwaukee Bucks',  2018
EXEC add_PlayedForByTeamName 'Greg Monroe', 'Phoenix Suns',  2018
EXEC add_PlayedForByTeamName 'Greg Monroe', 'Boston Celtics',  2019
EXEC add_PlayedForByTeamName 'Greg Monroe', 'Philadelphia 76ers',  2019
EXEC add_PlayedForByTeamName 'Greg Monroe', 'Toronto Raptors',  2019
EXEC add_PlayedForByTeamName 'Greg Monroe', 'Milwaukee Bucks',  2022
EXEC add_PlayedForByTeamName 'Greg Monroe', 'Washington Wizards',  2022
EXEC add_PlayedForByTeamName 'Timofey Mozgov', 'Brooklyn Nets',  2018
EXEC add_PlayedForByTeamName 'Gary Neal', 'Atlanta Hawks',  2017
EXEC add_PlayedForByTeamName 'Patrick Patterson', 'Los Angeles Clippers',  2020
EXEC add_PlayedForByTeamName 'Patrick Patterson', 'Los Angeles Clippers',  2021
EXEC add_PlayedForByTeamName 'Quincy Pondexter', 'Chicago Bulls',  2018
EXEC add_PlayedForByTeamName 'Quincy Pondexter', 'San Antonio Spurs',  2019
EXEC add_PlayedForByTeamName 'Larry Sanders', 'Cleveland Cavaliers',  2017
EXEC add_PlayedForByTeamName 'Ish Smith', 'Detroit Pistons',  2017
EXEC add_PlayedForByTeamName 'Ish Smith', 'Detroit Pistons',  2018
EXEC add_PlayedForByTeamName 'Ish Smith', 'Detroit Pistons',  2019
EXEC add_PlayedForByTeamName 'Ish Smith', 'Washington Wizards',  2020
EXEC add_PlayedForByTeamName 'Ish Smith', 'Washington Wizards',  2021
EXEC add_PlayedForByTeamName 'Ish Smith', 'Charlotte Hornets',  2022
EXEC add_PlayedForByTeamName 'Ish Smith', 'Washington Wizards',  2022
EXEC add_PlayedForByTeamName 'Lance Stephenson', 'Indiana Pacers',  2017
EXEC add_PlayedForByTeamName 'Lance Stephenson', 'New Orleans Pelicans',  2017
EXEC add_PlayedForByTeamName 'Lance Stephenson', 'Indiana Pacers',  2018
EXEC add_PlayedForByTeamName 'Lance Stephenson', 'Los Angeles Lakers',  2019
EXEC add_PlayedForByTeamName 'Lance Stephenson', 'Atlanta Hawks',  2022
EXEC add_PlayedForByTeamName 'Lance Stephenson', 'Indiana Pacers',  2022
EXEC add_PlayedForByTeamName 'Evan Turner', 'Atlanta Hawks',  2020
EXEC add_PlayedForByTeamName 'Ekpe Udoh', 'Utah Jazz',  2018
EXEC add_PlayedForByTeamName 'Ekpe Udoh', 'Utah Jazz',  2019
EXEC add_PlayedForByTeamName 'John Wall', 'Washington Wizards',  2017
EXEC add_PlayedForByTeamName 'John Wall', 'Washington Wizards',  2018
EXEC add_PlayedForByTeamName 'John Wall', 'Washington Wizards',  2019
EXEC add_PlayedForByTeamName 'John Wall', 'Houston Rockets',  2021
EXEC add_PlayedForByTeamName 'Hassan Whiteside', 'Miami Heat',  2017
EXEC add_PlayedForByTeamName 'Hassan Whiteside', 'Miami Heat',  2018
EXEC add_PlayedForByTeamName 'Hassan Whiteside', 'Miami Heat',  2019
EXEC add_PlayedForByTeamName 'Hassan Whiteside', 'Sacramento Kings',  2021
EXEC add_PlayedForByTeamName 'Hassan Whiteside', 'Utah Jazz',  2022
EXEC add_PlayedForByTeamName 'Lavoy Allen', 'Indiana Pacers',  2017
EXEC add_PlayedForByTeamName 'Bismack Biyombo', 'Orlando Magic',  2017
EXEC add_PlayedForByTeamName 'Bismack Biyombo', 'Orlando Magic',  2018
EXEC add_PlayedForByTeamName 'Bismack Biyombo', 'Charlotte Hornets',  2019
EXEC add_PlayedForByTeamName 'Bismack Biyombo', 'Charlotte Hornets',  2020
EXEC add_PlayedForByTeamName 'Bismack Biyombo', 'Charlotte Hornets',  2021
EXEC add_PlayedForByTeamName 'Bismack Biyombo', 'Phoenix Suns',  2022
EXEC add_PlayedForByTeamName 'MarShon Brooks', 'Memphis Grizzlies',  2018
EXEC add_PlayedForByTeamName 'MarShon Brooks', 'Memphis Grizzlies',  2019
EXEC add_PlayedForByTeamName 'Alec Burks', 'Utah Jazz',  2017
EXEC add_PlayedForByTeamName 'Alec Burks', 'Utah Jazz',  2018
EXEC add_PlayedForByTeamName 'Alec Burks', 'New York Knicks',  2022
EXEC add_PlayedForByTeamName 'Alec Burks', 'Philadelphia 76ers',  2020
EXEC add_PlayedForByTeamName 'Alec Burks', 'New York Knicks',  2021
EXEC add_PlayedForByTeamName 'Alec Burks', 'Cleveland Cavaliers',  2019
EXEC add_PlayedForByTeamName 'Alec Burks', 'Sacramento Kings',  2019
EXEC add_PlayedForByTeamName 'Alec Burks', 'Utah Jazz',  2019
EXEC add_PlayedForByTeamName 'Jimmy Butler', 'Chicago Bulls',  2017
EXEC add_PlayedForByTeamName 'Jimmy Butler', 'Philadelphia 76ers',  2019
EXEC add_PlayedForByTeamName 'Jimmy Butler', 'Miami Heat',  2020
EXEC add_PlayedForByTeamName 'Jimmy Butler', 'Miami Heat',  2021
EXEC add_PlayedForByTeamName 'Jimmy Butler', 'Miami Heat',  2022
EXEC add_PlayedForByTeamName 'Kenneth Faried', 'Denver Nuggets',  2017
EXEC add_PlayedForByTeamName 'Kenneth Faried', 'Denver Nuggets',  2018
EXEC add_PlayedForByTeamName 'Kenneth Faried', 'Brooklyn Nets',  2019
EXEC add_PlayedForByTeamName 'Kenneth Faried', 'Houston Rockets',  2019
EXEC add_PlayedForByTeamName 'Jimmer Fredette', 'Phoenix Suns',  2019
EXEC add_PlayedForByTeamName 'Justin Harper', 'Philadelphia 76ers',  2017
EXEC add_PlayedForByTeamName 'Tobias Harris', 'Detroit Pistons',  2018
EXEC add_PlayedForByTeamName 'Tobias Harris', 'Los Angeles Clippers',  2018
EXEC add_PlayedForByTeamName 'Tobias Harris', 'Los Angeles Clippers',  2019
EXEC add_PlayedForByTeamName 'Tobias Harris', 'Philadelphia 76ers',  2019
EXEC add_PlayedForByTeamName 'Tobias Harris', 'Philadelphia 76ers',  2020
EXEC add_PlayedForByTeamName 'Tobias Harris', 'Philadelphia 76ers',  2021
EXEC add_PlayedForByTeamName 'Tobias Harris', 'Philadelphia 76ers',  2022
EXEC add_PlayedForByTeamName 'Kyrie Irving', 'Cleveland Cavaliers',  2017
EXEC add_PlayedForByTeamName 'Kyrie Irving', 'Boston Celtics',  2018
EXEC add_PlayedForByTeamName 'Kyrie Irving', 'Boston Celtics',  2019
EXEC add_PlayedForByTeamName 'Kyrie Irving', 'Brooklyn Nets',  2020
EXEC add_PlayedForByTeamName 'Kyrie Irving', 'Brooklyn Nets',  2021
EXEC add_PlayedForByTeamName 'Kyrie Irving', 'Brooklyn Nets',  2022
EXEC add_PlayedForByTeamName 'Reggie Jackson', 'Detroit Pistons',  2018
EXEC add_PlayedForByTeamName 'Reggie Jackson', 'Detroit Pistons',  2019
EXEC add_PlayedForByTeamName 'Reggie Jackson', 'Detroit Pistons',  2020
EXEC add_PlayedForByTeamName 'Reggie Jackson', 'Los Angeles Clippers',  2020
EXEC add_PlayedForByTeamName 'Reggie Jackson', 'Los Angeles Clippers',  2021
EXEC add_PlayedForByTeamName 'Reggie Jackson', 'Los Angeles Clippers',  2022
EXEC add_PlayedForByTeamName 'Cory Joseph', 'Toronto Raptors',  2017
EXEC add_PlayedForByTeamName 'Cory Joseph', 'Indiana Pacers',  2018
EXEC add_PlayedForByTeamName 'Cory Joseph', 'Indiana Pacers',  2019
EXEC add_PlayedForByTeamName 'Cory Joseph', 'Sacramento Kings',  2020
EXEC add_PlayedForByTeamName 'Cory Joseph', 'Detroit Pistons',  2021
EXEC add_PlayedForByTeamName 'Cory Joseph', 'Sacramento Kings',  2021
EXEC add_PlayedForByTeamName 'Cory Joseph', 'Detroit Pistons',  2022
EXEC add_PlayedForByTeamName 'Enes Kanter', 'New York Knicks',  2018
EXEC add_PlayedForByTeamName 'Enes Kanter', 'New York Knicks',  2019
EXEC add_PlayedForByTeamName 'Enes Kanter', 'Boston Celtics',  2020
EXEC add_PlayedForByTeamName 'Enes Kanter', 'Boston Celtics',  2022
EXEC add_PlayedForByTeamName 'Brandon Knight', 'Phoenix Suns',  2017
EXEC add_PlayedForByTeamName 'Brandon Knight', 'Cleveland Cavaliers',  2019
EXEC add_PlayedForByTeamName 'Brandon Knight', 'Houston Rockets',  2019
EXEC add_PlayedForByTeamName 'Brandon Knight', 'Cleveland Cavaliers',  2020
EXEC add_PlayedForByTeamName 'Brandon Knight', 'Detroit Pistons',  2020
EXEC add_PlayedForByTeamName 'Brandon Knight', 'Dallas Mavericks',  2022
EXEC add_PlayedForByTeamName 'Kawhi Leonard', 'San Antonio Spurs',  2017
EXEC add_PlayedForByTeamName 'Kawhi Leonard', 'San Antonio Spurs',  2018
EXEC add_PlayedForByTeamName 'Kawhi Leonard', 'Toronto Raptors',  2019
EXEC add_PlayedForByTeamName 'Kawhi Leonard', 'Los Angeles Clippers',  2020
EXEC add_PlayedForByTeamName 'Kawhi Leonard', 'Los Angeles Clippers',  2021
EXEC add_PlayedForByTeamName 'Jon Leuer', 'Detroit Pistons',  2017
EXEC add_PlayedForByTeamName 'Jon Leuer', 'Detroit Pistons',  2018
EXEC add_PlayedForByTeamName 'Jon Leuer', 'Detroit Pistons',  2019
EXEC add_PlayedForByTeamName 'DeAndre Liggins', 'Cleveland Cavaliers',  2017
EXEC add_PlayedForByTeamName 'DeAndre Liggins', 'Dallas Mavericks',  2017
EXEC add_PlayedForByTeamName 'DeAndre Liggins', 'Milwaukee Bucks',  2018
EXEC add_PlayedForByTeamName 'DeAndre Liggins', 'New Orleans Pelicans',  2018
EXEC add_PlayedForByTeamName 'Shelvin Mack', 'Orlando Magic',  2018
EXEC add_PlayedForByTeamName 'Shelvin Mack', 'Charlotte Hornets',  2019
EXEC add_PlayedForByTeamName 'Shelvin Mack', 'Memphis Grizzlies',  2019
EXEC add_PlayedForByTeamName 'E"Twaun Moore', 'New Orleans Pelicans',  2017
EXEC add_PlayedForByTeamName 'E"Twaun Moore', 'New Orleans Pelicans',  2018
EXEC add_PlayedForByTeamName 'E"Twaun Moore', 'New Orleans Pelicans',  2019
EXEC add_PlayedForByTeamName 'E"Twaun Moore', 'New Orleans Pelicans',  2020
EXEC add_PlayedForByTeamName 'E"Twaun Moore', 'Phoenix Suns',  2021
EXEC add_PlayedForByTeamName 'Marcus Morris', 'Detroit Pistons',  2017
EXEC add_PlayedForByTeamName 'Marcus Morris', 'Boston Celtics',  2018
EXEC add_PlayedForByTeamName 'Marcus Morris', 'Boston Celtics',  2019
EXEC add_PlayedForByTeamName 'Marcus Morris', 'Los Angeles Clippers',  2020
EXEC add_PlayedForByTeamName 'Marcus Morris', 'New York Knicks',  2020
EXEC add_PlayedForByTeamName 'Marcus Morris', 'Los Angeles Clippers',  2021
EXEC add_PlayedForByTeamName 'Marcus Morris', 'Los Angeles Clippers',  2022
EXEC add_PlayedForByTeamName 'Markieff Morris', 'Washington Wizards',  2017
EXEC add_PlayedForByTeamName 'Markieff Morris', 'Washington Wizards',  2018
EXEC add_PlayedForByTeamName 'Markieff Morris', 'Washington Wizards',  2019
EXEC add_PlayedForByTeamName 'Markieff Morris', 'Detroit Pistons',  2020
EXEC add_PlayedForByTeamName 'Markieff Morris', 'Los Angeles Lakers',  2020
EXEC add_PlayedForByTeamName 'Markieff Morris', 'Los Angeles Lakers',  2021
EXEC add_PlayedForByTeamName 'Markieff Morris', 'Miami Heat',  2022
EXEC add_PlayedForByTeamName 'Chandler Parsons', 'Memphis Grizzlies',  2017
EXEC add_PlayedForByTeamName 'Chandler Parsons', 'Memphis Grizzlies',  2018
EXEC add_PlayedForByTeamName 'Chandler Parsons', 'Memphis Grizzlies',  2019
EXEC add_PlayedForByTeamName 'Chandler Parsons', 'Atlanta Hawks',  2020
EXEC add_PlayedForByTeamName 'Ricky Rubio', 'Utah Jazz',  2018
EXEC add_PlayedForByTeamName 'Ricky Rubio', 'Utah Jazz',  2019
EXEC add_PlayedForByTeamName 'Ricky Rubio', 'Cleveland Cavaliers',  2022
EXEC add_PlayedForByTeamName 'Ricky Rubio', 'Phoenix Suns',  2020
EXEC add_PlayedForByTeamName 'Iman Shumpert', 'Cleveland Cavaliers',  2017
EXEC add_PlayedForByTeamName 'Iman Shumpert', 'Cleveland Cavaliers',  2018
EXEC add_PlayedForByTeamName 'Iman Shumpert', 'Houston Rockets',  2019
EXEC add_PlayedForByTeamName 'Iman Shumpert', 'Sacramento Kings',  2019
EXEC add_PlayedForByTeamName 'Iman Shumpert', 'Brooklyn Nets',  2020
EXEC add_PlayedForByTeamName 'Iman Shumpert', 'Brooklyn Nets',  2021
EXEC add_PlayedForByTeamName 'Xavier Silas', 'Boston Celtics',  2018
EXEC add_PlayedForByTeamName 'Julyan Stone', 'Charlotte Hornets',  2018
EXEC add_PlayedForByTeamName 'Isaiah Thomas', 'Boston Celtics',  2017
EXEC add_PlayedForByTeamName 'Isaiah Thomas', 'Cleveland Cavaliers',  2018
EXEC add_PlayedForByTeamName 'Isaiah Thomas', 'Los Angeles Lakers',  2018
EXEC add_PlayedForByTeamName 'Isaiah Thomas', 'Denver Nuggets',  2019
EXEC add_PlayedForByTeamName 'Isaiah Thomas', 'Washington Wizards',  2020
EXEC add_PlayedForByTeamName 'Isaiah Thomas', 'New Orleans Pelicans',  2021
EXEC add_PlayedForByTeamName 'Isaiah Thomas', 'Dallas Mavericks',  2022
EXEC add_PlayedForByTeamName 'Isaiah Thomas', 'Los Angeles Lakers',  2022
EXEC add_PlayedForByTeamName 'Lance Thomas', 'New York Knicks',  2017
EXEC add_PlayedForByTeamName 'Lance Thomas', 'New York Knicks',  2018
EXEC add_PlayedForByTeamName 'Lance Thomas', 'New York Knicks',  2019
EXEC add_PlayedForByTeamName 'Lance Thomas', 'Brooklyn Nets',  2020
EXEC add_PlayedForByTeamName 'Tristan Thompson', 'Cleveland Cavaliers',  2018
EXEC add_PlayedForByTeamName 'Tristan Thompson', 'Cleveland Cavaliers',  2019
EXEC add_PlayedForByTeamName 'Tristan Thompson', 'Cleveland Cavaliers',  2020
EXEC add_PlayedForByTeamName 'Tristan Thompson', 'Boston Celtics',  2021
EXEC add_PlayedForByTeamName 'Tristan Thompson', 'Chicago Bulls',  2022
EXEC add_PlayedForByTeamName 'Tristan Thompson', 'Indiana Pacers',  2022
EXEC add_PlayedForByTeamName 'Tristan Thompson', 'Sacramento Kings',  2022
EXEC add_PlayedForByTeamName 'Nikola Vucevic', 'Orlando Magic',  2017
EXEC add_PlayedForByTeamName 'Nikola Vucevic', 'Orlando Magic',  2018
EXEC add_PlayedForByTeamName 'Nikola Vucevic', 'Orlando Magic',  2019
EXEC add_PlayedForByTeamName 'Nikola Vucevic', 'Orlando Magic',  2020
EXEC add_PlayedForByTeamName 'Nikola Vucevic', 'Chicago Bulls',  2021
EXEC add_PlayedForByTeamName 'Nikola Vucevic', 'Orlando Magic',  2021
EXEC add_PlayedForByTeamName 'Nikola Vucevic', 'Chicago Bulls',  2022
EXEC add_PlayedForByTeamName 'Kemba Walker', 'Charlotte Hornets',  2017
EXEC add_PlayedForByTeamName 'Kemba Walker', 'Charlotte Hornets',  2018
EXEC add_PlayedForByTeamName 'Kemba Walker', 'Charlotte Hornets',  2019
EXEC add_PlayedForByTeamName 'Kemba Walker', 'Boston Celtics',  2020
EXEC add_PlayedForByTeamName 'Kemba Walker', 'Boston Celtics',  2021
EXEC add_PlayedForByTeamName 'Kemba Walker', 'New York Knicks',  2022
EXEC add_PlayedForByTeamName 'Derrick Williams', 'Cleveland Cavaliers',  2017
EXEC add_PlayedForByTeamName 'Derrick Williams', 'Miami Heat',  2017
EXEC add_PlayedForByTeamName 'Derrick Williams', 'Los Angeles Lakers',  2018
EXEC add_PlayedForByTeamName 'Quincy Acy', 'Brooklyn Nets',  2018
EXEC add_PlayedForByTeamName 'Quincy Acy', 'Phoenix Suns',  2019
EXEC add_PlayedForByTeamName 'Harrison Barnes', 'Dallas Mavericks',  2017
EXEC add_PlayedForByTeamName 'Harrison Barnes', 'Dallas Mavericks',  2018
EXEC add_PlayedForByTeamName 'Harrison Barnes', 'Dallas Mavericks',  2019
EXEC add_PlayedForByTeamName 'Harrison Barnes', 'Sacramento Kings',  2019
EXEC add_PlayedForByTeamName 'Harrison Barnes', 'Sacramento Kings',  2020
EXEC add_PlayedForByTeamName 'Harrison Barnes', 'Sacramento Kings',  2021
EXEC add_PlayedForByTeamName 'Harrison Barnes', 'Sacramento Kings',  2022
EXEC add_PlayedForByTeamName 'Will Barton', 'Denver Nuggets',  2018
EXEC add_PlayedForByTeamName 'Will Barton', 'Denver Nuggets',  2019
EXEC add_PlayedForByTeamName 'Will Barton', 'Denver Nuggets',  2020
EXEC add_PlayedForByTeamName 'Will Barton', 'Denver Nuggets',  2021
EXEC add_PlayedForByTeamName 'Will Barton', 'Denver Nuggets',  2022
EXEC add_PlayedForByTeamName 'Aron Baynes', 'Detroit Pistons',  2017
EXEC add_PlayedForByTeamName 'Aron Baynes', 'Boston Celtics',  2018
EXEC add_PlayedForByTeamName 'Aron Baynes', 'Boston Celtics',  2019
EXEC add_PlayedForByTeamName 'Aron Baynes', 'Phoenix Suns',  2020
EXEC add_PlayedForByTeamName 'Aron Baynes', 'Toronto Raptors',  2021
EXEC add_PlayedForByTeamName 'Kent Bazemore', 'Atlanta Hawks',  2017
EXEC add_PlayedForByTeamName 'Kent Bazemore', 'Atlanta Hawks',  2018
EXEC add_PlayedForByTeamName 'Kent Bazemore', 'Atlanta Hawks',  2019
EXEC add_PlayedForByTeamName 'Kent Bazemore', 'Sacramento Kings',  2020
EXEC add_PlayedForByTeamName 'Kent Bazemore', 'Los Angeles Lakers',  2022
EXEC add_PlayedForByTeamName 'Bradley Beal', 'Washington Wizards',  2017
EXEC add_PlayedForByTeamName 'Bradley Beal', 'Washington Wizards',  2018
EXEC add_PlayedForByTeamName 'Bradley Beal', 'Washington Wizards',  2019
EXEC add_PlayedForByTeamName 'Bradley Beal', 'Washington Wizards',  2020
EXEC add_PlayedForByTeamName 'Bradley Beal', 'Washington Wizards',  2021
EXEC add_PlayedForByTeamName 'Bradley Beal', 'Washington Wizards',  2022
EXEC add_PlayedForByTeamName 'Patrick Beverley', 'Los Angeles Clippers',  2018
EXEC add_PlayedForByTeamName 'Patrick Beverley', 'Los Angeles Clippers',  2019
EXEC add_PlayedForByTeamName 'Patrick Beverley', 'Los Angeles Clippers',  2020
EXEC add_PlayedForByTeamName 'Patrick Beverley', 'Los Angeles Clippers',  2021
EXEC add_PlayedForByTeamName 'Jae Crowder', 'Boston Celtics',  2017
EXEC add_PlayedForByTeamName 'Jae Crowder', 'Cleveland Cavaliers',  2018
EXEC add_PlayedForByTeamName 'Jae Crowder', 'Utah Jazz',  2018
EXEC add_PlayedForByTeamName 'Jae Crowder', 'Utah Jazz',  2019
EXEC add_PlayedForByTeamName 'Jae Crowder', 'Memphis Grizzlies',  2020
EXEC add_PlayedForByTeamName 'Jae Crowder', 'Miami Heat',  2020
EXEC add_PlayedForByTeamName 'Jae Crowder', 'Phoenix Suns',  2021
EXEC add_PlayedForByTeamName 'Jae Crowder', 'Phoenix Suns',  2022
EXEC add_PlayedForByTeamName 'Anthony Davis', 'New Orleans Pelicans',  2017
EXEC add_PlayedForByTeamName 'Anthony Davis', 'New Orleans Pelicans',  2018
EXEC add_PlayedForByTeamName 'Anthony Davis', 'New Orleans Pelicans',  2019
EXEC add_PlayedForByTeamName 'Anthony Davis', 'Los Angeles Lakers',  2020
EXEC add_PlayedForByTeamName 'Anthony Davis', 'Los Angeles Lakers',  2021
EXEC add_PlayedForByTeamName 'Anthony Davis', 'Los Angeles Lakers',  2022
EXEC add_PlayedForByTeamName 'Andre Drummond', 'Detroit Pistons',  2017
EXEC add_PlayedForByTeamName 'Andre Drummond', 'Detroit Pistons',  2018
EXEC add_PlayedForByTeamName 'Andre Drummond', 'Detroit Pistons',  2019
EXEC add_PlayedForByTeamName 'Andre Drummond', 'Brooklyn Nets',  2022
EXEC add_PlayedForByTeamName 'Andre Drummond', 'Philadelphia 76ers',  2022
EXEC add_PlayedForByTeamName 'Andre Drummond', 'Cleveland Cavaliers',  2020
EXEC add_PlayedForByTeamName 'Andre Drummond', 'Detroit Pistons',  2020
EXEC add_PlayedForByTeamName 'Andre Drummond', 'Cleveland Cavaliers',  2021
EXEC add_PlayedForByTeamName 'Andre Drummond', 'Los Angeles Lakers',  2021
EXEC add_PlayedForByTeamName 'Evan Fournier', 'Orlando Magic',  2017
EXEC add_PlayedForByTeamName 'Evan Fournier', 'Orlando Magic',  2018
EXEC add_PlayedForByTeamName 'Evan Fournier', 'Orlando Magic',  2019
EXEC add_PlayedForByTeamName 'Evan Fournier', 'New York Knicks',  2022
EXEC add_PlayedForByTeamName 'Evan Fournier', 'Orlando Magic',  2020
EXEC add_PlayedForByTeamName 'Evan Fournier', 'Boston Celtics',  2021
EXEC add_PlayedForByTeamName 'Evan Fournier', 'Orlando Magic',  2021
EXEC add_PlayedForByTeamName 'Maurice Harkless', 'Los Angeles Clippers',  2020
EXEC add_PlayedForByTeamName 'Maurice Harkless', 'New York Knicks',  2020
EXEC add_PlayedForByTeamName 'Maurice Harkless', 'Miami Heat',  2021
EXEC add_PlayedForByTeamName 'Maurice Harkless', 'Sacramento Kings',  2021
EXEC add_PlayedForByTeamName 'Maurice Harkless', 'Sacramento Kings',  2022
EXEC add_PlayedForByTeamName 'John Henson', 'Milwaukee Bucks',  2017
EXEC add_PlayedForByTeamName 'John Henson', 'Milwaukee Bucks',  2018
EXEC add_PlayedForByTeamName 'John Henson', 'Milwaukee Bucks',  2019
EXEC add_PlayedForByTeamName 'John Henson', 'Cleveland Cavaliers',  2020
EXEC add_PlayedForByTeamName 'John Henson', 'Detroit Pistons',  2020
EXEC add_PlayedForByTeamName 'Justin Holiday', 'New York Knicks',  2017
EXEC add_PlayedForByTeamName 'Justin Holiday', 'Chicago Bulls',  2018
EXEC add_PlayedForByTeamName 'Justin Holiday', 'Chicago Bulls',  2019
EXEC add_PlayedForByTeamName 'Justin Holiday', 'Memphis Grizzlies',  2019
EXEC add_PlayedForByTeamName 'Justin Holiday', 'Indiana Pacers',  2020
EXEC add_PlayedForByTeamName 'Justin Holiday', 'Indiana Pacers',  2021
EXEC add_PlayedForByTeamName 'Justin Holiday', 'Indiana Pacers',  2022
EXEC add_PlayedForByTeamName 'Justin Holiday', 'Sacramento Kings',  2022
EXEC add_PlayedForByTeamName 'John Jenkins', 'Phoenix Suns',  2017
EXEC add_PlayedForByTeamName 'John Jenkins', 'New York Knicks',  2019
EXEC add_PlayedForByTeamName 'John Jenkins', 'Washington Wizards',  2019
EXEC add_PlayedForByTeamName 'Terrence Jones', 'Houston Rockets',  2019
EXEC add_PlayedForByTeamName 'Jeremy Lamb', 'Charlotte Hornets',  2017
EXEC add_PlayedForByTeamName 'Jeremy Lamb', 'Charlotte Hornets',  2018
EXEC add_PlayedForByTeamName 'Jeremy Lamb', 'Charlotte Hornets',  2019
EXEC add_PlayedForByTeamName 'Jeremy Lamb', 'Indiana Pacers',  2020
EXEC add_PlayedForByTeamName 'Jeremy Lamb', 'Indiana Pacers',  2021
EXEC add_PlayedForByTeamName 'Jeremy Lamb', 'Indiana Pacers',  2022
EXEC add_PlayedForByTeamName 'Jeremy Lamb', 'Sacramento Kings',  2022
EXEC add_PlayedForByTeamName 'Meyers Leonard', 'Miami Heat',  2020
EXEC add_PlayedForByTeamName 'Meyers Leonard', 'Miami Heat',  2021
EXEC add_PlayedForByTeamName 'Scott Machado', 'Los Angeles Lakers',  2019
EXEC add_PlayedForByTeamName 'Khris Middleton', 'Milwaukee Bucks',  2017
EXEC add_PlayedForByTeamName 'Khris Middleton', 'Milwaukee Bucks',  2018
EXEC add_PlayedForByTeamName 'Khris Middleton', 'Milwaukee Bucks',  2019
EXEC add_PlayedForByTeamName 'Khris Middleton', 'Milwaukee Bucks',  2020
EXEC add_PlayedForByTeamName 'Khris Middleton', 'Milwaukee Bucks',  2021
EXEC add_PlayedForByTeamName 'Khris Middleton', 'Milwaukee Bucks',  2022
EXEC add_PlayedForByTeamName 'Darius Miller', 'New Orleans Pelicans',  2018
EXEC add_PlayedForByTeamName 'Darius Miller', 'New Orleans Pelicans',  2019
EXEC add_PlayedForByTeamName 'Donatas Motiejunas', 'New Orleans Pelicans',  2017
EXEC add_PlayedForByTeamName 'Donatas Motiejunas', 'San Antonio Spurs',  2019
EXEC add_PlayedForByTeamName 'Andrew Nicholson', 'Brooklyn Nets',  2017
EXEC add_PlayedForByTeamName 'Andrew Nicholson', 'Washington Wizards',  2017
EXEC add_PlayedForByTeamName 'Kyle O"Quinn', 'New York Knicks',  2017
EXEC add_PlayedForByTeamName 'Kyle O"Quinn', 'New York Knicks',  2018
EXEC add_PlayedForByTeamName 'Kyle O"Quinn', 'Indiana Pacers',  2019
EXEC add_PlayedForByTeamName 'Kyle O"Quinn', 'Philadelphia 76ers',  2020
EXEC add_PlayedForByTeamName 'Miles Plumlee', 'Charlotte Hornets',  2017
EXEC add_PlayedForByTeamName 'Miles Plumlee', 'Milwaukee Bucks',  2017
EXEC add_PlayedForByTeamName 'Miles Plumlee', 'Atlanta Hawks',  2018
EXEC add_PlayedForByTeamName 'Miles Plumlee', 'Atlanta Hawks',  2019
EXEC add_PlayedForByTeamName 'Austin Rivers', 'Los Angeles Clippers',  2017
EXEC add_PlayedForByTeamName 'Austin Rivers', 'Los Angeles Clippers',  2018
EXEC add_PlayedForByTeamName 'Austin Rivers', 'Houston Rockets',  2019
EXEC add_PlayedForByTeamName 'Austin Rivers', 'Washington Wizards',  2019
EXEC add_PlayedForByTeamName 'Austin Rivers', 'Houston Rockets',  2020
EXEC add_PlayedForByTeamName 'Austin Rivers', 'Denver Nuggets',  2021
EXEC add_PlayedForByTeamName 'Austin Rivers', 'New York Knicks',  2021
EXEC add_PlayedForByTeamName 'Austin Rivers', 'Denver Nuggets',  2022
EXEC add_PlayedForByTeamName 'Brian Roberts', 'Charlotte Hornets',  2017
EXEC add_PlayedForByTeamName 'Terrence Ross', 'Orlando Magic',  2018
EXEC add_PlayedForByTeamName 'Terrence Ross', 'Orlando Magic',  2019
EXEC add_PlayedForByTeamName 'Terrence Ross', 'Orlando Magic',  2020
EXEC add_PlayedForByTeamName 'Terrence Ross', 'Orlando Magic',  2021
EXEC add_PlayedForByTeamName 'Terrence Ross', 'Orlando Magic',  2022
EXEC add_PlayedForByTeamName 'Mike Scott', 'Atlanta Hawks',  2017
EXEC add_PlayedForByTeamName 'Mike Scott', 'Washington Wizards',  2018
EXEC add_PlayedForByTeamName 'Mike Scott', 'Los Angeles Clippers',  2019
EXEC add_PlayedForByTeamName 'Mike Scott', 'Philadelphia 76ers',  2019
EXEC add_PlayedForByTeamName 'Mike Scott', 'Philadelphia 76ers',  2020
EXEC add_PlayedForByTeamName 'Mike Scott', 'Philadelphia 76ers',  2021
EXEC add_PlayedForByTeamName 'Jared Sullinger', 'Toronto Raptors',  2017
EXEC add_PlayedForByTeamName 'Marquis Teague', 'Memphis Grizzlies',  2018
EXEC add_PlayedForByTeamName 'Mirza Teletovic', 'Milwaukee Bucks',  2017
EXEC add_PlayedForByTeamName 'Mirza Teletovic', 'Milwaukee Bucks',  2018
EXEC add_PlayedForByTeamName 'Jonas Valanciunas', 'Toronto Raptors',  2017
EXEC add_PlayedForByTeamName 'Jonas Valanciunas', 'Toronto Raptors',  2018
EXEC add_PlayedForByTeamName 'Jonas Valanciunas', 'Memphis Grizzlies',  2019
EXEC add_PlayedForByTeamName 'Jonas Valanciunas', 'New Orleans Pelicans',  2022
EXEC add_PlayedForByTeamName 'Jonas Valanciunas', 'Toronto Raptors',  2019
EXEC add_PlayedForByTeamName 'Jonas Valanciunas', 'Memphis Grizzlies',  2020
EXEC add_PlayedForByTeamName 'Jonas Valanciunas', 'Memphis Grizzlies',  2021
EXEC add_PlayedForByTeamName 'Dion Waiters', 'Miami Heat',  2017
EXEC add_PlayedForByTeamName 'Dion Waiters', 'Miami Heat',  2018
EXEC add_PlayedForByTeamName 'Dion Waiters', 'Miami Heat',  2019
EXEC add_PlayedForByTeamName 'Dion Waiters', 'Los Angeles Lakers',  2020
EXEC add_PlayedForByTeamName 'Dion Waiters', 'Miami Heat',  2020
EXEC add_PlayedForByTeamName 'Tyler Zeller', 'Brooklyn Nets',  2018
EXEC add_PlayedForByTeamName 'Tyler Zeller', 'Milwaukee Bucks',  2018
EXEC add_PlayedForByTeamName 'Tyler Zeller', 'Atlanta Hawks',  2019
EXEC add_PlayedForByTeamName 'Tyler Zeller', 'Memphis Grizzlies',  2019
EXEC add_PlayedForByTeamName 'Tyler Zeller', 'San Antonio Spurs',  2020
EXEC add_PlayedForByTeamName 'Steven Adams', 'New Orleans Pelicans',  2021
EXEC add_PlayedForByTeamName 'Steven Adams', 'Memphis Grizzlies',  2022
EXEC add_PlayedForByTeamName 'Anthony Bennett', 'Brooklyn Nets',  2017
EXEC add_PlayedForByTeamName 'Vander Blue', 'Los Angeles Lakers',  2018
EXEC add_PlayedForByTeamName 'Lorenzo Brown', 'Toronto Raptors',  2018
EXEC add_PlayedForByTeamName 'Lorenzo Brown', 'Toronto Raptors',  2019
EXEC add_PlayedForByTeamName 'Reggie Bullock', 'Detroit Pistons',  2018
EXEC add_PlayedForByTeamName 'Reggie Bullock', 'Detroit Pistons',  2019
EXEC add_PlayedForByTeamName 'Reggie Bullock', 'Los Angeles Lakers',  2019
EXEC add_PlayedForByTeamName 'Reggie Bullock', 'New York Knicks',  2020
EXEC add_PlayedForByTeamName 'Reggie Bullock', 'New York Knicks',  2021
EXEC add_PlayedForByTeamName 'Reggie Bullock', 'Dallas Mavericks',  2022
EXEC add_PlayedForByTeamName 'Trey Burke', 'New York Knicks',  2018
EXEC add_PlayedForByTeamName 'Trey Burke', 'Dallas Mavericks',  2019
EXEC add_PlayedForByTeamName 'Trey Burke', 'New York Knicks',  2019
EXEC add_PlayedForByTeamName 'Trey Burke', 'Dallas Mavericks',  2020
EXEC add_PlayedForByTeamName 'Trey Burke', 'Philadelphia 76ers',  2020
EXEC add_PlayedForByTeamName 'Trey Burke', 'Dallas Mavericks',  2021
EXEC add_PlayedForByTeamName 'Trey Burke', 'Dallas Mavericks',  2022
EXEC add_PlayedForByTeamName 'Dwight Buycks', 'Detroit Pistons',  2018
EXEC add_PlayedForByTeamName 'Isaiah Canaan', 'Chicago Bulls',  2017
EXEC add_PlayedForByTeamName 'Isaiah Canaan', 'Houston Rockets',  2018
EXEC add_PlayedForByTeamName 'Isaiah Canaan', 'Phoenix Suns',  2018
EXEC add_PlayedForByTeamName 'Isaiah Canaan', 'Milwaukee Bucks',  2019
EXEC add_PlayedForByTeamName 'Isaiah Canaan', 'Phoenix Suns',  2019
EXEC add_PlayedForByTeamName 'Ian Clark', 'New Orleans Pelicans',  2018
EXEC add_PlayedForByTeamName 'Ian Clark', 'New Orleans Pelicans',  2019
EXEC add_PlayedForByTeamName 'Robert Covington', 'Philadelphia 76ers',  2018
EXEC add_PlayedForByTeamName 'Robert Covington', 'Philadelphia 76ers',  2019
EXEC add_PlayedForByTeamName 'Robert Covington', 'Houston Rockets',  2020
EXEC add_PlayedForByTeamName 'Robert Covington', 'Los Angeles Clippers',  2022
EXEC add_PlayedForByTeamName 'Allen Crabbe', 'Brooklyn Nets',  2018
EXEC add_PlayedForByTeamName 'Allen Crabbe', 'Brooklyn Nets',  2019
EXEC add_PlayedForByTeamName 'Allen Crabbe', 'Atlanta Hawks',  2020
EXEC add_PlayedForByTeamName 'Seth Curry', 'Brooklyn Nets',  2022
EXEC add_PlayedForByTeamName 'Seth Curry', 'Philadelphia 76ers',  2022
EXEC add_PlayedForByTeamName 'Seth Curry', 'Dallas Mavericks',  2020
EXEC add_PlayedForByTeamName 'Seth Curry', 'Philadelphia 76ers',  2021
EXEC add_PlayedForByTeamName 'Troy Daniels', 'Phoenix Suns',  2018
EXEC add_PlayedForByTeamName 'Troy Daniels', 'Phoenix Suns',  2019
EXEC add_PlayedForByTeamName 'Troy Daniels', 'Denver Nuggets',  2020
EXEC add_PlayedForByTeamName 'Troy Daniels', 'Los Angeles Lakers',  2020
EXEC add_PlayedForByTeamName 'Dewayne Dedmon', 'San Antonio Spurs',  2017
EXEC add_PlayedForByTeamName 'Dewayne Dedmon', 'Atlanta Hawks',  2018
EXEC add_PlayedForByTeamName 'Dewayne Dedmon', 'Atlanta Hawks',  2019
EXEC add_PlayedForByTeamName 'Dewayne Dedmon', 'Atlanta Hawks',  2020
EXEC add_PlayedForByTeamName 'Dewayne Dedmon', 'Sacramento Kings',  2020
EXEC add_PlayedForByTeamName 'Dewayne Dedmon', 'Miami Heat',  2021
EXEC add_PlayedForByTeamName 'Dewayne Dedmon', 'Miami Heat',  2022
EXEC add_PlayedForByTeamName 'Matthew Dellavedova', 'Milwaukee Bucks',  2017
EXEC add_PlayedForByTeamName 'Matthew Dellavedova', 'Milwaukee Bucks',  2018
EXEC add_PlayedForByTeamName 'Matthew Dellavedova', 'Cleveland Cavaliers',  2019
EXEC add_PlayedForByTeamName 'Matthew Dellavedova', 'Milwaukee Bucks',  2019
EXEC add_PlayedForByTeamName 'Matthew Dellavedova', 'Cleveland Cavaliers',  2020
EXEC add_PlayedForByTeamName 'Matthew Dellavedova', 'Cleveland Cavaliers',  2021
EXEC add_PlayedForByTeamName 'Gorgui Dieng', 'Memphis Grizzlies',  2020
EXEC add_PlayedForByTeamName 'Gorgui Dieng', 'Memphis Grizzlies',  2021
EXEC add_PlayedForByTeamName 'Gorgui Dieng', 'San Antonio Spurs',  2021
EXEC add_PlayedForByTeamName 'Gorgui Dieng', 'Atlanta Hawks',  2022
EXEC add_PlayedForByTeamName 'Rudy Gobert', 'Utah Jazz',  2018
EXEC add_PlayedForByTeamName 'Rudy Gobert', 'Utah Jazz',  2019
EXEC add_PlayedForByTeamName 'Rudy Gobert', 'Utah Jazz',  2020
EXEC add_PlayedForByTeamName 'Rudy Gobert', 'Utah Jazz',  2021
EXEC add_PlayedForByTeamName 'Rudy Gobert', 'Utah Jazz',  2022
EXEC add_PlayedForByTeamName 'Archie Goodwin', 'Brooklyn Nets',  2017
EXEC add_PlayedForByTeamName 'Archie Goodwin', 'New Orleans Pelicans',  2017
EXEC add_PlayedForByTeamName 'Justin Hamilton', 'Brooklyn Nets',  2017
EXEC add_PlayedForByTeamName 'Solomon Hill', 'New Orleans Pelicans',  2018
EXEC add_PlayedForByTeamName 'Solomon Hill', 'New Orleans Pelicans',  2019
EXEC add_PlayedForByTeamName 'Solomon Hill', 'Memphis Grizzlies',  2020
EXEC add_PlayedForByTeamName 'Solomon Hill', 'Miami Heat',  2020
EXEC add_PlayedForByTeamName 'Solomon Hill', 'Atlanta Hawks',  2021
EXEC add_PlayedForByTeamName 'Solomon Hill', 'Atlanta Hawks',  2022
EXEC add_PlayedForByTeamName 'Scotty Hopson', 'Dallas Mavericks',  2018
EXEC add_PlayedForByTeamName 'Shane Larkin', 'Boston Celtics',  2018
EXEC add_PlayedForByTeamName 'Alex Len', 'Phoenix Suns',  2017
EXEC add_PlayedForByTeamName 'Alex Len', 'Phoenix Suns',  2018
EXEC add_PlayedForByTeamName 'Alex Len', 'Atlanta Hawks',  2019
EXEC add_PlayedForByTeamName 'Alex Len', 'Washington Wizards',  2021
EXEC add_PlayedForByTeamName 'Alex Len', 'Sacramento Kings',  2022
EXEC add_PlayedForByTeamName 'Alex Len', 'Atlanta Hawks',  2020
EXEC add_PlayedForByTeamName 'Alex Len', 'Sacramento Kings',  2020
EXEC add_PlayedForByTeamName 'Alex Len', 'Toronto Raptors',  2021
EXEC add_PlayedForByTeamName 'Ben McLemore', 'Sacramento Kings',  2017
EXEC add_PlayedForByTeamName 'Ben McLemore', 'Memphis Grizzlies',  2018
EXEC add_PlayedForByTeamName 'Ben McLemore', 'Sacramento Kings',  2019
EXEC add_PlayedForByTeamName 'Ben McLemore', 'Houston Rockets',  2020
EXEC add_PlayedForByTeamName 'Ben McLemore', 'Houston Rockets',  2021
EXEC add_PlayedForByTeamName 'Ben McLemore', 'Los Angeles Lakers',  2021
EXEC add_PlayedForByTeamName 'Shabazz Muhammad', 'Milwaukee Bucks',  2018
EXEC add_PlayedForByTeamName 'Mike Muscala', 'Atlanta Hawks',  2017
EXEC add_PlayedForByTeamName 'Mike Muscala', 'Atlanta Hawks',  2018
EXEC add_PlayedForByTeamName 'Mike Muscala', 'Los Angeles Lakers',  2019
EXEC add_PlayedForByTeamName 'Mike Muscala', 'Philadelphia 76ers',  2019
EXEC add_PlayedForByTeamName 'James Nunnally', 'Houston Rockets',  2019
EXEC add_PlayedForByTeamName 'James Nunnally', 'New Orleans Pelicans',  2021
EXEC add_PlayedForByTeamName 'Victor Oladipo', 'Indiana Pacers',  2018
EXEC add_PlayedForByTeamName 'Victor Oladipo', 'Houston Rockets',  2021
EXEC add_PlayedForByTeamName 'Victor Oladipo', 'Indiana Pacers',  2021
EXEC add_PlayedForByTeamName 'Victor Oladipo', 'Miami Heat',  2021
EXEC add_PlayedForByTeamName 'Victor Oladipo', 'Indiana Pacers',  2019
EXEC add_PlayedForByTeamName 'Victor Oladipo', 'Indiana Pacers',  2020
EXEC add_PlayedForByTeamName 'Kelly Olynyk', 'Boston Celtics',  2017
EXEC add_PlayedForByTeamName 'Kelly Olynyk', 'Miami Heat',  2018
EXEC add_PlayedForByTeamName 'Kelly Olynyk', 'Miami Heat',  2019
EXEC add_PlayedForByTeamName 'Kelly Olynyk', 'Miami Heat',  2020
EXEC add_PlayedForByTeamName 'Kelly Olynyk', 'Houston Rockets',  2021
EXEC add_PlayedForByTeamName 'Kelly Olynyk', 'Miami Heat',  2021
EXEC add_PlayedForByTeamName 'Kelly Olynyk', 'Detroit Pistons',  2022
EXEC add_PlayedForByTeamName 'Arinze Onuaku', 'Orlando Magic',  2017
EXEC add_PlayedForByTeamName 'Mason Plumlee', 'Denver Nuggets',  2017
EXEC add_PlayedForByTeamName 'Mason Plumlee', 'Denver Nuggets',  2018
EXEC add_PlayedForByTeamName 'Mason Plumlee', 'Denver Nuggets',  2019
EXEC add_PlayedForByTeamName 'Mason Plumlee', 'Denver Nuggets',  2020
EXEC add_PlayedForByTeamName 'Mason Plumlee', 'Detroit Pistons',  2021
EXEC add_PlayedForByTeamName 'Mason Plumlee', 'Charlotte Hornets',  2022
EXEC add_PlayedForByTeamName 'Otto Porter', 'Washington Wizards',  2018
EXEC add_PlayedForByTeamName 'Otto Porter', 'Chicago Bulls',  2019
EXEC add_PlayedForByTeamName 'Otto Porter', 'Washington Wizards',  2019
EXEC add_PlayedForByTeamName 'Otto Porter', 'Chicago Bulls',  2020
EXEC add_PlayedForByTeamName 'Otto Porter', 'Chicago Bulls',  2021
EXEC add_PlayedForByTeamName 'Otto Porter', 'Orlando Magic',  2021
EXEC add_PlayedForByTeamName 'Andre Roberson', 'Brooklyn Nets',  2021
EXEC add_PlayedForByTeamName 'Tony Snell', 'Milwaukee Bucks',  2018
EXEC add_PlayedForByTeamName 'Tony Snell', 'Milwaukee Bucks',  2019
EXEC add_PlayedForByTeamName 'Tony Snell', 'Detroit Pistons',  2020
EXEC add_PlayedForByTeamName 'Tony Snell', 'Atlanta Hawks',  2021
EXEC add_PlayedForByTeamName 'Tony Snell', 'New Orleans Pelicans',  2022
EXEC add_PlayedForByTeamName 'D.J. Stephens', 'Memphis Grizzlies',  2019
EXEC add_PlayedForByTeamName 'Hollis Thompson', 'New Orleans Pelicans',  2017
EXEC add_PlayedForByTeamName 'Hollis Thompson', 'Philadelphia 76ers',  2017
EXEC add_PlayedForByTeamName 'Jeff Withey', 'Utah Jazz',  2017
EXEC add_PlayedForByTeamName 'Jeff Withey', 'Dallas Mavericks',  2018
EXEC add_PlayedForByTeamName 'Nate Wolters', 'Utah Jazz',  2018
EXEC add_PlayedForByTeamName 'Cody Zeller', 'Charlotte Hornets',  2017
EXEC add_PlayedForByTeamName 'Cody Zeller', 'Charlotte Hornets',  2018
EXEC add_PlayedForByTeamName 'Cody Zeller', 'Charlotte Hornets',  2019
EXEC add_PlayedForByTeamName 'Cody Zeller', 'Charlotte Hornets',  2020
EXEC add_PlayedForByTeamName 'Cody Zeller', 'Charlotte Hornets',  2021
EXEC add_PlayedForByTeamName 'Kyle Anderson', 'San Antonio Spurs',  2017
EXEC add_PlayedForByTeamName 'Kyle Anderson', 'San Antonio Spurs',  2018
EXEC add_PlayedForByTeamName 'Kyle Anderson', 'Memphis Grizzlies',  2019
EXEC add_PlayedForByTeamName 'Kyle Anderson', 'Memphis Grizzlies',  2020
EXEC add_PlayedForByTeamName 'Kyle Anderson', 'Memphis Grizzlies',  2021
EXEC add_PlayedForByTeamName 'Kyle Anderson', 'Memphis Grizzlies',  2022
EXEC add_PlayedForByTeamName 'Tarik Black', 'Houston Rockets',  2018
EXEC add_PlayedForByTeamName 'Bojan Bogdanovic', 'Brooklyn Nets',  2017
EXEC add_PlayedForByTeamName 'Bojan Bogdanovic', 'Washington Wizards',  2017
EXEC add_PlayedForByTeamName 'Bojan Bogdanovic', 'Indiana Pacers',  2018
EXEC add_PlayedForByTeamName 'Bojan Bogdanovic', 'Indiana Pacers',  2019
EXEC add_PlayedForByTeamName 'Bojan Bogdanovic', 'Utah Jazz',  2020
EXEC add_PlayedForByTeamName 'Bojan Bogdanovic', 'Utah Jazz',  2021
EXEC add_PlayedForByTeamName 'Bojan Bogdanovic', 'Utah Jazz',  2022
EXEC add_PlayedForByTeamName 'Markel Brown', 'Houston Rockets',  2018
EXEC add_PlayedForByTeamName 'Bruno Caboclo', 'Toronto Raptors',  2017
EXEC add_PlayedForByTeamName 'Bruno Caboclo', 'Sacramento Kings',  2018
EXEC add_PlayedForByTeamName 'Bruno Caboclo', 'Toronto Raptors',  2018
EXEC add_PlayedForByTeamName 'Bruno Caboclo', 'Memphis Grizzlies',  2019
EXEC add_PlayedForByTeamName 'Bruno Caboclo', 'Houston Rockets',  2020
EXEC add_PlayedForByTeamName 'Bruno Caboclo', 'Memphis Grizzlies',  2020
EXEC add_PlayedForByTeamName 'Bruno Caboclo', 'Houston Rockets',  2021
EXEC add_PlayedForByTeamName 'Clint Capela', 'Houston Rockets',  2017
EXEC add_PlayedForByTeamName 'Clint Capela', 'Houston Rockets',  2018
EXEC add_PlayedForByTeamName 'Clint Capela', 'Houston Rockets',  2019
EXEC add_PlayedForByTeamName 'Clint Capela', 'Houston Rockets',  2020
EXEC add_PlayedForByTeamName 'Clint Capela', 'Atlanta Hawks',  2021
EXEC add_PlayedForByTeamName 'Clint Capela', 'Atlanta Hawks',  2022
EXEC add_PlayedForByTeamName 'Jordan Clarkson', 'Los Angeles Lakers',  2017
EXEC add_PlayedForByTeamName 'Jordan Clarkson', 'Cleveland Cavaliers',  2018
EXEC add_PlayedForByTeamName 'Jordan Clarkson', 'Los Angeles Lakers',  2018
EXEC add_PlayedForByTeamName 'Jordan Clarkson', 'Cleveland Cavaliers',  2019
EXEC add_PlayedForByTeamName 'Jordan Clarkson', 'Cleveland Cavaliers',  2020
EXEC add_PlayedForByTeamName 'Jordan Clarkson', 'Utah Jazz',  2020
EXEC add_PlayedForByTeamName 'Jordan Clarkson', 'Utah Jazz',  2021
EXEC add_PlayedForByTeamName 'Jordan Clarkson', 'Utah Jazz',  2022
EXEC add_PlayedForByTeamName 'Jack Cooley', 'Sacramento Kings',  2018
EXEC add_PlayedForByTeamName 'Spencer Dinwiddie', 'Brooklyn Nets',  2018
EXEC add_PlayedForByTeamName 'Spencer Dinwiddie', 'Brooklyn Nets',  2019
EXEC add_PlayedForByTeamName 'Spencer Dinwiddie', 'Brooklyn Nets',  2020
EXEC add_PlayedForByTeamName 'Spencer Dinwiddie', 'Washington Wizards',  2022
EXEC add_PlayedForByTeamName 'Spencer Dinwiddie', 'Brooklyn Nets',  2021
EXEC add_PlayedForByTeamName 'Spencer Dinwiddie', 'Dallas Mavericks',  2022
EXEC add_PlayedForByTeamName 'James Ennis', 'Memphis Grizzlies',  2017
EXEC add_PlayedForByTeamName 'James Ennis', 'Detroit Pistons',  2018
EXEC add_PlayedForByTeamName 'James Ennis', 'Memphis Grizzlies',  2018
EXEC add_PlayedForByTeamName 'James Ennis', 'Houston Rockets',  2019
EXEC add_PlayedForByTeamName 'James Ennis', 'Brooklyn Nets',  2022
EXEC add_PlayedForByTeamName 'James Ennis', 'Denver Nuggets',  2022
EXEC add_PlayedForByTeamName 'James Ennis', 'Los Angeles Clippers',  2022
EXEC add_PlayedForByTeamName 'James Ennis', 'Philadelphia 76ers',  2019
EXEC add_PlayedForByTeamName 'James Ennis', 'Orlando Magic',  2020
EXEC add_PlayedForByTeamName 'James Ennis', 'Philadelphia 76ers',  2020
EXEC add_PlayedForByTeamName 'James Ennis', 'Orlando Magic',  2021
EXEC add_PlayedForByTeamName 'Tyler Ennis', 'Los Angeles Lakers',  2018
EXEC add_PlayedForByTeamName 'Dante Exum', 'Utah Jazz',  2017
EXEC add_PlayedForByTeamName 'Dante Exum', 'Utah Jazz',  2018
EXEC add_PlayedForByTeamName 'Dante Exum', 'Utah Jazz',  2019
EXEC add_PlayedForByTeamName 'Dante Exum', 'Cleveland Cavaliers',  2020
EXEC add_PlayedForByTeamName 'Dante Exum', 'Utah Jazz',  2020
EXEC add_PlayedForByTeamName 'Dante Exum', 'Cleveland Cavaliers',  2021
EXEC add_PlayedForByTeamName 'Tim Frazier', 'Washington Wizards',  2018
EXEC add_PlayedForByTeamName 'Tim Frazier', 'Milwaukee Bucks',  2019
EXEC add_PlayedForByTeamName 'Tim Frazier', 'New Orleans Pelicans',  2019
EXEC add_PlayedForByTeamName 'Tim Frazier', 'Detroit Pistons',  2020
EXEC add_PlayedForByTeamName 'Tim Frazier', 'Memphis Grizzlies',  2021
EXEC add_PlayedForByTeamName 'Tim Frazier', 'Cleveland Cavaliers',  2022
EXEC add_PlayedForByTeamName 'Tim Frazier', 'Orlando Magic',  2022
EXEC add_PlayedForByTeamName 'Langston Galloway', 'New Orleans Pelicans',  2017
EXEC add_PlayedForByTeamName 'Langston Galloway', 'Sacramento Kings',  2017
EXEC add_PlayedForByTeamName 'Langston Galloway', 'Detroit Pistons',  2018
EXEC add_PlayedForByTeamName 'Langston Galloway', 'Brooklyn Nets',  2022
EXEC add_PlayedForByTeamName 'Langston Galloway', 'Milwaukee Bucks',  2022
EXEC add_PlayedForByTeamName 'Langston Galloway', 'Phoenix Suns',  2021
EXEC add_PlayedForByTeamName 'Langston Galloway', 'Detroit Pistons',  2019
EXEC add_PlayedForByTeamName 'Langston Galloway', 'Detroit Pistons',  2020
EXEC add_PlayedForByTeamName 'Aaron Gordon', 'Orlando Magic',  2017
EXEC add_PlayedForByTeamName 'Aaron Gordon', 'Orlando Magic',  2018
EXEC add_PlayedForByTeamName 'Aaron Gordon', 'Orlando Magic',  2019
EXEC add_PlayedForByTeamName 'Aaron Gordon', 'Denver Nuggets',  2022
EXEC add_PlayedForByTeamName 'Aaron Gordon', 'Orlando Magic',  2020
EXEC add_PlayedForByTeamName 'Aaron Gordon', 'Denver Nuggets',  2021
EXEC add_PlayedForByTeamName 'Aaron Gordon', 'Orlando Magic',  2021
EXEC add_PlayedForByTeamName 'Jerami Grant', 'Philadelphia 76ers',  2017
EXEC add_PlayedForByTeamName 'Jerami Grant', 'Denver Nuggets',  2020
EXEC add_PlayedForByTeamName 'Jerami Grant', 'Detroit Pistons',  2021
EXEC add_PlayedForByTeamName 'Jerami Grant', 'Detroit Pistons',  2022
EXEC add_PlayedForByTeamName 'JaMychal Green', 'Memphis Grizzlies',  2017
EXEC add_PlayedForByTeamName 'JaMychal Green', 'Memphis Grizzlies',  2018
EXEC add_PlayedForByTeamName 'JaMychal Green', 'Los Angeles Clippers',  2019
EXEC add_PlayedForByTeamName 'JaMychal Green', 'Memphis Grizzlies',  2019
EXEC add_PlayedForByTeamName 'JaMychal Green', 'Los Angeles Clippers',  2020
EXEC add_PlayedForByTeamName 'JaMychal Green', 'Denver Nuggets',  2021
EXEC add_PlayedForByTeamName 'JaMychal Green', 'Denver Nuggets',  2022
EXEC add_PlayedForByTeamName 'Gary Harris', 'Denver Nuggets',  2017
EXEC add_PlayedForByTeamName 'Gary Harris', 'Denver Nuggets',  2018
EXEC add_PlayedForByTeamName 'Gary Harris', 'Denver Nuggets',  2019
EXEC add_PlayedForByTeamName 'Gary Harris', 'Orlando Magic',  2022
EXEC add_PlayedForByTeamName 'Gary Harris', 'Denver Nuggets',  2020
EXEC add_PlayedForByTeamName 'Gary Harris', 'Denver Nuggets',  2021
EXEC add_PlayedForByTeamName 'Gary Harris', 'Orlando Magic',  2021
EXEC add_PlayedForByTeamName 'Joe Harris', 'Brooklyn Nets',  2017
EXEC add_PlayedForByTeamName 'Joe Harris', 'Brooklyn Nets',  2018
EXEC add_PlayedForByTeamName 'Joe Harris', 'Brooklyn Nets',  2019
EXEC add_PlayedForByTeamName 'Joe Harris', 'Brooklyn Nets',  2020
EXEC add_PlayedForByTeamName 'Joe Harris', 'Brooklyn Nets',  2021
EXEC add_PlayedForByTeamName 'Joe Harris', 'Brooklyn Nets',  2022
EXEC add_PlayedForByTeamName 'Rodney Hood', 'Cleveland Cavaliers',  2018
EXEC add_PlayedForByTeamName 'Rodney Hood', 'Utah Jazz',  2018
EXEC add_PlayedForByTeamName 'Rodney Hood', 'Cleveland Cavaliers',  2019
EXEC add_PlayedForByTeamName 'Rodney Hood', 'Toronto Raptors',  2021
EXEC add_PlayedForByTeamName 'Rodney Hood', 'Los Angeles Clippers',  2022
EXEC add_PlayedForByTeamName 'Rodney Hood', 'Milwaukee Bucks',  2022
EXEC add_PlayedForByTeamName 'Joe Ingles', 'Utah Jazz',  2017
EXEC add_PlayedForByTeamName 'Joe Ingles', 'Utah Jazz',  2018
EXEC add_PlayedForByTeamName 'Joe Ingles', 'Utah Jazz',  2019
EXEC add_PlayedForByTeamName 'Joe Ingles', 'Utah Jazz',  2020
EXEC add_PlayedForByTeamName 'Joe Ingles', 'Utah Jazz',  2021
EXEC add_PlayedForByTeamName 'Joe Ingles', 'Utah Jazz',  2022
EXEC add_PlayedForByTeamName 'Tyler Johnson', 'Miami Heat',  2018
EXEC add_PlayedForByTeamName 'Tyler Johnson', 'Miami Heat',  2019
EXEC add_PlayedForByTeamName 'Tyler Johnson', 'Phoenix Suns',  2019
EXEC add_PlayedForByTeamName 'Tyler Johnson', 'San Antonio Spurs',  2022
EXEC add_PlayedForByTeamName 'Tyler Johnson', 'Brooklyn Nets',  2020
EXEC add_PlayedForByTeamName 'Tyler Johnson', 'Phoenix Suns',  2020
EXEC add_PlayedForByTeamName 'Tyler Johnson', 'Brooklyn Nets',  2021
EXEC add_PlayedForByTeamName 'Tyler Johnson', 'Philadelphia 76ers',  2022
EXEC add_PlayedForByTeamName 'Sean Kilpatrick', 'Brooklyn Nets',  2018
EXEC add_PlayedForByTeamName 'Sean Kilpatrick', 'Chicago Bulls',  2018
EXEC add_PlayedForByTeamName 'Sean Kilpatrick', 'Los Angeles Clippers',  2018
EXEC add_PlayedForByTeamName 'Sean Kilpatrick', 'Milwaukee Bucks',  2018
EXEC add_PlayedForByTeamName 'Joffrey Lauvergne', 'Chicago Bulls',  2017
EXEC add_PlayedForByTeamName 'Joffrey Lauvergne', 'San Antonio Spurs',  2018
EXEC add_PlayedForByTeamName 'Zach LaVine', 'Chicago Bulls',  2018
EXEC add_PlayedForByTeamName 'Zach LaVine', 'Chicago Bulls',  2019
EXEC add_PlayedForByTeamName 'Zach LaVine', 'Chicago Bulls',  2020
EXEC add_PlayedForByTeamName 'Zach LaVine', 'Chicago Bulls',  2021
EXEC add_PlayedForByTeamName 'Zach LaVine', 'Chicago Bulls',  2022
EXEC add_PlayedForByTeamName 'Kalin Lucas', 'Detroit Pistons',  2019
EXEC add_PlayedForByTeamName 'K.J. McDaniels', 'Brooklyn Nets',  2017
EXEC add_PlayedForByTeamName 'K.J. McDaniels', 'Houston Rockets',  2017
EXEC add_PlayedForByTeamName 'Doug McDermott', 'Chicago Bulls',  2017
EXEC add_PlayedForByTeamName 'Doug McDermott', 'Dallas Mavericks',  2018
EXEC add_PlayedForByTeamName 'Doug McDermott', 'New York Knicks',  2018
EXEC add_PlayedForByTeamName 'Doug McDermott', 'Indiana Pacers',  2019
EXEC add_PlayedForByTeamName 'Doug McDermott', 'Indiana Pacers',  2020
EXEC add_PlayedForByTeamName 'Doug McDermott', 'Indiana Pacers',  2021
EXEC add_PlayedForByTeamName 'Doug McDermott', 'San Antonio Spurs',  2022
EXEC add_PlayedForByTeamName 'Elijah Millsap', 'Phoenix Suns',  2017
EXEC add_PlayedForByTeamName 'Nikola Mirotic', 'Chicago Bulls',  2017
EXEC add_PlayedForByTeamName 'Nikola Mirotic', 'Chicago Bulls',  2018
EXEC add_PlayedForByTeamName 'Nikola Mirotic', 'New Orleans Pelicans',  2018
EXEC add_PlayedForByTeamName 'Nikola Mirotic', 'Milwaukee Bucks',  2019
EXEC add_PlayedForByTeamName 'Nikola Mirotic', 'New Orleans Pelicans',  2019
EXEC add_PlayedForByTeamName 'Eric Moreland', 'Detroit Pistons',  2018
EXEC add_PlayedForByTeamName 'Eric Moreland', 'Phoenix Suns',  2019
EXEC add_PlayedForByTeamName 'Eric Moreland', 'Toronto Raptors',  2019
EXEC add_PlayedForByTeamName 'Shabazz Napier', 'Brooklyn Nets',  2019
EXEC add_PlayedForByTeamName 'Shabazz Napier', 'Washington Wizards',  2020
EXEC add_PlayedForByTeamName 'Nerlens Noel', 'Dallas Mavericks',  2017
EXEC add_PlayedForByTeamName 'Nerlens Noel', 'Philadelphia 76ers',  2017
EXEC add_PlayedForByTeamName 'Nerlens Noel', 'Dallas Mavericks',  2018
EXEC add_PlayedForByTeamName 'Nerlens Noel', 'New York Knicks',  2021
EXEC add_PlayedForByTeamName 'Nerlens Noel', 'New York Knicks',  2022
EXEC add_PlayedForByTeamName 'Lucas Nogueira', 'Toronto Raptors',  2017
EXEC add_PlayedForByTeamName 'Lucas Nogueira', 'Toronto Raptors',  2018
EXEC add_PlayedForByTeamName 'Jusuf Nurkic', 'Denver Nuggets',  2017
EXEC add_PlayedForByTeamName 'Johnny O"Bryant', 'Charlotte Hornets',  2017
EXEC add_PlayedForByTeamName 'Johnny O"Bryant', 'Denver Nuggets',  2017
EXEC add_PlayedForByTeamName 'Johnny O"Bryant', 'Charlotte Hornets',  2018
EXEC add_PlayedForByTeamName 'Jabari Parker', 'Milwaukee Bucks',  2017
EXEC add_PlayedForByTeamName 'Jabari Parker', 'Milwaukee Bucks',  2018
EXEC add_PlayedForByTeamName 'Jabari Parker', 'Chicago Bulls',  2019
EXEC add_PlayedForByTeamName 'Jabari Parker', 'Washington Wizards',  2019
EXEC add_PlayedForByTeamName 'Jabari Parker', 'Atlanta Hawks',  2020
EXEC add_PlayedForByTeamName 'Jabari Parker', 'Sacramento Kings',  2020
EXEC add_PlayedForByTeamName 'Jabari Parker', 'Boston Celtics',  2021
EXEC add_PlayedForByTeamName 'Jabari Parker', 'Sacramento Kings',  2021
EXEC add_PlayedForByTeamName 'Jabari Parker', 'Boston Celtics',  2022
EXEC add_PlayedForByTeamName 'Adreian Payne', 'Orlando Magic',  2018
EXEC add_PlayedForByTeamName 'Elfrid Payton', 'Orlando Magic',  2017
EXEC add_PlayedForByTeamName 'Elfrid Payton', 'Orlando Magic',  2018
EXEC add_PlayedForByTeamName 'Elfrid Payton', 'Phoenix Suns',  2018
EXEC add_PlayedForByTeamName 'Elfrid Payton', 'New Orleans Pelicans',  2019
EXEC add_PlayedForByTeamName 'Elfrid Payton', 'New York Knicks',  2020
EXEC add_PlayedForByTeamName 'Elfrid Payton', 'New York Knicks',  2021
EXEC add_PlayedForByTeamName 'Elfrid Payton', 'Phoenix Suns',  2022
EXEC add_PlayedForByTeamName 'Dwight Powell', 'Dallas Mavericks',  2017
EXEC add_PlayedForByTeamName 'Dwight Powell', 'Dallas Mavericks',  2018
EXEC add_PlayedForByTeamName 'Dwight Powell', 'Dallas Mavericks',  2019
EXEC add_PlayedForByTeamName 'Dwight Powell', 'Dallas Mavericks',  2020
EXEC add_PlayedForByTeamName 'Dwight Powell', 'Dallas Mavericks',  2021
EXEC add_PlayedForByTeamName 'Dwight Powell', 'Dallas Mavericks',  2022
EXEC add_PlayedForByTeamName 'Julius Randle', 'Los Angeles Lakers',  2017
EXEC add_PlayedForByTeamName 'Julius Randle', 'Los Angeles Lakers',  2018
EXEC add_PlayedForByTeamName 'Julius Randle', 'New Orleans Pelicans',  2019
EXEC add_PlayedForByTeamName 'Julius Randle', 'New York Knicks',  2020
EXEC add_PlayedForByTeamName 'Julius Randle', 'New York Knicks',  2021
EXEC add_PlayedForByTeamName 'Julius Randle', 'New York Knicks',  2022
EXEC add_PlayedForByTeamName 'JaKarr Sampson', 'Sacramento Kings',  2018
EXEC add_PlayedForByTeamName 'JaKarr Sampson', 'Chicago Bulls',  2019
EXEC add_PlayedForByTeamName 'JaKarr Sampson', 'Indiana Pacers',  2020
EXEC add_PlayedForByTeamName 'JaKarr Sampson', 'Indiana Pacers',  2021
EXEC add_PlayedForByTeamName 'Marcus Smart', 'Boston Celtics',  2017
EXEC add_PlayedForByTeamName 'Marcus Smart', 'Boston Celtics',  2018
EXEC add_PlayedForByTeamName 'Marcus Smart', 'Boston Celtics',  2019
EXEC add_PlayedForByTeamName 'Marcus Smart', 'Boston Celtics',  2020
EXEC add_PlayedForByTeamName 'Marcus Smart', 'Boston Celtics',  2021
EXEC add_PlayedForByTeamName 'Marcus Smart', 'Boston Celtics',  2022
EXEC add_PlayedForByTeamName 'Nik Stauskas', 'Philadelphia 76ers',  2017
EXEC add_PlayedForByTeamName 'Nik Stauskas', 'Brooklyn Nets',  2018
EXEC add_PlayedForByTeamName 'Nik Stauskas', 'Philadelphia 76ers',  2018
EXEC add_PlayedForByTeamName 'Nik Stauskas', 'Cleveland Cavaliers',  2019
EXEC add_PlayedForByTeamName 'Nik Stauskas', 'Miami Heat',  2022

--ADD MVP


EXEC add_MVPByName 1971, 'Kareem Abdul-Jabbar'
EXEC add_MVPByName 1972, 'Kareem Abdul-Jabbar'
EXEC add_MVPByName 1974, 'Kareem Abdul-Jabbar'
EXEC add_MVPByName 1976, 'Kareem Abdul-Jabbar'
EXEC add_MVPByName 1977, 'Kareem Abdul-Jabbar'
EXEC add_MVPByName 1980, 'Kareem Abdul-Jabbar'
EXEC add_MVPByName 1975, 'Bob McAdoo'
EXEC add_MVPByName 2025, 'Larry Cannon'
EXEC add_MVPByName 2049, 'Larry Cannon'
EXEC add_MVPByName 1978, 'Bill Walton'
EXEC add_MVPByName 1981, 'Julius Erving'
EXEC add_MVPByName 1982, 'Moses Malone'
EXEC add_MVPByName 1983, 'Moses Malone'
EXEC add_MVPByName 1979, 'Moses Malone'
EXEC add_MVPByName 1984, 'Larry Bird'
EXEC add_MVPByName 1985, 'Larry Bird'
EXEC add_MVPByName 1986, 'Larry Bird'
EXEC add_MVPByName 1987, 'Magic Johnson'
EXEC add_MVPByName 1989, 'Magic Johnson'
EXEC add_MVPByName 1990, 'Magic Johnson'
EXEC add_MVPByName 1993, 'Charles Barkley'
EXEC add_MVPByName 1996, 'Michael Jordan'
EXEC add_MVPByName 1991, 'Michael Jordan'
EXEC add_MVPByName 1992, 'Michael Jordan'
EXEC add_MVPByName 1998, 'Michael Jordan'
EXEC add_MVPByName 1988, 'Michael Jordan'
EXEC add_MVPByName 1994, 'Hakeem Olajuwon'
EXEC add_MVPByName 1997, 'Karl Malone'
EXEC add_MVPByName 1995, 'David Robinson'
EXEC add_MVPByName 2004, 'Kevin Garnett'
EXEC add_MVPByName 2001, 'Allen Iverson'
EXEC add_MVPByName 2005, 'Steve Nash'
EXEC add_MVPByName 2006, 'Steve Nash'
EXEC add_MVPByName 2002, 'Tim Duncan'
EXEC add_MVPByName 2003, 'Tim Duncan'
EXEC add_MVPByName 2007, 'Dirk Nowitzki'
EXEC add_MVPByName 2009, 'LeBron James'
EXEC add_MVPByName 2010, 'LeBron James'
EXEC add_MVPByName 2012, 'LeBron James'
EXEC add_MVPByName 2013, 'LeBron James'
EXEC add_MVPByName 2014, 'Kevin Durant'
EXEC add_MVPByName 2011, 'Derrick Rose'
EXEC add_MVPByName 2017, 'Russell Westbrook'
EXEC add_MVPByName 2015, 'Stephen Curry'
EXEC add_MVPByName 2016, 'Stephen Curry'
EXEC add_MVPByName 2018, 'James Harden'
EXEC add_MVPByName 1943, 'Nik Stauskas'


--ADD CHAMPIONSHIP


EXEC add_ChampionshipByName 1947, 'Philadelphia Warriors'
EXEC add_ChampionshipByName 1948, 'Baltimore Bullets'
EXEC add_ChampionshipByName 1949, 'Minneapolis Lakers'
EXEC add_ChampionshipByName 1950, 'Minneapolis Lakers'
EXEC add_ChampionshipByName 1951, 'Rochester Royals'
EXEC add_ChampionshipByName 1952, 'Minneapolis Lakers'
EXEC add_ChampionshipByName 1953, 'Minneapolis Lakers'
EXEC add_ChampionshipByName 1954, 'Minneapolis Lakers'
EXEC add_ChampionshipByName 1955, 'Syracuse Nationals'
EXEC add_ChampionshipByName 1956, 'Philadelphia Warriors'
EXEC add_ChampionshipByName 1957, 'Boston Celtics'
EXEC add_ChampionshipByName 1958, 'St. Louis Hawks'
EXEC add_ChampionshipByName 1959, 'Boston Celtics'
EXEC add_ChampionshipByName 1960, 'Boston Celtics'
EXEC add_ChampionshipByName 1961, 'Boston Celtics'
EXEC add_ChampionshipByName 1962, 'Boston Celtics'
EXEC add_ChampionshipByName 1963, 'Boston Celtics'
EXEC add_ChampionshipByName 1964, 'Boston Celtics'
EXEC add_ChampionshipByName 1965, 'Boston Celtics'
EXEC add_ChampionshipByName 1966, 'Boston Celtics'
EXEC add_ChampionshipByName 1967, 'Philadelphia 76ers'
EXEC add_ChampionshipByName 1968, 'Boston Celtics'
EXEC add_ChampionshipByName 1969, 'Boston Celtics'
EXEC add_ChampionshipByName 1970, 'New York Knicks'
EXEC add_ChampionshipByName 1971, 'Milwaukee Bucks'
EXEC add_ChampionshipByName 1972, 'Los Angeles Lakers'
EXEC add_ChampionshipByName 1973, 'New York Knicks'
EXEC add_ChampionshipByName 1974, 'Boston Celtics'
EXEC add_ChampionshipByName 1975, 'Golden State Warriors'
EXEC add_ChampionshipByName 1976, 'Boston Celtics'
EXEC add_ChampionshipByName 1977, 'Portland Trail Blaze'
EXEC add_ChampionshipByName 1978, 'Washington Bullets'
EXEC add_ChampionshipByName 1979, 'Seattle SuperSonics'
EXEC add_ChampionshipByName 1980, 'Los Angeles Lakers'
EXEC add_ChampionshipByName 1981, 'Boston Celtics'
EXEC add_ChampionshipByName 1982, 'Los Angeles Lakers'
EXEC add_ChampionshipByName 1983, 'Philadelphia 76ers'
EXEC add_ChampionshipByName 1984, 'Boston Celtics'
EXEC add_ChampionshipByName 1985, 'Los Angeles Lakers'
EXEC add_ChampionshipByName 1986, 'Boston Celtics'
EXEC add_ChampionshipByName 1987, 'Los Angeles Lakers'
EXEC add_ChampionshipByName 1988, 'Los Angeles Lakers'
EXEC add_ChampionshipByName 1989, 'Detroit Pistons'
EXEC add_ChampionshipByName 1990, 'Detroit Pistons'
EXEC add_ChampionshipByName 1991, 'Chicago Bulls'
EXEC add_ChampionshipByName 1992, 'Chicago Bulls'
EXEC add_ChampionshipByName 1993, 'Chicago Bulls'
EXEC add_ChampionshipByName 1994, 'Houston Rockets'
EXEC add_ChampionshipByName 1995, 'Houston Rockets'
EXEC add_ChampionshipByName 1996, 'Chicago Bulls'
EXEC add_ChampionshipByName 1997, 'Chicago Bulls'
EXEC add_ChampionshipByName 1998, 'Chicago Bulls'
EXEC add_ChampionshipByName 1999, 'San Antonio Spurs'
EXEC add_ChampionshipByName 2000, 'Los Angeles Lakers'
EXEC add_ChampionshipByName 2001, 'Los Angeles Lakers'
EXEC add_ChampionshipByName 2002, 'Los Angeles Lakers'
EXEC add_ChampionshipByName 2003, 'San Antonio Spurs'
EXEC add_ChampionshipByName 2004, 'Detroit Pistons'
EXEC add_ChampionshipByName 2005, 'San Antonio Spurs'
EXEC add_ChampionshipByName 2006, 'Miami Heat'
EXEC add_ChampionshipByName 2007, 'San Antonio Spurs'
EXEC add_ChampionshipByName 2008, 'Boston Celtics'
EXEC add_ChampionshipByName 2009, 'Los Angeles Lakers'
EXEC add_ChampionshipByName 2010, 'Los Angeles Lakers'
EXEC add_ChampionshipByName 2011, 'Dallas Mavericks'
EXEC add_ChampionshipByName 2012, 'Miami Heat'
EXEC add_ChampionshipByName 2013, 'Miami Heat'
EXEC add_ChampionshipByName 2014, 'San Antonio Spurs'
EXEC add_ChampionshipByName 2015, 'Golden State Warriors'
EXEC add_ChampionshipByName 2016, 'Cleveland Cavaliers'
EXEC add_ChampionshipByName 2017, 'Golden State Warriors'
EXEC add_ChampionshipByName 2018, 'Golden State Warriors'
EXEC add_ChampionshipByName 2019, 'Toronto Raptors'
EXEC add_ChampionshipByName 2020, 'Los Angeles Lakers'
EXEC add_ChampionshipByName 2021, 'Milwaukee Bucks'
EXEC add_ChampionshipByName 2022, 'Boston Celtics'



-- ADD PLAYER STATS


EXEC add_PlayerStatsByName 'Mike Dunleavy',  1,  2,  5,  1,  40,  34,  46,  1,  2003
EXEC add_PlayerStatsByName 'Mike Dunleavy',  2,  5,  11,  1,  44,  37,  51,  2,  2004
EXEC add_PlayerStatsByName 'Mike Dunleavy',  2,  5,  13,  1,  45,  38,  51,  2,  2005
EXEC add_PlayerStatsByName 'Eddie Johnson',  1,  2,  8,  0,  41,  33,  47,  1,  1998
EXEC add_PlayerStatsByName 'Eddie Johnson',  0,  0,  4,  0,  46,  0,  46,  1,  1999
EXEC add_PlayerStatsByName 'Larry Johnson',  2,  5,  15,  1,  48,  23,  49,  2,  1998
EXEC add_PlayerStatsByName 'Larry Johnson',  2,  5,  12,  1,  45,  35,  49,  3,  1999
EXEC add_PlayerStatsByName 'Larry Johnson',  2,  5,  10,  1,  43,  33,  47,  2,  2000
EXEC add_PlayerStatsByName 'Larry Johnson',  2,  5,  9,  1,  41,  31,  45,  3,  2001
EXEC add_PlayerStatsByName 'Terry Cummings',  0,  3,  6,  0,  46,  0,  46,  2,  1998
EXEC add_PlayerStatsByName 'Terry Cummings',  1,  5,  9,  1,  43,  100,  44,  3,  1999
EXEC add_PlayerStatsByName 'Ricky Pierce',  0,  1,  3,  0,  36,  30,  37,  0,  1998
EXEC add_PlayerStatsByName 'Thurl Bailey',  0,  2,  4,  0,  44,  0,  44,  1,  1999
EXEC add_PlayerStatsByName 'Dale Ellis',  1,  2,  11,  0,  49,  46,  58,  1,  1998
EXEC add_PlayerStatsByName 'Dale Ellis',  0,  2,  10,  0,  44,  43,  55,  1,  1999
EXEC add_PlayerStatsByName 'Dale Ellis',  0,  1,  4,  0,  41,  37,  53,  1,  2000
EXEC add_PlayerStatsByName 'Derek Harper',  3,  1,  8,  1,  41,  36,  47,  2,  1998
EXEC add_PlayerStatsByName 'Derek Harper',  4,  1,  6,  1,  41,  36,  48,  1,  1999
EXEC add_PlayerStatsByName 'Charles Jones',  1,  1,  3,  1,  31,  31,  39,  1,  1999
EXEC add_PlayerStatsByName 'Charles Jones',  1,  1,  3,  0,  32,  33,  42,  0,  2000
EXEC add_PlayerStatsByName 'Mark Jones',  0,  1,  2,  0,  28,  0,  28,  1,  2005
EXEC add_PlayerStatsByName 'Michael Cage',  0,  3,  1,  0,  51,  0,  51,  1,  1998
EXEC add_PlayerStatsByName 'Antoine Carr',  0,  1,  2,  0,  40,  0,  40,  1,  1999
EXEC add_PlayerStatsByName 'Jerome Kersey',  1,  3,  6,  1,  41,  10,  41,  2,  1998
EXEC add_PlayerStatsByName 'Jerome Kersey',  0,  2,  3,  0,  34,  21,  34,  2,  1999
EXEC add_PlayerStatsByName 'Jerome Kersey',  1,  3,  4,  0,  41,  0,  41,  2,  2000
EXEC add_PlayerStatsByName 'Jerome Kersey',  0,  2,  3,  0,  46,  0,  46,  1,  2001
EXEC add_PlayerStatsByName 'Sam Perkins',  1,  3,  7,  0,  41,  39,  50,  2,  1998
EXEC add_PlayerStatsByName 'Sam Perkins',  0,  2,  5,  0,  40,  38,  48,  1,  1999
EXEC add_PlayerStatsByName 'Sam Perkins',  0,  3,  6,  0,  41,  40,  51,  1,  2000
EXEC add_PlayerStatsByName 'Sam Perkins',  0,  2,  3,  0,  38,  34,  46,  1,  2001
EXEC add_PlayerStatsByName 'Otis Thorpe',  3,  7,  10,  2,  47,  0,  47,  3,  1998
EXEC add_PlayerStatsByName 'Otis Thorpe',  2,  6,  11,  1,  54,  0,  54,  4,  1999
EXEC add_PlayerStatsByName 'Otis Thorpe',  0,  3,  5,  1,  51,  0,  51,  2,  2000
EXEC add_PlayerStatsByName 'Kevin Willis',  1,  8,  16,  2,  51,  14,  51,  2,  1998
EXEC add_PlayerStatsByName 'Kevin Willis',  1,  8,  12,  2,  41,  0,  41,  3,  1999
EXEC add_PlayerStatsByName 'Kevin Willis',  0,  6,  7,  1,  41,  33,  41,  3,  2000
EXEC add_PlayerStatsByName 'Kevin Willis',  0,  6,  9,  1,  44,  16,  44,  2,  2001
EXEC add_PlayerStatsByName 'Kevin Willis',  0,  5,  6,  0,  44,  0,  44,  1,  2002
EXEC add_PlayerStatsByName 'Kevin Willis',  0,  3,  4,  0,  47,  0,  47,  1,  2003
EXEC add_PlayerStatsByName 'Kevin Willis',  0,  2,  3,  0,  46,  0,  46,  1,  2004
EXEC add_PlayerStatsByName 'Tyrone Corbin',  2,  4,  10,  1,  43,  34,  47,  2,  1998
EXEC add_PlayerStatsByName 'Tyrone Corbin',  0,  3,  7,  0,  39,  31,  44,  1,  1999
EXEC add_PlayerStatsByName 'Tyrone Corbin',  1,  3,  4,  0,  35,  22,  37,  1,  2000
EXEC add_PlayerStatsByName 'Tyrone Corbin',  0,  0,  1,  0,  23,  0,  23,  1,  2001
EXEC add_PlayerStatsByName 'A.C. Green',  1,  8,  7,  0,  45,  0,  45,  1,  1998
EXEC add_PlayerStatsByName 'A.C. Green',  0,  4,  4,  0,  42,  0,  42,  1,  1999
EXEC add_PlayerStatsByName 'A.C. Green',  1,  5,  5,  0,  44,  25,  44,  1,  2000
EXEC add_PlayerStatsByName 'A.C. Green',  0,  3,  4,  0,  44,  0,  44,  1,  2001
EXEC add_PlayerStatsByName 'Joe Kleine',  0,  2,  2,  0,  40,  0,  40,  1,  1999
EXEC add_PlayerStatsByName 'Charles Oakley',  2,  9,  9,  1,  44,  0,  44,  3,  1998
EXEC add_PlayerStatsByName 'Charles Oakley',  3,  7,  7,  1,  42,  20,  43,  3,  1999
EXEC add_PlayerStatsByName 'Charles Oakley',  3,  6,  6,  1,  41,  34,  43,  3,  2000
EXEC add_PlayerStatsByName 'Charles Oakley',  3,  9,  9,  1,  38,  22,  39,  3,  2001
EXEC add_PlayerStatsByName 'Charles Oakley',  2,  6,  3,  1,  36,  16,  37,  3,  2002
EXEC add_PlayerStatsByName 'Terry Porter',  3,  2,  9,  1,  44,  39,  52,  1,  1998
EXEC add_PlayerStatsByName 'Terry Porter',  2,  2,  10,  1,  46,  41,  54,  1,  1999
EXEC add_PlayerStatsByName 'Terry Porter',  3,  2,  9,  1,  44,  43,  54,  1,  2000
EXEC add_PlayerStatsByName 'Terry Porter',  3,  2,  7,  1,  44,  42,  54,  1,  2001
EXEC add_PlayerStatsByName 'Terry Porter',  2,  2,  5,  1,  42,  41,  51,  1,  2002
EXEC add_PlayerStatsByName 'Detlef Schrempf',  4,  7,  15,  2,  48,  41,  52,  2,  1998
EXEC add_PlayerStatsByName 'Detlef Schrempf',  3,  7,  15,  2,  47,  39,  50,  3,  1999
EXEC add_PlayerStatsByName 'Detlef Schrempf',  2,  4,  7,  1,  43,  40,  45,  2,  2000
EXEC add_PlayerStatsByName 'Detlef Schrempf',  1,  3,  4,  1,  41,  37,  42,  1,  2001
EXEC add_PlayerStatsByName 'Spud Webb',  1,  0,  3,  1,  41,  0,  41,  1,  1998
EXEC add_PlayerStatsByName 'Bill Wennington',  0,  2,  3,  0,  34,  100,  35,  2,  1999
EXEC add_PlayerStatsByName 'Gerald Wilkins',  1,  1,  5,  1,  32,  26,  35,  1,  1998
EXEC add_PlayerStatsByName 'Dell Curry',  1,  1,  9,  1,  44,  42,  51,  1,  1998
EXEC add_PlayerStatsByName 'Dell Curry',  1,  2,  10,  1,  48,  47,  58,  1,  1999
EXEC add_PlayerStatsByName 'Dell Curry',  1,  1,  7,  0,  42,  39,  53,  1,  2000
EXEC add_PlayerStatsByName 'Dell Curry',  1,  1,  6,  0,  42,  42,  50,  0,  2001
EXEC add_PlayerStatsByName 'Dell Curry',  1,  1,  6,  0,  40,  34,  47,  0,  2002
EXEC add_PlayerStatsByName 'Ron Harper',  2,  3,  9,  1,  44,  19,  45,  2,  1998
EXEC add_PlayerStatsByName 'Ron Harper',  3,  5,  11,  1,  37,  31,  41,  2,  1999
EXEC add_PlayerStatsByName 'Ron Harper',  3,  4,  7,  1,  39,  31,  43,  2,  2000
EXEC add_PlayerStatsByName 'Ron Harper',  2,  3,  6,  1,  46,  26,  50,  1,  2001
EXEC add_PlayerStatsByName 'Cedric Henderson',  2,  4,  10,  2,  48,  0,  48,  2,  1998
EXEC add_PlayerStatsByName 'Cedric Henderson',  2,  3,  9,  1,  41,  16,  41,  2,  1999
EXEC add_PlayerStatsByName 'Cedric Henderson',  0,  2,  5,  1,  39,  6,  39,  1,  2000
EXEC add_PlayerStatsByName 'Cedric Henderson',  1,  1,  4,  1,  38,  12,  39,  1,  2001
EXEC add_PlayerStatsByName 'Cedric Henderson',  0,  0,  3,  0,  48,  50,  51,  0,  2002
EXEC add_PlayerStatsByName 'Jeff Hornacek',  4,  3,  14,  1,  48,  44,  51,  2,  1998
EXEC add_PlayerStatsByName 'Jeff Hornacek',  4,  3,  12,  1,  47,  42,  51,  2,  1999
EXEC add_PlayerStatsByName 'Jeff Hornacek',  2,  2,  12,  1,  49,  47,  53,  1,  2000
EXEC add_PlayerStatsByName 'Nate McMillan',  3,  2,  3,  0,  34,  44,  45,  2,  1998
EXEC add_PlayerStatsByName 'Johnny Newman',  1,  1,  14,  2,  43,  34,  45,  2,  1998
EXEC add_PlayerStatsByName 'Johnny Newman',  0,  1,  6,  0,  42,  37,  46,  2,  1999
EXEC add_PlayerStatsByName 'Johnny Newman',  0,  1,  10,  1,  44,  37,  50,  2,  2000
EXEC add_PlayerStatsByName 'Johnny Newman',  1,  2,  10,  1,  41,  33,  46,  2,  2001
EXEC add_PlayerStatsByName 'Johnny Newman',  0,  1,  4,  0,  45,  38,  52,  1,  2002
EXEC add_PlayerStatsByName 'Chuck Person',  1,  3,  6,  1,  35,  34,  47,  2,  1998
EXEC add_PlayerStatsByName 'Chuck Person',  1,  2,  6,  0,  38,  35,  48,  1,  1999
EXEC add_PlayerStatsByName 'Chuck Person',  0,  1,  2,  0,  30,  25,  39,  1,  2000
EXEC add_PlayerStatsByName 'Mark Price',  4,  2,  9,  2,  43,  33,  48,  1,  1998
EXEC add_PlayerStatsByName 'David Wingate',  0,  1,  2,  0,  47,  42,  48,  1,  1998
EXEC add_PlayerStatsByName 'Greg Anderson',  0,  2,  1,  0,  44,  0,  44,  1,  1998
EXEC add_PlayerStatsByName 'Muggsy Bogues',  5,  2,  5,  1,  43,  25,  44,  1,  1998
EXEC add_PlayerStatsByName 'Muggsy Bogues',  3,  2,  5,  1,  49,  0,  49,  1,  1999
EXEC add_PlayerStatsByName 'Muggsy Bogues',  3,  1,  5,  0,  43,  33,  46,  1,  2000
EXEC add_PlayerStatsByName 'Muggsy Bogues',  1,  1,  0,  1,  0,  0,  0,  1,  2001
EXEC add_PlayerStatsByName 'Chris Dudley',  0,  1,  1,  0,  40,  0,  40,  1,  2002
EXEC add_PlayerStatsByName 'Armen Gilliam',  1,  5,  11,  1,  48,  0,  48,  2,  1998
EXEC add_PlayerStatsByName 'Armen Gilliam',  0,  3,  8,  1,  45,  0,  45,  1,  1999
EXEC add_PlayerStatsByName 'Armen Gilliam',  0,  4,  6,  1,  43,  0,  43,  1,  2000
EXEC add_PlayerStatsByName 'Horace Grant',  2,  8,  12,  1,  45,  0,  45,  2,  1998
EXEC add_PlayerStatsByName 'Horace Grant',  1,  7,  8,  0,  43,  0,  43,  2,  1999
EXEC add_PlayerStatsByName 'Horace Grant',  2,  7,  8,  0,  44,  0,  44,  2,  2000
EXEC add_PlayerStatsByName 'Horace Grant',  1,  7,  8,  0,  46,  0,  46,  2,  2001
EXEC add_PlayerStatsByName 'Horace Grant',  1,  4,  4,  0,  41,  0,  41,  1,  2004
EXEC add_PlayerStatsByName 'Mark Jackson',  8,  3,  8,  2,  41,  31,  45,  1,  1998
EXEC add_PlayerStatsByName 'Mark Jackson',  7,  3,  7,  2,  41,  31,  46,  1,  1999
EXEC add_PlayerStatsByName 'Mark Jackson',  8,  3,  8,  2,  43,  40,  51,  1,  2000
EXEC add_PlayerStatsByName 'Mark Jackson',  8,  3,  7,  2,  41,  33,  47,  1,  2001
EXEC add_PlayerStatsByName 'Mark Jackson',  7,  3,  8,  1,  43,  40,  50,  2,  2002
EXEC add_PlayerStatsByName 'Mark Jackson',  4,  2,  4,  1,  39,  28,  43,  1,  2003
EXEC add_PlayerStatsByName 'Mark Jackson',  2,  1,  2,  1,  34,  17,  37,  1,  2004
EXEC add_PlayerStatsByName 'Kevin Johnson',  4,  3,  9,  2,  44,  15,  45,  1,  1998
EXEC add_PlayerStatsByName 'Kevin Johnson',  4,  2,  6,  1,  57,  100,  58,  1,  2000
EXEC add_PlayerStatsByName 'Brad Lohaus',  0,  1,  2,  0,  33,  28,  42,  1,  1998
EXEC add_PlayerStatsByName 'Derrick McKey',  1,  3,  6,  1,  45,  23,  46,  2,  1998
EXEC add_PlayerStatsByName 'Derrick McKey',  1,  3,  4,  0,  44,  0,  44,  1,  1999
EXEC add_PlayerStatsByName 'Derrick McKey',  1,  4,  4,  0,  39,  43,  44,  2,  2000
EXEC add_PlayerStatsByName 'Derrick McKey',  1,  2,  2,  0,  44,  20,  45,  2,  2001
EXEC add_PlayerStatsByName 'Derrick McKey',  1,  3,  2,  0,  42,  41,  44,  2,  2002
EXEC add_PlayerStatsByName 'Olden Polynice',  1,  6,  7,  1,  45,  0,  45,  2,  1998
EXEC add_PlayerStatsByName 'Olden Polynice',  0,  8,  7,  1,  47,  100,  47,  3,  1999
EXEC add_PlayerStatsByName 'Olden Polynice',  0,  5,  5,  0,  51,  50,  51,  3,  2000
EXEC add_PlayerStatsByName 'Olden Polynice',  0,  4,  5,  1,  49,  0,  49,  3,  2001
EXEC add_PlayerStatsByName 'Joe Wolf',  0,  2,  1,  0,  33,  20,  33,  1,  1998
EXEC add_PlayerStatsByName 'Anthony Bowie',  0,  1,  2,  0,  54,  75,  56,  0,  1998
EXEC add_PlayerStatsByName 'Scott Brooks',  1,  0,  1,  0,  42,  45,  46,  0,  1998
EXEC add_PlayerStatsByName 'Mark Bryant',  0,  3,  4,  0,  48,  0,  48,  2,  1998
EXEC add_PlayerStatsByName 'Mark Bryant',  1,  5,  9,  1,  48,  0,  48,  3,  1999
EXEC add_PlayerStatsByName 'Rex Chapman',  3,  2,  15,  1,  42,  38,  49,  1,  1998
EXEC add_PlayerStatsByName 'Rex Chapman',  2,  2,  12,  1,  35,  35,  41,  1,  1999
EXEC add_PlayerStatsByName 'Rex Chapman',  1,  1,  6,  0,  38,  33,  45,  1,  2000
EXEC add_PlayerStatsByName 'Mark Davis',  1,  2,  4,  1,  44,  0,  44,  1,  1998
EXEC add_PlayerStatsByName 'Mark Davis',  1,  3,  6,  1,  40,  0,  40,  2,  2000
EXEC add_PlayerStatsByName 'Ledell Eackles',  0,  1,  5,  0,  42,  34,  47,  1,  1998
EXEC add_PlayerStatsByName 'Kevin Edwards',  1,  1,  3,  0,  34,  40,  36,  0,  1998
EXEC add_PlayerStatsByName 'Kevin Edwards',  1,  1,  3,  0,  32,  26,  34,  1,  2001
EXEC add_PlayerStatsByName 'Duane Ferrell',  0,  0,  1,  0,  36,  0,  36,  1,  1998
EXEC add_PlayerStatsByName 'Gary Grant',  3,  2,  4,  1,  46,  36,  50,  1,  1998
EXEC add_PlayerStatsByName 'Harvey Grant',  0,  2,  2,  0,  38,  16,  38,  1,  1998
EXEC add_PlayerStatsByName 'Harvey Grant',  0,  2,  3,  0,  36,  16,  37,  1,  1999
EXEC add_PlayerStatsByName 'Jeff Grayer',  0,  0,  2,  0,  36,  33,  45,  1,  1998
EXEC add_PlayerStatsByName 'Jack Haley',  0,  0,  1,  0,  27,  0,  27,  0,  1998
EXEC add_PlayerStatsByName 'Hersey Hawkins',  2,  4,  10,  1,  44,  41,  53,  1,  1998
EXEC add_PlayerStatsByName 'Hersey Hawkins',  2,  4,  10,  1,  41,  30,  48,  1,  1999
EXEC add_PlayerStatsByName 'Hersey Hawkins',  2,  2,  7,  1,  42,  39,  49,  2,  2000
EXEC add_PlayerStatsByName 'Hersey Hawkins',  1,  1,  3,  0,  40,  37,  47,  0,  2001
EXEC add_PlayerStatsByName 'Avery Johnson',  7,  2,  10,  2,  47,  15,  48,  1,  1998
EXEC add_PlayerStatsByName 'Avery Johnson',  7,  2,  9,  2,  47,  8,  47,  2,  1999
EXEC add_PlayerStatsByName 'Avery Johnson',  6,  1,  11,  1,  47,  11,  47,  1,  2000
EXEC add_PlayerStatsByName 'Avery Johnson',  4,  1,  5,  1,  44,  16,  44,  1,  2001
EXEC add_PlayerStatsByName 'Avery Johnson',  4,  1,  7,  1,  47,  0,  47,  1,  2002
EXEC add_PlayerStatsByName 'Avery Johnson',  1,  0,  3,  0,  42,  0,  42,  0,  2003
EXEC add_PlayerStatsByName 'Avery Johnson',  2,  0,  4,  1,  40,  0,  40,  0,  2004
EXEC add_PlayerStatsByName 'Steve Kerr',  1,  1,  7,  0,  45,  43,  54,  1,  1998
EXEC add_PlayerStatsByName 'Steve Kerr',  1,  1,  4,  0,  39,  31,  46,  0,  1999
EXEC add_PlayerStatsByName 'Steve Kerr',  0,  0,  2,  0,  43,  51,  54,  0,  2000
EXEC add_PlayerStatsByName 'Steve Kerr',  1,  0,  3,  0,  42,  42,  52,  0,  2001
EXEC add_PlayerStatsByName 'Steve Kerr',  1,  0,  4,  0,  47,  39,  53,  0,  2002
EXEC add_PlayerStatsByName 'Steve Kerr',  0,  0,  4,  0,  43,  39,  52,  0,  2003
EXEC add_PlayerStatsByName 'Andrew Lang',  0,  2,  2,  0,  37,  0,  37,  1,  1998
EXEC add_PlayerStatsByName 'Grant Long',  0,  3,  3,  0,  42,  0,  42,  2,  1998
EXEC add_PlayerStatsByName 'Grant Long',  1,  5,  9,  1,  42,  16,  42,  2,  1999
EXEC add_PlayerStatsByName 'Grant Long',  1,  5,  4,  1,  44,  0,  44,  2,  2000
EXEC add_PlayerStatsByName 'Grant Long',  1,  4,  6,  0,  43,  26,  44,  2,  2001
EXEC add_PlayerStatsByName 'Grant Long',  2,  3,  6,  1,  42,  17,  43,  1,  2002
EXEC add_PlayerStatsByName 'Grant Long',  0,  2,  1,  0,  38,  0,  38,  1,  2003
EXEC add_PlayerStatsByName 'Dan Majerle',  2,  3,  7,  0,  41,  37,  54,  1,  1998
EXEC add_PlayerStatsByName 'Dan Majerle',  3,  4,  7,  1,  39,  33,  51,  2,  1999
EXEC add_PlayerStatsByName 'Dan Majerle',  3,  4,  7,  0,  40,  36,  53,  2,  2000
EXEC add_PlayerStatsByName 'Dan Majerle',  1,  3,  5,  0,  33,  31,  44,  1,  2001
EXEC add_PlayerStatsByName 'Dan Majerle',  1,  2,  4,  0,  34,  33,  47,  1,  2002
EXEC add_PlayerStatsByName 'Danny Manning',  2,  5,  13,  1,  51,  0,  51,  2,  1998
EXEC add_PlayerStatsByName 'Danny Manning',  2,  4,  9,  1,  48,  11,  48,  2,  1999
EXEC add_PlayerStatsByName 'Danny Manning',  1,  2,  4,  0,  44,  25,  44,  2,  2000
EXEC add_PlayerStatsByName 'Danny Manning',  1,  2,  7,  1,  49,  25,  50,  2,  2001
EXEC add_PlayerStatsByName 'Danny Manning',  0,  2,  4,  0,  47,  14,  48,  2,  2002
EXEC add_PlayerStatsByName 'Danny Manning',  0,  1,  2,  0,  40,  37,  45,  0,  2003
EXEC add_PlayerStatsByName 'Vernon Maxwell',  1,  1,  6,  1,  39,  33,  47,  1,  1998
EXEC add_PlayerStatsByName 'Vernon Maxwell',  1,  1,  10,  1,  39,  34,  48,  2,  1999
EXEC add_PlayerStatsByName 'Vernon Maxwell',  1,  1,  10,  1,  34,  30,  41,  1,  2000
EXEC add_PlayerStatsByName 'Vernon Maxwell',  1,  1,  4,  0,  32,  30,  40,  1,  2001
EXEC add_PlayerStatsByName 'Chris Morris',  0,  2,  4,  0,  41,  30,  45,  1,  1998
EXEC add_PlayerStatsByName 'Chris Morris',  0,  2,  4,  0,  43,  28,  48,  1,  1999
EXEC add_PlayerStatsByName 'Will Perdue',  0,  6,  5,  1,  54,  0,  54,  1,  1998
EXEC add_PlayerStatsByName 'Rony Seikaly',  1,  7,  13,  2,  43,  0,  43,  2,  1998
EXEC add_PlayerStatsByName 'Brian Shaw',  4,  3,  6,  1,  34,  29,  37,  2,  1998
EXEC add_PlayerStatsByName 'Brian Shaw',  2,  2,  4,  1,  38,  31,  41,  1,  2000
EXEC add_PlayerStatsByName 'Brian Shaw',  3,  3,  5,  1,  39,  31,  45,  2,  2001
EXEC add_PlayerStatsByName 'Brian Shaw',  1,  1,  2,  0,  35,  33,  43,  0,  2002
EXEC add_PlayerStatsByName 'Brian Shaw',  1,  1,  3,  0,  38,  34,  46,  0,  2003
EXEC add_PlayerStatsByName 'Charles Smith',  0,  0,  3,  0,  39,  31,  45,  0,  1998
EXEC add_PlayerStatsByName 'Charles Smith',  0,  1,  3,  0,  36,  21,  39,  1,  1999
EXEC add_PlayerStatsByName 'Charles Smith',  1,  2,  7,  1,  42,  26,  46,  1,  2002
EXEC add_PlayerStatsByName 'Charles Smith',  0,  0,  1,  0,  25,  0,  25,  1,  2003
EXEC add_PlayerStatsByName 'Rik Smits',  1,  6,  16,  1,  49,  0,  49,  3,  1998
EXEC add_PlayerStatsByName 'Rik Smits',  1,  5,  14,  1,  49,  0,  49,  3,  1999
EXEC add_PlayerStatsByName 'Rik Smits',  1,  5,  12,  1,  48,  0,  48,  3,  2000
EXEC add_PlayerStatsByName 'John Starks',  2,  2,  12,  1,  39,  32,  46,  2,  1998
EXEC add_PlayerStatsByName 'John Starks',  4,  3,  13,  1,  37,  28,  42,  2,  1999
EXEC add_PlayerStatsByName 'John Starks',  4,  2,  13,  1,  37,  34,  42,  2,  2000
EXEC add_PlayerStatsByName 'John Starks',  2,  2,  9,  1,  39,  35,  44,  2,  2001
EXEC add_PlayerStatsByName 'John Starks',  1,  1,  4,  0,  36,  30,  41,  1,  2002
EXEC add_PlayerStatsByName 'Rod Strickland',  10,  5,  17,  3,  43,  25,  43,  2,  1998
EXEC add_PlayerStatsByName 'Rod Strickland',  9,  4,  15,  3,  41,  28,  42,  2,  1999
EXEC add_PlayerStatsByName 'Rod Strickland',  7,  3,  12,  2,  42,  4,  43,  2,  2000
EXEC add_PlayerStatsByName 'Rod Strickland',  5,  2,  9,  2,  42,  23,  42,  1,  2001
EXEC add_PlayerStatsByName 'Rod Strickland',  6,  3,  10,  2,  44,  30,  44,  1,  2002
EXEC add_PlayerStatsByName 'Rod Strickland',  4,  2,  6,  1,  43,  9,  43,  1,  2003
EXEC add_PlayerStatsByName 'Rod Strickland',  4,  2,  6,  1,  42,  27,  43,  1,  2004
EXEC add_PlayerStatsByName 'Micheal Williams',  1,  0,  2,  0,  33,  0,  33,  1,  1998
EXEC add_PlayerStatsByName 'Nick Anderson',  2,  5,  15,  1,  45,  36,  50,  1,  1998
EXEC add_PlayerStatsByName 'Nick Anderson',  1,  5,  14,  1,  39,  34,  47,  1,  1999
EXEC add_PlayerStatsByName 'Nick Anderson',  1,  4,  10,  1,  39,  33,  47,  1,  2000
EXEC add_PlayerStatsByName 'Nick Anderson',  0,  1,  1,  0,  24,  25,  33,  0,  2001
EXEC add_PlayerStatsByName 'Nick Anderson',  0,  2,  4,  0,  27,  27,  36,  1,  2002
EXEC add_PlayerStatsByName 'B.J. Armstrong',  2,  1,  4,  0,  49,  25,  51,  1,  1998
EXEC add_PlayerStatsByName 'B.J. Armstrong',  1,  1,  3,  0,  45,  46,  49,  1,  1999
EXEC add_PlayerStatsByName 'B.J. Armstrong',  2,  1,  7,  1,  44,  44,  48,  1,  2000
EXEC add_PlayerStatsByName 'Dana Barros',  2,  2,  6,  1,  38,  33,  44,  1,  2002
EXEC add_PlayerStatsByName 'Mookie Blaylock',  6,  4,  13,  2,  39,  26,  44,  1,  1998
EXEC add_PlayerStatsByName 'Mookie Blaylock',  5,  4,  13,  2,  37,  30,  43,  1,  1999
EXEC add_PlayerStatsByName 'Mookie Blaylock',  6,  3,  11,  2,  39,  33,  45,  1,  2000
EXEC add_PlayerStatsByName 'Mookie Blaylock',  6,  3,  11,  1,  39,  32,  44,  1,  2001
EXEC add_PlayerStatsByName 'Mookie Blaylock',  3,  1,  3,  1,  34,  35,  39,  0,  2002
EXEC add_PlayerStatsByName 'Chucky Brown',  0,  2,  5,  0,  43,  25,  43,  1,  1998
EXEC add_PlayerStatsByName 'Chucky Brown',  1,  3,  8,  0,  47,  37,  49,  2,  1999
EXEC add_PlayerStatsByName 'Chucky Brown',  1,  2,  5,  0,  45,  20,  45,  1,  2000
EXEC add_PlayerStatsByName 'Chucky Brown',  0,  2,  3,  0,  42,  0,  42,  1,  2001
EXEC add_PlayerStatsByName 'Terry Davis',  0,  6,  4,  0,  49,  0,  49,  2,  1998
EXEC add_PlayerStatsByName 'Sherman Douglas',  4,  1,  8,  1,  49,  30,  50,  2,  1998
EXEC add_PlayerStatsByName 'Sherman Douglas',  4,  1,  8,  2,  43,  0,  43,  1,  1999
EXEC add_PlayerStatsByName 'Sherman Douglas',  1,  1,  6,  1,  50,  31,  52,  1,  2000
EXEC add_PlayerStatsByName 'Sherman Douglas',  2,  1,  5,  1,  40,  20,  41,  1,  2001
EXEC add_PlayerStatsByName 'Blue Edwards',  2,  2,  10,  1,  43,  33,  46,  2,  1998
EXEC add_PlayerStatsByName 'Blue Edwards',  1,  1,  3,  0,  44,  40,  47,  1,  1999
EXEC add_PlayerStatsByName 'Sean Elliott',  1,  3,  9,  1,  40,  37,  45,  2,  1998
EXEC add_PlayerStatsByName 'Sean Elliott',  2,  4,  11,  1,  41,  32,  44,  2,  1999
EXEC add_PlayerStatsByName 'Sean Elliott',  1,  2,  6,  1,  35,  35,  42,  1,  2000
EXEC add_PlayerStatsByName 'Sean Elliott',  1,  3,  7,  1,  43,  42,  51,  1,  2001
EXEC add_PlayerStatsByName 'Tom Hammonds',  0,  4,  6,  0,  51,  0,  51,  2,  1998
EXEC add_PlayerStatsByName 'Jaren Jackson',  1,  2,  8,  1,  39,  37,  48,  2,  1998
EXEC add_PlayerStatsByName 'Jaren Jackson',  1,  2,  6,  0,  38,  36,  47,  1,  1999
EXEC add_PlayerStatsByName 'Jaren Jackson',  1,  2,  6,  0,  38,  35,  49,  1,  2000
EXEC add_PlayerStatsByName 'Jaren Jackson',  0,  0,  2,  0,  40,  38,  48,  0,  2001
EXEC add_PlayerStatsByName 'Jaren Jackson',  0,  1,  4,  0,  40,  35,  50,  1,  2002
EXEC add_PlayerStatsByName 'Shawn Kemp',  2,  9,  18,  3,  44,  25,  44,  3,  1998
EXEC add_PlayerStatsByName 'Shawn Kemp',  2,  9,  20,  3,  48,  50,  48,  3,  1999
EXEC add_PlayerStatsByName 'Shawn Kemp',  1,  8,  17,  3,  41,  33,  41,  4,  2000
EXEC add_PlayerStatsByName 'Shawn Kemp',  1,  3,  6,  1,  40,  36,  41,  2,  2001
EXEC add_PlayerStatsByName 'Shawn Kemp',  0,  3,  6,  1,  43,  0,  43,  2,  2002
EXEC add_PlayerStatsByName 'Shawn Kemp',  0,  5,  6,  1,  41,  0,  41,  3,  2003
EXEC add_PlayerStatsByName 'Tim Legler',  0,  0,  1,  0,  15,  0,  15,  1,  1998
EXEC add_PlayerStatsByName 'Tim Legler',  0,  1,  4,  0,  44,  40,  50,  1,  1999
EXEC add_PlayerStatsByName 'Tim Legler',  1,  1,  3,  0,  35,  33,  40,  1,  2000
EXEC add_PlayerStatsByName 'Anthony Mason',  4,  10,  12,  1,  50,  0,  50,  2,  1998
EXEC add_PlayerStatsByName 'Anthony Mason',  4,  8,  11,  2,  48,  0,  48,  2,  2000
EXEC add_PlayerStatsByName 'Anthony Mason',  4,  7,  9,  1,  50,  100,  50,  2,  2002
EXEC add_PlayerStatsByName 'Anthony Mason',  3,  6,  7,  1,  48,  0,  48,  2,  2003
EXEC add_PlayerStatsByName 'George McCloud',  1,  3,  7,  1,  40,  34,  48,  2,  1998
EXEC add_PlayerStatsByName 'George McCloud',  1,  3,  8,  1,  43,  41,  54,  2,  1999
EXEC add_PlayerStatsByName 'George McCloud',  3,  3,  10,  1,  41,  37,  50,  2,  2000
EXEC add_PlayerStatsByName 'George McCloud',  3,  2,  9,  1,  38,  32,  44,  2,  2001
EXEC add_PlayerStatsByName 'George McCloud',  3,  3,  8,  2,  35,  27,  41,  2,  2002
EXEC add_PlayerStatsByName 'Sam Mitchell',  1,  4,  12,  0,  46,  34,  47,  2,  1998
EXEC add_PlayerStatsByName 'Sam Mitchell',  2,  3,  11,  0,  40,  23,  41,  2,  1999
EXEC add_PlayerStatsByName 'Sam Mitchell',  1,  2,  6,  0,  44,  43,  46,  1,  2000
EXEC add_PlayerStatsByName 'Sam Mitchell',  0,  1,  3,  0,  40,  20,  42,  1,  2001
EXEC add_PlayerStatsByName 'Sam Mitchell',  0,  1,  3,  0,  43,  28,  45,  1,  2002
EXEC add_PlayerStatsByName 'J.R. Reid',  0,  2,  4,  0,  45,  37,  46,  2,  1998
EXEC add_PlayerStatsByName 'J.R. Reid',  1,  5,  9,  1,  47,  0,  47,  3,  1999
EXEC add_PlayerStatsByName 'J.R. Reid',  0,  3,  4,  0,  41,  14,  42,  2,  2000
EXEC add_PlayerStatsByName 'Glen Rice',  2,  4,  22,  2,  45,  43,  50,  2,  1998
EXEC add_PlayerStatsByName 'Glen Rice',  2,  3,  17,  1,  43,  39,  49,  2,  1999
EXEC add_PlayerStatsByName 'Glen Rice',  2,  4,  15,  1,  43,  36,  47,  2,  2000
EXEC add_PlayerStatsByName 'Glen Rice',  1,  4,  12,  1,  44,  38,  49,  2,  2001
EXEC add_PlayerStatsByName 'Glen Rice',  1,  2,  8,  1,  38,  28,  44,  1,  2002
EXEC add_PlayerStatsByName 'Glen Rice',  1,  2,  9,  0,  42,  39,  53,  1,  2003
EXEC add_PlayerStatsByName 'Glen Rice',  1,  2,  3,  0,  28,  17,  32,  1,  2004
EXEC add_PlayerStatsByName 'Pooh Richardson',  3,  1,  4,  0,  37,  19,  38,  1,  1998
EXEC add_PlayerStatsByName 'Pooh Richardson',  2,  1,  2,  0,  33,  0,  33,  0,  1999
EXEC add_PlayerStatsByName 'Clifford Robinson',  2,  5,  14,  1,  47,  32,  49,  3,  1998
EXEC add_PlayerStatsByName 'Clifford Robinson',  2,  4,  16,  1,  47,  41,  52,  3,  1999
EXEC add_PlayerStatsByName 'Clifford Robinson',  2,  4,  18,  2,  46,  37,  51,  3,  2000
EXEC add_PlayerStatsByName 'Clifford Robinson',  2,  4,  16,  2,  42,  36,  46,  3,  2001
EXEC add_PlayerStatsByName 'Clifford Robinson',  2,  4,  14,  1,  42,  37,  47,  3,  2002
EXEC add_PlayerStatsByName 'Clifford Robinson',  3,  3,  12,  2,  39,  33,  44,  3,  2003
EXEC add_PlayerStatsByName 'Clifford Robinson',  3,  3,  11,  2,  38,  35,  44,  2,  2004
EXEC add_PlayerStatsByName 'Michael Smith',  1,  6,  5,  1,  47,  0,  47,  2,  1998
EXEC add_PlayerStatsByName 'Michael Smith',  1,  7,  4,  1,  53,  0,  53,  2,  1999
EXEC add_PlayerStatsByName 'Michael Smith',  1,  7,  6,  1,  56,  0,  56,  2,  2000
EXEC add_PlayerStatsByName 'Michael Smith',  1,  7,  3,  0,  48,  0,  48,  2,  2001
EXEC add_PlayerStatsByName 'Doug West',  1,  2,  4,  0,  37,  0,  37,  2,  1998
EXEC add_PlayerStatsByName 'Doug West',  1,  1,  5,  0,  47,  0,  47,  2,  1999
EXEC add_PlayerStatsByName 'Doug West',  1,  1,  4,  0,  40,  0,  40,  2,  2000
EXEC add_PlayerStatsByName 'Doug West',  0,  1,  1,  0,  28,  0,  28,  1,  2001
EXEC add_PlayerStatsByName 'Haywoode Workman',  5,  3,  6,  2,  42,  36,  47,  1,  1999
EXEC add_PlayerStatsByName 'Haywoode Workman',  1,  0,  2,  0,  34,  32,  42,  1,  2000
EXEC add_PlayerStatsByName 'Mahmoud Abdul-Rauf',  1,  1,  7,  0,  37,  16,  38,  1,  1998
EXEC add_PlayerStatsByName 'Mahmoud Abdul-Rauf',  1,  0,  6,  0,  48,  28,  49,  1,  2001
EXEC add_PlayerStatsByName 'Keith Askins',  0,  2,  2,  0,  32,  28,  40,  2,  1998
EXEC add_PlayerStatsByName 'Keith Askins',  0,  1,  1,  0,  32,  27,  38,  1,  1999
EXEC add_PlayerStatsByName 'Dee Brown',  2,  2,  9,  1,  43,  39,  53,  1,  1998
EXEC add_PlayerStatsByName 'Dee Brown',  2,  2,  11,  1,  37,  38,  51,  1,  1999
EXEC add_PlayerStatsByName 'Dee Brown',  2,  1,  6,  1,  36,  35,  49,  1,  2000
EXEC add_PlayerStatsByName 'Dee Brown',  1,  1,  6,  1,  36,  37,  50,  1,  2001
EXEC add_PlayerStatsByName 'Dee Brown',  0,  1,  1,  0,  15,  8,  17,  0,  2002
EXEC add_PlayerStatsByName 'Jud Buechler',  0,  1,  2,  0,  48,  38,  55,  0,  1998
EXEC add_PlayerStatsByName 'Jud Buechler',  1,  2,  5,  0,  41,  41,  54,  1,  1999
EXEC add_PlayerStatsByName 'Jud Buechler',  0,  1,  2,  0,  35,  21,  41,  0,  2000
EXEC add_PlayerStatsByName 'Jud Buechler',  0,  1,  3,  0,  46,  41,  56,  1,  2001
EXEC add_PlayerStatsByName 'Jud Buechler',  0,  1,  1,  0,  37,  35,  46,  0,  2002
EXEC add_PlayerStatsByName 'Matt Bullard',  0,  2,  7,  0,  45,  41,  57,  1,  1998
EXEC add_PlayerStatsByName 'Matt Bullard',  0,  1,  2,  0,  37,  38,  48,  0,  1999
EXEC add_PlayerStatsByName 'Matt Bullard',  1,  2,  6,  0,  40,  44,  52,  1,  2000
EXEC add_PlayerStatsByName 'Matt Bullard',  0,  2,  5,  0,  42,  40,  56,  1,  2001
EXEC add_PlayerStatsByName 'Matt Bullard',  0,  1,  3,  0,  33,  28,  40,  0,  2002
EXEC add_PlayerStatsByName 'Willie Burton',  0,  0,  2,  0,  38,  33,  45,  0,  1998
EXEC add_PlayerStatsByName 'Willie Burton',  0,  2,  1,  0,  14,  0,  14,  0,  1999
EXEC add_PlayerStatsByName 'Elden Campbell',  1,  5,  10,  1,  46,  50,  46,  2,  1998
EXEC add_PlayerStatsByName 'Elden Campbell',  1,  8,  12,  1,  47,  0,  47,  3,  1999
EXEC add_PlayerStatsByName 'Elden Campbell',  1,  7,  12,  1,  44,  0,  44,  3,  2000
EXEC add_PlayerStatsByName 'Elden Campbell',  1,  7,  13,  1,  44,  0,  44,  3,  2001
EXEC add_PlayerStatsByName 'Elden Campbell',  1,  6,  13,  1,  48,  0,  48,  3,  2002
EXEC add_PlayerStatsByName 'Elden Campbell',  0,  3,  6,  0,  39,  0,  39,  2,  2003
EXEC add_PlayerStatsByName 'Elden Campbell',  0,  2,  3,  0,  31,  0,  31,  1,  2005
EXEC add_PlayerStatsByName 'Cedric Ceballos',  1,  4,  11,  1,  49,  30,  51,  1,  1998
EXEC add_PlayerStatsByName 'Cedric Ceballos',  0,  6,  12,  2,  42,  39,  46,  1,  1999
EXEC add_PlayerStatsByName 'Cedric Ceballos',  1,  6,  16,  1,  44,  32,  46,  2,  2000
EXEC add_PlayerStatsByName 'Cedric Ceballos',  0,  2,  6,  0,  44,  30,  48,  1,  2001
EXEC add_PlayerStatsByName 'Derrick Coleman',  2,  9,  17,  2,  41,  26,  42,  2,  1998
EXEC add_PlayerStatsByName 'Derrick Coleman',  2,  8,  13,  2,  41,  21,  42,  2,  1999
EXEC add_PlayerStatsByName 'Derrick Coleman',  2,  8,  16,  2,  45,  36,  48,  2,  2000
EXEC add_PlayerStatsByName 'Derrick Coleman',  1,  5,  8,  1,  38,  39,  42,  1,  2001
EXEC add_PlayerStatsByName 'Derrick Coleman',  1,  8,  15,  2,  45,  33,  46,  2,  2002
EXEC add_PlayerStatsByName 'Derrick Coleman',  1,  7,  9,  1,  44,  32,  47,  2,  2003
EXEC add_PlayerStatsByName 'Derrick Coleman',  1,  5,  8,  1,  41,  22,  42,  2,  2004
EXEC add_PlayerStatsByName 'Derrick Coleman',  0,  3,  1,  0,  21,  0,  21,  1,  2005
EXEC add_PlayerStatsByName 'Bimbo Coles',  4,  2,  8,  1,  37,  22,  39,  2,  1998
EXEC add_PlayerStatsByName 'Bimbo Coles',  4,  2,  9,  1,  44,  24,  44,  2,  1999
EXEC add_PlayerStatsByName 'Bimbo Coles',  3,  2,  8,  1,  45,  20,  46,  2,  2000
EXEC add_PlayerStatsByName 'Bimbo Coles',  2,  1,  4,  1,  38,  12,  38,  1,  2001
EXEC add_PlayerStatsByName 'Bimbo Coles',  2,  1,  3,  0,  38,  20,  39,  1,  2002
EXEC add_PlayerStatsByName 'Bimbo Coles',  2,  1,  4,  0,  33,  21,  35,  1,  2003
EXEC add_PlayerStatsByName 'Mario Elie',  3,  2,  8,  1,  45,  29,  51,  1,  1998
EXEC add_PlayerStatsByName 'Mario Elie',  1,  2,  9,  1,  47,  37,  53,  1,  1999
EXEC add_PlayerStatsByName 'Mario Elie',  2,  3,  7,  1,  42,  39,  50,  2,  2000
EXEC add_PlayerStatsByName 'Mario Elie',  1,  2,  4,  0,  42,  36,  49,  1,  2001
EXEC add_PlayerStatsByName 'Danny Ferry',  0,  1,  4,  0,  39,  33,  45,  1,  1998
EXEC add_PlayerStatsByName 'Danny Ferry',  1,  2,  7,  0,  47,  39,  54,  2,  1999
EXEC add_PlayerStatsByName 'Danny Ferry',  1,  3,  7,  0,  49,  44,  54,  2,  2000
EXEC add_PlayerStatsByName 'Danny Ferry',  0,  2,  5,  0,  47,  44,  56,  2,  2001
EXEC add_PlayerStatsByName 'Danny Ferry',  1,  1,  4,  0,  42,  43,  55,  1,  2002
EXEC add_PlayerStatsByName 'Danny Ferry',  0,  1,  1,  0,  35,  35,  44,  0,  2003
EXEC add_PlayerStatsByName 'Greg Foster',  0,  3,  5,  0,  44,  22,  44,  2,  1998
EXEC add_PlayerStatsByName 'Greg Foster',  0,  2,  2,  0,  37,  25,  38,  1,  1999
EXEC add_PlayerStatsByName 'Greg Foster',  0,  1,  3,  0,  40,  20,  41,  1,  2000
EXEC add_PlayerStatsByName 'Greg Foster',  0,  1,  2,  0,  42,  33,  43,  1,  2001
EXEC add_PlayerStatsByName 'Greg Foster',  0,  1,  1,  0,  22,  0,  22,  0,  2002
EXEC add_PlayerStatsByName 'Greg Foster',  0,  3,  4,  1,  38,  25,  38,  2,  2003
EXEC add_PlayerStatsByName 'Kendall Gill',  2,  4,  13,  1,  42,  25,  44,  3,  1998
EXEC add_PlayerStatsByName 'Kendall Gill',  2,  4,  11,  1,  39,  11,  40,  3,  1999
EXEC add_PlayerStatsByName 'Kendall Gill',  2,  3,  13,  1,  41,  25,  42,  2,  2000
EXEC add_PlayerStatsByName 'Kendall Gill',  2,  4,  9,  1,  33,  28,  33,  2,  2001
EXEC add_PlayerStatsByName 'Kendall Gill',  1,  2,  5,  0,  38,  13,  39,  2,  2002
EXEC add_PlayerStatsByName 'Kendall Gill',  1,  3,  8,  1,  42,  32,  43,  2,  2003
EXEC add_PlayerStatsByName 'Kendall Gill',  1,  3,  9,  1,  39,  23,  40,  1,  2004
EXEC add_PlayerStatsByName 'Kendall Gill',  1,  2,  6,  0,  40,  33,  41,  2,  2005
EXEC add_PlayerStatsByName 'Steve Henson',  0,  0,  1,  0,  50,  37,  55,  0,  1998
EXEC add_PlayerStatsByName 'Sean Higgins',  0,  0,  0,  0,  0,  0,  0,  1,  1998
EXEC add_PlayerStatsByName 'Tyrone Hill',  1,  10,  10,  1,  49,  0,  49,  4,  1998
EXEC add_PlayerStatsByName 'Tyrone Hill',  0,  9,  12,  1,  48,  0,  48,  3,  2000
EXEC add_PlayerStatsByName 'Tyrone Hill',  0,  9,  9,  1,  47,  0,  47,  3,  2001
EXEC add_PlayerStatsByName 'Tyrone Hill',  0,  10,  8,  1,  39,  0,  39,  3,  2002
EXEC add_PlayerStatsByName 'Henry James',  0,  0,  2,  0,  40,  44,  50,  0,  1998
EXEC add_PlayerStatsByName 'Negele Knight',  1,  1,  1,  1,  37,  0,  37,  0,  1999
EXEC add_PlayerStatsByName 'Tony Massenburg',  0,  6,  11,  1,  48,  0,  48,  2,  1999
EXEC add_PlayerStatsByName 'Tony Massenburg',  0,  4,  5,  0,  45,  100,  45,  2,  2002
EXEC add_PlayerStatsByName 'Tony Massenburg',  0,  3,  4,  0,  47,  0,  47,  2,  2004
EXEC add_PlayerStatsByName 'Terry Mills',  0,  3,  4,  0,  39,  30,  45,  2,  1998
EXEC add_PlayerStatsByName 'Terry Mills',  0,  4,  9,  3,  37,  50,  50,  3,  1999
EXEC add_PlayerStatsByName 'Terry Mills',  1,  4,  6,  0,  43,  39,  53,  3,  2000
EXEC add_PlayerStatsByName 'Terry Mills',  0,  1,  1,  0,  32,  17,  36,  1,  2001
EXEC add_PlayerStatsByName 'Larry Robinson',  0,  2,  2,  0,  31,  50,  39,  0,  1998
EXEC add_PlayerStatsByName 'Larry Robinson',  1,  2,  5,  0,  36,  37,  48,  1,  2001
EXEC add_PlayerStatsByName 'Larry Robinson',  0,  1,  1,  0,  25,  50,  37,  0,  2002
EXEC add_PlayerStatsByName 'Dennis Scott',  1,  3,  11,  1,  39,  36,  47,  1,  1998
EXEC add_PlayerStatsByName 'Dennis Scott',  1,  1,  6,  0,  40,  38,  49,  1,  1999
EXEC add_PlayerStatsByName 'Dennis Scott',  1,  1,  5,  0,  37,  37,  48,  1,  2000
EXEC add_PlayerStatsByName 'Tony Smith',  1,  1,  2,  1,  33,  0,  33,  1,  1998
EXEC add_PlayerStatsByName 'Tony Smith',  1,  0,  2,  1,  34,  0,  34,  2,  2001
EXEC add_PlayerStatsByName 'Loy Vaught',  0,  6,  7,  1,  42,  0,  42,  3,  1998
EXEC add_PlayerStatsByName 'Loy Vaught',  0,  3,  3,  0,  38,  0,  38,  1,  1999
EXEC add_PlayerStatsByName 'Loy Vaught',  0,  2,  1,  0,  36,  0,  36,  1,  2000
EXEC add_PlayerStatsByName 'Jayson Williams',  1,  13,  12,  1,  49,  0,  49,  3,  1998
EXEC add_PlayerStatsByName 'Jayson Williams',  1,  12,  8,  1,  44,  0,  44,  4,  1999
EXEC add_PlayerStatsByName 'Scott Williams',  0,  3,  4,  0,  43,  0,  43,  2,  1998
EXEC add_PlayerStatsByName 'Scott Williams',  0,  5,  6,  0,  47,  25,  47,  2,  2001
EXEC add_PlayerStatsByName 'Scott Williams',  0,  5,  4,  0,  39,  0,  39,  2,  2002
EXEC add_PlayerStatsByName 'Scott Williams',  0,  2,  4,  0,  41,  0,  41,  2,  2003
EXEC add_PlayerStatsByName 'Scott Williams',  0,  3,  4,  0,  48,  66,  48,  2,  2004
EXEC add_PlayerStatsByName 'Victor Alexander',  0,  1,  2,  0,  35,  0,  35,  0,  2002
EXEC add_PlayerStatsByName 'Kenny Anderson',  5,  2,  12,  2,  39,  35,  44,  2,  1998
EXEC add_PlayerStatsByName 'Kenny Anderson',  5,  3,  12,  2,  45,  25,  45,  2,  1999
EXEC add_PlayerStatsByName 'Kenny Anderson',  5,  2,  14,  1,  44,  38,  48,  2,  2000
EXEC add_PlayerStatsByName 'Kenny Anderson',  4,  2,  7,  1,  38,  33,  41,  1,  2001
EXEC add_PlayerStatsByName 'Kenny Anderson',  5,  3,  9,  1,  43,  27,  44,  2,  2002
EXEC add_PlayerStatsByName 'Kenny Anderson',  3,  2,  6,  1,  42,  14,  42,  1,  2003
EXEC add_PlayerStatsByName 'Kenny Anderson',  2,  1,  6,  1,  44,  25,  44,  1,  2004
EXEC add_PlayerStatsByName 'Kenny Anderson',  2,  2,  4,  1,  42,  46,  43,  2,  2005
EXEC add_PlayerStatsByName 'Greg Anthony',  2,  1,  5,  1,  43,  41,  52,  1,  1998
EXEC add_PlayerStatsByName 'Greg Anthony',  2,  1,  6,  1,  41,  39,  51,  1,  1999
EXEC add_PlayerStatsByName 'Greg Anthony',  2,  1,  6,  1,  40,  37,  51,  1,  2000
EXEC add_PlayerStatsByName 'Greg Anthony',  1,  1,  4,  0,  38,  40,  51,  1,  2001
EXEC add_PlayerStatsByName 'Greg Anthony',  4,  2,  7,  1,  38,  29,  43,  1,  2002
EXEC add_PlayerStatsByName 'Stacey Augmon',  1,  2,  4,  0,  44,  0,  44,  1,  1999
EXEC add_PlayerStatsByName 'Stacey Augmon',  0,  2,  3,  0,  47,  0,  47,  1,  2000
EXEC add_PlayerStatsByName 'Stacey Augmon',  1,  2,  4,  0,  47,  0,  47,  1,  2001
EXEC add_PlayerStatsByName 'Stacey Augmon',  1,  1,  3,  0,  41,  0,  41,  1,  2003
EXEC add_PlayerStatsByName 'Isaac Austin',  2,  7,  13,  2,  46,  0,  46,  3,  1998
EXEC add_PlayerStatsByName 'Isaac Austin',  1,  4,  9,  2,  40,  28,  41,  2,  1999
EXEC add_PlayerStatsByName 'Isaac Austin',  1,  4,  6,  1,  42,  25,  43,  2,  2000
EXEC add_PlayerStatsByName 'Isaac Austin',  1,  4,  4,  1,  35,  25,  36,  1,  2001
EXEC add_PlayerStatsByName 'David Benoit',  0,  2,  5,  0,  37,  32,  44,  2,  1998
EXEC add_PlayerStatsByName 'David Benoit',  0,  1,  3,  0,  48,  38,  50,  1,  2001
EXEC add_PlayerStatsByName 'Terrell Brandon',  7,  3,  16,  2,  46,  33,  48,  2,  1998
EXEC add_PlayerStatsByName 'Terrell Brandon',  8,  3,  13,  2,  41,  25,  43,  2,  1999
EXEC add_PlayerStatsByName 'Terrell Brandon',  8,  3,  17,  2,  46,  40,  49,  2,  2000
EXEC add_PlayerStatsByName 'Terrell Brandon',  7,  3,  16,  2,  45,  36,  46,  1,  2001
EXEC add_PlayerStatsByName 'Terrell Brandon',  8,  2,  12,  1,  42,  17,  43,  1,  2002
EXEC add_PlayerStatsByName 'Randy Brown',  2,  1,  4,  0,  38,  0,  38,  1,  1998
EXEC add_PlayerStatsByName 'Randy Brown',  3,  3,  8,  2,  41,  0,  41,  2,  1999
EXEC add_PlayerStatsByName 'Randy Brown',  3,  2,  6,  1,  36,  50,  36,  2,  2000
EXEC add_PlayerStatsByName 'Randy Brown',  2,  1,  4,  1,  42,  0,  42,  2,  2001
EXEC add_PlayerStatsByName 'Pete Chilcutt',  1,  3,  4,  0,  43,  41,  51,  1,  1998
EXEC add_PlayerStatsByName 'Pete Chilcutt',  0,  2,  3,  0,  36,  38,  44,  1,  1999
EXEC add_PlayerStatsByName 'Pete Chilcutt',  0,  2,  2,  0,  41,  23,  44,  1,  2000
EXEC add_PlayerStatsByName 'Dale Davis',  1,  7,  7,  0,  49,  0,  49,  2,  2001
EXEC add_PlayerStatsByName 'Bison Dele',  1,  8,  16,  2,  51,  33,  51,  3,  1998
EXEC add_PlayerStatsByName 'Bison Dele',  1,  5,  10,  2,  50,  0,  50,  3,  1999
EXEC add_PlayerStatsByName 'Rick Fox',  3,  4,  12,  2,  47,  32,  52,  3,  1998
EXEC add_PlayerStatsByName 'Rick Fox',  2,  2,  9,  1,  44,  33,  49,  2,  1999
EXEC add_PlayerStatsByName 'Rick Fox',  1,  2,  6,  1,  41,  32,  47,  2,  2000
EXEC add_PlayerStatsByName 'Rick Fox',  3,  4,  9,  1,  44,  39,  53,  2,  2001
EXEC add_PlayerStatsByName 'Rick Fox',  3,  4,  7,  1,  42,  31,  47,  3,  2002
EXEC add_PlayerStatsByName 'Rick Fox',  3,  4,  9,  1,  42,  37,  50,  2,  2003
EXEC add_PlayerStatsByName 'Rick Fox',  2,  2,  4,  1,  39,  24,  43,  2,  2004
EXEC add_PlayerStatsByName 'Chris Gatling',  0,  5,  11,  1,  45,  25,  45,  2,  1998
EXEC add_PlayerStatsByName 'Chris Gatling',  0,  3,  5,  1,  44,  12,  44,  2,  1999
EXEC add_PlayerStatsByName 'Chris Gatling',  0,  5,  11,  2,  45,  25,  46,  2,  2000
EXEC add_PlayerStatsByName 'Chris Gatling',  0,  5,  11,  1,  44,  30,  46,  2,  2001
EXEC add_PlayerStatsByName 'Chris Gatling',  0,  3,  6,  1,  44,  12,  44,  2,  2002
EXEC add_PlayerStatsByName 'Carl Herrera',  0,  1,  2,  0,  43,  0,  43,  1,  1998
EXEC add_PlayerStatsByName 'Carl Herrera',  0,  2,  2,  0,  39,  0,  39,  1,  1999
EXEC add_PlayerStatsByName 'Mark Macon',  0,  0,  1,  0,  20,  33,  22,  0,  1999
EXEC add_PlayerStatsByName 'Eric Murdock',  2,  1,  6,  1,  42,  30,  45,  2,  1998
EXEC add_PlayerStatsByName 'Eric Murdock',  4,  2,  7,  1,  39,  36,  43,  2,  1999
EXEC add_PlayerStatsByName 'Eric Murdock',  2,  1,  5,  1,  38,  38,  42,  1,  2000
EXEC add_PlayerStatsByName 'Jimmy Oliver',  1,  2,  5,  0,  50,  50,  62,  1,  1998
EXEC add_PlayerStatsByName 'Jimmy Oliver',  0,  0,  1,  0,  33,  100,  50,  1,  1999
EXEC add_PlayerStatsByName 'Billy Owens',  2,  7,  10,  2,  46,  37,  48,  3,  1998
EXEC add_PlayerStatsByName 'Billy Owens',  1,  3,  7,  1,  39,  45,  40,  1,  1999
EXEC add_PlayerStatsByName 'Billy Owens',  1,  4,  6,  1,  41,  32,  43,  2,  2000
EXEC add_PlayerStatsByName 'Billy Owens',  1,  4,  4,  0,  38,  15,  38,  2,  2001
EXEC add_PlayerStatsByName 'Robert Pack',  3,  2,  7,  3,  33,  50,  35,  1,  1998
EXEC add_PlayerStatsByName 'Robert Pack',  3,  1,  8,  2,  43,  0,  43,  1,  1999
EXEC add_PlayerStatsByName 'Robert Pack',  5,  1,  8,  2,  41,  36,  42,  1,  2000
EXEC add_PlayerStatsByName 'Robert Pack',  4,  1,  6,  1,  42,  38,  43,  1,  2001
EXEC add_PlayerStatsByName 'Robert Pack',  3,  1,  3,  1,  36,  25,  37,  2,  2002
EXEC add_PlayerStatsByName 'Robert Pack',  2,  1,  5,  1,  40,  0,  40,  1,  2003
EXEC add_PlayerStatsByName 'Elliot Perry',  2,  1,  7,  1,  43,  34,  44,  1,  1998
EXEC add_PlayerStatsByName 'Elliot Perry',  1,  1,  2,  1,  37,  41,  42,  0,  1999
EXEC add_PlayerStatsByName 'Elliot Perry',  2,  1,  5,  1,  43,  28,  45,  0,  2000
EXEC add_PlayerStatsByName 'Elliot Perry',  1,  0,  3,  0,  46,  20,  46,  0,  2001
EXEC add_PlayerStatsByName 'Bobby Phills',  3,  3,  10,  1,  44,  38,  48,  2,  1998
EXEC add_PlayerStatsByName 'Bobby Phills',  3,  4,  14,  2,  43,  39,  50,  2,  1999
EXEC add_PlayerStatsByName 'Bobby Phills',  2,  2,  13,  1,  45,  33,  49,  2,  2000
EXEC add_PlayerStatsByName 'Stanley Roberts',  0,  3,  2,  0,  31,  0,  31,  3,  2000
EXEC add_PlayerStatsByName 'Steve Smith',  4,  4,  20,  2,  44,  35,  48,  3,  1998
EXEC add_PlayerStatsByName 'Steve Smith',  3,  4,  18,  2,  40,  33,  44,  2,  1999
EXEC add_PlayerStatsByName 'Steve Smith',  2,  3,  14,  1,  46,  39,  52,  2,  2000
EXEC add_PlayerStatsByName 'Steve Smith',  2,  3,  13,  1,  45,  33,  50,  2,  2001
EXEC add_PlayerStatsByName 'Steve Smith',  2,  2,  11,  1,  45,  47,  54,  2,  2002
EXEC add_PlayerStatsByName 'Steve Smith',  1,  1,  6,  0,  38,  33,  45,  1,  2003
EXEC add_PlayerStatsByName 'Steve Smith',  0,  1,  5,  0,  40,  40,  48,  1,  2004
EXEC add_PlayerStatsByName 'Derek Strong',  0,  7,  12,  1,  42,  0,  42,  2,  1998
EXEC add_PlayerStatsByName 'Derek Strong',  0,  3,  5,  0,  42,  0,  42,  1,  1999
EXEC add_PlayerStatsByName 'Derek Strong',  0,  2,  2,  0,  43,  25,  44,  0,  2000
EXEC add_PlayerStatsByName 'Derek Strong',  0,  3,  4,  0,  38,  0,  38,  1,  2001
EXEC add_PlayerStatsByName 'Carl Thomas',  0,  1,  3,  0,  40,  33,  47,  0,  1998
EXEC add_PlayerStatsByName 'Jon Barry',  2,  2,  6,  0,  40,  37,  49,  1,  2004
EXEC add_PlayerStatsByName 'Jon Barry',  2,  2,  6,  1,  43,  43,  53,  1,  2005
EXEC add_PlayerStatsByName 'Doug Christie',  3,  5,  16,  2,  42,  32,  47,  2,  1998
EXEC add_PlayerStatsByName 'Doug Christie',  3,  4,  15,  2,  38,  30,  42,  2,  1999
EXEC add_PlayerStatsByName 'Doug Christie',  4,  3,  12,  2,  40,  36,  47,  2,  2000
EXEC add_PlayerStatsByName 'Doug Christie',  3,  4,  12,  1,  39,  37,  45,  2,  2001
EXEC add_PlayerStatsByName 'Doug Christie',  4,  4,  12,  2,  46,  35,  52,  2,  2002
EXEC add_PlayerStatsByName 'Doug Christie',  4,  4,  9,  1,  47,  39,  54,  2,  2003
EXEC add_PlayerStatsByName 'Doug Christie',  4,  4,  10,  1,  46,  34,  49,  2,  2004
EXEC add_PlayerStatsByName 'Doug Christie',  3,  3,  6,  2,  39,  24,  41,  2,  2005
EXEC add_PlayerStatsByName 'John Crotty',  2,  1,  3,  1,  32,  30,  35,  1,  1998
EXEC add_PlayerStatsByName 'John Crotty',  2,  1,  5,  1,  41,  38,  46,  1,  1999
EXEC add_PlayerStatsByName 'John Crotty',  1,  1,  4,  0,  42,  41,  48,  1,  2000
EXEC add_PlayerStatsByName 'John Crotty',  1,  0,  2,  0,  33,  57,  36,  1,  2001
EXEC add_PlayerStatsByName 'John Crotty',  3,  1,  6,  1,  47,  44,  54,  1,  2002
EXEC add_PlayerStatsByName 'John Crotty',  2,  1,  3,  0,  34,  30,  39,  1,  2003
EXEC add_PlayerStatsByName 'Lloyd Daniels',  0,  1,  5,  0,  41,  22,  44,  0,  1998
EXEC add_PlayerStatsByName 'Hubert Davis',  1,  2,  11,  1,  45,  43,  52,  1,  1998
EXEC add_PlayerStatsByName 'Hubert Davis',  1,  1,  9,  1,  43,  45,  52,  1,  1999
EXEC add_PlayerStatsByName 'Hubert Davis',  1,  1,  7,  0,  46,  49,  55,  1,  2000
EXEC add_PlayerStatsByName 'Hubert Davis',  1,  2,  7,  1,  45,  45,  54,  1,  2001
EXEC add_PlayerStatsByName 'Hubert Davis',  2,  1,  7,  0,  44,  45,  53,  1,  2002
EXEC add_PlayerStatsByName 'Hubert Davis',  0,  0,  1,  0,  39,  33,  46,  0,  2003
EXEC add_PlayerStatsByName 'Hubert Davis',  0,  0,  0,  0,  9,  0,  9,  0,  2004
EXEC add_PlayerStatsByName 'Todd Day',  1,  1,  6,  0,  35,  16,  38,  2,  1998
EXEC add_PlayerStatsByName 'Todd Day',  1,  2,  6,  0,  39,  38,  49,  2,  2000
EXEC add_PlayerStatsByName 'Todd Day',  0,  1,  4,  0,  37,  37,  48,  1,  2001
EXEC add_PlayerStatsByName 'LaPhonso Ellis',  2,  7,  14,  2,  40,  28,  43,  3,  1998
EXEC add_PlayerStatsByName 'LaPhonso Ellis',  0,  5,  10,  1,  42,  20,  42,  2,  1999
EXEC add_PlayerStatsByName 'LaPhonso Ellis',  1,  5,  8,  0,  45,  14,  45,  2,  2000
EXEC add_PlayerStatsByName 'LaPhonso Ellis',  1,  6,  9,  1,  46,  31,  47,  3,  2001
EXEC add_PlayerStatsByName 'LaPhonso Ellis',  0,  4,  7,  1,  41,  30,  46,  3,  2002
EXEC add_PlayerStatsByName 'LaPhonso Ellis',  0,  2,  5,  0,  38,  25,  43,  1,  2003
EXEC add_PlayerStatsByName 'Matt Geiger',  1,  6,  11,  1,  50,  9,  50,  2,  1998
EXEC add_PlayerStatsByName 'Matt Geiger',  1,  7,  13,  2,  47,  20,  48,  3,  1999
EXEC add_PlayerStatsByName 'Matt Geiger',  0,  6,  9,  1,  44,  0,  44,  3,  2000
EXEC add_PlayerStatsByName 'Matt Geiger',  0,  4,  6,  0,  39,  0,  39,  2,  2001
EXEC add_PlayerStatsByName 'Litterial Green',  0,  0,  1,  0,  21,  0,  21,  0,  1998
EXEC add_PlayerStatsByName 'Tom Gugliotta',  4,  8,  20,  2,  50,  11,  50,  2,  1998
EXEC add_PlayerStatsByName 'Tom Gugliotta',  2,  8,  17,  2,  48,  28,  48,  2,  1999
EXEC add_PlayerStatsByName 'Tom Gugliotta',  2,  7,  13,  2,  48,  12,  48,  2,  2000
EXEC add_PlayerStatsByName 'Tom Gugliotta',  1,  4,  6,  0,  39,  25,  39,  1,  2001
EXEC add_PlayerStatsByName 'Tom Gugliotta',  1,  5,  6,  1,  42,  33,  42,  2,  2002
EXEC add_PlayerStatsByName 'Tom Gugliotta',  1,  3,  4,  1,  45,  0,  45,  1,  2003
EXEC add_PlayerStatsByName 'Tom Gugliotta',  1,  3,  2,  0,  34,  25,  34,  1,  2004
EXEC add_PlayerStatsByName 'Tom Gugliotta',  1,  4,  5,  1,  41,  30,  42,  2,  2005
EXEC add_PlayerStatsByName 'Robert Horry',  2,  7,  7,  1,  47,  20,  49,  3,  1998
EXEC add_PlayerStatsByName 'Robert Horry',  1,  4,  4,  1,  45,  44,  52,  2,  1999
EXEC add_PlayerStatsByName 'Robert Horry',  1,  4,  5,  1,  43,  30,  47,  2,  2000
EXEC add_PlayerStatsByName 'Robert Horry',  1,  3,  5,  1,  38,  34,  45,  2,  2001
EXEC add_PlayerStatsByName 'Robert Horry',  2,  5,  6,  1,  39,  37,  48,  2,  2002
EXEC add_PlayerStatsByName 'Robert Horry',  2,  6,  6,  1,  38,  28,  44,  3,  2003
EXEC add_PlayerStatsByName 'Robert Horry',  1,  3,  4,  0,  40,  38,  46,  2,  2004
EXEC add_PlayerStatsByName 'Robert Horry',  1,  3,  6,  0,  41,  37,  48,  1,  2005
EXEC add_PlayerStatsByName 'Jim Jackson',  4,  5,  15,  3,  43,  31,  45,  2,  1998
EXEC add_PlayerStatsByName 'Jim Jackson',  2,  3,  8,  1,  41,  27,  44,  1,  1999
EXEC add_PlayerStatsByName 'Jim Jackson',  2,  5,  16,  2,  41,  38,  45,  2,  2000
EXEC add_PlayerStatsByName 'Jim Jackson',  2,  4,  11,  2,  37,  32,  39,  2,  2001
EXEC add_PlayerStatsByName 'Jim Jackson',  2,  5,  10,  1,  44,  46,  47,  2,  2002
EXEC add_PlayerStatsByName 'Jim Jackson',  1,  4,  7,  1,  44,  45,  47,  2,  2003
EXEC add_PlayerStatsByName 'Jim Jackson',  2,  6,  12,  2,  42,  40,  51,  2,  2004
EXEC add_PlayerStatsByName 'Jim Jackson',  2,  4,  10,  1,  42,  41,  53,  2,  2005
EXEC add_PlayerStatsByName 'Adam Keefe',  0,  3,  4,  0,  45,  0,  45,  1,  1999
EXEC add_PlayerStatsByName 'Adam Keefe',  0,  2,  2,  0,  40,  0,  40,  1,  2000
EXEC add_PlayerStatsByName 'Adam Keefe',  0,  3,  2,  0,  40,  33,  40,  1,  2001
EXEC add_PlayerStatsByName 'Christian Laettner',  2,  6,  13,  2,  48,  22,  48,  3,  1998
EXEC add_PlayerStatsByName 'Christian Laettner',  1,  3,  7,  1,  35,  33,  36,  1,  1999
EXEC add_PlayerStatsByName 'Christian Laettner',  2,  6,  12,  2,  47,  29,  47,  4,  2000
EXEC add_PlayerStatsByName 'Christian Laettner',  1,  4,  9,  1,  50,  30,  50,  3,  2001
EXEC add_PlayerStatsByName 'Christian Laettner',  2,  5,  7,  1,  46,  20,  46,  2,  2002
EXEC add_PlayerStatsByName 'Christian Laettner',  3,  6,  8,  1,  49,  12,  49,  2,  2003
EXEC add_PlayerStatsByName 'Christian Laettner',  1,  4,  5,  0,  46,  28,  47,  2,  2004
EXEC add_PlayerStatsByName 'Christian Laettner',  0,  2,  5,  0,  58,  14,  58,  1,  2005
EXEC add_PlayerStatsByName 'Sam Mack',  1,  2,  10,  1,  39,  40,  49,  2,  1998
EXEC add_PlayerStatsByName 'Sam Mack',  1,  2,  10,  0,  43,  39,  54,  2,  1999
EXEC add_PlayerStatsByName 'Sam Mack',  1,  1,  5,  0,  30,  32,  38,  2,  2000
EXEC add_PlayerStatsByName 'Sam Mack',  0,  1,  3,  0,  28,  25,  35,  1,  2002
EXEC add_PlayerStatsByName 'Don MacLean',  0,  0,  0,  0,  10,  50,  15,  0,  1998
EXEC add_PlayerStatsByName 'Don MacLean',  0,  3,  10,  1,  39,  27,  42,  2,  1999
EXEC add_PlayerStatsByName 'Don MacLean',  0,  1,  2,  0,  36,  33,  38,  1,  2000
EXEC add_PlayerStatsByName 'Don MacLean',  0,  2,  3,  1,  50,  100,  55,  1,  2001
EXEC add_PlayerStatsByName 'Lee Mayberry',  4,  1,  4,  1,  37,  35,  46,  2,  1998
EXEC add_PlayerStatsByName 'Lee Mayberry',  2,  0,  2,  1,  36,  20,  42,  1,  1999
EXEC add_PlayerStatsByName 'Oliver Miller',  3,  6,  6,  2,  46,  0,  46,  2,  1998
EXEC add_PlayerStatsByName 'Oliver Miller',  0,  2,  2,  0,  53,  0,  53,  1,  2004
EXEC add_PlayerStatsByName 'Tracy Murray',  1,  3,  15,  1,  44,  39,  52,  2,  1998
EXEC add_PlayerStatsByName 'Tracy Murray',  0,  2,  6,  0,  35,  32,  42,  1,  1999
EXEC add_PlayerStatsByName 'Tracy Murray',  0,  3,  10,  1,  43,  43,  51,  2,  2000
EXEC add_PlayerStatsByName 'Tracy Murray',  0,  1,  5,  0,  37,  35,  45,  1,  2001
EXEC add_PlayerStatsByName 'Tracy Murray',  0,  1,  5,  0,  41,  38,  50,  1,  2002
EXEC add_PlayerStatsByName 'Tracy Murray',  0,  0,  2,  0,  32,  21,  38,  0,  2003
EXEC add_PlayerStatsByName 'Tracy Murray',  0,  0,  1,  0,  25,  40,  33,  0,  2004
EXEC add_PlayerStatsByName 'Doug Overton',  1,  0,  2,  1,  38,  0,  38,  1,  1998
EXEC add_PlayerStatsByName 'Doug Overton',  1,  0,  3,  0,  42,  28,  44,  0,  1999
EXEC add_PlayerStatsByName 'Doug Overton',  1,  0,  3,  0,  39,  35,  42,  1,  2000
EXEC add_PlayerStatsByName 'Doug Overton',  3,  1,  6,  1,  37,  30,  41,  1,  2001
EXEC add_PlayerStatsByName 'Doug Overton',  0,  0,  2,  0,  31,  25,  39,  0,  2002
EXEC add_PlayerStatsByName 'Doug Overton',  2,  1,  3,  1,  40,  13,  41,  1,  2004
EXEC add_PlayerStatsByName 'Anthony Peeler',  3,  3,  12,  1,  45,  42,  51,  2,  1998
EXEC add_PlayerStatsByName 'Anthony Peeler',  2,  3,  9,  1,  37,  29,  44,  2,  1999
EXEC add_PlayerStatsByName 'Anthony Peeler',  2,  2,  9,  1,  43,  33,  49,  2,  2000
EXEC add_PlayerStatsByName 'Anthony Peeler',  2,  2,  10,  1,  42,  39,  48,  2,  2001
EXEC add_PlayerStatsByName 'Anthony Peeler',  2,  2,  9,  0,  42,  39,  50,  1,  2002
EXEC add_PlayerStatsByName 'Anthony Peeler',  3,  2,  7,  1,  41,  41,  48,  2,  2003
EXEC add_PlayerStatsByName 'Anthony Peeler',  1,  2,  5,  1,  44,  48,  54,  1,  2004
EXEC add_PlayerStatsByName 'Brent Price',  2,  1,  5,  1,  41,  39,  53,  2,  1998
EXEC add_PlayerStatsByName 'Brent Price',  2,  2,  7,  1,  48,  41,  59,  2,  1999
EXEC add_PlayerStatsByName 'Brent Price',  1,  0,  3,  1,  34,  36,  45,  1,  2000
EXEC add_PlayerStatsByName 'Brent Price',  0,  0,  2,  0,  27,  25,  31,  1,  2001
EXEC add_PlayerStatsByName 'Brent Price',  0,  0,  1,  0,  33,  26,  40,  0,  2002
EXEC add_PlayerStatsByName 'Sean Rooks',  0,  2,  2,  0,  40,  0,  40,  1,  1999
EXEC add_PlayerStatsByName 'Sean Rooks',  0,  3,  5,  0,  42,  50,  42,  2,  2001
EXEC add_PlayerStatsByName 'Sean Rooks',  1,  3,  4,  0,  42,  0,  42,  2,  2003
EXEC add_PlayerStatsByName 'Sean Rooks',  0,  1,  2,  0,  35,  0,  35,  1,  2004
EXEC add_PlayerStatsByName 'Malik Sealy',  1,  2,  7,  1,  42,  22,  43,  2,  1998
EXEC add_PlayerStatsByName 'Malik Sealy',  1,  3,  8,  1,  41,  26,  42,  2,  1999
EXEC add_PlayerStatsByName 'Malik Sealy',  2,  4,  11,  1,  47,  28,  48,  2,  2000
EXEC add_PlayerStatsByName 'Latrell Sprewell',  4,  3,  21,  3,  39,  18,  41,  1,  1998
EXEC add_PlayerStatsByName 'Latrell Sprewell',  2,  4,  16,  2,  41,  27,  43,  1,  1999
EXEC add_PlayerStatsByName 'Latrell Sprewell',  4,  4,  18,  2,  43,  34,  45,  2,  2000
EXEC add_PlayerStatsByName 'Latrell Sprewell',  3,  4,  17,  2,  43,  30,  44,  2,  2001
EXEC add_PlayerStatsByName 'Latrell Sprewell',  3,  3,  19,  2,  40,  36,  45,  2,  2002
EXEC add_PlayerStatsByName 'Latrell Sprewell',  4,  3,  16,  2,  40,  37,  46,  1,  2003
EXEC add_PlayerStatsByName 'Latrell Sprewell',  3,  3,  16,  1,  40,  33,  44,  1,  2004
EXEC add_PlayerStatsByName 'Bryant Stith',  1,  2,  7,  1,  33,  20,  35,  1,  1998
EXEC add_PlayerStatsByName 'Bryant Stith',  1,  2,  7,  1,  39,  29,  44,  1,  1999
EXEC add_PlayerStatsByName 'Bryant Stith',  1,  1,  5,  0,  45,  30,  50,  1,  2000
EXEC add_PlayerStatsByName 'Bryant Stith',  2,  3,  9,  1,  40,  37,  47,  2,  2001
EXEC add_PlayerStatsByName 'Bryant Stith',  0,  1,  4,  0,  37,  35,  43,  0,  2002
EXEC add_PlayerStatsByName 'Walt Williams',  2,  3,  10,  1,  38,  36,  46,  2,  1998
EXEC add_PlayerStatsByName 'Walt Williams',  1,  3,  9,  1,  42,  43,  51,  2,  1999
EXEC add_PlayerStatsByName 'Walt Williams',  2,  4,  10,  1,  45,  39,  53,  2,  2000
EXEC add_PlayerStatsByName 'Walt Williams',  1,  3,  8,  1,  39,  39,  48,  2,  2001
EXEC add_PlayerStatsByName 'Walt Williams',  1,  3,  9,  1,  41,  42,  51,  2,  2002
EXEC add_PlayerStatsByName 'Walt Williams',  0,  3,  5,  0,  39,  37,  48,  2,  2003
EXEC add_PlayerStatsByName 'Vin Baker',  1,  6,  13,  2,  45,  0,  45,  3,  1999
EXEC add_PlayerStatsByName 'Vin Baker',  1,  7,  16,  2,  45,  25,  45,  3,  2000
EXEC add_PlayerStatsByName 'Vin Baker',  1,  5,  12,  2,  42,  6,  42,  3,  2001
EXEC add_PlayerStatsByName 'Vin Baker',  0,  3,  5,  1,  47,  0,  47,  2,  2003
EXEC add_PlayerStatsByName 'Vin Baker',  1,  5,  9,  1,  48,  33,  48,  3,  2004
EXEC add_PlayerStatsByName 'Vin Baker',  0,  1,  1,  0,  31,  0,  31,  1,  2005
EXEC add_PlayerStatsByName 'Corie Blount',  0,  4,  3,  0,  57,  0,  57,  2,  1998
EXEC add_PlayerStatsByName 'Corie Blount',  0,  4,  2,  0,  36,  0,  36,  2,  1999
EXEC add_PlayerStatsByName 'Corie Blount',  0,  3,  2,  0,  49,  0,  49,  2,  2000
EXEC add_PlayerStatsByName 'Corie Blount',  0,  5,  4,  1,  44,  25,  44,  2,  2001
EXEC add_PlayerStatsByName 'Corie Blount',  0,  5,  3,  0,  45,  0,  45,  2,  2002
EXEC add_PlayerStatsByName 'Corie Blount',  0,  4,  4,  0,  45,  0,  45,  2,  2004
EXEC add_PlayerStatsByName 'Shawn Bradley',  0,  8,  11,  1,  42,  33,  42,  3,  1998
EXEC add_PlayerStatsByName 'Shawn Bradley',  0,  8,  8,  1,  48,  0,  48,  3,  1999
EXEC add_PlayerStatsByName 'Shawn Bradley',  0,  6,  8,  1,  47,  20,  48,  3,  2000
EXEC add_PlayerStatsByName 'Shawn Bradley',  0,  7,  7,  1,  49,  16,  49,  3,  2001
EXEC add_PlayerStatsByName 'Shawn Bradley',  0,  3,  4,  0,  47,  0,  47,  2,  2002
EXEC add_PlayerStatsByName 'Shawn Bradley',  0,  5,  6,  0,  53,  0,  53,  3,  2003
EXEC add_PlayerStatsByName 'Shawn Bradley',  0,  2,  3,  0,  47,  0,  47,  2,  2004
EXEC add_PlayerStatsByName 'P.J. Brown',  1,  7,  9,  1,  48,  0,  48,  3,  2000
EXEC add_PlayerStatsByName 'P.J. Brown',  1,  9,  8,  1,  44,  0,  44,  3,  2001
EXEC add_PlayerStatsByName 'P.J. Brown',  1,  9,  10,  1,  53,  0,  53,  2,  2003
EXEC add_PlayerStatsByName 'P.J. Brown',  1,  8,  10,  1,  47,  0,  47,  2,  2004
EXEC add_PlayerStatsByName 'Scott Burrell',  0,  2,  5,  0,  42,  35,  49,  1,  1998
EXEC add_PlayerStatsByName 'Scott Burrell',  1,  3,  6,  0,  36,  38,  42,  2,  1999
EXEC add_PlayerStatsByName 'Scott Burrell',  1,  3,  6,  0,  39,  35,  49,  2,  2000
EXEC add_PlayerStatsByName 'Scott Burrell',  0,  0,  4,  0,  46,  33,  53,  2,  2001
EXEC add_PlayerStatsByName 'Mitchell Butler',  1,  1,  2,  0,  31,  16,  33,  1,  1998
EXEC add_PlayerStatsByName 'Mitchell Butler',  0,  1,  5,  0,  48,  37,  52,  1,  1999
EXEC add_PlayerStatsByName 'Mitchell Butler',  0,  1,  2,  0,  43,  33,  45,  0,  2002
EXEC add_PlayerStatsByName 'Mitchell Butler',  0,  1,  3,  0,  43,  36,  48,  1,  2004
EXEC add_PlayerStatsByName 'Sam Cassell',  8,  3,  19,  3,  44,  18,  44,  3,  1998
EXEC add_PlayerStatsByName 'Sam Cassell',  4,  1,  15,  2,  41,  20,  43,  2,  1999
EXEC add_PlayerStatsByName 'Sam Cassell',  9,  3,  18,  3,  46,  28,  47,  3,  2000
EXEC add_PlayerStatsByName 'Sam Cassell',  7,  3,  18,  2,  47,  30,  48,  2,  2001
EXEC add_PlayerStatsByName 'Sam Cassell',  6,  4,  19,  2,  46,  34,  49,  2,  2002
EXEC add_PlayerStatsByName 'Sam Cassell',  5,  4,  19,  2,  47,  36,  49,  2,  2003
EXEC add_PlayerStatsByName 'Sam Cassell',  7,  3,  19,  2,  48,  39,  51,  3,  2004
EXEC add_PlayerStatsByName 'Sam Cassell',  5,  2,  13,  1,  46,  26,  48,  2,  2005
EXEC add_PlayerStatsByName 'Calbert Cheaney',  2,  4,  12,  1,  45,  28,  46,  3,  1998
EXEC add_PlayerStatsByName 'Calbert Cheaney',  1,  2,  7,  0,  41,  21,  42,  2,  1999
EXEC add_PlayerStatsByName 'Calbert Cheaney',  1,  2,  4,  0,  44,  33,  47,  2,  2000
EXEC add_PlayerStatsByName 'Calbert Cheaney',  1,  3,  7,  1,  48,  0,  48,  2,  2002
EXEC add_PlayerStatsByName 'Calbert Cheaney',  2,  3,  8,  1,  49,  40,  50,  2,  2003
EXEC add_PlayerStatsByName 'Calbert Cheaney',  1,  3,  7,  1,  48,  0,  48,  2,  2004
EXEC add_PlayerStatsByName 'Calbert Cheaney',  1,  2,  4,  0,  42,  0,  42,  1,  2005
EXEC add_PlayerStatsByName 'Michael Curry',  1,  1,  6,  0,  46,  44,  47,  2,  1998
EXEC add_PlayerStatsByName 'Michael Curry',  1,  2,  4,  0,  43,  6,  43,  2,  1999
EXEC add_PlayerStatsByName 'Michael Curry',  1,  1,  6,  0,  48,  20,  48,  2,  2000
EXEC add_PlayerStatsByName 'Michael Curry',  1,  1,  5,  0,  45,  44,  46,  2,  2001
EXEC add_PlayerStatsByName 'Michael Curry',  1,  2,  4,  0,  45,  26,  46,  2,  2002
EXEC add_PlayerStatsByName 'Michael Curry',  1,  1,  3,  0,  40,  29,  43,  2,  2003
EXEC add_PlayerStatsByName 'Michael Curry',  0,  1,  2,  0,  38,  20,  39,  2,  2004
EXEC add_PlayerStatsByName 'Antonio Davis',  0,  6,  9,  1,  48,  0,  48,  2,  1998
EXEC add_PlayerStatsByName 'Antonio Davis',  1,  10,  13,  1,  43,  0,  43,  2,  2001
EXEC add_PlayerStatsByName 'Antonio Davis',  2,  9,  14,  2,  42,  0,  42,  2,  2002
EXEC add_PlayerStatsByName 'Terry Dehere',  2,  1,  6,  1,  39,  37,  45,  1,  1998
EXEC add_PlayerStatsByName 'Terry Dehere',  1,  0,  3,  0,  36,  41,  45,  1,  1999
EXEC add_PlayerStatsByName 'Harold Ellis',  0,  1,  6,  0,  55,  0,  55,  2,  1998
EXEC add_PlayerStatsByName 'Andrew Gaze',  0,  0,  1,  0,  32,  31,  42,  0,  1999
EXEC add_PlayerStatsByName 'Greg Graham',  1,  0,  2,  1,  58,  0,  58,  1,  1998
EXEC add_PlayerStatsByName 'Anfernee Hardaway',  3,  4,  16,  2,  37,  30,  40,  2,  1998
EXEC add_PlayerStatsByName 'Anfernee Hardaway',  5,  5,  15,  3,  42,  28,  44,  2,  1999
EXEC add_PlayerStatsByName 'Anfernee Hardaway',  5,  5,  16,  2,  47,  32,  49,  2,  2000
EXEC add_PlayerStatsByName 'Anfernee Hardaway',  3,  4,  9,  0,  41,  25,  44,  1,  2001
EXEC add_PlayerStatsByName 'Anfernee Hardaway',  4,  4,  12,  2,  41,  27,  43,  2,  2002
EXEC add_PlayerStatsByName 'Anfernee Hardaway',  4,  4,  10,  2,  44,  35,  46,  2,  2003
EXEC add_PlayerStatsByName 'Anfernee Hardaway',  2,  3,  9,  1,  41,  38,  43,  1,  2004
EXEC add_PlayerStatsByName 'Anfernee Hardaway',  2,  2,  7,  1,  42,  30,  45,  2,  2005
EXEC add_PlayerStatsByName 'Lucious Harris',  0,  1,  3,  0,  39,  30,  42,  1,  1998
EXEC add_PlayerStatsByName 'Lucious Harris',  0,  1,  5,  0,  40,  22,  43,  1,  1999
EXEC add_PlayerStatsByName 'Lucious Harris',  1,  2,  6,  0,  42,  33,  46,  1,  2000
EXEC add_PlayerStatsByName 'Lucious Harris',  1,  3,  9,  0,  42,  34,  46,  1,  2001
EXEC add_PlayerStatsByName 'Lucious Harris',  1,  2,  9,  0,  46,  37,  50,  1,  2002
EXEC add_PlayerStatsByName 'Lucious Harris',  2,  3,  10,  0,  41,  34,  44,  1,  2003
EXEC add_PlayerStatsByName 'Lucious Harris',  2,  2,  6,  0,  40,  37,  44,  1,  2004
EXEC add_PlayerStatsByName 'Lucious Harris',  0,  1,  4,  0,  39,  32,  43,  0,  2005
EXEC add_PlayerStatsByName 'Allan Houston',  2,  3,  18,  2,  44,  38,  47,  2,  1998
EXEC add_PlayerStatsByName 'Allan Houston',  2,  3,  16,  2,  41,  40,  45,  2,  1999
EXEC add_PlayerStatsByName 'Allan Houston',  2,  3,  19,  2,  48,  43,  52,  2,  2000
EXEC add_PlayerStatsByName 'Allan Houston',  2,  3,  18,  2,  44,  38,  48,  2,  2001
EXEC add_PlayerStatsByName 'Allan Houston',  2,  3,  20,  2,  43,  39,  48,  2,  2002
EXEC add_PlayerStatsByName 'Allan Houston',  2,  2,  22,  2,  44,  39,  50,  2,  2003
EXEC add_PlayerStatsByName 'Allan Houston',  2,  2,  18,  2,  43,  43,  49,  2,  2004
EXEC add_PlayerStatsByName 'Allan Houston',  2,  1,  11,  1,  41,  38,  49,  2,  2005
EXEC add_PlayerStatsByName 'Lindsey Hunter',  3,  3,  12,  1,  38,  32,  43,  2,  1998
EXEC add_PlayerStatsByName 'Lindsey Hunter',  3,  3,  11,  1,  43,  38,  49,  2,  1999
EXEC add_PlayerStatsByName 'Lindsey Hunter',  4,  3,  12,  1,  42,  43,  51,  2,  2000
EXEC add_PlayerStatsByName 'Lindsey Hunter',  2,  2,  10,  0,  38,  37,  47,  2,  2001
EXEC add_PlayerStatsByName 'Lindsey Hunter',  1,  1,  5,  0,  38,  38,  46,  1,  2002
EXEC add_PlayerStatsByName 'Lindsey Hunter',  2,  2,  9,  2,  35,  31,  40,  1,  2003
EXEC add_PlayerStatsByName 'Lindsey Hunter',  2,  2,  3,  1,  34,  28,  39,  1,  2004
EXEC add_PlayerStatsByName 'Lindsey Hunter',  1,  1,  3,  0,  35,  27,  39,  1,  2005
EXEC add_PlayerStatsByName 'Bobby Hurley',  2,  1,  4,  1,  39,  22,  40,  1,  1998
EXEC add_PlayerStatsByName 'Ervin Johnson',  0,  8,  4,  1,  51,  0,  51,  3,  2000
EXEC add_PlayerStatsByName 'Ervin Johnson',  0,  5,  2,  0,  46,  0,  46,  2,  2002
EXEC add_PlayerStatsByName 'Ervin Johnson',  0,  3,  1,  0,  53,  0,  53,  2,  2004
EXEC add_PlayerStatsByName 'Ervin Johnson',  0,  2,  1,  0,  51,  100,  52,  1,  2005
EXEC add_PlayerStatsByName 'Popeye Jones',  1,  7,  8,  1,  40,  66,  41,  2,  1998
EXEC add_PlayerStatsByName 'Popeye Jones',  0,  2,  3,  0,  39,  0,  39,  1,  1999
EXEC add_PlayerStatsByName 'Popeye Jones',  0,  2,  2,  0,  42,  66,  43,  1,  2000
EXEC add_PlayerStatsByName 'Popeye Jones',  0,  4,  3,  0,  39,  16,  39,  2,  2001
EXEC add_PlayerStatsByName 'Popeye Jones',  1,  7,  7,  1,  43,  36,  44,  2,  2002
EXEC add_PlayerStatsByName 'Adonis Jordan',  0,  0,  1,  0,  50,  0,  50,  0,  1999
EXEC add_PlayerStatsByName 'Reggie Jordan',  0,  1,  2,  0,  47,  0,  47,  1,  1998
EXEC add_PlayerStatsByName 'Reggie Jordan',  0,  1,  1,  0,  32,  0,  32,  0,  2000
EXEC add_PlayerStatsByName 'George Lynch',  1,  4,  7,  1,  48,  30,  48,  2,  1998
EXEC add_PlayerStatsByName 'George Lynch',  1,  6,  8,  1,  42,  39,  43,  3,  1999
EXEC add_PlayerStatsByName 'George Lynch',  1,  7,  9,  1,  46,  41,  47,  3,  2000
EXEC add_PlayerStatsByName 'George Lynch',  1,  7,  8,  1,  44,  26,  45,  2,  2001
EXEC add_PlayerStatsByName 'George Lynch',  1,  4,  3,  0,  36,  16,  37,  1,  2002
EXEC add_PlayerStatsByName 'George Lynch',  1,  4,  4,  0,  40,  35,  44,  1,  2003
EXEC add_PlayerStatsByName 'George Lynch',  1,  4,  4,  0,  39,  30,  45,  2,  2004
EXEC add_PlayerStatsByName 'George Lynch',  2,  4,  3,  1,  36,  29,  38,  1,  2005
EXEC add_PlayerStatsByName 'Gerald Madkins',  2,  0,  1,  0,  38,  40,  47,  0,  1998
EXEC add_PlayerStatsByName 'Jamal Mashburn',  2,  4,  15,  2,  43,  30,  46,  2,  1998
EXEC add_PlayerStatsByName 'Jamal Mashburn',  3,  6,  14,  2,  45,  43,  47,  2,  1999
EXEC add_PlayerStatsByName 'Jamal Mashburn',  3,  5,  17,  2,  44,  40,  49,  2,  2000
EXEC add_PlayerStatsByName 'Jamal Mashburn',  5,  7,  20,  2,  41,  35,  45,  2,  2001
EXEC add_PlayerStatsByName 'Jamal Mashburn',  4,  6,  21,  2,  40,  36,  43,  2,  2002
EXEC add_PlayerStatsByName 'Jamal Mashburn',  5,  6,  21,  2,  42,  38,  46,  2,  2003
EXEC add_PlayerStatsByName 'Jamal Mashburn',  2,  6,  20,  1,  39,  28,  41,  2,  2004
EXEC add_PlayerStatsByName 'Chris Mills',  1,  5,  9,  1,  43,  29,  46,  2,  1998
EXEC add_PlayerStatsByName 'Chris Mills',  2,  5,  10,  1,  41,  27,  44,  2,  1999
EXEC add_PlayerStatsByName 'Chris Mills',  2,  6,  16,  1,  42,  26,  43,  3,  2000
EXEC add_PlayerStatsByName 'Chris Mills',  1,  6,  12,  1,  37,  28,  39,  2,  2001
EXEC add_PlayerStatsByName 'Chris Mills',  1,  2,  7,  0,  41,  37,  47,  1,  2002
EXEC add_PlayerStatsByName 'Chris Mills',  1,  2,  4,  0,  36,  28,  40,  1,  2003
EXEC add_PlayerStatsByName 'Bo Outlaw',  2,  7,  9,  2,  55,  25,  55,  3,  1998
EXEC add_PlayerStatsByName 'Bo Outlaw',  1,  5,  6,  1,  54,  0,  54,  2,  1999
EXEC add_PlayerStatsByName 'Bo Outlaw',  3,  6,  6,  1,  60,  0,  60,  2,  2000
EXEC add_PlayerStatsByName 'Bo Outlaw',  2,  7,  7,  1,  61,  50,  61,  3,  2001
EXEC add_PlayerStatsByName 'Bo Outlaw',  1,  4,  4,  1,  55,  50,  55,  2,  2002
EXEC add_PlayerStatsByName 'Bo Outlaw',  1,  4,  4,  1,  55,  0,  55,  2,  2003
EXEC add_PlayerStatsByName 'Bo Outlaw',  1,  4,  4,  0,  51,  0,  51,  2,  2004
EXEC add_PlayerStatsByName 'Isaiah Rider',  3,  4,  19,  2,  42,  32,  47,  2,  1998
EXEC add_PlayerStatsByName 'Isaiah Rider',  2,  4,  13,  2,  41,  37,  44,  2,  1999
EXEC add_PlayerStatsByName 'Isaiah Rider',  3,  4,  19,  2,  41,  31,  44,  2,  2000
EXEC add_PlayerStatsByName 'Isaiah Rider',  1,  2,  7,  1,  42,  37,  46,  1,  2001
EXEC add_PlayerStatsByName 'Isaiah Rider',  1,  3,  9,  1,  45,  40,  49,  1,  2002
EXEC add_PlayerStatsByName 'Eric Riley',  0,  3,  3,  0,  41,  0,  41,  2,  1998
EXEC add_PlayerStatsByName 'James Robinson',  1,  1,  7,  1,  38,  32,  46,  1,  1998
EXEC add_PlayerStatsByName 'James Robinson',  1,  2,  5,  1,  36,  28,  41,  1,  1999
EXEC add_PlayerStatsByName 'James Robinson',  0,  1,  1,  0,  36,  40,  45,  0,  2001
EXEC add_PlayerStatsByName 'Rodney Rogers',  2,  5,  15,  2,  45,  34,  49,  3,  1998
EXEC add_PlayerStatsByName 'Rodney Rogers',  1,  3,  7,  1,  44,  28,  47,  3,  1999
EXEC add_PlayerStatsByName 'Rodney Rogers',  2,  5,  13,  2,  48,  43,  55,  3,  2000
EXEC add_PlayerStatsByName 'Rodney Rogers',  2,  4,  12,  1,  43,  29,  46,  3,  2001
EXEC add_PlayerStatsByName 'Rodney Rogers',  1,  4,  11,  1,  47,  37,  52,  2,  2002
EXEC add_PlayerStatsByName 'Rodney Rogers',  1,  3,  7,  1,  40,  33,  45,  2,  2003
EXEC add_PlayerStatsByName 'Rodney Rogers',  2,  4,  7,  1,  41,  32,  45,  2,  2004
EXEC add_PlayerStatsByName 'Bryon Russell',  1,  4,  9,  1,  43,  34,  50,  2,  1998
EXEC add_PlayerStatsByName 'Bryon Russell',  1,  5,  12,  1,  46,  35,  51,  3,  1999
EXEC add_PlayerStatsByName 'Bryon Russell',  1,  5,  14,  1,  44,  39,  50,  3,  2000
EXEC add_PlayerStatsByName 'Bryon Russell',  2,  4,  12,  1,  44,  41,  50,  2,  2001
EXEC add_PlayerStatsByName 'Bryon Russell',  2,  4,  9,  1,  38,  34,  44,  3,  2002
EXEC add_PlayerStatsByName 'Bryon Russell',  1,  3,  4,  0,  35,  32,  42,  1,  2003
EXEC add_PlayerStatsByName 'Bryon Russell',  1,  2,  4,  0,  40,  38,  49,  1,  2004
EXEC add_PlayerStatsByName 'Rex Walters',  0,  0,  2,  0,  45,  27,  50,  0,  1998
EXEC add_PlayerStatsByName 'Rex Walters',  1,  1,  3,  1,  36,  31,  43,  1,  1999
EXEC add_PlayerStatsByName 'Rex Walters',  2,  1,  2,  0,  41,  25,  44,  1,  2000
EXEC add_PlayerStatsByName 'David Wesley',  6,  2,  13,  2,  44,  34,  47,  2,  1998
EXEC add_PlayerStatsByName 'David Wesley',  6,  3,  14,  2,  44,  35,  50,  2,  1999
EXEC add_PlayerStatsByName 'David Wesley',  5,  2,  13,  1,  42,  35,  47,  2,  2000
EXEC add_PlayerStatsByName 'David Wesley',  4,  2,  17,  2,  42,  37,  46,  2,  2001
EXEC add_PlayerStatsByName 'David Wesley',  3,  2,  14,  1,  40,  33,  44,  2,  2002
EXEC add_PlayerStatsByName 'David Wesley',  3,  2,  16,  1,  43,  42,  49,  2,  2003
EXEC add_PlayerStatsByName 'David Wesley',  2,  2,  14,  1,  38,  32,  44,  2,  2004
EXEC add_PlayerStatsByName 'Chris Whitney',  2,  1,  5,  0,  35,  30,  42,  1,  1998
EXEC add_PlayerStatsByName 'Chris Whitney',  1,  1,  4,  0,  41,  33,  51,  1,  1999
EXEC add_PlayerStatsByName 'Chris Whitney',  3,  1,  7,  1,  41,  37,  50,  2,  2000
EXEC add_PlayerStatsByName 'Chris Whitney',  4,  1,  9,  1,  38,  37,  48,  2,  2001
EXEC add_PlayerStatsByName 'Chris Whitney',  3,  1,  10,  1,  41,  40,  51,  2,  2002
EXEC add_PlayerStatsByName 'Chris Whitney',  2,  1,  7,  1,  35,  30,  42,  1,  2003
EXEC add_PlayerStatsByName 'Chris Whitney',  0,  0,  2,  0,  37,  44,  46,  0,  2004
EXEC add_PlayerStatsByName 'Aaron Williams',  0,  2,  4,  0,  52,  0,  52,  1,  1998
EXEC add_PlayerStatsByName 'Aaron Williams',  0,  3,  4,  0,  42,  0,  42,  1,  1999
EXEC add_PlayerStatsByName 'Aaron Williams',  0,  5,  7,  1,  52,  0,  52,  2,  2000
EXEC add_PlayerStatsByName 'Aaron Williams',  1,  7,  10,  1,  45,  0,  45,  3,  2001
EXEC add_PlayerStatsByName 'Aaron Williams',  0,  4,  7,  1,  52,  0,  52,  2,  2002
EXEC add_PlayerStatsByName 'Aaron Williams',  1,  4,  6,  1,  45,  0,  45,  2,  2003
EXEC add_PlayerStatsByName 'Aaron Williams',  1,  4,  6,  1,  50,  33,  50,  2,  2004
EXEC add_PlayerStatsByName 'Darrell Armstrong',  4,  3,  9,  2,  41,  36,  44,  2,  1998
EXEC add_PlayerStatsByName 'Darrell Armstrong',  6,  3,  13,  3,  44,  36,  50,  1,  1999
EXEC add_PlayerStatsByName 'Darrell Armstrong',  6,  3,  16,  3,  43,  34,  49,  1,  2000
EXEC add_PlayerStatsByName 'Darrell Armstrong',  7,  4,  15,  2,  41,  35,  48,  2,  2001
EXEC add_PlayerStatsByName 'Darrell Armstrong',  3,  3,  9,  2,  40,  33,  47,  2,  2003
EXEC add_PlayerStatsByName 'Darrell Armstrong',  3,  2,  10,  2,  39,  31,  48,  1,  2004
EXEC add_PlayerStatsByName 'Darrell Armstrong',  4,  3,  10,  2,  33,  24,  38,  2,  2005
EXEC add_PlayerStatsByName 'Tim Breaux',  0,  0,  1,  0,  36,  33,  40,  0,  1998
EXEC add_PlayerStatsByName 'Chris Childs',  3,  2,  6,  1,  42,  31,  45,  2,  1998
EXEC add_PlayerStatsByName 'Chris Childs',  4,  2,  6,  1,  42,  38,  49,  3,  1999
EXEC add_PlayerStatsByName 'Chris Childs',  4,  2,  5,  1,  40,  35,  46,  3,  2000
EXEC add_PlayerStatsByName 'Chris Childs',  4,  2,  4,  2,  40,  30,  45,  3,  2001
EXEC add_PlayerStatsByName 'Chris Childs',  5,  2,  4,  1,  32,  27,  38,  2,  2002
EXEC add_PlayerStatsByName 'Chris Childs',  1,  0,  1,  0,  30,  16,  32,  1,  2003
EXEC add_PlayerStatsByName 'Bill Curley',  0,  2,  3,  0,  48,  0,  48,  2,  1998
EXEC add_PlayerStatsByName 'Bill Curley',  0,  1,  2,  0,  40,  20,  41,  2,  1999
EXEC add_PlayerStatsByName 'Bill Curley',  0,  1,  2,  0,  42,  0,  42,  2,  2000
EXEC add_PlayerStatsByName 'Bill Curley',  0,  1,  3,  0,  53,  50,  54,  2,  2001
EXEC add_PlayerStatsByName 'Tony Dumas',  0,  0,  2,  0,  50,  50,  58,  0,  1998
EXEC add_PlayerStatsByName 'Howard Eisley',  4,  2,  7,  2,  44,  40,  48,  2,  1998
EXEC add_PlayerStatsByName 'Howard Eisley',  3,  1,  7,  2,  44,  42,  47,  2,  1999
EXEC add_PlayerStatsByName 'Howard Eisley',  4,  2,  8,  1,  41,  36,  46,  2,  2000
EXEC add_PlayerStatsByName 'Howard Eisley',  3,  2,  9,  1,  39,  39,  47,  2,  2001
EXEC add_PlayerStatsByName 'Howard Eisley',  2,  1,  4,  1,  33,  24,  37,  1,  2002
EXEC add_PlayerStatsByName 'Howard Eisley',  5,  2,  9,  1,  41,  38,  52,  2,  2003
EXEC add_PlayerStatsByName 'Howard Eisley',  4,  1,  6,  1,  36,  31,  42,  2,  2004
EXEC add_PlayerStatsByName 'Howard Eisley',  3,  1,  5,  1,  39,  26,  43,  2,  2005
EXEC add_PlayerStatsByName 'Brian Grant',  1,  9,  12,  1,  50,  0,  50,  3,  1998
EXEC add_PlayerStatsByName 'Brian Grant',  1,  5,  7,  1,  49,  50,  49,  2,  2000
EXEC add_PlayerStatsByName 'Brian Grant',  1,  8,  15,  2,  47,  0,  47,  3,  2001
EXEC add_PlayerStatsByName 'Brian Grant',  1,  8,  9,  1,  46,  0,  46,  3,  2002
EXEC add_PlayerStatsByName 'Brian Grant',  0,  6,  8,  1,  47,  0,  47,  3,  2004
EXEC add_PlayerStatsByName 'Juwan Howard',  3,  7,  18,  2,  46,  0,  46,  3,  1998
EXEC add_PlayerStatsByName 'Juwan Howard',  3,  8,  18,  2,  47,  0,  47,  3,  1999
EXEC add_PlayerStatsByName 'Juwan Howard',  3,  5,  14,  2,  45,  0,  45,  3,  2000
EXEC add_PlayerStatsByName 'Juwan Howard',  2,  7,  18,  3,  47,  0,  47,  3,  2001
EXEC add_PlayerStatsByName 'Juwan Howard',  2,  7,  14,  1,  46,  0,  46,  3,  2002
EXEC add_PlayerStatsByName 'Juwan Howard',  3,  7,  18,  2,  45,  50,  45,  3,  2003
EXEC add_PlayerStatsByName 'Juwan Howard',  2,  7,  17,  2,  45,  0,  45,  3,  2004
EXEC add_PlayerStatsByName 'Juwan Howard',  1,  5,  9,  1,  45,  0,  45,  2,  2005
EXEC add_PlayerStatsByName 'Eddie Jones',  3,  3,  16,  1,  48,  38,  55,  2,  1998
EXEC add_PlayerStatsByName 'Eddie Jones',  3,  3,  15,  1,  43,  33,  47,  2,  1999
EXEC add_PlayerStatsByName 'Eddie Jones',  4,  4,  20,  2,  42,  37,  48,  2,  2000
EXEC add_PlayerStatsByName 'Eddie Jones',  2,  4,  17,  2,  44,  37,  49,  2,  2001
EXEC add_PlayerStatsByName 'Eddie Jones',  3,  4,  18,  1,  43,  39,  49,  3,  2002
EXEC add_PlayerStatsByName 'Eddie Jones',  3,  4,  18,  1,  42,  40,  49,  2,  2003
EXEC add_PlayerStatsByName 'Eddie Jones',  3,  3,  17,  1,  40,  37,  48,  2,  2004
EXEC add_PlayerStatsByName 'Eddie Jones',  2,  5,  12,  1,  42,  37,  51,  3,  2005
EXEC add_PlayerStatsByName 'Donyell Marshall',  2,  8,  15,  2,  41,  31,  44,  3,  1998
EXEC add_PlayerStatsByName 'Donyell Marshall',  1,  7,  11,  1,  42,  36,  44,  2,  1999
EXEC add_PlayerStatsByName 'Donyell Marshall',  2,  10,  14,  1,  39,  35,  42,  2,  2000
EXEC add_PlayerStatsByName 'Donyell Marshall',  1,  7,  13,  1,  50,  32,  52,  2,  2001
EXEC add_PlayerStatsByName 'Donyell Marshall',  1,  7,  14,  2,  51,  31,  52,  2,  2002
EXEC add_PlayerStatsByName 'Donyell Marshall',  1,  9,  13,  1,  45,  37,  47,  3,  2003
EXEC add_PlayerStatsByName 'Donyell Marshall',  1,  9,  14,  1,  46,  40,  52,  3,  2004
EXEC add_PlayerStatsByName 'Donyell Marshall',  1,  6,  11,  0,  44,  41,  56,  2,  2005
EXEC add_PlayerStatsByName 'Darrick Martin',  4,  2,  10,  1,  37,  36,  45,  2,  1998
EXEC add_PlayerStatsByName 'Darrick Martin',  3,  1,  8,  1,  36,  29,  42,  2,  1999
EXEC add_PlayerStatsByName 'Darrick Martin',  1,  0,  5,  0,  38,  30,  43,  1,  2000
EXEC add_PlayerStatsByName 'Darrick Martin',  0,  0,  3,  0,  38,  51,  47,  0,  2001
EXEC add_PlayerStatsByName 'Darrick Martin',  1,  0,  0,  0,  0,  0,  0,  1,  2002
EXEC add_PlayerStatsByName 'Darrick Martin',  1,  0,  3,  0,  29,  23,  34,  1,  2004
EXEC add_PlayerStatsByName 'Darrick Martin',  2,  0,  3,  0,  32,  27,  37,  1,  2005
EXEC add_PlayerStatsByName 'Jim McIlvaine',  0,  3,  3,  0,  45,  0,  45,  3,  1998
EXEC add_PlayerStatsByName 'Aaron McKie',  2,  2,  4,  0,  36,  19,  38,  2,  1998
EXEC add_PlayerStatsByName 'Aaron McKie',  2,  2,  4,  1,  40,  19,  41,  1,  1999
EXEC add_PlayerStatsByName 'Aaron McKie',  2,  3,  8,  1,  41,  36,  44,  2,  2000
EXEC add_PlayerStatsByName 'Aaron McKie',  5,  4,  11,  2,  47,  31,  51,  2,  2001
EXEC add_PlayerStatsByName 'Aaron McKie',  3,  4,  12,  1,  44,  39,  50,  1,  2002
EXEC add_PlayerStatsByName 'Aaron McKie',  3,  4,  9,  1,  42,  33,  45,  2,  2003
EXEC add_PlayerStatsByName 'Aaron McKie',  2,  3,  9,  1,  45,  43,  52,  1,  2004
EXEC add_PlayerStatsByName 'Aaron McKie',  1,  2,  2,  0,  43,  32,  50,  1,  2005
EXEC add_PlayerStatsByName 'Anthony Miller',  0,  2,  2,  0,  46,  0,  46,  1,  1999
EXEC add_PlayerStatsByName 'Greg Minor',  1,  2,  5,  0,  43,  19,  44,  1,  1998
EXEC add_PlayerStatsByName 'Greg Minor',  1,  2,  4,  0,  41,  28,  43,  1,  1999
EXEC add_PlayerStatsByName 'Eric Montross',  0,  3,  2,  0,  52,  0,  52,  2,  1999
EXEC add_PlayerStatsByName 'Eric Montross',  0,  2,  2,  0,  40,  0,  40,  1,  2002
EXEC add_PlayerStatsByName 'Lamond Murray',  1,  6,  15,  2,  48,  35,  50,  2,  1998
EXEC add_PlayerStatsByName 'Lamond Murray',  1,  3,  12,  2,  39,  33,  42,  2,  1999
EXEC add_PlayerStatsByName 'Lamond Murray',  1,  5,  15,  2,  45,  36,  47,  2,  2000
EXEC add_PlayerStatsByName 'Lamond Murray',  1,  4,  12,  1,  42,  37,  45,  2,  2001
EXEC add_PlayerStatsByName 'Lamond Murray',  2,  5,  16,  2,  43,  42,  48,  2,  2002
EXEC add_PlayerStatsByName 'Lamond Murray',  0,  2,  6,  1,  35,  35,  40,  1,  2004
EXEC add_PlayerStatsByName 'Ivano Newbill',  0,  2,  2,  0,  35,  100,  36,  1,  1998
EXEC add_PlayerStatsByName 'Wesley Person',  2,  4,  14,  1,  46,  43,  56,  1,  1998
EXEC add_PlayerStatsByName 'Wesley Person',  1,  3,  11,  0,  45,  37,  53,  1,  1999
EXEC add_PlayerStatsByName 'Wesley Person',  1,  3,  9,  0,  42,  42,  50,  1,  2000
EXEC add_PlayerStatsByName 'Wesley Person',  1,  3,  7,  0,  43,  40,  49,  1,  2001
EXEC add_PlayerStatsByName 'Wesley Person',  2,  3,  15,  0,  49,  44,  56,  1,  2002
EXEC add_PlayerStatsByName 'Wesley Person',  1,  2,  11,  0,  45,  43,  53,  1,  2003
EXEC add_PlayerStatsByName 'Wesley Person',  1,  2,  5,  0,  40,  39,  48,  0,  2004
EXEC add_PlayerStatsByName 'Eric Piatkowski',  1,  3,  11,  1,  45,  40,  54,  2,  1998
EXEC add_PlayerStatsByName 'Eric Piatkowski',  1,  2,  10,  1,  43,  39,  51,  1,  1999
EXEC add_PlayerStatsByName 'Eric Piatkowski',  1,  3,  8,  0,  41,  38,  49,  1,  2000
EXEC add_PlayerStatsByName 'Eric Piatkowski',  1,  3,  10,  0,  43,  40,  52,  1,  2001
EXEC add_PlayerStatsByName 'Eric Piatkowski',  1,  2,  8,  0,  43,  46,  55,  1,  2002
EXEC add_PlayerStatsByName 'Eric Piatkowski',  1,  2,  9,  0,  47,  39,  56,  1,  2003
EXEC add_PlayerStatsByName 'Eric Piatkowski',  0,  1,  4,  0,  37,  35,  49,  0,  2004
EXEC add_PlayerStatsByName 'Eldridge Recasner',  2,  2,  9,  1,  45,  41,  52,  1,  1998
EXEC add_PlayerStatsByName 'Eldridge Recasner',  2,  1,  5,  1,  44,  40,  51,  1,  1999
EXEC add_PlayerStatsByName 'Eldridge Recasner',  0,  0,  1,  0,  42,  25,  50,  0,  2000
EXEC add_PlayerStatsByName 'Eldridge Recasner',  0,  1,  2,  0,  33,  33,  39,  0,  2001
EXEC add_PlayerStatsByName 'Eldridge Recasner',  0,  0,  0,  0,  33,  0,  33,  0,  2002
EXEC add_PlayerStatsByName 'Khalid Reeves',  2,  2,  8,  1,  41,  36,  46,  2,  1998
EXEC add_PlayerStatsByName 'Khalid Reeves',  1,  0,  2,  0,  38,  33,  40,  1,  1999
EXEC add_PlayerStatsByName 'Khalid Reeves',  4,  1,  3,  2,  25,  0,  25,  2,  2000
EXEC add_PlayerStatsByName 'Glenn Robinson',  2,  5,  23,  3,  47,  38,  48,  2,  1998
EXEC add_PlayerStatsByName 'Glenn Robinson',  2,  5,  18,  2,  45,  39,  47,  2,  1999
EXEC add_PlayerStatsByName 'Glenn Robinson',  2,  6,  20,  2,  47,  36,  50,  2,  2000
EXEC add_PlayerStatsByName 'Glenn Robinson',  3,  6,  22,  2,  46,  29,  48,  2,  2001
EXEC add_PlayerStatsByName 'Glenn Robinson',  2,  6,  20,  2,  46,  32,  49,  2,  2002
EXEC add_PlayerStatsByName 'Glenn Robinson',  3,  6,  20,  3,  43,  34,  46,  2,  2003
EXEC add_PlayerStatsByName 'Glenn Robinson',  1,  4,  16,  2,  44,  34,  47,  2,  2004
EXEC add_PlayerStatsByName 'Carlos Rogers',  0,  3,  5,  0,  51,  0,  51,  1,  1998
EXEC add_PlayerStatsByName 'Carlos Rogers',  0,  5,  8,  1,  52,  7,  52,  1,  2000
EXEC add_PlayerStatsByName 'Carlos Rogers',  0,  3,  4,  0,  68,  0,  68,  0,  2001
EXEC add_PlayerStatsByName 'Carlos Rogers',  0,  1,  2,  0,  55,  16,  56,  0,  2002
EXEC add_PlayerStatsByName 'Jalen Rose',  1,  2,  9,  1,  47,  34,  49,  2,  1998
EXEC add_PlayerStatsByName 'Jalen Rose',  1,  3,  11,  1,  40,  26,  42,  2,  1999
EXEC add_PlayerStatsByName 'Jalen Rose',  4,  4,  18,  2,  47,  39,  50,  2,  2000
EXEC add_PlayerStatsByName 'Jalen Rose',  6,  5,  20,  2,  45,  33,  48,  3,  2001
EXEC add_PlayerStatsByName 'Jalen Rose',  4,  4,  20,  2,  45,  36,  48,  3,  2002
EXEC add_PlayerStatsByName 'Jalen Rose',  4,  4,  22,  3,  40,  37,  44,  3,  2003
EXEC add_PlayerStatsByName 'Jalen Rose',  5,  4,  15,  3,  40,  34,  43,  2,  2004
EXEC add_PlayerStatsByName 'Dickey Simpkins',  0,  1,  3,  0,  53,  0,  53,  1,  1998
EXEC add_PlayerStatsByName 'Dickey Simpkins',  1,  6,  9,  1,  46,  0,  46,  2,  1999
EXEC add_PlayerStatsByName 'Dickey Simpkins',  1,  5,  4,  1,  40,  0,  40,  3,  2000
EXEC add_PlayerStatsByName 'Mark Strickland',  0,  4,  6,  0,  53,  0,  53,  1,  1998
EXEC add_PlayerStatsByName 'Mark Strickland',  0,  2,  3,  0,  49,  0,  49,  0,  1999
EXEC add_PlayerStatsByName 'Mark Strickland',  0,  2,  4,  0,  43,  50,  43,  1,  2001
EXEC add_PlayerStatsByName 'Mark Strickland',  0,  2,  4,  0,  44,  25,  44,  1,  2002
EXEC add_PlayerStatsByName 'Brooks Thompson',  0,  0,  2,  0,  41,  30,  49,  0,  1998
EXEC add_PlayerStatsByName 'Fred Vinson',  0,  0,  1,  0,  29,  28,  35,  0,  2000
EXEC add_PlayerStatsByName 'Charlie Ward',  5,  3,  7,  2,  45,  37,  53,  2,  1998
EXEC add_PlayerStatsByName 'Charlie Ward',  5,  3,  7,  2,  40,  35,  48,  2,  1999
EXEC add_PlayerStatsByName 'Charlie Ward',  4,  3,  7,  1,  42,  38,  53,  2,  2000
EXEC add_PlayerStatsByName 'Charlie Ward',  4,  2,  7,  1,  41,  38,  50,  2,  2001
EXEC add_PlayerStatsByName 'Charlie Ward',  3,  2,  5,  1,  37,  32,  46,  1,  2002
EXEC add_PlayerStatsByName 'Charlie Ward',  4,  2,  7,  1,  39,  37,  52,  2,  2003
EXEC add_PlayerStatsByName 'Charlie Ward',  3,  2,  6,  1,  41,  40,  51,  1,  2004
EXEC add_PlayerStatsByName 'Monty Williams',  1,  2,  6,  1,  44,  50,  45,  1,  1998
EXEC add_PlayerStatsByName 'Monty Williams',  1,  3,  8,  1,  48,  40,  49,  2,  2000
EXEC add_PlayerStatsByName 'Monty Williams',  1,  3,  5,  1,  44,  7,  44,  1,  2001
EXEC add_PlayerStatsByName 'Monty Williams',  1,  3,  7,  1,  54,  0,  54,  2,  2002
EXEC add_PlayerStatsByName 'Monty Williams',  1,  2,  4,  0,  42,  0,  42,  1,  2003
EXEC add_PlayerStatsByName 'Cory Alexander',  3,  2,  8,  1,  42,  37,  51,  1,  1998
EXEC add_PlayerStatsByName 'Cory Alexander',  3,  2,  7,  1,  37,  28,  43,  2,  1999
EXEC add_PlayerStatsByName 'Cory Alexander',  2,  1,  2,  1,  28,  25,  33,  1,  2000
EXEC add_PlayerStatsByName 'Cory Alexander',  1,  1,  2,  1,  32,  25,  35,  1,  2001
EXEC add_PlayerStatsByName 'Cory Alexander',  2,  1,  3,  1,  32,  42,  40,  1,  2005
EXEC add_PlayerStatsByName 'John Amaechi',  1,  3,  10,  1,  43,  16,  43,  2,  2000
EXEC add_PlayerStatsByName 'John Amaechi',  0,  3,  7,  1,  40,  0,  40,  2,  2001
EXEC add_PlayerStatsByName 'Brent Barry',  3,  3,  13,  2,  42,  40,  51,  2,  1998
EXEC add_PlayerStatsByName 'Brent Barry',  5,  5,  14,  2,  50,  42,  61,  2,  2002
EXEC add_PlayerStatsByName 'Brent Barry',  5,  3,  10,  2,  50,  45,  63,  2,  2004
EXEC add_PlayerStatsByName 'Brent Barry',  2,  2,  7,  0,  42,  35,  53,  1,  2005
EXEC add_PlayerStatsByName 'Corey Beck',  1,  1,  3,  1,  45,  50,  46,  1,  1998
EXEC add_PlayerStatsByName 'Corey Beck',  1,  1,  2,  0,  45,  100,  46,  1,  1999
EXEC add_PlayerStatsByName 'Mario Bennett',  0,  2,  3,  0,  59,  50,  59,  1,  1998
EXEC add_PlayerStatsByName 'Travis Best',  3,  1,  6,  1,  41,  30,  44,  2,  1998
EXEC add_PlayerStatsByName 'Travis Best',  3,  1,  7,  1,  41,  37,  45,  2,  1999
EXEC add_PlayerStatsByName 'Travis Best',  3,  1,  8,  1,  48,  37,  51,  2,  2000
EXEC add_PlayerStatsByName 'Travis Best',  6,  2,  11,  1,  44,  38,  46,  3,  2001
EXEC add_PlayerStatsByName 'Travis Best',  4,  2,  7,  1,  44,  35,  46,  2,  2002
EXEC add_PlayerStatsByName 'Travis Best',  3,  2,  8,  1,  39,  33,  42,  2,  2003
EXEC add_PlayerStatsByName 'Travis Best',  1,  1,  2,  0,  37,  15,  38,  1,  2004
EXEC add_PlayerStatsByName 'Travis Best',  1,  1,  6,  0,  42,  30,  44,  1,  2005
EXEC add_PlayerStatsByName 'Jason Caffey',  0,  4,  7,  1,  48,  0,  48,  2,  1998
EXEC add_PlayerStatsByName 'Jason Caffey',  0,  5,  8,  2,  44,  0,  44,  3,  1999
EXEC add_PlayerStatsByName 'Jason Caffey',  1,  6,  12,  2,  47,  0,  47,  3,  2000
EXEC add_PlayerStatsByName 'Jason Caffey',  0,  2,  4,  0,  50,  0,  50,  1,  2002
EXEC add_PlayerStatsByName 'Chris Carr',  1,  3,  9,  1,  42,  31,  46,  2,  1998
EXEC add_PlayerStatsByName 'Chris Carr',  0,  1,  5,  0,  37,  37,  43,  1,  1999
EXEC add_PlayerStatsByName 'Chris Carr',  1,  3,  9,  2,  39,  31,  42,  2,  2000
EXEC add_PlayerStatsByName 'Chris Carr',  0,  1,  4,  0,  47,  45,  54,  1,  2001
EXEC add_PlayerStatsByName 'Andrew DeClercq',  0,  4,  5,  1,  49,  0,  49,  3,  1998
EXEC add_PlayerStatsByName 'Tyus Edney',  2,  1,  5,  1,  43,  30,  43,  1,  1998
EXEC add_PlayerStatsByName 'Tyus Edney',  2,  1,  4,  1,  38,  16,  39,  0,  2001
EXEC add_PlayerStatsByName 'Michael Finley',  4,  5,  21,  2,  44,  35,  47,  2,  1998
EXEC add_PlayerStatsByName 'Michael Finley',  4,  5,  20,  2,  44,  33,  47,  1,  1999
EXEC add_PlayerStatsByName 'Michael Finley',  5,  6,  22,  2,  45,  40,  48,  2,  2000
EXEC add_PlayerStatsByName 'Michael Finley',  4,  5,  21,  2,  45,  34,  48,  2,  2001
EXEC add_PlayerStatsByName 'Michael Finley',  3,  5,  20,  1,  46,  33,  49,  2,  2002
EXEC add_PlayerStatsByName 'Michael Finley',  3,  5,  19,  1,  42,  37,  47,  1,  2003
EXEC add_PlayerStatsByName 'Michael Finley',  2,  4,  18,  1,  44,  40,  50,  1,  2004
EXEC add_PlayerStatsByName 'Michael Finley',  2,  4,  15,  0,  42,  40,  49,  1,  2005
EXEC add_PlayerStatsByName 'Anthony Goldwire',  3,  1,  9,  1,  42,  38,  47,  1,  1998
EXEC add_PlayerStatsByName 'Anthony Goldwire',  1,  0,  4,  0,  37,  26,  43,  0,  2001
EXEC add_PlayerStatsByName 'Anthony Goldwire',  0,  0,  1,  0,  36,  33,  42,  0,  2003
EXEC add_PlayerStatsByName 'Anthony Goldwire',  1,  0,  1,  0,  31,  25,  36,  0,  2004
EXEC add_PlayerStatsByName 'Anthony Goldwire',  2,  1,  5,  0,  41,  40,  53,  1,  2005
EXEC add_PlayerStatsByName 'Alan Henderson',  1,  6,  14,  1,  48,  50,  48,  2,  1998
EXEC add_PlayerStatsByName 'Alan Henderson',  0,  6,  12,  1,  44,  0,  44,  2,  1999
EXEC add_PlayerStatsByName 'Alan Henderson',  0,  7,  13,  1,  46,  10,  46,  2,  2000
EXEC add_PlayerStatsByName 'Alan Henderson',  0,  5,  10,  1,  44,  0,  44,  2,  2001
EXEC add_PlayerStatsByName 'Alan Henderson',  0,  3,  5,  0,  50,  100,  51,  1,  2002
EXEC add_PlayerStatsByName 'Alan Henderson',  0,  4,  4,  0,  46,  0,  46,  2,  2003
EXEC add_PlayerStatsByName 'Alan Henderson',  0,  4,  3,  0,  52,  0,  52,  1,  2005
EXEC add_PlayerStatsByName 'Fred Hoiberg',  0,  1,  4,  0,  38,  37,  45,  1,  1998
EXEC add_PlayerStatsByName 'Fred Hoiberg',  0,  0,  1,  0,  28,  11,  31,  0,  1999
EXEC add_PlayerStatsByName 'Fred Hoiberg',  2,  3,  9,  1,  38,  34,  45,  2,  2000
EXEC add_PlayerStatsByName 'Fred Hoiberg',  3,  4,  9,  1,  43,  41,  54,  2,  2001
EXEC add_PlayerStatsByName 'Fred Hoiberg',  1,  2,  4,  0,  41,  26,  45,  1,  2002
EXEC add_PlayerStatsByName 'Fred Hoiberg',  1,  2,  2,  0,  38,  23,  40,  0,  2003
EXEC add_PlayerStatsByName 'Fred Hoiberg',  1,  3,  6,  0,  46,  44,  56,  1,  2004
EXEC add_PlayerStatsByName 'Fred Hoiberg',  1,  2,  5,  0,  48,  48,  61,  1,  2005
EXEC add_PlayerStatsByName 'Voshon Lenard',  2,  3,  12,  1,  42,  40,  51,  2,  1998
EXEC add_PlayerStatsByName 'Voshon Lenard',  0,  1,  6,  0,  39,  34,  46,  1,  1999
EXEC add_PlayerStatsByName 'Voshon Lenard',  2,  2,  11,  1,  40,  39,  48,  2,  2000
EXEC add_PlayerStatsByName 'Voshon Lenard',  2,  2,  12,  1,  39,  38,  48,  2,  2001
EXEC add_PlayerStatsByName 'Voshon Lenard',  1,  2,  11,  1,  41,  37,  46,  1,  2002
EXEC add_PlayerStatsByName 'Voshon Lenard',  2,  3,  14,  1,  40,  36,  45,  2,  2003
EXEC add_PlayerStatsByName 'Voshon Lenard',  2,  2,  14,  1,  42,  36,  47,  2,  2004
EXEC add_PlayerStatsByName 'Voshon Lenard',  2,  2,  9,  0,  38,  33,  46,  0,  2005
EXEC add_PlayerStatsByName 'Donny Marshall',  0,  0,  1,  0,  27,  0,  27,  1,  2000
EXEC add_PlayerStatsByName 'Donny Marshall',  0,  1,  1,  0,  27,  50,  31,  0,  2002
EXEC add_PlayerStatsByName 'Donny Marshall',  0,  1,  0,  0,  0,  0,  0,  0,  2003
EXEC add_PlayerStatsByName 'Antonio McDyess',  1,  7,  15,  1,  53,  0,  53,  3,  1998
EXEC add_PlayerStatsByName 'Antonio McDyess',  1,  10,  21,  2,  47,  11,  47,  3,  1999
EXEC add_PlayerStatsByName 'Antonio McDyess',  2,  8,  19,  2,  50,  0,  50,  3,  2000
EXEC add_PlayerStatsByName 'Antonio McDyess',  0,  6,  9,  1,  51,  0,  51,  2,  2005
EXEC add_PlayerStatsByName 'Loren Meyer',  0,  1,  1,  0,  25,  20,  26,  1,  1999
EXEC add_PlayerStatsByName 'Lawrence Moten',  0,  0,  1,  0,  23,  0,  23,  0,  1998
EXEC add_PlayerStatsByName 'Greg Ostertag',  0,  6,  4,  1,  46,  0,  46,  2,  2000
EXEC add_PlayerStatsByName 'Greg Ostertag',  0,  5,  4,  0,  49,  50,  49,  2,  2001
EXEC add_PlayerStatsByName 'Greg Ostertag',  1,  7,  6,  1,  47,  0,  47,  2,  2004
EXEC add_PlayerStatsByName 'Cherokee Parks',  0,  5,  7,  0,  49,  0,  49,  3,  1998
EXEC add_PlayerStatsByName 'Cherokee Parks',  0,  5,  5,  1,  42,  0,  42,  2,  1999
EXEC add_PlayerStatsByName 'Cherokee Parks',  0,  3,  3,  0,  49,  0,  49,  2,  2000
EXEC add_PlayerStatsByName 'Cherokee Parks',  0,  3,  4,  0,  48,  0,  48,  1,  2001
EXEC add_PlayerStatsByName 'Cherokee Parks',  0,  4,  6,  0,  50,  50,  50,  1,  2003
EXEC add_PlayerStatsByName 'Bryant Reeves',  2,  7,  16,  2,  52,  0,  52,  3,  1998
EXEC add_PlayerStatsByName 'Bryant Reeves',  1,  5,  10,  1,  40,  0,  40,  4,  1999
EXEC add_PlayerStatsByName 'Bryant Reeves',  1,  5,  8,  1,  44,  0,  44,  3,  2000
EXEC add_PlayerStatsByName 'Bryant Reeves',  1,  6,  8,  1,  46,  25,  46,  3,  2001
EXEC add_PlayerStatsByName 'Shawn Respert',  1,  1,  5,  0,  44,  33,  49,  1,  1998
EXEC add_PlayerStatsByName 'Shawn Respert',  0,  1,  3,  0,  36,  30,  41,  0,  1999
EXEC add_PlayerStatsByName 'Joe Smith',  1,  6,  14,  2,  43,  0,  43,  3,  1998
EXEC add_PlayerStatsByName 'Joe Smith',  1,  8,  13,  1,  42,  0,  42,  3,  1999
EXEC add_PlayerStatsByName 'Joe Smith',  1,  6,  9,  1,  46,  100,  46,  3,  2000
EXEC add_PlayerStatsByName 'Joe Smith',  1,  7,  12,  1,  40,  0,  40,  3,  2001
EXEC add_PlayerStatsByName 'Joe Smith',  1,  6,  10,  1,  51,  66,  51,  3,  2002
EXEC add_PlayerStatsByName 'Joe Smith',  0,  5,  7,  0,  46,  0,  46,  3,  2003
EXEC add_PlayerStatsByName 'Joe Smith',  1,  8,  10,  1,  43,  20,  44,  2,  2004
EXEC add_PlayerStatsByName 'Eric Snow',  2,  1,  3,  1,  42,  11,  43,  1,  1998
EXEC add_PlayerStatsByName 'Eric Snow',  6,  3,  8,  2,  42,  23,  43,  3,  1999
EXEC add_PlayerStatsByName 'Eric Snow',  7,  3,  7,  2,  43,  24,  44,  3,  2000
EXEC add_PlayerStatsByName 'Eric Snow',  7,  3,  9,  2,  41,  26,  42,  2,  2001
EXEC add_PlayerStatsByName 'Eric Snow',  6,  3,  12,  2,  44,  11,  44,  2,  2002
EXEC add_PlayerStatsByName 'Eric Snow',  6,  3,  12,  2,  45,  21,  45,  2,  2003
EXEC add_PlayerStatsByName 'Eric Snow',  6,  3,  10,  2,  41,  11,  41,  2,  2004
EXEC add_PlayerStatsByName 'Jerry Stackhouse',  3,  3,  15,  2,  43,  24,  45,  2,  1998
EXEC add_PlayerStatsByName 'Jerry Stackhouse',  2,  2,  14,  2,  37,  27,  40,  1,  1999
EXEC add_PlayerStatsByName 'Jerry Stackhouse',  4,  3,  23,  3,  42,  28,  45,  2,  2000
EXEC add_PlayerStatsByName 'Jerry Stackhouse',  5,  3,  29,  4,  40,  35,  44,  2,  2001
EXEC add_PlayerStatsByName 'Jerry Stackhouse',  5,  4,  21,  3,  39,  28,  43,  2,  2002
EXEC add_PlayerStatsByName 'Jerry Stackhouse',  4,  3,  21,  2,  40,  28,  43,  1,  2003
EXEC add_PlayerStatsByName 'Jerry Stackhouse',  4,  3,  13,  3,  39,  35,  43,  1,  2004
EXEC add_PlayerStatsByName 'Damon Stoudamire',  8,  4,  17,  3,  41,  29,  45,  2,  1998
EXEC add_PlayerStatsByName 'Damon Stoudamire',  6,  3,  12,  2,  39,  31,  43,  1,  1999
EXEC add_PlayerStatsByName 'Damon Stoudamire',  5,  3,  12,  1,  43,  37,  47,  2,  2000
EXEC add_PlayerStatsByName 'Damon Stoudamire',  5,  3,  13,  2,  43,  37,  47,  2,  2001
EXEC add_PlayerStatsByName 'Damon Stoudamire',  6,  3,  13,  2,  40,  35,  45,  2,  2002
EXEC add_PlayerStatsByName 'Damon Stoudamire',  3,  2,  6,  1,  37,  38,  42,  1,  2003
EXEC add_PlayerStatsByName 'Damon Stoudamire',  6,  3,  13,  2,  40,  36,  47,  2,  2004
EXEC add_PlayerStatsByName 'Bob Sura',  3,  2,  5,  2,  37,  31,  41,  2,  1998
EXEC add_PlayerStatsByName 'Bob Sura',  3,  2,  4,  1,  33,  20,  35,  2,  1999
EXEC add_PlayerStatsByName 'Bob Sura',  3,  3,  13,  2,  43,  36,  51,  2,  2000
EXEC add_PlayerStatsByName 'Bob Sura',  4,  4,  11,  3,  39,  27,  43,  2,  2001
EXEC add_PlayerStatsByName 'Bob Sura',  3,  3,  10,  1,  42,  31,  45,  2,  2002
EXEC add_PlayerStatsByName 'Bob Sura',  3,  3,  7,  1,  41,  32,  45,  2,  2003
EXEC add_PlayerStatsByName 'Bob Sura',  2,  4,  7,  1,  41,  26,  43,  2,  2004
EXEC add_PlayerStatsByName 'Kurt Thomas',  1,  5,  8,  1,  46,  0,  46,  3,  1999
EXEC add_PlayerStatsByName 'Kurt Thomas',  1,  6,  8,  1,  50,  33,  50,  3,  2000
EXEC add_PlayerStatsByName 'Kurt Thomas',  0,  6,  10,  1,  51,  33,  51,  3,  2001
EXEC add_PlayerStatsByName 'Kurt Thomas',  1,  9,  13,  1,  49,  16,  49,  4,  2002
EXEC add_PlayerStatsByName 'Kurt Thomas',  2,  7,  14,  1,  48,  66,  48,  4,  2003
EXEC add_PlayerStatsByName 'Kurt Thomas',  1,  8,  11,  1,  47,  0,  47,  3,  2004
EXEC add_PlayerStatsByName 'Gary Trent',  1,  6,  11,  1,  47,  33,  48,  3,  1998
EXEC add_PlayerStatsByName 'Gary Trent',  1,  7,  16,  1,  47,  0,  47,  2,  1999
EXEC add_PlayerStatsByName 'Gary Trent',  2,  4,  13,  2,  49,  0,  49,  2,  2000
EXEC add_PlayerStatsByName 'Gary Trent',  0,  2,  4,  0,  43,  0,  43,  1,  2001
EXEC add_PlayerStatsByName 'Gary Trent',  0,  4,  7,  0,  50,  0,  50,  2,  2002
EXEC add_PlayerStatsByName 'Gary Trent',  1,  3,  6,  0,  53,  0,  53,  1,  2003
EXEC add_PlayerStatsByName 'Gary Trent',  0,  3,  5,  0,  47,  0,  47,  1,  2004
EXEC add_PlayerStatsByName 'David Vaughn',  0,  3,  4,  1,  44,  0,  44,  2,  1998
EXEC add_PlayerStatsByName 'Rasheed Wallace',  2,  6,  14,  2,  53,  20,  53,  3,  1998
EXEC add_PlayerStatsByName 'Rasheed Wallace',  1,  4,  12,  1,  50,  41,  52,  3,  1999
EXEC add_PlayerStatsByName 'Rasheed Wallace',  1,  7,  16,  1,  51,  16,  52,  2,  2000
EXEC add_PlayerStatsByName 'Rasheed Wallace',  2,  7,  19,  2,  50,  32,  52,  2,  2001
EXEC add_PlayerStatsByName 'Rasheed Wallace',  1,  8,  19,  1,  46,  36,  51,  2,  2002
EXEC add_PlayerStatsByName 'Rasheed Wallace',  2,  7,  18,  1,  47,  35,  52,  3,  2003
EXEC add_PlayerStatsByName 'Rasheed Wallace',  2,  6,  16,  1,  43,  33,  47,  2,  2004
EXEC add_PlayerStatsByName 'Eric Williams',  1,  2,  7,  1,  36,  23,  37,  2,  1999
EXEC add_PlayerStatsByName 'Eric Williams',  1,  2,  7,  1,  42,  34,  46,  2,  2000
EXEC add_PlayerStatsByName 'Eric Williams',  1,  2,  6,  0,  36,  33,  41,  2,  2001
EXEC add_PlayerStatsByName 'Eric Williams',  1,  3,  6,  1,  37,  27,  40,  2,  2002
EXEC add_PlayerStatsByName 'Eric Williams',  1,  4,  9,  1,  44,  33,  47,  2,  2003
EXEC add_PlayerStatsByName 'Eric Williams',  1,  4,  10,  1,  38,  27,  41,  2,  2004
EXEC add_PlayerStatsByName 'Corliss Williamson',  2,  5,  17,  2,  49,  0,  49,  3,  1998
EXEC add_PlayerStatsByName 'Corliss Williamson',  1,  4,  13,  1,  48,  20,  48,  2,  1999
EXEC add_PlayerStatsByName 'Corliss Williamson',  0,  4,  11,  1,  50,  0,  50,  2,  2001
EXEC add_PlayerStatsByName 'Corliss Williamson',  1,  4,  13,  1,  51,  20,  51,  2,  2002
EXEC add_PlayerStatsByName 'Corliss Williamson',  1,  4,  12,  1,  45,  18,  45,  2,  2003
EXEC add_PlayerStatsByName 'Shareef Abdur-Rahim',  2,  7,  22,  3,  48,  41,  49,  2,  1998
EXEC add_PlayerStatsByName 'Shareef Abdur-Rahim',  3,  7,  23,  3,  43,  30,  43,  2,  1999
EXEC add_PlayerStatsByName 'Shareef Abdur-Rahim',  3,  10,  20,  3,  46,  30,  47,  3,  2000
EXEC add_PlayerStatsByName 'Shareef Abdur-Rahim',  3,  9,  20,  2,  47,  18,  47,  2,  2001
EXEC add_PlayerStatsByName 'Shareef Abdur-Rahim',  3,  9,  21,  3,  46,  30,  46,  2,  2002
EXEC add_PlayerStatsByName 'Shareef Abdur-Rahim',  3,  8,  19,  2,  47,  35,  48,  3,  2003
EXEC add_PlayerStatsByName 'Shareef Abdur-Rahim',  2,  7,  16,  2,  47,  26,  48,  2,  2004
EXEC add_PlayerStatsByName 'Shareef Abdur-Rahim',  2,  7,  16,  2,  50,  38,  51,  2,  2005
EXEC add_PlayerStatsByName 'Shandon Anderson',  1,  2,  8,  1,  53,  21,  54,  1,  1998
EXEC add_PlayerStatsByName 'Shandon Anderson',  1,  2,  8,  1,  44,  34,  46,  1,  1999
EXEC add_PlayerStatsByName 'Shandon Anderson',  2,  4,  12,  2,  47,  35,  52,  2,  2000
EXEC add_PlayerStatsByName 'Shandon Anderson',  2,  4,  8,  1,  44,  27,  48,  2,  2001
EXEC add_PlayerStatsByName 'Shandon Anderson',  0,  3,  5,  1,  39,  27,  45,  1,  2002
EXEC add_PlayerStatsByName 'Shandon Anderson',  1,  3,  8,  1,  46,  37,  51,  2,  2003
EXEC add_PlayerStatsByName 'Shandon Anderson',  1,  2,  7,  1,  42,  28,  45,  2,  2004
EXEC add_PlayerStatsByName 'Shandon Anderson',  1,  2,  3,  0,  45,  17,  46,  2,  2005
EXEC add_PlayerStatsByName 'Bruce Bowen',  1,  2,  5,  0,  40,  33,  44,  2,  1998
EXEC add_PlayerStatsByName 'Bruce Bowen',  0,  1,  2,  0,  28,  26,  31,  1,  1999
EXEC add_PlayerStatsByName 'Bruce Bowen',  0,  1,  2,  0,  37,  46,  44,  1,  2000
EXEC add_PlayerStatsByName 'Bruce Bowen',  1,  3,  7,  0,  36,  33,  45,  3,  2001
EXEC add_PlayerStatsByName 'Bruce Bowen',  1,  2,  7,  1,  38,  37,  46,  2,  2002
EXEC add_PlayerStatsByName 'Bruce Bowen',  1,  2,  7,  0,  46,  44,  57,  2,  2003
EXEC add_PlayerStatsByName 'Bruce Bowen',  1,  3,  6,  1,  42,  36,  49,  2,  2004
EXEC add_PlayerStatsByName 'Bruce Bowen',  1,  3,  8,  0,  42,  40,  50,  2,  2005
EXEC add_PlayerStatsByName 'Marcus Brown',  0,  1,  1,  0,  28,  0,  28,  1,  2000
EXEC add_PlayerStatsByName 'Marcus Camby',  1,  7,  12,  2,  41,  0,  41,  3,  1998
EXEC add_PlayerStatsByName 'Marcus Camby',  0,  7,  10,  1,  48,  50,  48,  3,  2000
EXEC add_PlayerStatsByName 'Marcus Camby',  0,  11,  12,  1,  52,  12,  52,  3,  2001
EXEC add_PlayerStatsByName 'Marcus Camby',  1,  11,  11,  1,  44,  0,  44,  3,  2002
EXEC add_PlayerStatsByName 'Marcus Camby',  1,  7,  7,  0,  41,  40,  41,  2,  2003
EXEC add_PlayerStatsByName 'Marcus Camby',  1,  10,  8,  1,  47,  0,  47,  3,  2004
EXEC add_PlayerStatsByName 'Marcus Camby',  2,  10,  10,  1,  46,  0,  46,  2,  2005
EXEC add_PlayerStatsByName 'Erick Dampier',  1,  8,  11,  2,  44,  0,  44,  3,  1998
EXEC add_PlayerStatsByName 'Erick Dampier',  1,  5,  7,  1,  40,  0,  40,  2,  2001
EXEC add_PlayerStatsByName 'Erick Dampier',  0,  6,  8,  1,  49,  0,  49,  3,  2003
EXEC add_PlayerStatsByName 'Erick Dampier',  0,  12,  12,  1,  53,  0,  53,  3,  2004
EXEC add_PlayerStatsByName 'Erick Dampier',  0,  8,  9,  1,  55,  0,  55,  3,  2005
EXEC add_PlayerStatsByName 'Emanual Davis',  1,  1,  4,  1,  44,  37,  53,  1,  1998
EXEC add_PlayerStatsByName 'Emanual Davis',  1,  1,  4,  0,  36,  30,  43,  1,  2000
EXEC add_PlayerStatsByName 'Emanual Davis',  2,  2,  5,  1,  41,  39,  49,  1,  2001
EXEC add_PlayerStatsByName 'Emanual Davis',  2,  2,  6,  1,  35,  34,  42,  2,  2002
EXEC add_PlayerStatsByName 'Emanual Davis',  1,  1,  3,  1,  36,  24,  40,  1,  2003
EXEC add_PlayerStatsByName 'Tony Delk',  2,  2,  10,  1,  39,  26,  42,  1,  1998
EXEC add_PlayerStatsByName 'Tony Delk',  2,  1,  6,  1,  36,  24,  39,  1,  1999
EXEC add_PlayerStatsByName 'Tony Delk',  1,  1,  6,  0,  43,  22,  44,  1,  2000
EXEC add_PlayerStatsByName 'Tony Delk',  2,  3,  12,  1,  41,  32,  44,  2,  2001
EXEC add_PlayerStatsByName 'Tony Delk',  2,  3,  9,  0,  38,  31,  44,  1,  2002
EXEC add_PlayerStatsByName 'Tony Delk',  2,  3,  9,  1,  41,  39,  52,  1,  2003
EXEC add_PlayerStatsByName 'Tony Delk',  0,  1,  6,  0,  38,  30,  43,  1,  2004
EXEC add_PlayerStatsByName 'Tony Delk',  1,  2,  11,  1,  41,  35,  47,  2,  2005
EXEC add_PlayerStatsByName 'Brian Evans',  0,  1,  4,  0,  39,  33,  44,  1,  1998
EXEC add_PlayerStatsByName 'Brian Evans',  0,  1,  2,  0,  29,  30,  34,  0,  1999
EXEC add_PlayerStatsByName 'Jamie Feick',  0,  2,  2,  0,  43,  30,  45,  1,  1998
EXEC add_PlayerStatsByName 'Jamie Feick',  0,  9,  5,  0,  42,  100,  43,  2,  2000
EXEC add_PlayerStatsByName 'Derek Fisher',  4,  2,  5,  1,  43,  38,  47,  1,  1998
EXEC add_PlayerStatsByName 'Derek Fisher',  3,  1,  5,  1,  37,  39,  44,  1,  1999
EXEC add_PlayerStatsByName 'Derek Fisher',  2,  1,  6,  1,  34,  31,  40,  1,  2000
EXEC add_PlayerStatsByName 'Derek Fisher',  4,  3,  11,  1,  41,  39,  47,  2,  2001
EXEC add_PlayerStatsByName 'Derek Fisher',  2,  2,  11,  0,  41,  41,  52,  1,  2002
EXEC add_PlayerStatsByName 'Derek Fisher',  3,  2,  10,  1,  43,  40,  49,  2,  2003
EXEC add_PlayerStatsByName 'Derek Fisher',  2,  1,  7,  1,  35,  29,  39,  1,  2004
EXEC add_PlayerStatsByName 'Derek Fisher',  4,  2,  11,  1,  39,  37,  46,  2,  2005
EXEC add_PlayerStatsByName 'Todd Fuller',  0,  3,  4,  0,  42,  0,  42,  1,  1998
EXEC add_PlayerStatsByName 'Reggie Geary',  1,  1,  2,  0,  33,  30,  36,  1,  1998
EXEC add_PlayerStatsByName 'Darvin Ham',  1,  4,  5,  0,  55,  0,  55,  2,  2000
EXEC add_PlayerStatsByName 'Darvin Ham',  0,  4,  3,  1,  48,  66,  50,  2,  2001
EXEC add_PlayerStatsByName 'Darvin Ham',  1,  2,  4,  1,  56,  14,  57,  2,  2002
EXEC add_PlayerStatsByName 'Darvin Ham',  0,  2,  2,  0,  44,  0,  44,  1,  2003
EXEC add_PlayerStatsByName 'Darvin Ham',  0,  1,  1,  0,  49,  50,  50,  1,  2004
EXEC add_PlayerStatsByName 'Othella Harrington',  0,  3,  6,  0,  48,  0,  48,  1,  1998
EXEC add_PlayerStatsByName 'Othella Harrington',  1,  6,  13,  2,  50,  0,  50,  3,  2000
EXEC add_PlayerStatsByName 'Othella Harrington',  0,  5,  9,  2,  48,  0,  48,  3,  2001
EXEC add_PlayerStatsByName 'Othella Harrington',  0,  4,  7,  1,  52,  0,  52,  3,  2002
EXEC add_PlayerStatsByName 'Michael Hawkins',  1,  1,  1,  0,  35,  26,  41,  0,  1999
EXEC add_PlayerStatsByName 'Michael Hawkins',  1,  0,  0,  0,  23,  20,  26,  0,  2000
EXEC add_PlayerStatsByName 'Michael Hawkins',  1,  0,  0,  0,  33,  50,  44,  1,  2001
EXEC add_PlayerStatsByName 'Shane Heal',  0,  0,  3,  0,  29,  22,  37,  0,  2004
EXEC add_PlayerStatsByName 'Mark Hendrickson',  0,  3,  3,  0,  38,  0,  38,  1,  1998
EXEC add_PlayerStatsByName 'Mark Hendrickson',  0,  3,  5,  0,  44,  0,  44,  1,  1999
EXEC add_PlayerStatsByName 'Kerry Kittles',  2,  4,  17,  1,  44,  41,  48,  2,  1998
EXEC add_PlayerStatsByName 'Kerry Kittles',  2,  4,  12,  1,  37,  31,  41,  1,  1999
EXEC add_PlayerStatsByName 'Kerry Kittles',  2,  3,  13,  0,  43,  40,  50,  1,  2000
EXEC add_PlayerStatsByName 'Kerry Kittles',  2,  3,  13,  1,  46,  40,  51,  1,  2002
EXEC add_PlayerStatsByName 'Kerry Kittles',  2,  3,  13,  0,  46,  35,  52,  1,  2003
EXEC add_PlayerStatsByName 'Kerry Kittles',  2,  4,  13,  1,  45,  35,  50,  1,  2004
EXEC add_PlayerStatsByName 'Kerry Kittles',  1,  2,  6,  0,  38,  33,  43,  1,  2005
EXEC add_PlayerStatsByName 'Travis Knight',  1,  4,  6,  1,  44,  27,  45,  3,  1998
EXEC add_PlayerStatsByName 'Travis Knight',  0,  3,  4,  0,  51,  0,  51,  2,  1999
EXEC add_PlayerStatsByName 'Travis Knight',  0,  1,  0,  0,  18,  0,  18,  1,  2001
EXEC add_PlayerStatsByName 'Travis Knight',  0,  1,  1,  0,  38,  0,  38,  1,  2003
EXEC add_PlayerStatsByName 'Randy Livingston',  2,  1,  4,  1,  41,  34,  44,  1,  2000
EXEC add_PlayerStatsByName 'Randy Livingston',  0,  0,  0,  0,  0,  0,  0,  0,  2001
EXEC add_PlayerStatsByName 'Randy Livingston',  2,  1,  3,  0,  27,  12,  28,  0,  2002
EXEC add_PlayerStatsByName 'Randy Livingston',  1,  1,  2,  1,  20,  0,  20,  1,  2004
EXEC add_PlayerStatsByName 'Randy Livingston',  2,  0,  3,  0,  42,  62,  47,  1,  2005
EXEC add_PlayerStatsByName 'Horacio Llamas',  0,  2,  3,  1,  38,  33,  40,  1,  1998
EXEC add_PlayerStatsByName 'Matt Maloney',  2,  1,  8,  1,  40,  36,  51,  1,  1998
EXEC add_PlayerStatsByName 'Matt Maloney',  1,  0,  1,  0,  17,  6,  19,  0,  1999
EXEC add_PlayerStatsByName 'Matt Maloney',  2,  1,  6,  1,  35,  35,  45,  0,  2000
EXEC add_PlayerStatsByName 'Matt Maloney',  2,  2,  6,  1,  42,  35,  49,  1,  2001
EXEC add_PlayerStatsByName 'Matt Maloney',  1,  0,  1,  0,  32,  33,  42,  0,  2003
EXEC add_PlayerStatsByName 'Stephon Marbury',  8,  2,  17,  3,  41,  31,  45,  2,  1998
EXEC add_PlayerStatsByName 'Stephon Marbury',  8,  2,  21,  3,  42,  33,  46,  2,  1999
EXEC add_PlayerStatsByName 'Stephon Marbury',  8,  3,  22,  3,  43,  28,  45,  2,  2000
EXEC add_PlayerStatsByName 'Stephon Marbury',  7,  3,  23,  2,  44,  32,  48,  2,  2001
EXEC add_PlayerStatsByName 'Stephon Marbury',  8,  3,  20,  3,  44,  28,  46,  2,  2002
EXEC add_PlayerStatsByName 'Stephon Marbury',  8,  3,  22,  3,  43,  30,  46,  2,  2003
EXEC add_PlayerStatsByName 'Stephon Marbury',  8,  3,  20,  3,  43,  31,  46,  2,  2004
EXEC add_PlayerStatsByName 'Stephon Marbury',  8,  3,  21,  2,  46,  35,  50,  2,  2005
EXEC add_PlayerStatsByName 'Walter McCarty',  2,  4,  9,  1,  40,  30,  44,  3,  1998
EXEC add_PlayerStatsByName 'Walter McCarty',  1,  3,  5,  1,  36,  26,  39,  2,  1999
EXEC add_PlayerStatsByName 'Walter McCarty',  1,  1,  3,  1,  33,  30,  41,  1,  2000
EXEC add_PlayerStatsByName 'Walter McCarty',  0,  1,  2,  0,  35,  33,  43,  1,  2001
EXEC add_PlayerStatsByName 'Walter McCarty',  0,  2,  3,  0,  44,  39,  55,  1,  2002
EXEC add_PlayerStatsByName 'Walter McCarty',  1,  3,  6,  0,  41,  36,  52,  2,  2003
EXEC add_PlayerStatsByName 'Walter McCarty',  1,  3,  7,  1,  38,  37,  51,  2,  2004
EXEC add_PlayerStatsByName 'Walter McCarty',  0,  1,  3,  0,  40,  35,  52,  2,  2005
EXEC add_PlayerStatsByName 'Amal McCaskill',  0,  2,  1,  0,  40,  0,  40,  1,  2004
EXEC add_PlayerStatsByName 'Jeff McInnis',  2,  0,  3,  0,  37,  25,  40,  1,  1999
EXEC add_PlayerStatsByName 'Jeff McInnis',  3,  2,  7,  1,  43,  33,  44,  2,  2000
EXEC add_PlayerStatsByName 'Jeff McInnis',  5,  2,  12,  1,  46,  36,  49,  2,  2001
EXEC add_PlayerStatsByName 'Jeff McInnis',  6,  2,  14,  1,  41,  32,  44,  2,  2002
EXEC add_PlayerStatsByName 'Jeff McInnis',  2,  1,  5,  1,  44,  17,  45,  1,  2003
EXEC add_PlayerStatsByName 'Jeff McInnis',  6,  2,  11,  1,  44,  36,  47,  2,  2004
EXEC add_PlayerStatsByName 'Jeff McInnis',  5,  2,  12,  1,  41,  34,  46,  2,  2005
EXEC add_PlayerStatsByName 'Moochie Norris',  2,  1,  3,  1,  32,  40,  40,  1,  1999
EXEC add_PlayerStatsByName 'Moochie Norris',  3,  2,  6,  1,  43,  41,  47,  1,  2000
EXEC add_PlayerStatsByName 'Moochie Norris',  3,  2,  6,  1,  44,  28,  47,  1,  2001
EXEC add_PlayerStatsByName 'Moochie Norris',  4,  3,  8,  1,  39,  26,  42,  1,  2002
EXEC add_PlayerStatsByName 'Moochie Norris',  2,  1,  4,  1,  40,  24,  42,  0,  2003
EXEC add_PlayerStatsByName 'Moochie Norris',  1,  1,  3,  1,  36,  34,  41,  0,  2004
EXEC add_PlayerStatsByName 'Jermaine O"Neal',  0,  3,  4,  0,  48,  0,  48,  1,  1998
EXEC add_PlayerStatsByName 'Jermaine O"Neal',  0,  2,  2,  0,  43,  0,  43,  1,  1999
EXEC add_PlayerStatsByName 'Jermaine O"Neal',  0,  3,  3,  0,  48,  0,  48,  1,  2000
EXEC add_PlayerStatsByName 'Jermaine O"Neal',  1,  9,  12,  2,  46,  0,  46,  3,  2001
EXEC add_PlayerStatsByName 'Jermaine O"Neal',  1,  10,  19,  2,  47,  7,  48,  3,  2002
EXEC add_PlayerStatsByName 'Jermaine O"Neal',  2,  10,  20,  2,  48,  33,  48,  3,  2003
EXEC add_PlayerStatsByName 'Jermaine O"Neal',  2,  10,  20,  2,  43,  11,  43,  3,  2004
EXEC add_PlayerStatsByName 'Vitaly Potapenko',  0,  3,  7,  1,  48,  0,  48,  2,  1998
EXEC add_PlayerStatsByName 'Vitaly Potapenko',  1,  6,  10,  2,  49,  0,  49,  3,  1999
EXEC add_PlayerStatsByName 'Vitaly Potapenko',  1,  6,  9,  1,  49,  0,  49,  3,  2000
EXEC add_PlayerStatsByName 'Chris Robinson',  1,  1,  4,  0,  37,  36,  44,  1,  1998
EXEC add_PlayerStatsByName 'Roy Rogers',  0,  2,  2,  0,  39,  0,  39,  0,  2000
EXEC add_PlayerStatsByName 'Malik Rose',  0,  1,  3,  0,  43,  33,  43,  1,  1998
EXEC add_PlayerStatsByName 'Malik Rose',  0,  3,  6,  1,  46,  0,  46,  2,  1999
EXEC add_PlayerStatsByName 'Malik Rose',  0,  4,  6,  1,  45,  33,  45,  3,  2000
EXEC add_PlayerStatsByName 'Malik Rose',  0,  5,  7,  1,  43,  17,  43,  2,  2001
EXEC add_PlayerStatsByName 'Malik Rose',  0,  6,  9,  1,  46,  8,  46,  2,  2002
EXEC add_PlayerStatsByName 'Malik Rose',  1,  6,  10,  2,  45,  40,  46,  2,  2003
EXEC add_PlayerStatsByName 'Malik Rose',  1,  4,  7,  1,  42,  0,  42,  2,  2004
EXEC add_PlayerStatsByName 'Joe Stephens',  0,  0,  3,  0,  35,  30,  41,  0,  1998
EXEC add_PlayerStatsByName 'Joe Stephens',  0,  2,  3,  0,  37,  0,  37,  0,  2000
EXEC add_PlayerStatsByName 'Erick Strickland',  2,  2,  7,  1,  35,  29,  40,  2,  1998
EXEC add_PlayerStatsByName 'Erick Strickland',  1,  2,  7,  1,  40,  30,  44,  1,  1999
EXEC add_PlayerStatsByName 'Erick Strickland',  3,  4,  12,  1,  43,  39,  48,  2,  2000
EXEC add_PlayerStatsByName 'Erick Strickland',  1,  2,  5,  1,  30,  31,  36,  1,  2001
EXEC add_PlayerStatsByName 'Erick Strickland',  2,  2,  7,  1,  38,  38,  48,  1,  2002
EXEC add_PlayerStatsByName 'Erick Strickland',  2,  2,  6,  1,  42,  38,  51,  1,  2003
EXEC add_PlayerStatsByName 'Erick Strickland',  2,  1,  5,  1,  40,  43,  47,  1,  2004
EXEC add_PlayerStatsByName 'Antoine Walker',  3,  10,  22,  3,  42,  31,  45,  3,  1998
EXEC add_PlayerStatsByName 'Antoine Walker',  3,  8,  18,  2,  41,  36,  45,  3,  1999
EXEC add_PlayerStatsByName 'Antoine Walker',  3,  8,  20,  3,  43,  25,  45,  3,  2000
EXEC add_PlayerStatsByName 'Antoine Walker',  5,  8,  23,  3,  41,  36,  47,  3,  2001
EXEC add_PlayerStatsByName 'Antoine Walker',  5,  8,  22,  3,  39,  34,  46,  2,  2002
EXEC add_PlayerStatsByName 'Antoine Walker',  4,  7,  20,  3,  38,  32,  44,  2,  2003
EXEC add_PlayerStatsByName 'Antoine Walker',  4,  8,  14,  2,  42,  26,  46,  2,  2004
EXEC add_PlayerStatsByName 'Samaki Walker',  0,  7,  8,  1,  48,  0,  48,  3,  1998
EXEC add_PlayerStatsByName 'Samaki Walker',  0,  3,  5,  0,  46,  0,  46,  2,  1999
EXEC add_PlayerStatsByName 'Samaki Walker',  0,  4,  5,  1,  48,  33,  48,  1,  2001
EXEC add_PlayerStatsByName 'Samaki Walker',  1,  5,  4,  0,  42,  0,  42,  2,  2003
EXEC add_PlayerStatsByName 'Samaki Walker',  0,  3,  3,  0,  38,  0,  38,  1,  2004
EXEC add_PlayerStatsByName 'John Wallace',  1,  4,  14,  2,  47,  50,  47,  2,  1998
EXEC add_PlayerStatsByName 'John Wallace',  0,  2,  6,  1,  46,  0,  46,  1,  2000
EXEC add_PlayerStatsByName 'John Wallace',  0,  2,  5,  0,  42,  13,  42,  1,  2001
EXEC add_PlayerStatsByName 'John Wallace',  0,  1,  5,  0,  43,  38,  44,  1,  2002
EXEC add_PlayerStatsByName 'John Wallace',  0,  1,  4,  0,  42,  38,  43,  1,  2004
EXEC add_PlayerStatsByName 'Donald Whiteside',  0,  0,  0,  0,  50,  0,  50,  0,  1998
EXEC add_PlayerStatsByName 'Jerome Williams',  0,  4,  5,  0,  52,  0,  52,  1,  1998
EXEC add_PlayerStatsByName 'Jerome Williams',  0,  9,  8,  1,  56,  0,  56,  2,  2000
EXEC add_PlayerStatsByName 'Jerome Williams',  0,  6,  6,  1,  46,  0,  46,  2,  2001
EXEC add_PlayerStatsByName 'Jerome Williams',  1,  9,  9,  1,  49,  16,  50,  2,  2003
EXEC add_PlayerStatsByName 'Jerome Williams',  1,  7,  6,  1,  47,  0,  47,  2,  2004
EXEC add_PlayerStatsByName 'Lorenzen Wright',  0,  8,  9,  1,  44,  0,  44,  3,  1998
EXEC add_PlayerStatsByName 'Lorenzen Wright',  0,  7,  6,  1,  45,  0,  45,  3,  1999
EXEC add_PlayerStatsByName 'Lorenzen Wright',  0,  4,  6,  0,  49,  33,  50,  2,  2000
EXEC add_PlayerStatsByName 'Lorenzen Wright',  1,  7,  12,  1,  44,  0,  44,  3,  2001
EXEC add_PlayerStatsByName 'Lorenzen Wright',  1,  9,  12,  1,  45,  0,  45,  2,  2002
EXEC add_PlayerStatsByName 'Lorenzen Wright',  1,  7,  11,  1,  45,  0,  45,  3,  2003
EXEC add_PlayerStatsByName 'Lorenzen Wright',  1,  6,  9,  1,  43,  0,  43,  3,  2004
EXEC add_PlayerStatsByName 'Tariq Abdul-Wahad',  0,  2,  6,  1,  40,  21,  40,  1,  1998
EXEC add_PlayerStatsByName 'Tariq Abdul-Wahad',  1,  3,  9,  1,  43,  28,  44,  2,  1999
EXEC add_PlayerStatsByName 'Tariq Abdul-Wahad',  1,  4,  11,  1,  42,  13,  42,  2,  2000
EXEC add_PlayerStatsByName 'Tariq Abdul-Wahad',  0,  2,  3,  1,  38,  40,  40,  1,  2001
EXEC add_PlayerStatsByName 'Tariq Abdul-Wahad',  1,  3,  5,  1,  37,  50,  37,  2,  2002
EXEC add_PlayerStatsByName 'Tariq Abdul-Wahad',  1,  2,  4,  0,  46,  0,  46,  1,  2003
EXEC add_PlayerStatsByName 'Derek Anderson',  3,  2,  11,  1,  40,  20,  42,  2,  1998
EXEC add_PlayerStatsByName 'Derek Anderson',  3,  2,  10,  2,  39,  30,  43,  1,  1999
EXEC add_PlayerStatsByName 'Derek Anderson',  3,  4,  16,  2,  43,  30,  47,  2,  2000
EXEC add_PlayerStatsByName 'Derek Anderson',  3,  4,  15,  2,  41,  39,  46,  2,  2001
EXEC add_PlayerStatsByName 'Derek Anderson',  3,  2,  10,  1,  40,  37,  47,  1,  2002
EXEC add_PlayerStatsByName 'Derek Anderson',  4,  3,  13,  1,  42,  35,  49,  1,  2003
EXEC add_PlayerStatsByName 'Derek Anderson',  4,  3,  13,  1,  37,  30,  44,  1,  2004
EXEC add_PlayerStatsByName 'Derek Anderson',  3,  2,  9,  1,  38,  38,  46,  1,  2005
EXEC add_PlayerStatsByName 'Chris Anstey',  0,  3,  5,  1,  39,  18,  40,  2,  1998
EXEC add_PlayerStatsByName 'Chris Anstey',  0,  2,  3,  0,  36,  0,  36,  2,  1999
EXEC add_PlayerStatsByName 'Chris Anstey',  0,  3,  6,  1,  44,  16,  44,  2,  2000
EXEC add_PlayerStatsByName 'Drew Barry',  1,  1,  2,  1,  47,  42,  59,  1,  1998
EXEC add_PlayerStatsByName 'Tony Battie',  0,  5,  8,  1,  44,  21,  44,  3,  1998
EXEC add_PlayerStatsByName 'Tony Battie',  0,  5,  6,  0,  47,  12,  47,  3,  2000
EXEC add_PlayerStatsByName 'Tony Battie',  0,  6,  6,  0,  54,  0,  54,  3,  2002
EXEC add_PlayerStatsByName 'Tony Battie',  0,  5,  5,  1,  47,  100,  48,  2,  2004
EXEC add_PlayerStatsByName 'Tony Battie',  0,  5,  4,  1,  46,  0,  46,  3,  2005
EXEC add_PlayerStatsByName 'Chauncey Billups',  3,  2,  11,  2,  37,  32,  44,  2,  1998
EXEC add_PlayerStatsByName 'Chauncey Billups',  3,  2,  13,  2,  38,  36,  47,  2,  1999
EXEC add_PlayerStatsByName 'Chauncey Billups',  3,  2,  8,  1,  33,  17,  37,  2,  2000
EXEC add_PlayerStatsByName 'Chauncey Billups',  5,  2,  12,  1,  42,  39,  49,  2,  2002
EXEC add_PlayerStatsByName 'Chauncey Billups',  3,  3,  16,  1,  42,  39,  50,  1,  2003
EXEC add_PlayerStatsByName 'Chauncey Billups',  5,  3,  16,  2,  39,  38,  45,  2,  2004
EXEC add_PlayerStatsByName 'Chauncey Billups',  5,  3,  16,  2,  44,  42,  53,  2,  2005
EXEC add_PlayerStatsByName 'Keith Booth',  0,  0,  1,  0,  33,  0,  33,  0,  1998
EXEC add_PlayerStatsByName 'Keith Booth',  1,  2,  3,  1,  32,  10,  32,  1,  1999
EXEC add_PlayerStatsByName 'Rick Brunson',  2,  1,  4,  1,  34,  36,  42,  1,  1998
EXEC add_PlayerStatsByName 'Rick Brunson',  1,  0,  1,  0,  28,  0,  28,  0,  1999
EXEC add_PlayerStatsByName 'Rick Brunson',  1,  0,  1,  0,  41,  15,  42,  0,  2000
EXEC add_PlayerStatsByName 'Rick Brunson',  1,  1,  2,  0,  33,  14,  35,  1,  2001
EXEC add_PlayerStatsByName 'Rick Brunson',  1,  1,  2,  0,  39,  54,  42,  0,  2002
EXEC add_PlayerStatsByName 'Rick Brunson',  2,  1,  3,  1,  46,  66,  50,  1,  2003
EXEC add_PlayerStatsByName 'Rick Brunson',  2,  0,  3,  0,  38,  47,  43,  1,  2004
EXEC add_PlayerStatsByName 'Rick Brunson',  5,  2,  5,  1,  37,  36,  43,  1,  2005
EXEC add_PlayerStatsByName 'Kelvin Cato',  0,  3,  3,  0,  42,  0,  42,  2,  1998
EXEC add_PlayerStatsByName 'Kelvin Cato',  0,  3,  3,  0,  45,  100,  45,  2,  1999
EXEC add_PlayerStatsByName 'Kelvin Cato',  0,  6,  8,  1,  53,  0,  53,  2,  2000
EXEC add_PlayerStatsByName 'Kelvin Cato',  0,  7,  6,  0,  58,  0,  58,  2,  2002
EXEC add_PlayerStatsByName 'Kelvin Cato',  0,  5,  4,  0,  52,  0,  52,  2,  2003
EXEC add_PlayerStatsByName 'Keith Closs',  0,  1,  2,  0,  52,  0,  52,  0,  1999
EXEC add_PlayerStatsByName 'Keith Closs',  0,  3,  4,  0,  48,  0,  48,  1,  2000
EXEC add_PlayerStatsByName 'James Collins',  0,  0,  2,  0,  38,  45,  46,  0,  1998
EXEC add_PlayerStatsByName 'James Cotton',  0,  0,  2,  0,  38,  0,  38,  0,  1998
EXEC add_PlayerStatsByName 'James Cotton',  0,  1,  2,  0,  33,  0,  33,  0,  1999
EXEC add_PlayerStatsByName 'Chris Crawford',  0,  1,  3,  0,  41,  33,  42,  0,  1998
EXEC add_PlayerStatsByName 'Chris Crawford',  0,  2,  6,  1,  43,  33,  45,  2,  1999
EXEC add_PlayerStatsByName 'Chris Crawford',  0,  1,  4,  0,  39,  25,  41,  1,  2000
EXEC add_PlayerStatsByName 'Chris Crawford',  0,  2,  6,  1,  45,  27,  46,  2,  2001
EXEC add_PlayerStatsByName 'Chris Crawford',  0,  3,  7,  1,  46,  0,  46,  3,  2002
EXEC add_PlayerStatsByName 'Chris Crawford',  0,  1,  4,  0,  61,  33,  65,  1,  2003
EXEC add_PlayerStatsByName 'Chris Crawford',  0,  3,  10,  1,  44,  38,  49,  2,  2004
EXEC add_PlayerStatsByName 'Austin Croshere',  0,  1,  2,  0,  37,  30,  39,  1,  1998
EXEC add_PlayerStatsByName 'Austin Croshere',  0,  1,  3,  0,  42,  27,  48,  1,  1999
EXEC add_PlayerStatsByName 'Austin Croshere',  1,  6,  10,  1,  44,  36,  48,  2,  2000
EXEC add_PlayerStatsByName 'Austin Croshere',  1,  4,  10,  1,  39,  33,  44,  2,  2001
EXEC add_PlayerStatsByName 'Austin Croshere',  1,  3,  6,  0,  41,  33,  46,  1,  2002
EXEC add_PlayerStatsByName 'Austin Croshere',  1,  3,  5,  0,  41,  39,  47,  1,  2003
EXEC add_PlayerStatsByName 'Austin Croshere',  0,  3,  5,  0,  38,  38,  47,  1,  2004
EXEC add_PlayerStatsByName 'Austin Croshere',  1,  5,  8,  1,  37,  25,  42,  2,  2005
EXEC add_PlayerStatsByName 'Antonio Daniels',  4,  1,  7,  2,  41,  21,  42,  1,  1998
EXEC add_PlayerStatsByName 'Antonio Daniels',  2,  1,  4,  0,  45,  29,  46,  0,  1999
EXEC add_PlayerStatsByName 'Antonio Daniels',  2,  1,  6,  0,  47,  33,  50,  1,  2000
EXEC add_PlayerStatsByName 'Antonio Daniels',  3,  2,  9,  1,  46,  40,  53,  1,  2001
EXEC add_PlayerStatsByName 'Antonio Daniels',  2,  2,  9,  0,  44,  29,  48,  1,  2002
EXEC add_PlayerStatsByName 'Antonio Daniels',  1,  1,  3,  0,  45,  30,  50,  0,  2003
EXEC add_PlayerStatsByName 'Antonio Daniels',  4,  2,  8,  0,  47,  36,  52,  0,  2004
EXEC add_PlayerStatsByName 'Antonio Daniels',  4,  2,  11,  1,  43,  29,  47,  1,  2005
EXEC add_PlayerStatsByName 'Tony Farmer',  0,  1,  2,  0,  32,  22,  34,  0,  1998
EXEC add_PlayerStatsByName 'Tony Farmer',  1,  4,  6,  1,  40,  18,  42,  2,  2000
EXEC add_PlayerStatsByName 'Danny Fortson',  1,  5,  10,  2,  45,  33,  45,  3,  1998
EXEC add_PlayerStatsByName 'Danny Fortson',  0,  11,  11,  1,  49,  0,  49,  4,  1999
EXEC add_PlayerStatsByName 'Danny Fortson',  1,  11,  11,  2,  42,  25,  42,  3,  2002
EXEC add_PlayerStatsByName 'Danny Fortson',  0,  4,  3,  0,  37,  0,  37,  2,  2003
EXEC add_PlayerStatsByName 'Adonal Foyle',  0,  3,  3,  0,  40,  0,  40,  1,  1998
EXEC add_PlayerStatsByName 'Adonal Foyle',  0,  6,  5,  0,  53,  0,  53,  2,  2003
EXEC add_PlayerStatsByName 'Lawrence Funderburke',  1,  4,  9,  1,  49,  14,  49,  1,  1998
EXEC add_PlayerStatsByName 'Lawrence Funderburke',  0,  4,  8,  1,  55,  20,  56,  1,  1999
EXEC add_PlayerStatsByName 'Lawrence Funderburke',  0,  3,  6,  0,  52,  0,  52,  1,  2000
EXEC add_PlayerStatsByName 'Lawrence Funderburke',  0,  3,  4,  0,  46,  0,  46,  1,  2002
EXEC add_PlayerStatsByName 'Chris Garner',  1,  0,  1,  0,  32,  28,  35,  1,  1998
EXEC add_PlayerStatsByName 'Chris Garner',  2,  1,  2,  1,  18,  0,  18,  2,  2001
EXEC add_PlayerStatsByName 'Ed Gray',  1,  1,  7,  1,  38,  39,  42,  2,  1998
EXEC add_PlayerStatsByName 'Ed Gray',  0,  0,  4,  1,  29,  28,  32,  1,  1999
EXEC add_PlayerStatsByName 'Derek Grimm',  0,  0,  1,  0,  28,  33,  42,  0,  1998
EXEC add_PlayerStatsByName 'Jerald Honeycutt',  0,  2,  6,  1,  40,  37,  47,  2,  1998
EXEC add_PlayerStatsByName 'Jerald Honeycutt',  0,  0,  1,  0,  28,  29,  35,  1,  1999
EXEC add_PlayerStatsByName 'Troy Hudson',  0,  0,  1,  0,  42,  0,  42,  0,  1998
EXEC add_PlayerStatsByName 'Troy Hudson',  3,  2,  6,  1,  40,  31,  45,  1,  1999
EXEC add_PlayerStatsByName 'Troy Hudson',  3,  2,  8,  1,  37,  31,  43,  1,  2000
EXEC add_PlayerStatsByName 'Troy Hudson',  2,  1,  4,  1,  33,  20,  36,  1,  2001
EXEC add_PlayerStatsByName 'Troy Hudson',  3,  1,  11,  2,  43,  35,  47,  1,  2002
EXEC add_PlayerStatsByName 'Troy Hudson',  5,  2,  14,  2,  42,  36,  47,  2,  2003
EXEC add_PlayerStatsByName 'Troy Hudson',  2,  1,  7,  1,  38,  40,  46,  1,  2004
EXEC add_PlayerStatsByName 'Troy Hudson',  3,  1,  8,  1,  40,  34,  46,  1,  2005
EXEC add_PlayerStatsByName 'Zydrunas Ilgauskas',  0,  8,  13,  1,  51,  25,  51,  3,  1998
EXEC add_PlayerStatsByName 'Zydrunas Ilgauskas',  0,  6,  11,  2,  48,  0,  48,  3,  2001
EXEC add_PlayerStatsByName 'Zydrunas Ilgauskas',  1,  5,  11,  1,  42,  0,  42,  3,  2002
EXEC add_PlayerStatsByName 'Zydrunas Ilgauskas',  1,  7,  17,  2,  44,  0,  44,  3,  2003
EXEC add_PlayerStatsByName 'Zydrunas Ilgauskas',  1,  8,  15,  2,  48,  28,  48,  3,  2004
EXEC add_PlayerStatsByName 'Zydrunas Ilgauskas',  1,  8,  16,  2,  46,  28,  46,  4,  2005
EXEC add_PlayerStatsByName 'Bobby Jackson',  4,  4,  11,  2,  39,  25,  40,  2,  1998
EXEC add_PlayerStatsByName 'Bobby Jackson',  3,  2,  7,  1,  40,  37,  42,  1,  1999
EXEC add_PlayerStatsByName 'Bobby Jackson',  2,  2,  5,  0,  40,  28,  42,  1,  2000
EXEC add_PlayerStatsByName 'Bobby Jackson',  2,  3,  7,  1,  43,  37,  47,  1,  2001
EXEC add_PlayerStatsByName 'Bobby Jackson',  2,  3,  11,  1,  44,  36,  49,  1,  2002
EXEC add_PlayerStatsByName 'Bobby Jackson',  3,  3,  15,  1,  46,  37,  52,  2,  2003
EXEC add_PlayerStatsByName 'Bobby Jackson',  2,  3,  13,  1,  44,  37,  51,  2,  2004
EXEC add_PlayerStatsByName 'Bobby Jackson',  2,  3,  12,  1,  42,  34,  49,  2,  2005
EXEC add_PlayerStatsByName 'Anthony Johnson',  4,  2,  7,  1,  37,  32,  40,  2,  1998
EXEC add_PlayerStatsByName 'Anthony Johnson',  2,  1,  5,  1,  40,  26,  41,  1,  1999
EXEC add_PlayerStatsByName 'Anthony Johnson',  1,  0,  2,  0,  37,  18,  38,  1,  2000
EXEC add_PlayerStatsByName 'Anthony Johnson',  1,  0,  2,  0,  34,  20,  35,  1,  2001
EXEC add_PlayerStatsByName 'Anthony Johnson',  1,  0,  2,  0,  41,  33,  43,  0,  2002
EXEC add_PlayerStatsByName 'Anthony Johnson',  1,  1,  4,  0,  44,  37,  47,  1,  2003
EXEC add_PlayerStatsByName 'Anthony Johnson',  2,  1,  6,  1,  40,  33,  45,  1,  2004
EXEC add_PlayerStatsByName 'Anthony Johnson',  4,  2,  8,  1,  44,  38,  49,  2,  2005
EXEC add_PlayerStatsByName 'Dontae" Jones',  0,  0,  2,  0,  33,  26,  38,  0,  1998
EXEC add_PlayerStatsByName 'Brevin Knight',  8,  3,  9,  2,  44,  0,  44,  3,  1998
EXEC add_PlayerStatsByName 'Brevin Knight',  7,  3,  9,  2,  42,  0,  42,  2,  1999
EXEC add_PlayerStatsByName 'Brevin Knight',  7,  3,  9,  2,  41,  20,  41,  2,  2000
EXEC add_PlayerStatsByName 'Brevin Knight',  5,  3,  6,  1,  37,  10,  37,  2,  2001
EXEC add_PlayerStatsByName 'Brevin Knight',  5,  2,  7,  2,  42,  25,  42,  2,  2002
EXEC add_PlayerStatsByName 'Brevin Knight',  4,  1,  3,  1,  42,  25,  43,  2,  2003
EXEC add_PlayerStatsByName 'Brevin Knight',  3,  2,  4,  1,  42,  25,  43,  1,  2004
EXEC add_PlayerStatsByName 'Brevin Knight',  9,  2,  10,  2,  42,  15,  42,  2,  2005
EXEC add_PlayerStatsByName 'Rusty LaRue',  0,  0,  3,  0,  40,  25,  44,  0,  1998
EXEC add_PlayerStatsByName 'Rusty LaRue',  1,  1,  4,  0,  35,  33,  42,  1,  1999
EXEC add_PlayerStatsByName 'Rusty LaRue',  2,  2,  9,  1,  34,  14,  37,  2,  2000
EXEC add_PlayerStatsByName 'Rusty LaRue',  2,  1,  5,  1,  39,  34,  44,  1,  2002
EXEC add_PlayerStatsByName 'Rusty LaRue',  0,  0,  1,  1,  33,  100,  50,  0,  2004
EXEC add_PlayerStatsByName 'Ron Mercer',  2,  3,  15,  1,  45,  10,  45,  2,  1998
EXEC add_PlayerStatsByName 'Ron Mercer',  2,  3,  17,  2,  43,  16,  43,  2,  1999
EXEC add_PlayerStatsByName 'Ron Mercer',  2,  3,  16,  2,  42,  31,  43,  2,  2000
EXEC add_PlayerStatsByName 'Ron Mercer',  3,  3,  19,  2,  44,  30,  45,  2,  2001
EXEC add_PlayerStatsByName 'Ron Mercer',  2,  3,  13,  1,  39,  28,  40,  2,  2002
EXEC add_PlayerStatsByName 'Ron Mercer',  1,  2,  7,  0,  40,  18,  41,  1,  2003
EXEC add_PlayerStatsByName 'Ron Mercer',  0,  1,  5,  0,  42,  28,  43,  0,  2004
EXEC add_PlayerStatsByName 'Marko Milic',  0,  0,  2,  0,  60,  50,  63,  0,  1998
EXEC add_PlayerStatsByName 'Marko Milic',  0,  0,  1,  0,  40,  0,  40,  0,  1999
EXEC add_PlayerStatsByName 'Charles O"Bannon',  0,  1,  2,  0,  37,  0,  37,  0,  1998
EXEC add_PlayerStatsByName 'Charles O"Bannon',  0,  1,  3,  0,  42,  0,  42,  1,  1999
EXEC add_PlayerStatsByName 'Kevin Ollie',  1,  1,  3,  1,  37,  0,  37,  0,  1998
EXEC add_PlayerStatsByName 'Kevin Ollie',  2,  1,  3,  0,  39,  33,  39,  1,  2001
EXEC add_PlayerStatsByName 'Kevin Ollie',  3,  2,  5,  1,  38,  50,  39,  1,  2002
EXEC add_PlayerStatsByName 'Kevin Ollie',  3,  2,  6,  0,  45,  33,  45,  1,  2003
EXEC add_PlayerStatsByName 'Kevin Ollie',  2,  2,  4,  1,  37,  44,  37,  1,  2004
EXEC add_PlayerStatsByName 'Anthony Parker',  0,  0,  1,  0,  39,  32,  46,  0,  1998
EXEC add_PlayerStatsByName 'Anthony Parker',  0,  1,  3,  0,  42,  7,  43,  0,  2000
EXEC add_PlayerStatsByName 'Scot Pollard',  0,  6,  6,  0,  46,  0,  46,  2,  2001
EXEC add_PlayerStatsByName 'Mark Pope',  0,  0,  1,  0,  34,  33,  35,  1,  1998
EXEC add_PlayerStatsByName 'Mark Pope',  0,  1,  0,  0,  14,  0,  14,  1,  1999
EXEC add_PlayerStatsByName 'Mark Pope',  0,  2,  2,  0,  43,  20,  45,  2,  2001
EXEC add_PlayerStatsByName 'Mark Pope',  0,  1,  1,  0,  39,  16,  41,  1,  2002
EXEC add_PlayerStatsByName 'Rodrick Rhodes',  1,  1,  5,  1,  36,  25,  37,  2,  1998
EXEC add_PlayerStatsByName 'Rodrick Rhodes',  0,  1,  3,  1,  25,  14,  26,  1,  1999
EXEC add_PlayerStatsByName 'Shea Seals',  0,  1,  1,  0,  12,  0,  12,  0,  1998
EXEC add_PlayerStatsByName 'God Shammgod',  1,  0,  3,  1,  32,  0,  32,  1,  1998
EXEC add_PlayerStatsByName 'Johnny Taylor',  0,  1,  3,  0,  35,  50,  36,  1,  1998
EXEC add_PlayerStatsByName 'Johnny Taylor',  0,  2,  5,  0,  41,  38,  48,  2,  1999
EXEC add_PlayerStatsByName 'Johnny Taylor',  0,  1,  1,  0,  35,  100,  39,  0,  2000
EXEC add_PlayerStatsByName 'Maurice Taylor',  0,  4,  11,  1,  47,  0,  47,  3,  1998
EXEC add_PlayerStatsByName 'Maurice Taylor',  1,  5,  16,  2,  46,  16,  46,  3,  1999
EXEC add_PlayerStatsByName 'Maurice Taylor',  1,  6,  17,  2,  46,  12,  46,  3,  2000
EXEC add_PlayerStatsByName 'Maurice Taylor',  1,  5,  13,  1,  48,  0,  48,  3,  2001
EXEC add_PlayerStatsByName 'Maurice Taylor',  1,  3,  8,  1,  43,  0,  43,  2,  2003
EXEC add_PlayerStatsByName 'Maurice Taylor',  1,  5,  11,  2,  48,  0,  48,  3,  2004
EXEC add_PlayerStatsByName 'John Thomas',  0,  3,  4,  0,  57,  0,  57,  2,  1999
EXEC add_PlayerStatsByName 'John Thomas',  0,  1,  2,  0,  45,  0,  45,  1,  2000
EXEC add_PlayerStatsByName 'Tim Thomas',  1,  3,  11,  1,  44,  36,  49,  2,  1998
EXEC add_PlayerStatsByName 'Tim Thomas',  0,  2,  7,  0,  47,  30,  51,  2,  1999
EXEC add_PlayerStatsByName 'Tim Thomas',  1,  4,  11,  1,  46,  34,  50,  2,  2000
EXEC add_PlayerStatsByName 'Tim Thomas',  1,  4,  12,  1,  43,  41,  50,  2,  2001
EXEC add_PlayerStatsByName 'Tim Thomas',  1,  4,  11,  1,  42,  32,  48,  2,  2002
EXEC add_PlayerStatsByName 'Tim Thomas',  1,  4,  13,  1,  44,  36,  49,  3,  2003
EXEC add_PlayerStatsByName 'Tim Thomas',  1,  4,  14,  1,  44,  37,  49,  3,  2004
EXEC add_PlayerStatsByName 'Jacque Vaughn',  1,  0,  3,  1,  36,  37,  37,  1,  1998
EXEC add_PlayerStatsByName 'Jacque Vaughn',  0,  0,  2,  0,  36,  25,  40,  0,  1999
EXEC add_PlayerStatsByName 'Jacque Vaughn',  1,  0,  3,  1,  41,  41,  44,  1,  2000
EXEC add_PlayerStatsByName 'Jacque Vaughn',  3,  1,  6,  1,  43,  38,  47,  1,  2001
EXEC add_PlayerStatsByName 'Jacque Vaughn',  4,  2,  6,  1,  47,  44,  49,  2,  2002
EXEC add_PlayerStatsByName 'Jacque Vaughn',  2,  1,  5,  1,  44,  23,  45,  2,  2003
EXEC add_PlayerStatsByName 'Jacque Vaughn',  2,  1,  3,  1,  38,  15,  39,  1,  2004
EXEC add_PlayerStatsByName 'Eric Washington',  1,  1,  7,  1,  40,  32,  44,  2,  1998
EXEC add_PlayerStatsByName 'Eric Washington',  0,  2,  5,  0,  39,  38,  49,  2,  1999
EXEC add_PlayerStatsByName 'Bubba Wells',  0,  1,  3,  0,  41,  16,  41,  1,  1998
EXEC add_PlayerStatsByName 'DeJuan Wheat',  0,  0,  1,  0,  40,  47,  48,  0,  1998
EXEC add_PlayerStatsByName 'DeJuan Wheat',  2,  1,  4,  1,  37,  36,  43,  1,  1999
EXEC add_PlayerStatsByName 'Alvin Williams',  1,  1,  6,  1,  44,  32,  45,  1,  1998
EXEC add_PlayerStatsByName 'Alvin Williams',  2,  1,  5,  1,  40,  33,  43,  1,  1999
EXEC add_PlayerStatsByName 'Alvin Williams',  2,  1,  5,  0,  39,  29,  42,  1,  2000
EXEC add_PlayerStatsByName 'Alvin Williams',  5,  2,  9,  1,  43,  30,  45,  2,  2001
EXEC add_PlayerStatsByName 'Alvin Williams',  5,  3,  11,  1,  41,  32,  44,  2,  2002
EXEC add_PlayerStatsByName 'Alvin Williams',  5,  3,  13,  1,  43,  32,  46,  2,  2003
EXEC add_PlayerStatsByName 'Alvin Williams',  4,  2,  8,  1,  40,  29,  43,  2,  2004
EXEC add_PlayerStatsByName 'Brandon Williams',  0,  1,  4,  1,  32,  33,  35,  2,  1998
EXEC add_PlayerStatsByName 'Brandon Williams',  0,  0,  0,  0,  14,  0,  14,  0,  2003
EXEC add_PlayerStatsByName 'Travis Williams',  0,  2,  3,  0,  47,  0,  47,  1,  1998
EXEC add_PlayerStatsByName 'Toby Bailey',  0,  1,  3,  0,  41,  20,  42,  1,  2000
EXEC add_PlayerStatsByName 'Corey Benjamin',  1,  3,  4,  0,  30,  15,  32,  2,  2003
EXEC add_PlayerStatsByName 'Mike Bibby',  6,  2,  13,  2,  43,  20,  44,  2,  1999
EXEC add_PlayerStatsByName 'Mike Bibby',  8,  3,  14,  3,  44,  36,  48,  2,  2000
EXEC add_PlayerStatsByName 'Mike Bibby',  8,  3,  15,  3,  45,  37,  50,  1,  2001
EXEC add_PlayerStatsByName 'Mike Bibby',  5,  2,  13,  1,  45,  37,  47,  1,  2002
EXEC add_PlayerStatsByName 'Mike Bibby',  5,  2,  15,  2,  47,  40,  51,  1,  2003
EXEC add_PlayerStatsByName 'Mike Bibby',  5,  3,  18,  2,  45,  39,  51,  1,  2004
EXEC add_PlayerStatsByName 'Mike Bibby',  6,  4,  19,  2,  44,  36,  49,  2,  2005
EXEC add_PlayerStatsByName 'Earl Boykins',  1,  0,  3,  0,  38,  16,  39,  0,  1999
EXEC add_PlayerStatsByName 'Earl Boykins',  1,  1,  5,  0,  48,  40,  51,  0,  2000
EXEC add_PlayerStatsByName 'Earl Boykins',  3,  1,  6,  0,  39,  12,  40,  0,  2001
EXEC add_PlayerStatsByName 'Earl Boykins',  2,  0,  4,  0,  40,  31,  42,  0,  2002
EXEC add_PlayerStatsByName 'Earl Boykins',  3,  1,  8,  1,  42,  37,  46,  1,  2003
EXEC add_PlayerStatsByName 'Earl Boykins',  3,  1,  10,  1,  41,  32,  45,  1,  2004
EXEC add_PlayerStatsByName 'Earl Boykins',  4,  1,  12,  1,  41,  33,  44,  1,  2005
EXEC add_PlayerStatsByName 'Gerald Brown',  0,  0,  2,  0,  37,  30,  38,  0,  1999
EXEC add_PlayerStatsByName 'Cory Carr',  1,  1,  4,  1,  32,  16,  34,  1,  1999
EXEC add_PlayerStatsByName 'Vince Carter',  3,  5,  18,  2,  45,  28,  46,  2,  1999
EXEC add_PlayerStatsByName 'Vince Carter',  3,  5,  25,  2,  46,  40,  49,  3,  2000
EXEC add_PlayerStatsByName 'Vince Carter',  3,  5,  27,  2,  46,  40,  50,  2,  2001
EXEC add_PlayerStatsByName 'Vince Carter',  4,  5,  24,  2,  42,  38,  47,  3,  2002
EXEC add_PlayerStatsByName 'Vince Carter',  3,  4,  20,  1,  46,  34,  49,  2,  2003
EXEC add_PlayerStatsByName 'Vince Carter',  4,  4,  22,  3,  41,  38,  44,  2,  2004
EXEC add_PlayerStatsByName 'Vince Carter',  4,  5,  24,  2,  45,  40,  49,  3,  2005
EXEC add_PlayerStatsByName 'Keon Clark',  0,  3,  3,  0,  45,  0,  45,  1,  1999
EXEC add_PlayerStatsByName 'Keon Clark',  0,  6,  8,  1,  54,  12,  54,  2,  2000
EXEC add_PlayerStatsByName 'Keon Clark',  0,  5,  7,  1,  48,  0,  48,  3,  2001
EXEC add_PlayerStatsByName 'Keon Clark',  1,  7,  11,  1,  49,  0,  49,  3,  2002
EXEC add_PlayerStatsByName 'Keon Clark',  1,  5,  6,  1,  50,  0,  50,  2,  2003
EXEC add_PlayerStatsByName 'Ricky Davis',  1,  1,  4,  1,  40,  16,  41,  1,  1999
EXEC add_PlayerStatsByName 'Ricky Davis',  1,  1,  4,  1,  50,  0,  50,  0,  2000
EXEC add_PlayerStatsByName 'Ricky Davis',  1,  1,  4,  0,  41,  100,  43,  1,  2001
EXEC add_PlayerStatsByName 'Ricky Davis',  2,  3,  11,  1,  48,  31,  48,  1,  2002
EXEC add_PlayerStatsByName 'Ricky Davis',  5,  4,  20,  3,  41,  36,  43,  2,  2003
EXEC add_PlayerStatsByName 'Ricky Davis',  3,  4,  14,  2,  46,  37,  49,  2,  2004
EXEC add_PlayerStatsByName 'Ricky Davis',  3,  3,  16,  2,  46,  33,  49,  2,  2005
EXEC add_PlayerStatsByName 'Michael Dickerson',  1,  1,  10,  1,  46,  43,  54,  1,  1999
EXEC add_PlayerStatsByName 'Michael Dickerson',  2,  3,  18,  2,  43,  40,  48,  2,  2000
EXEC add_PlayerStatsByName 'Michael Dickerson',  3,  3,  16,  2,  41,  37,  45,  3,  2001
EXEC add_PlayerStatsByName 'Michael Dickerson',  2,  3,  10,  2,  31,  38,  39,  3,  2002
EXEC add_PlayerStatsByName 'Michael Dickerson',  1,  1,  4,  1,  41,  36,  50,  2,  2003
EXEC add_PlayerStatsByName 'Michael Doleac',  0,  4,  7,  0,  45,  50,  45,  2,  2000
EXEC add_PlayerStatsByName 'Michael Doleac',  0,  3,  6,  0,  41,  0,  41,  3,  2001
EXEC add_PlayerStatsByName 'Michael Doleac',  0,  3,  4,  0,  44,  0,  44,  2,  2005
EXEC add_PlayerStatsByName 'Bryce Drew',  1,  0,  3,  0,  36,  32,  42,  1,  1999
EXEC add_PlayerStatsByName 'Bryce Drew',  2,  1,  5,  0,  38,  36,  45,  1,  2000
EXEC add_PlayerStatsByName 'Bryce Drew',  3,  1,  6,  1,  37,  38,  44,  2,  2001
EXEC add_PlayerStatsByName 'Bryce Drew',  1,  1,  3,  0,  42,  42,  51,  0,  2002
EXEC add_PlayerStatsByName 'Bryce Drew',  0,  1,  1,  0,  29,  42,  35,  0,  2003
EXEC add_PlayerStatsByName 'Bryce Drew',  0,  0,  0,  0,  22,  14,  25,  0,  2004
EXEC add_PlayerStatsByName 'Marlon Garnett',  0,  0,  2,  0,  29,  26,  35,  0,  1999
EXEC add_PlayerStatsByName 'Pat Garrity',  0,  1,  5,  0,  50,  38,  52,  1,  1999
EXEC add_PlayerStatsByName 'Pat Garrity',  0,  2,  8,  1,  44,  40,  50,  2,  2000
EXEC add_PlayerStatsByName 'Pat Garrity',  0,  2,  8,  0,  38,  43,  47,  3,  2001
EXEC add_PlayerStatsByName 'Pat Garrity',  1,  4,  11,  0,  42,  42,  53,  2,  2002
EXEC add_PlayerStatsByName 'Pat Garrity',  1,  3,  10,  1,  41,  39,  52,  3,  2003
EXEC add_PlayerStatsByName 'Pat Garrity',  0,  1,  4,  0,  40,  33,  48,  1,  2005
EXEC add_PlayerStatsByName 'Matt Harpring',  0,  4,  8,  1,  46,  40,  47,  2,  1999
EXEC add_PlayerStatsByName 'Matt Harpring',  2,  3,  4,  0,  23,  100,  29,  1,  2000
EXEC add_PlayerStatsByName 'Matt Harpring',  1,  4,  11,  1,  45,  25,  46,  2,  2001
EXEC add_PlayerStatsByName 'Matt Harpring',  1,  7,  11,  1,  46,  30,  47,  2,  2002
EXEC add_PlayerStatsByName 'Matt Harpring',  1,  6,  17,  2,  51,  41,  54,  2,  2003
EXEC add_PlayerStatsByName 'Matt Harpring',  2,  8,  16,  2,  47,  24,  48,  3,  2004
EXEC add_PlayerStatsByName 'Matt Harpring',  1,  6,  14,  1,  48,  20,  49,  3,  2005
EXEC add_PlayerStatsByName 'Al Harrington',  0,  1,  2,  0,  32,  0,  32,  1,  1999
EXEC add_PlayerStatsByName 'Al Harrington',  0,  3,  6,  1,  45,  23,  47,  2,  2000
EXEC add_PlayerStatsByName 'Al Harrington',  1,  4,  7,  1,  44,  14,  44,  2,  2001
EXEC add_PlayerStatsByName 'Al Harrington',  1,  6,  13,  1,  47,  33,  47,  3,  2002
EXEC add_PlayerStatsByName 'Al Harrington',  1,  6,  12,  2,  43,  28,  44,  3,  2003
EXEC add_PlayerStatsByName 'Al Harrington',  1,  6,  13,  2,  46,  27,  47,  3,  2004
EXEC add_PlayerStatsByName 'Al Harrington',  3,  7,  17,  3,  45,  21,  46,  3,  2005
EXEC add_PlayerStatsByName 'J.R. Henderson',  0,  1,  3,  0,  36,  40,  37,  1,  1999
EXEC add_PlayerStatsByName 'Larry Hughes',  1,  3,  9,  1,  41,  15,  42,  1,  1999
EXEC add_PlayerStatsByName 'Larry Hughes',  2,  4,  15,  2,  40,  23,  41,  2,  2000
EXEC add_PlayerStatsByName 'Larry Hughes',  4,  5,  16,  3,  38,  18,  39,  2,  2001
EXEC add_PlayerStatsByName 'Larry Hughes',  4,  3,  12,  2,  42,  19,  43,  2,  2002
EXEC add_PlayerStatsByName 'Larry Hughes',  3,  4,  12,  2,  46,  36,  48,  2,  2003
EXEC add_PlayerStatsByName 'Larry Hughes',  2,  5,  18,  2,  39,  34,  43,  2,  2004
EXEC add_PlayerStatsByName 'Larry Hughes',  4,  6,  22,  2,  43,  28,  45,  2,  2005
EXEC add_PlayerStatsByName 'Randell Jackson',  0,  2,  4,  1,  42,  14,  43,  1,  1999
EXEC add_PlayerStatsByName 'Sam Jacobson',  0,  1,  4,  0,  60,  0,  60,  1,  1999
EXEC add_PlayerStatsByName 'Sam Jacobson',  0,  1,  4,  0,  50,  37,  53,  2,  2000
EXEC add_PlayerStatsByName 'Jerome James',  0,  3,  4,  1,  50,  0,  50,  3,  2005
EXEC add_PlayerStatsByName 'Antawn Jamison',  0,  6,  9,  1,  45,  30,  45,  2,  1999
EXEC add_PlayerStatsByName 'Antawn Jamison',  2,  8,  19,  2,  47,  28,  47,  2,  2000
EXEC add_PlayerStatsByName 'Antawn Jamison',  2,  8,  24,  2,  44,  30,  45,  2,  2001
EXEC add_PlayerStatsByName 'Antawn Jamison',  2,  6,  19,  2,  44,  32,  47,  2,  2002
EXEC add_PlayerStatsByName 'Antawn Jamison',  1,  7,  22,  2,  47,  31,  49,  2,  2003
EXEC add_PlayerStatsByName 'Antawn Jamison',  0,  6,  14,  1,  53,  40,  54,  2,  2004
EXEC add_PlayerStatsByName 'Antawn Jamison',  2,  7,  19,  1,  43,  34,  46,  2,  2005
EXEC add_PlayerStatsByName 'Damon Jones',  1,  1,  5,  0,  36,  40,  46,  1,  1999
EXEC add_PlayerStatsByName 'Damon Jones',  1,  1,  4,  0,  38,  36,  48,  0,  2000
EXEC add_PlayerStatsByName 'Damon Jones',  3,  1,  6,  1,  40,  36,  51,  0,  2001
EXEC add_PlayerStatsByName 'Damon Jones',  2,  1,  5,  0,  40,  37,  52,  1,  2002
EXEC add_PlayerStatsByName 'Damon Jones',  1,  1,  4,  0,  38,  36,  48,  0,  2003
EXEC add_PlayerStatsByName 'Damon Jones',  5,  2,  7,  1,  40,  35,  49,  1,  2004
EXEC add_PlayerStatsByName 'Damon Jones',  4,  2,  11,  1,  45,  43,  61,  1,  2005
EXEC add_PlayerStatsByName 'Raef LaFrentz',  0,  7,  13,  0,  45,  38,  50,  3,  1999
EXEC add_PlayerStatsByName 'Raef LaFrentz',  1,  7,  12,  1,  44,  32,  48,  3,  2000
EXEC add_PlayerStatsByName 'Raef LaFrentz',  1,  7,  12,  1,  47,  36,  50,  3,  2001
EXEC add_PlayerStatsByName 'Raef LaFrentz',  1,  7,  13,  1,  45,  38,  51,  3,  2002
EXEC add_PlayerStatsByName 'Raef LaFrentz',  0,  4,  9,  0,  51,  40,  56,  3,  2003
EXEC add_PlayerStatsByName 'Raef LaFrentz',  1,  4,  7,  0,  46,  20,  49,  2,  2004
EXEC add_PlayerStatsByName 'Raef LaFrentz',  1,  6,  11,  0,  49,  36,  55,  3,  2005
EXEC add_PlayerStatsByName 'Rashard Lewis',  0,  1,  2,  1,  36,  16,  37,  1,  1999
EXEC add_PlayerStatsByName 'Rashard Lewis',  0,  4,  8,  1,  48,  33,  52,  2,  2000
EXEC add_PlayerStatsByName 'Rashard Lewis',  1,  6,  14,  1,  48,  43,  55,  2,  2001
EXEC add_PlayerStatsByName 'Rashard Lewis',  1,  7,  16,  1,  46,  38,  53,  2,  2002
EXEC add_PlayerStatsByName 'Rashard Lewis',  1,  6,  18,  1,  45,  34,  48,  2,  2003
EXEC add_PlayerStatsByName 'Rashard Lewis',  2,  6,  17,  1,  43,  37,  49,  2,  2004
EXEC add_PlayerStatsByName 'Rashard Lewis',  1,  5,  20,  1,  46,  40,  53,  2,  2005
EXEC add_PlayerStatsByName 'Tyronn Lue',  1,  0,  5,  0,  43,  43,  48,  1,  1999
EXEC add_PlayerStatsByName 'Tyronn Lue',  2,  1,  6,  1,  48,  50,  53,  2,  2000
EXEC add_PlayerStatsByName 'Tyronn Lue',  1,  0,  3,  0,  42,  32,  47,  1,  2001
EXEC add_PlayerStatsByName 'Tyronn Lue',  3,  1,  7,  1,  42,  44,  48,  1,  2002
EXEC add_PlayerStatsByName 'Tyronn Lue',  3,  2,  8,  1,  43,  34,  48,  2,  2003
EXEC add_PlayerStatsByName 'Tyronn Lue',  4,  2,  10,  1,  43,  38,  48,  2,  2004
EXEC add_PlayerStatsByName 'Tyronn Lue',  4,  2,  11,  1,  45,  35,  49,  2,  2005
EXEC add_PlayerStatsByName 'Sean Marks',  0,  0,  1,  0,  33,  0,  33,  0,  2000
EXEC add_PlayerStatsByName 'Sean Marks',  0,  1,  2,  0,  37,  0,  37,  1,  2003
EXEC add_PlayerStatsByName 'Sean Marks',  0,  2,  3,  0,  33,  0,  33,  1,  2005
EXEC add_PlayerStatsByName 'Roshown McLeod',  0,  1,  4,  0,  38,  10,  38,  0,  1999
EXEC add_PlayerStatsByName 'Roshown McLeod',  1,  3,  7,  1,  39,  15,  39,  1,  2000
EXEC add_PlayerStatsByName 'Roshown McLeod',  1,  3,  9,  1,  43,  9,  44,  2,  2001
EXEC add_PlayerStatsByName 'Brad Miller',  0,  3,  6,  0,  56,  50,  56,  1,  1999
EXEC add_PlayerStatsByName 'Brad Miller',  0,  5,  7,  0,  46,  0,  46,  2,  2000
EXEC add_PlayerStatsByName 'Brad Miller',  1,  7,  8,  1,  43,  20,  43,  3,  2001
EXEC add_PlayerStatsByName 'Brad Miller',  2,  8,  13,  1,  49,  42,  50,  3,  2002
EXEC add_PlayerStatsByName 'Brad Miller',  2,  8,  13,  1,  49,  31,  49,  2,  2003
EXEC add_PlayerStatsByName 'Brad Miller',  4,  10,  14,  2,  51,  31,  51,  3,  2004
EXEC add_PlayerStatsByName 'Cuttino Mobley',  2,  2,  9,  1,  42,  35,  49,  2,  1999
EXEC add_PlayerStatsByName 'Cuttino Mobley',  2,  3,  15,  2,  43,  35,  48,  2,  2000
EXEC add_PlayerStatsByName 'Cuttino Mobley',  2,  5,  19,  2,  43,  35,  47,  2,  2001
EXEC add_PlayerStatsByName 'Cuttino Mobley',  2,  4,  21,  2,  43,  39,  49,  2,  2002
EXEC add_PlayerStatsByName 'Cuttino Mobley',  2,  4,  17,  2,  43,  35,  48,  2,  2003
EXEC add_PlayerStatsByName 'Cuttino Mobley',  3,  4,  15,  2,  42,  39,  50,  2,  2004
EXEC add_PlayerStatsByName 'Nazr Mohammed',  0,  5,  7,  1,  47,  0,  47,  1,  2001
EXEC add_PlayerStatsByName 'Nazr Mohammed',  0,  7,  9,  1,  46,  0,  46,  3,  2002
EXEC add_PlayerStatsByName 'Mikki Moore',  0,  3,  4,  0,  49,  0,  49,  2,  2001
EXEC add_PlayerStatsByName 'Mikki Moore',  0,  1,  2,  0,  47,  50,  48,  1,  2002
EXEC add_PlayerStatsByName 'Tyrone Nesby',  1,  3,  10,  1,  44,  36,  49,  2,  1999
EXEC add_PlayerStatsByName 'Tyrone Nesby',  1,  3,  13,  1,  39,  33,  44,  2,  2000
EXEC add_PlayerStatsByName 'Tyrone Nesby',  1,  2,  8,  1,  35,  27,  40,  2,  2001
EXEC add_PlayerStatsByName 'Tyrone Nesby',  1,  4,  6,  0,  43,  27,  45,  2,  2002
EXEC add_PlayerStatsByName 'Rasho Nesterovic',  1,  4,  5,  0,  47,  0,  47,  3,  2000
EXEC add_PlayerStatsByName 'Rasho Nesterovic',  0,  3,  4,  0,  46,  0,  46,  2,  2001
EXEC add_PlayerStatsByName 'Rasho Nesterovic',  0,  6,  8,  1,  49,  0,  49,  3,  2002
EXEC add_PlayerStatsByName 'Rasho Nesterovic',  1,  6,  11,  1,  52,  0,  52,  3,  2003
EXEC add_PlayerStatsByName 'Dirk Nowitzki',  1,  3,  8,  1,  40,  20,  42,  2,  1999
EXEC add_PlayerStatsByName 'Dirk Nowitzki',  2,  6,  17,  1,  46,  37,  51,  3,  2000
EXEC add_PlayerStatsByName 'Dirk Nowitzki',  2,  9,  21,  1,  47,  38,  53,  3,  2001
EXEC add_PlayerStatsByName 'Dirk Nowitzki',  2,  9,  23,  1,  47,  39,  53,  2,  2002
EXEC add_PlayerStatsByName 'Dirk Nowitzki',  3,  9,  25,  1,  46,  37,  51,  2,  2003
EXEC add_PlayerStatsByName 'Dirk Nowitzki',  2,  8,  21,  1,  46,  34,  50,  2,  2004
EXEC add_PlayerStatsByName 'Andrae Patterson',  0,  1,  3,  0,  44,  0,  44,  1,  1999
EXEC add_PlayerStatsByName 'Ruben Patterson',  0,  1,  2,  0,  41,  16,  42,  0,  1999
EXEC add_PlayerStatsByName 'Ruben Patterson',  1,  5,  11,  1,  53,  44,  54,  2,  2000
EXEC add_PlayerStatsByName 'Ruben Patterson',  2,  5,  13,  2,  49,  5,  49,  2,  2001
EXEC add_PlayerStatsByName 'Ruben Patterson',  1,  4,  11,  1,  51,  25,  52,  1,  2002
EXEC add_PlayerStatsByName 'Ruben Patterson',  1,  3,  8,  1,  49,  15,  49,  2,  2003
EXEC add_PlayerStatsByName 'Ruben Patterson',  1,  3,  6,  1,  50,  16,  50,  2,  2004
EXEC add_PlayerStatsByName 'Miles Simon',  0,  0,  0,  0,  20,  0,  20,  0,  1999
EXEC add_PlayerStatsByName 'Alvin Sims',  1,  1,  2,  1,  40,  100,  45,  0,  1999
EXEC add_PlayerStatsByName 'Ryan Stack',  0,  1,  2,  0,  33,  0,  33,  1,  2000
EXEC add_PlayerStatsByName 'Vladimir Stepania',  0,  3,  5,  1,  42,  0,  42,  2,  1999
EXEC add_PlayerStatsByName 'Vladimir Stepania',  0,  1,  2,  0,  36,  0,  36,  1,  2000
EXEC add_PlayerStatsByName 'Vladimir Stepania',  0,  3,  2,  0,  31,  25,  32,  1,  2001
EXEC add_PlayerStatsByName 'Vladimir Stepania',  0,  4,  4,  0,  47,  50,  47,  1,  2002
EXEC add_PlayerStatsByName 'Peja Stojakovic',  1,  3,  8,  1,  37,  32,  45,  0,  1999
EXEC add_PlayerStatsByName 'Peja Stojakovic',  1,  3,  11,  1,  44,  37,  51,  1,  2000
EXEC add_PlayerStatsByName 'Peja Stojakovic',  2,  5,  20,  1,  47,  40,  53,  1,  2001
EXEC add_PlayerStatsByName 'Peja Stojakovic',  2,  5,  21,  2,  48,  41,  54,  1,  2002
EXEC add_PlayerStatsByName 'Peja Stojakovic',  2,  5,  19,  1,  48,  38,  55,  2,  2003
EXEC add_PlayerStatsByName 'Peja Stojakovic',  2,  6,  24,  1,  48,  43,  56,  2,  2004
EXEC add_PlayerStatsByName 'Robert Traylor',  0,  3,  5,  0,  53,  0,  53,  2,  1999
EXEC add_PlayerStatsByName 'Robert Traylor',  0,  2,  3,  0,  47,  0,  47,  1,  2000
EXEC add_PlayerStatsByName 'Robert Traylor',  0,  4,  5,  1,  49,  0,  49,  2,  2001
EXEC add_PlayerStatsByName 'Robert Traylor',  0,  3,  3,  0,  42,  100,  42,  2,  2002
EXEC add_PlayerStatsByName 'Robert Traylor',  0,  3,  3,  0,  44,  33,  44,  2,  2003
EXEC add_PlayerStatsByName 'Robert Traylor',  0,  3,  5,  0,  50,  40,  50,  2,  2004
EXEC add_PlayerStatsByName 'Bonzi Wells',  0,  1,  4,  0,  55,  33,  57,  0,  1999
EXEC add_PlayerStatsByName 'Bonzi Wells',  1,  2,  8,  1,  49,  37,  51,  2,  2000
EXEC add_PlayerStatsByName 'Bonzi Wells',  2,  4,  12,  2,  53,  34,  54,  2,  2001
EXEC add_PlayerStatsByName 'Bonzi Wells',  2,  6,  17,  2,  46,  38,  50,  2,  2002
EXEC add_PlayerStatsByName 'Bonzi Wells',  3,  5,  15,  2,  44,  29,  46,  2,  2003
EXEC add_PlayerStatsByName 'Bonzi Wells',  1,  3,  12,  2,  42,  31,  44,  2,  2004
EXEC add_PlayerStatsByName 'Jahidi White',  0,  7,  8,  2,  49,  0,  49,  3,  2001
EXEC add_PlayerStatsByName 'Jason Williams',  6,  3,  12,  2,  37,  31,  45,  1,  1999
EXEC add_PlayerStatsByName 'Jason Williams',  7,  2,  12,  3,  37,  28,  44,  1,  2000
EXEC add_PlayerStatsByName 'Jason Williams',  5,  2,  9,  2,  40,  31,  47,  1,  2001
EXEC add_PlayerStatsByName 'Jason Williams',  8,  3,  14,  3,  38,  29,  44,  1,  2002
EXEC add_PlayerStatsByName 'Jason Williams',  8,  2,  12,  2,  38,  35,  47,  1,  2003
EXEC add_PlayerStatsByName 'Jason Williams',  6,  2,  10,  1,  40,  33,  49,  1,  2004
EXEC add_PlayerStatsByName 'Shammond Williams',  1,  1,  5,  0,  37,  29,  42,  0,  2000
EXEC add_PlayerStatsByName 'Shammond Williams',  2,  1,  6,  1,  43,  45,  52,  1,  2001
EXEC add_PlayerStatsByName 'Shammond Williams',  1,  1,  4,  0,  42,  37,  49,  0,  2002
EXEC add_PlayerStatsByName 'Shammond Williams',  3,  2,  8,  1,  39,  35,  47,  1,  2003
EXEC add_PlayerStatsByName 'Shammond Williams',  2,  1,  4,  0,  37,  30,  44,  1,  2004
EXEC add_PlayerStatsByName 'Korleone Young',  0,  1,  4,  0,  50,  25,  55,  1,  1999
EXEC add_PlayerStatsByName 'Rafer Alston',  2,  0,  2,  1,  28,  21,  30,  1,  2000
EXEC add_PlayerStatsByName 'Rafer Alston',  1,  0,  2,  0,  35,  26,  40,  0,  2001
EXEC add_PlayerStatsByName 'Rafer Alston',  2,  1,  3,  0,  34,  38,  41,  0,  2002
EXEC add_PlayerStatsByName 'Rafer Alston',  4,  2,  7,  1,  41,  39,  49,  2,  2003
EXEC add_PlayerStatsByName 'Rafer Alston',  4,  2,  10,  1,  37,  37,  48,  2,  2004
EXEC add_PlayerStatsByName 'Rafer Alston',  6,  3,  14,  2,  41,  35,  48,  2,  2005
EXEC add_PlayerStatsByName 'Chucky Atkins',  3,  1,  9,  1,  42,  35,  46,  1,  2000
EXEC add_PlayerStatsByName 'Chucky Atkins',  4,  2,  12,  1,  39,  35,  46,  2,  2001
EXEC add_PlayerStatsByName 'Chucky Atkins',  3,  1,  8,  1,  39,  33,  48,  1,  2004
EXEC add_PlayerStatsByName 'William Avery',  1,  0,  2,  0,  38,  27,  43,  0,  2001
EXEC add_PlayerStatsByName 'William Avery',  5,  5,  5,  5,  5,  5,  5,  14,  2002
EXEC add_PlayerStatsByName 'Jonathan Bender',  0,  0,  2,  0,  32,  16,  34,  0,  2000
EXEC add_PlayerStatsByName 'Jonathan Bender',  0,  3,  7,  1,  43,  36,  47,  1,  2002
EXEC add_PlayerStatsByName 'Jonathan Bender',  0,  1,  7,  1,  47,  40,  51,  1,  2004
EXEC add_PlayerStatsByName 'Jonathan Bender',  0,  2,  5,  1,  40,  20,  41,  1,  2005
EXEC add_PlayerStatsByName 'Calvin Booth',  0,  2,  2,  0,  43,  0,  43,  1,  2003
EXEC add_PlayerStatsByName 'Calvin Booth',  0,  3,  4,  0,  46,  0,  46,  2,  2004
EXEC add_PlayerStatsByName 'Calvin Booth',  0,  2,  2,  0,  45,  0,  45,  1,  2005
EXEC add_PlayerStatsByName 'Lazaro Borrell',  0,  2,  3,  0,  44,  0,  44,  0,  2000
EXEC add_PlayerStatsByName 'Cal Bowdler',  0,  1,  2,  0,  42,  0,  42,  1,  2000
EXEC add_PlayerStatsByName 'Cal Bowdler',  0,  1,  3,  0,  46,  20,  46,  1,  2001
EXEC add_PlayerStatsByName 'Cal Bowdler',  0,  2,  3,  0,  35,  20,  35,  1,  2002
EXEC add_PlayerStatsByName 'Ryan Bowen',  0,  2,  2,  0,  39,  11,  39,  1,  2000
EXEC add_PlayerStatsByName 'Ryan Bowen',  0,  2,  3,  0,  55,  36,  56,  1,  2001
EXEC add_PlayerStatsByName 'Ryan Bowen',  0,  4,  4,  0,  47,  8,  48,  2,  2002
EXEC add_PlayerStatsByName 'Ryan Bowen',  0,  2,  3,  0,  49,  28,  49,  1,  2003
EXEC add_PlayerStatsByName 'Ryan Bowen',  0,  1,  1,  0,  42,  50,  43,  0,  2005
EXEC add_PlayerStatsByName 'Ira Bowman',  0,  0,  3,  0,  71,  0,  71,  1,  2002
EXEC add_PlayerStatsByName 'Elton Brand',  1,  10,  20,  2,  48,  0,  48,  3,  2000
EXEC add_PlayerStatsByName 'Elton Brand',  3,  10,  20,  3,  47,  0,  47,  3,  2001
EXEC add_PlayerStatsByName 'Elton Brand',  2,  11,  18,  2,  50,  0,  50,  3,  2003
EXEC add_PlayerStatsByName 'Elton Brand',  3,  10,  20,  2,  49,  0,  49,  3,  2004
EXEC add_PlayerStatsByName 'Elton Brand',  2,  9,  20,  2,  50,  0,  50,  3,  2005
EXEC add_PlayerStatsByName 'Greg Buckner',  1,  3,  5,  0,  47,  38,  49,  3,  2000
EXEC add_PlayerStatsByName 'Greg Buckner',  1,  4,  6,  0,  43,  28,  44,  3,  2001
EXEC add_PlayerStatsByName 'Greg Buckner',  1,  3,  5,  0,  52,  31,  53,  2,  2002
EXEC add_PlayerStatsByName 'Greg Buckner',  1,  2,  6,  0,  46,  27,  48,  2,  2003
EXEC add_PlayerStatsByName 'Greg Buckner',  0,  1,  3,  0,  37,  27,  41,  1,  2004
EXEC add_PlayerStatsByName 'Greg Buckner',  1,  3,  6,  0,  52,  40,  60,  2,  2005
EXEC add_PlayerStatsByName 'Rodney Buford',  0,  1,  4,  0,  41,  24,  43,  1,  2000
EXEC add_PlayerStatsByName 'Rodney Buford',  0,  1,  5,  0,  43,  42,  46,  1,  2001
EXEC add_PlayerStatsByName 'Rodney Buford',  1,  4,  9,  1,  43,  24,  44,  1,  2002
EXEC add_PlayerStatsByName 'Rodney Buford',  0,  0,  1,  0,  33,  0,  33,  0,  2004
EXEC add_PlayerStatsByName 'Rodney Buford',  1,  3,  7,  0,  38,  31,  41,  1,  2005
EXEC add_PlayerStatsByName 'Anthony Carter',  4,  2,  6,  2,  39,  13,  39,  2,  2000
EXEC add_PlayerStatsByName 'Anthony Carter',  3,  2,  6,  1,  40,  15,  41,  2,  2001
EXEC add_PlayerStatsByName 'Anthony Carter',  4,  2,  4,  1,  34,  5,  34,  1,  2002
EXEC add_PlayerStatsByName 'Anthony Carter',  4,  1,  4,  1,  35,  0,  35,  1,  2003
EXEC add_PlayerStatsByName 'Anthony Carter',  2,  2,  4,  2,  29,  0,  29,  1,  2004
EXEC add_PlayerStatsByName 'Anthony Carter',  2,  1,  2,  0,  40,  11,  41,  1,  2005
EXEC add_PlayerStatsByName 'John Celestand',  1,  0,  2,  1,  33,  22,  35,  1,  2000
EXEC add_PlayerStatsByName 'Vonteego Cummings',  3,  2,  9,  1,  40,  32,  44,  2,  2000
EXEC add_PlayerStatsByName 'Vonteego Cummings',  3,  2,  7,  1,  34,  33,  39,  2,  2001
EXEC add_PlayerStatsByName 'Vonteego Cummings',  1,  0,  3,  0,  41,  26,  44,  0,  2002
EXEC add_PlayerStatsByName 'Baron Davis',  3,  2,  5,  1,  42,  22,  44,  2,  2000
EXEC add_PlayerStatsByName 'Baron Davis',  7,  5,  13,  2,  42,  31,  47,  3,  2001
EXEC add_PlayerStatsByName 'Baron Davis',  8,  4,  18,  3,  41,  35,  48,  2,  2002
EXEC add_PlayerStatsByName 'Baron Davis',  6,  3,  17,  2,  41,  35,  47,  3,  2003
EXEC add_PlayerStatsByName 'Baron Davis',  7,  4,  22,  3,  39,  32,  46,  2,  2004
EXEC add_PlayerStatsByName 'Baron Davis',  7,  3,  19,  2,  38,  33,  46,  2,  2005
EXEC add_PlayerStatsByName 'Derrick Dial',  0,  3,  5,  0,  37,  25,  40,  1,  2000
EXEC add_PlayerStatsByName 'Derrick Dial',  0,  1,  2,  0,  43,  20,  44,  0,  2001
EXEC add_PlayerStatsByName 'Derrick Dial',  1,  1,  3,  0,  34,  9,  34,  0,  2002
EXEC add_PlayerStatsByName 'Derrick Dial',  0,  1,  2,  0,  32,  22,  35,  0,  2004
EXEC add_PlayerStatsByName 'Obinna Ekezie',  0,  4,  5,  1,  43,  0,  43,  3,  2005
EXEC add_PlayerStatsByName 'Jeff Foster',  0,  1,  2,  0,  56,  0,  56,  0,  2000
EXEC add_PlayerStatsByName 'Jeff Foster',  0,  5,  3,  0,  46,  28,  47,  2,  2001
EXEC add_PlayerStatsByName 'Jeff Foster',  0,  6,  5,  1,  44,  13,  45,  2,  2002
EXEC add_PlayerStatsByName 'Jeff Foster',  0,  3,  2,  0,  36,  0,  36,  1,  2003
EXEC add_PlayerStatsByName 'Jeff Foster',  0,  7,  6,  0,  54,  0,  54,  2,  2004
EXEC add_PlayerStatsByName 'Jeff Foster',  0,  9,  7,  0,  51,  0,  51,  3,  2005
EXEC add_PlayerStatsByName 'Steve Francis',  6,  5,  18,  4,  44,  34,  49,  3,  2000
EXEC add_PlayerStatsByName 'Steve Francis',  6,  6,  19,  3,  45,  39,  50,  3,  2001
EXEC add_PlayerStatsByName 'Steve Francis',  6,  7,  21,  3,  41,  32,  45,  3,  2002
EXEC add_PlayerStatsByName 'Steve Francis',  6,  6,  21,  3,  43,  35,  46,  3,  2003
EXEC add_PlayerStatsByName 'Steve Francis',  6,  5,  16,  3,  40,  29,  43,  3,  2004
EXEC add_PlayerStatsByName 'Steve Francis',  7,  5,  21,  4,  42,  29,  43,  3,  2005
EXEC add_PlayerStatsByName 'Devean George',  0,  1,  3,  0,  38,  34,  44,  1,  2000
EXEC add_PlayerStatsByName 'Devean George',  0,  1,  3,  0,  30,  22,  34,  1,  2001
EXEC add_PlayerStatsByName 'Devean George',  1,  3,  7,  0,  41,  37,  47,  2,  2002
EXEC add_PlayerStatsByName 'Devean George',  1,  4,  6,  0,  39,  37,  44,  2,  2003
EXEC add_PlayerStatsByName 'Devean George',  1,  4,  7,  1,  40,  34,  46,  2,  2004
EXEC add_PlayerStatsByName 'Devean George',  0,  3,  7,  0,  35,  36,  45,  2,  2005
EXEC add_PlayerStatsByName 'Dion Glover',  0,  1,  6,  0,  38,  26,  42,  0,  2000
EXEC add_PlayerStatsByName 'Dion Glover',  1,  2,  5,  0,  42,  19,  43,  1,  2001
EXEC add_PlayerStatsByName 'Dion Glover',  1,  3,  8,  1,  42,  33,  45,  1,  2002
EXEC add_PlayerStatsByName 'Dion Glover',  1,  3,  9,  1,  42,  35,  47,  1,  2003
EXEC add_PlayerStatsByName 'Dion Glover',  1,  3,  9,  1,  39,  33,  42,  1,  2004
EXEC add_PlayerStatsByName 'Dion Glover',  0,  1,  3,  0,  36,  12,  38,  1,  2005
EXEC add_PlayerStatsByName 'Adrian Griffin',  2,  5,  6,  1,  42,  28,  44,  3,  2000
EXEC add_PlayerStatsByName 'Adrian Griffin',  0,  2,  2,  0,  34,  34,  38,  1,  2001
EXEC add_PlayerStatsByName 'Adrian Griffin',  1,  3,  7,  0,  49,  29,  52,  2,  2002
EXEC add_PlayerStatsByName 'Adrian Griffin',  1,  3,  4,  0,  43,  25,  44,  2,  2003
EXEC add_PlayerStatsByName 'Adrian Griffin',  0,  1,  0,  0,  27,  50,  30,  0,  2004
EXEC add_PlayerStatsByName 'Adrian Griffin',  0,  2,  2,  0,  36,  22,  36,  1,  2005
EXEC add_PlayerStatsByName 'Richard Hamilton',  1,  1,  9,  1,  42,  36,  44,  2,  2000
EXEC add_PlayerStatsByName 'Richard Hamilton',  2,  3,  18,  2,  43,  27,  45,  2,  2001
EXEC add_PlayerStatsByName 'Richard Hamilton',  2,  3,  20,  2,  43,  38,  44,  2,  2002
EXEC add_PlayerStatsByName 'Richard Hamilton',  2,  3,  19,  2,  44,  26,  45,  3,  2003
EXEC add_PlayerStatsByName 'Richard Hamilton',  4,  3,  17,  2,  45,  26,  46,  2,  2004
EXEC add_PlayerStatsByName 'Richard Hamilton',  4,  3,  18,  2,  44,  30,  45,  3,  2005
EXEC add_PlayerStatsByName 'Chris Herren',  2,  1,  3,  0,  36,  35,  46,  1,  2000
EXEC add_PlayerStatsByName 'Chris Herren',  2,  0,  3,  0,  30,  29,  38,  1,  2001
EXEC add_PlayerStatsByName 'Rick Hughes',  0,  2,  3,  0,  48,  0,  48,  1,  2000
EXEC add_PlayerStatsByName 'Jermaine Jackson',  0,  1,  1,  1,  9,  0,  9,  1,  2000
EXEC add_PlayerStatsByName 'Jermaine Jackson',  2,  1,  2,  0,  47,  50,  48,  1,  2002
EXEC add_PlayerStatsByName 'Jermaine Jackson',  1,  1,  2,  0,  36,  10,  36,  1,  2003
EXEC add_PlayerStatsByName 'Jermaine Jackson',  1,  1,  2,  0,  51,  0,  51,  1,  2005
EXEC add_PlayerStatsByName 'Tim James',  0,  1,  1,  0,  30,  33,  31,  0,  2001
EXEC add_PlayerStatsByName 'Jumaine Jones',  0,  1,  1,  0,  37,  50,  39,  0,  2000
EXEC add_PlayerStatsByName 'Jumaine Jones',  0,  2,  4,  0,  44,  33,  48,  1,  2001
EXEC add_PlayerStatsByName 'Jumaine Jones',  1,  6,  8,  1,  44,  31,  48,  2,  2002
EXEC add_PlayerStatsByName 'Jumaine Jones',  1,  5,  9,  1,  43,  35,  51,  2,  2003
EXEC add_PlayerStatsByName 'Jumaine Jones',  0,  1,  2,  0,  34,  29,  41,  1,  2004
EXEC add_PlayerStatsByName 'Jumaine Jones',  0,  5,  7,  0,  43,  39,  53,  2,  2005
EXEC add_PlayerStatsByName 'Trajan Langdon',  1,  1,  4,  0,  37,  42,  47,  1,  2000
EXEC add_PlayerStatsByName 'Trajan Langdon',  1,  1,  6,  0,  43,  41,  51,  1,  2001
EXEC add_PlayerStatsByName 'Trajan Langdon',  1,  1,  4,  0,  39,  36,  47,  1,  2002
EXEC add_PlayerStatsByName 'Quincy Lewis',  0,  1,  3,  0,  37,  36,  41,  2,  2000
EXEC add_PlayerStatsByName 'Quincy Lewis',  0,  1,  3,  0,  40,  36,  44,  2,  2001
EXEC add_PlayerStatsByName 'Quincy Lewis',  1,  1,  4,  0,  44,  16,  45,  2,  2002
EXEC add_PlayerStatsByName 'Quincy Lewis',  0,  0,  1,  0,  35,  40,  40,  0,  2004
EXEC add_PlayerStatsByName 'Corey Maggette',  0,  3,  8,  1,  47,  18,  48,  2,  2000
EXEC add_PlayerStatsByName 'Corey Maggette',  1,  4,  10,  1,  46,  30,  47,  2,  2001
EXEC add_PlayerStatsByName 'Corey Maggette',  1,  3,  11,  1,  44,  33,  48,  2,  2002
EXEC add_PlayerStatsByName 'Corey Maggette',  1,  5,  16,  2,  44,  35,  48,  3,  2003
EXEC add_PlayerStatsByName 'Corey Maggette',  3,  5,  20,  2,  44,  32,  48,  3,  2004
EXEC add_PlayerStatsByName 'Corey Maggette',  3,  6,  22,  3,  43,  30,  45,  2,  2005
EXEC add_PlayerStatsByName 'Shawn Marion',  1,  6,  10,  1,  47,  18,  47,  2,  2000
EXEC add_PlayerStatsByName 'Shawn Marion',  2,  10,  17,  1,  48,  25,  48,  2,  2001
EXEC add_PlayerStatsByName 'Shawn Marion',  2,  9,  19,  1,  46,  39,  48,  2,  2002
EXEC add_PlayerStatsByName 'Shawn Marion',  2,  9,  21,  1,  45,  38,  50,  2,  2003
EXEC add_PlayerStatsByName 'Shawn Marion',  2,  9,  19,  2,  44,  34,  47,  2,  2004
EXEC add_PlayerStatsByName 'Shawn Marion',  1,  11,  19,  1,  47,  33,  52,  2,  2005
EXEC add_PlayerStatsByName 'Andre Miller',  5,  3,  11,  2,  44,  20,  45,  2,  2000
EXEC add_PlayerStatsByName 'Andre Miller',  8,  4,  15,  3,  45,  26,  46,  2,  2001
EXEC add_PlayerStatsByName 'Andre Miller',  10,  4,  16,  3,  45,  25,  46,  2,  2002
EXEC add_PlayerStatsByName 'Andre Miller',  6,  4,  13,  2,  40,  21,  41,  2,  2003
EXEC add_PlayerStatsByName 'Andre Miller',  6,  4,  14,  2,  45,  18,  46,  2,  2004
EXEC add_PlayerStatsByName 'Jason Miskiri',  1,  0,  0,  0,  0,  0,  0,  2,  2000
EXEC add_PlayerStatsByName 'Lamar Odom',  4,  7,  16,  3,  43,  36,  46,  3,  2000
EXEC add_PlayerStatsByName 'Lamar Odom',  5,  7,  17,  3,  46,  31,  49,  3,  2001
EXEC add_PlayerStatsByName 'Lamar Odom',  5,  6,  13,  3,  41,  19,  44,  3,  2002
EXEC add_PlayerStatsByName 'Lamar Odom',  3,  6,  14,  2,  43,  32,  47,  3,  2003
EXEC add_PlayerStatsByName 'Lamar Odom',  4,  9,  17,  3,  43,  29,  45,  3,  2004
EXEC add_PlayerStatsByName 'Scott Padgett',  0,  1,  2,  0,  31,  29,  36,  1,  2000
EXEC add_PlayerStatsByName 'Scott Padgett',  0,  1,  2,  0,  41,  55,  47,  0,  2001
EXEC add_PlayerStatsByName 'Scott Padgett',  1,  3,  6,  0,  47,  43,  53,  1,  2002
EXEC add_PlayerStatsByName 'Scott Padgett',  1,  3,  5,  0,  40,  33,  45,  1,  2003
EXEC add_PlayerStatsByName 'Scott Padgett',  0,  2,  3,  0,  44,  43,  52,  1,  2004
EXEC add_PlayerStatsByName 'Milt Palacio',  0,  1,  2,  0,  43,  0,  43,  0,  2000
EXEC add_PlayerStatsByName 'Milt Palacio',  2,  1,  5,  1,  47,  33,  49,  1,  2001
EXEC add_PlayerStatsByName 'Milt Palacio',  1,  1,  3,  0,  38,  31,  41,  0,  2002
EXEC add_PlayerStatsByName 'Milt Palacio',  3,  2,  5,  1,  41,  21,  42,  2,  2003
EXEC add_PlayerStatsByName 'Milt Palacio',  3,  1,  4,  1,  34,  15,  35,  1,  2004
EXEC add_PlayerStatsByName 'James Posey',  1,  3,  8,  1,  42,  37,  50,  2,  2000
EXEC add_PlayerStatsByName 'James Posey',  2,  5,  8,  1,  41,  30,  46,  2,  2001
EXEC add_PlayerStatsByName 'James Posey',  2,  5,  10,  1,  37,  28,  42,  3,  2002
EXEC add_PlayerStatsByName 'James Posey',  2,  5,  10,  1,  41,  30,  45,  2,  2003
EXEC add_PlayerStatsByName 'James Posey',  1,  4,  13,  1,  47,  38,  55,  3,  2004
EXEC add_PlayerStatsByName 'Laron Profit',  0,  0,  1,  0,  35,  17,  38,  0,  2000
EXEC add_PlayerStatsByName 'Laron Profit',  2,  1,  4,  1,  39,  26,  41,  1,  2001
EXEC add_PlayerStatsByName 'Ryan Robertson',  0,  0,  5,  0,  33,  0,  33,  0,  2000
EXEC add_PlayerStatsByName 'Eddie Robinson',  0,  2,  7,  0,  54,  0,  54,  1,  2000
EXEC add_PlayerStatsByName 'Eddie Robinson',  0,  3,  7,  0,  53,  50,  53,  1,  2001
EXEC add_PlayerStatsByName 'Eddie Robinson',  1,  2,  9,  1,  45,  40,  45,  1,  2002
EXEC add_PlayerStatsByName 'Eddie Robinson',  1,  3,  5,  0,  49,  21,  49,  1,  2003
EXEC add_PlayerStatsByName 'Eddie Robinson',  1,  2,  6,  0,  48,  20,  48,  1,  2004
EXEC add_PlayerStatsByName 'Wally Szczerbiak',  2,  3,  11,  1,  51,  35,  53,  2,  2000
EXEC add_PlayerStatsByName 'Wally Szczerbiak',  3,  5,  14,  1,  51,  33,  52,  2,  2001
EXEC add_PlayerStatsByName 'Wally Szczerbiak',  3,  4,  18,  2,  50,  45,  54,  2,  2002
EXEC add_PlayerStatsByName 'Wally Szczerbiak',  2,  4,  17,  1,  48,  42,  52,  2,  2003
EXEC add_PlayerStatsByName 'Wally Szczerbiak',  1,  3,  10,  1,  44,  43,  49,  1,  2004
EXEC add_PlayerStatsByName 'Jason Terry',  4,  2,  8,  1,  41,  29,  45,  1,  2000
EXEC add_PlayerStatsByName 'Jason Terry',  4,  3,  19,  2,  43,  39,  48,  2,  2001
EXEC add_PlayerStatsByName 'Jason Terry',  5,  3,  19,  2,  43,  38,  50,  2,  2002
EXEC add_PlayerStatsByName 'Jason Terry',  7,  3,  17,  3,  42,  37,  49,  2,  2003
EXEC add_PlayerStatsByName 'Jason Terry',  5,  4,  16,  2,  41,  34,  47,  2,  2004
EXEC add_PlayerStatsByName 'Jamel Thomas',  0,  0,  2,  0,  44,  0,  44,  0,  2000
EXEC add_PlayerStatsByName 'Jamel Thomas',  0,  1,  2,  1,  31,  33,  34,  1,  2001
EXEC add_PlayerStatsByName 'Kenny Thomas',  1,  6,  8,  1,  39,  26,  42,  2,  2000
EXEC add_PlayerStatsByName 'Kenny Thomas',  1,  5,  7,  1,  44,  27,  47,  2,  2001
EXEC add_PlayerStatsByName 'Kenny Thomas',  1,  7,  14,  2,  47,  0,  47,  2,  2002
EXEC add_PlayerStatsByName 'Kenny Thomas',  1,  10,  13,  2,  46,  20,  46,  3,  2004
EXEC add_PlayerStatsByName 'Dedric Willoughby',  2,  2,  7,  1,  34,  29,  42,  1,  2000
EXEC add_PlayerStatsByName 'Courtney Alexander',  1,  2,  9,  1,  41,  37,  43,  2,  2001
EXEC add_PlayerStatsByName 'Courtney Alexander',  1,  2,  9,  1,  47,  27,  47,  2,  2002
EXEC add_PlayerStatsByName 'Courtney Alexander',  1,  1,  7,  1,  38,  33,  40,  1,  2003
EXEC add_PlayerStatsByName 'Erick Barkley',  0,  0,  2,  0,  36,  37,  43,  0,  2001
EXEC add_PlayerStatsByName 'Erick Barkley',  1,  0,  3,  0,  35,  14,  36,  1,  2002
EXEC add_PlayerStatsByName 'Raja Bell',  1,  1,  3,  0,  42,  27,  45,  1,  2002
EXEC add_PlayerStatsByName 'Raja Bell',  0,  1,  3,  0,  44,  41,  49,  1,  2003
EXEC add_PlayerStatsByName 'Raja Bell',  1,  2,  11,  1,  40,  37,  44,  3,  2004
EXEC add_PlayerStatsByName 'Raja Bell',  1,  3,  12,  1,  45,  40,  49,  3,  2005
EXEC add_PlayerStatsByName 'Mark Blount',  1,  4,  9,  1,  52,  0,  52,  2,  2005
EXEC add_PlayerStatsByName 'Brian Cardinal',  0,  1,  2,  0,  32,  0,  32,  1,  2001
EXEC add_PlayerStatsByName 'Brian Cardinal',  0,  0,  2,  0,  46,  42,  57,  0,  2002
EXEC add_PlayerStatsByName 'Brian Cardinal',  0,  1,  0,  0,  25,  0,  25,  0,  2003
EXEC add_PlayerStatsByName 'Brian Cardinal',  1,  4,  9,  1,  47,  44,  53,  2,  2004
EXEC add_PlayerStatsByName 'Brian Cardinal',  2,  3,  9,  1,  37,  35,  42,  3,  2005
EXEC add_PlayerStatsByName 'Mateen Cleaves',  2,  1,  5,  1,  40,  29,  40,  2,  2001
EXEC add_PlayerStatsByName 'Mateen Cleaves',  0,  0,  2,  0,  44,  25,  45,  0,  2002
EXEC add_PlayerStatsByName 'Mateen Cleaves',  0,  0,  1,  1,  26,  100,  28,  0,  2003
EXEC add_PlayerStatsByName 'Mateen Cleaves',  4,  1,  3,  1,  30,  0,  30,  3,  2004
EXEC add_PlayerStatsByName 'Mateen Cleaves',  0,  0,  0,  0,  35,  0,  35,  0,  2005
EXEC add_PlayerStatsByName 'Jason Collier',  0,  1,  3,  0,  38,  0,  38,  1,  2001
EXEC add_PlayerStatsByName 'Jason Collier',  0,  3,  4,  0,  43,  0,  43,  1,  2002
EXEC add_PlayerStatsByName 'Jason Collier',  0,  5,  11,  1,  47,  25,  48,  3,  2004
EXEC add_PlayerStatsByName 'Jason Collier',  0,  2,  5,  0,  46,  42,  47,  2,  2005
EXEC add_PlayerStatsByName 'Sean Colson',  0,  0,  1,  0,  25,  20,  27,  0,  2001
EXEC add_PlayerStatsByName 'Jamal Crawford',  2,  1,  4,  1,  35,  35,  41,  1,  2001
EXEC add_PlayerStatsByName 'Jamal Crawford',  2,  1,  9,  1,  47,  44,  54,  0,  2002
EXEC add_PlayerStatsByName 'Jamal Crawford',  4,  2,  10,  1,  41,  35,  46,  1,  2003
EXEC add_PlayerStatsByName 'Jamal Crawford',  5,  3,  17,  2,  38,  31,  44,  2,  2004
EXEC add_PlayerStatsByName 'Jamal Crawford',  4,  2,  17,  2,  39,  36,  48,  1,  2005
EXEC add_PlayerStatsByName 'Keyon Dooling',  2,  1,  5,  1,  40,  35,  44,  1,  2001
EXEC add_PlayerStatsByName 'Keyon Dooling',  0,  0,  4,  0,  38,  28,  42,  1,  2002
EXEC add_PlayerStatsByName 'Keyon Dooling',  1,  1,  6,  1,  38,  36,  46,  1,  2003
EXEC add_PlayerStatsByName 'Keyon Dooling',  2,  1,  6,  1,  38,  17,  40,  1,  2004
EXEC add_PlayerStatsByName 'Keyon Dooling',  1,  1,  5,  0,  40,  25,  43,  1,  2005
EXEC add_PlayerStatsByName 'Khalid El-Amin',  2,  1,  6,  1,  37,  33,  41,  2,  2001
EXEC add_PlayerStatsByName 'Marcus Fizer',  1,  4,  9,  1,  43,  25,  43,  2,  2001
EXEC add_PlayerStatsByName 'Marcus Fizer',  1,  5,  12,  1,  43,  17,  44,  2,  2002
EXEC add_PlayerStatsByName 'Marcus Fizer',  1,  5,  11,  1,  46,  16,  46,  2,  2003
EXEC add_PlayerStatsByName 'Marcus Fizer',  0,  4,  7,  1,  38,  11,  38,  2,  2004
EXEC add_PlayerStatsByName 'Marcus Fizer',  1,  3,  6,  1,  45,  0,  45,  1,  2005
EXEC add_PlayerStatsByName 'Eddie Gill',  3,  1,  4,  1,  39,  33,  42,  1,  2001
EXEC add_PlayerStatsByName 'Eddie Gill',  2,  1,  5,  1,  42,  31,  46,  1,  2002
EXEC add_PlayerStatsByName 'Eddie Gill',  0,  0,  2,  0,  41,  37,  45,  0,  2004
EXEC add_PlayerStatsByName 'Eddie Gill',  1,  1,  3,  0,  33,  30,  40,  1,  2005
EXEC add_PlayerStatsByName 'Steve Goodrich',  0,  1,  1,  0,  38,  33,  41,  1,  2001
EXEC add_PlayerStatsByName 'A.J. Guyton',  1,  1,  6,  0,  40,  39,  47,  1,  2001
EXEC add_PlayerStatsByName 'A.J. Guyton',  1,  1,  5,  0,  36,  37,  45,  0,  2002
EXEC add_PlayerStatsByName 'A.J. Guyton',  1,  0,  0,  0,  0,  0,  0,  0,  2003
EXEC add_PlayerStatsByName 'Jason Hart',  1,  1,  2,  0,  52,  0,  52,  1,  2002
EXEC add_PlayerStatsByName 'Jason Hart',  1,  1,  3,  0,  44,  22,  45,  1,  2004
EXEC add_PlayerStatsByName 'Jason Hart',  5,  2,  9,  1,  44,  36,  47,  2,  2005
EXEC add_PlayerStatsByName 'Donnell Harvey',  1,  5,  7,  1,  44,  14,  44,  2,  2003
EXEC add_PlayerStatsByName 'Donnell Harvey',  0,  2,  4,  0,  44,  0,  44,  2,  2004
EXEC add_PlayerStatsByName 'Eddie House',  1,  0,  5,  0,  42,  34,  46,  1,  2001
EXEC add_PlayerStatsByName 'Eddie House',  1,  1,  8,  1,  39,  34,  45,  1,  2002
EXEC add_PlayerStatsByName 'Eddie House',  1,  1,  7,  0,  38,  30,  42,  1,  2003
EXEC add_PlayerStatsByName 'Eddie House',  2,  2,  6,  1,  35,  37,  41,  1,  2004
EXEC add_PlayerStatsByName 'Eddie House',  1,  1,  5,  0,  45,  45,  51,  1,  2005
EXEC add_PlayerStatsByName 'Marc Jackson',  1,  7,  13,  1,  46,  21,  47,  2,  2001
EXEC add_PlayerStatsByName 'Marc Jackson',  0,  3,  4,  0,  36,  0,  36,  1,  2002
EXEC add_PlayerStatsByName 'Marc Jackson',  0,  2,  5,  0,  43,  100,  44,  1,  2003
EXEC add_PlayerStatsByName 'Marc Jackson',  0,  5,  9,  1,  41,  0,  41,  2,  2004
EXEC add_PlayerStatsByName 'Marc Jackson',  1,  5,  12,  1,  46,  0,  46,  2,  2005
EXEC add_PlayerStatsByName 'Stephen Jackson',  1,  2,  8,  1,  42,  33,  47,  2,  2001
EXEC add_PlayerStatsByName 'Stephen Jackson',  0,  1,  3,  1,  37,  25,  42,  1,  2002
EXEC add_PlayerStatsByName 'Stephen Jackson',  2,  3,  11,  2,  43,  32,  49,  2,  2003
EXEC add_PlayerStatsByName 'Stephen Jackson',  3,  4,  18,  2,  42,  34,  48,  2,  2004
EXEC add_PlayerStatsByName 'Stephen Jackson',  2,  4,  18,  2,  40,  36,  46,  3,  2005
EXEC add_PlayerStatsByName 'DerMarr Johnson',  0,  2,  5,  1,  37,  32,  42,  1,  2001
EXEC add_PlayerStatsByName 'DerMarr Johnson',  1,  3,  8,  1,  39,  36,  47,  2,  2002
EXEC add_PlayerStatsByName 'DerMarr Johnson',  0,  1,  5,  0,  37,  36,  43,  1,  2004
EXEC add_PlayerStatsByName 'DerMarr Johnson',  1,  2,  7,  0,  49,  35,  56,  2,  2005
EXEC add_PlayerStatsByName 'Dan Langhi',  0,  1,  2,  0,  37,  0,  37,  0,  2001
EXEC add_PlayerStatsByName 'Dan Langhi',  0,  2,  3,  0,  39,  25,  39,  0,  2002
EXEC add_PlayerStatsByName 'Dan Langhi',  0,  1,  3,  0,  40,  28,  42,  1,  2003
EXEC add_PlayerStatsByName 'Dan Langhi',  0,  0,  2,  0,  35,  50,  39,  1,  2004
EXEC add_PlayerStatsByName 'Art Long',  0,  2,  2,  0,  37,  66,  38,  1,  2003
EXEC add_PlayerStatsByName 'Mark Madsen',  0,  2,  2,  0,  48,  100,  49,  1,  2001
EXEC add_PlayerStatsByName 'Mark Madsen',  0,  2,  2,  0,  45,  0,  45,  1,  2002
EXEC add_PlayerStatsByName 'Mark Madsen',  0,  3,  3,  0,  49,  0,  49,  2,  2004
EXEC add_PlayerStatsByName 'Jamaal Magloire',  0,  4,  4,  0,  45,  0,  45,  1,  2001
EXEC add_PlayerStatsByName 'Jamaal Magloire',  0,  5,  8,  1,  55,  0,  55,  2,  2002
EXEC add_PlayerStatsByName 'Jamaal Magloire',  1,  8,  10,  1,  48,  0,  48,  3,  2003
EXEC add_PlayerStatsByName 'Jamaal Magloire',  1,  10,  13,  2,  47,  0,  47,  3,  2004
EXEC add_PlayerStatsByName 'Kenyon Martin',  1,  7,  12,  2,  44,  9,  44,  4,  2001
EXEC add_PlayerStatsByName 'Kenyon Martin',  2,  5,  14,  2,  46,  22,  47,  3,  2002
EXEC add_PlayerStatsByName 'Kenyon Martin',  2,  8,  16,  2,  47,  20,  47,  3,  2003
EXEC add_PlayerStatsByName 'Kenyon Martin',  2,  9,  16,  2,  48,  28,  49,  3,  2004
EXEC add_PlayerStatsByName 'Kenyon Martin',  2,  7,  15,  2,  49,  0,  49,  3,  2005
EXEC add_PlayerStatsByName 'Desmond Mason',  0,  3,  5,  0,  43,  26,  45,  1,  2001
EXEC add_PlayerStatsByName 'Desmond Mason',  1,  4,  12,  1,  46,  27,  47,  2,  2002
EXEC add_PlayerStatsByName 'Desmond Mason',  2,  6,  14,  1,  44,  29,  46,  2,  2003
EXEC add_PlayerStatsByName 'Desmond Mason',  1,  4,  14,  1,  47,  23,  47,  2,  2004
EXEC add_PlayerStatsByName 'Desmond Mason',  2,  3,  17,  2,  44,  12,  44,  2,  2005
EXEC add_PlayerStatsByName 'Paul McPherson',  0,  1,  4,  0,  50,  16,  50,  1,  2001
EXEC add_PlayerStatsByName 'Stanislav Medvedenko',  0,  1,  4,  0,  48,  100,  50,  1,  2001
EXEC add_PlayerStatsByName 'Stanislav Medvedenko',  0,  2,  4,  0,  47,  0,  47,  1,  2002
EXEC add_PlayerStatsByName 'Stanislav Medvedenko',  0,  2,  4,  0,  43,  0,  43,  2,  2003
EXEC add_PlayerStatsByName 'Stanislav Medvedenko',  0,  5,  8,  0,  44,  0,  44,  2,  2004
EXEC add_PlayerStatsByName 'Chris Mihm',  0,  4,  7,  1,  44,  0,  44,  2,  2001
EXEC add_PlayerStatsByName 'Chris Mihm',  0,  5,  7,  1,  42,  42,  42,  3,  2002
EXEC add_PlayerStatsByName 'Chris Mihm',  0,  4,  5,  0,  40,  0,  40,  2,  2003
EXEC add_PlayerStatsByName 'Darius Miles',  1,  5,  9,  1,  50,  5,  50,  2,  2001
EXEC add_PlayerStatsByName 'Darius Miles',  2,  5,  9,  2,  48,  15,  48,  2,  2002
EXEC add_PlayerStatsByName 'Darius Miles',  2,  5,  9,  2,  41,  0,  41,  2,  2003
EXEC add_PlayerStatsByName 'Darius Miles',  2,  4,  10,  1,  48,  17,  48,  2,  2004
EXEC add_PlayerStatsByName 'Mike Miller',  1,  4,  11,  1,  43,  40,  52,  2,  2001
EXEC add_PlayerStatsByName 'Mike Miller',  3,  4,  15,  1,  43,  38,  51,  2,  2002
EXEC add_PlayerStatsByName 'Mike Miller',  2,  5,  15,  1,  43,  36,  49,  2,  2003
EXEC add_PlayerStatsByName 'Mike Miller',  3,  3,  11,  1,  43,  37,  50,  2,  2004
EXEC add_PlayerStatsByName 'Lee Nailon',  0,  2,  3,  0,  48,  0,  48,  1,  2001
EXEC add_PlayerStatsByName 'Lee Nailon',  1,  3,  10,  1,  48,  50,  48,  2,  2002
EXEC add_PlayerStatsByName 'Lee Nailon',  0,  1,  5,  0,  44,  0,  44,  1,  2003
EXEC add_PlayerStatsByName 'Lee Nailon',  0,  2,  6,  0,  45,  0,  45,  1,  2004
EXEC add_PlayerStatsByName 'Ira Newble',  0,  1,  2,  0,  38,  44,  41,  0,  2001
EXEC add_PlayerStatsByName 'Ira Newble',  1,  5,  8,  1,  49,  14,  50,  2,  2002
EXEC add_PlayerStatsByName 'Ira Newble',  1,  3,  7,  0,  49,  38,  52,  2,  2003
EXEC add_PlayerStatsByName 'Ira Newble',  1,  2,  4,  0,  39,  10,  39,  1,  2004
EXEC add_PlayerStatsByName 'Mike Penberthy',  1,  1,  5,  0,  41,  39,  53,  1,  2001
EXEC add_PlayerStatsByName 'Morris Peterson',  1,  3,  9,  1,  43,  38,  47,  2,  2001
EXEC add_PlayerStatsByName 'Morris Peterson',  2,  3,  14,  1,  43,  36,  49,  2,  2002
EXEC add_PlayerStatsByName 'Morris Peterson',  2,  4,  14,  1,  39,  33,  44,  2,  2003
EXEC add_PlayerStatsByName 'Morris Peterson',  1,  3,  8,  0,  40,  37,  51,  2,  2004
EXEC add_PlayerStatsByName 'Chris Porter',  1,  3,  8,  1,  38,  0,  38,  2,  2001
EXEC add_PlayerStatsByName 'Lavor Postell',  0,  1,  2,  0,  31,  27,  34,  0,  2001
EXEC add_PlayerStatsByName 'Lavor Postell',  0,  0,  4,  0,  33,  23,  36,  0,  2002
EXEC add_PlayerStatsByName 'Lavor Postell',  0,  0,  3,  0,  36,  28,  39,  0,  2003
EXEC add_PlayerStatsByName 'Joel Przybilla',  0,  4,  2,  0,  53,  0,  53,  2,  2002
EXEC add_PlayerStatsByName 'Michael Redd',  0,  0,  2,  0,  26,  0,  26,  0,  2001
EXEC add_PlayerStatsByName 'Michael Redd',  1,  3,  11,  0,  48,  44,  55,  1,  2002
EXEC add_PlayerStatsByName 'Michael Redd',  1,  4,  15,  0,  46,  43,  56,  1,  2003
EXEC add_PlayerStatsByName 'Michael Redd',  2,  5,  21,  1,  44,  35,  48,  1,  2004
EXEC add_PlayerStatsByName 'Quentin Richardson',  0,  3,  8,  0,  44,  33,  49,  1,  2001
EXEC add_PlayerStatsByName 'Quentin Richardson',  1,  4,  13,  1,  43,  38,  50,  1,  2002
EXEC add_PlayerStatsByName 'Quentin Richardson',  0,  4,  9,  1,  37,  30,  42,  1,  2003
EXEC add_PlayerStatsByName 'Quentin Richardson',  2,  6,  17,  2,  39,  35,  45,  2,  2004
EXEC add_PlayerStatsByName 'Terrance Roberson',  0,  0,  0,  0,  0,  0,  0,  1,  2001
EXEC add_PlayerStatsByName 'Jamal Robinson',  0,  1,  1,  0,  13,  0,  13,  1,  2001
EXEC add_PlayerStatsByName 'Jabari Smith',  0,  1,  3,  0,  41,  0,  41,  1,  2002
EXEC add_PlayerStatsByName 'Jabari Smith',  0,  1,  2,  0,  37,  0,  37,  0,  2004
EXEC add_PlayerStatsByName 'Mike Smith',  0,  1,  3,  0,  32,  16,  34,  0,  2001
EXEC add_PlayerStatsByName 'DeShawn Stevenson',  0,  0,  2,  0,  34,  8,  34,  0,  2001
EXEC add_PlayerStatsByName 'DeShawn Stevenson',  1,  2,  4,  1,  38,  8,  38,  1,  2002
EXEC add_PlayerStatsByName 'DeShawn Stevenson',  0,  1,  4,  0,  40,  33,  40,  0,  2003
EXEC add_PlayerStatsByName 'DeShawn Stevenson',  2,  3,  11,  1,  43,  26,  44,  1,  2004
EXEC add_PlayerStatsByName 'Stromile Swift',  0,  3,  4,  0,  45,  0,  45,  2,  2001
EXEC add_PlayerStatsByName 'Stromile Swift',  0,  6,  11,  1,  48,  0,  48,  2,  2002
EXEC add_PlayerStatsByName 'Stromile Swift',  0,  5,  9,  1,  48,  0,  48,  2,  2003
EXEC add_PlayerStatsByName 'Stromile Swift',  0,  4,  9,  1,  46,  25,  47,  2,  2004
EXEC add_PlayerStatsByName 'Jake Tsakalidis',  0,  5,  7,  1,  47,  0,  47,  2,  2002
EXEC add_PlayerStatsByName 'David Vanterpool',  3,  1,  5,  1,  41,  0,  41,  2,  2001
EXEC add_PlayerStatsByName 'Wang Zhizhi',  0,  1,  4,  0,  42,  0,  42,  1,  2001
EXEC add_PlayerStatsByName 'Wang Zhizhi',  0,  2,  5,  0,  44,  41,  53,  1,  2002
EXEC add_PlayerStatsByName 'Wang Zhizhi',  0,  1,  4,  0,  38,  34,  43,  1,  2003
EXEC add_PlayerStatsByName 'Wang Zhizhi',  0,  1,  2,  0,  37,  28,  41,  0,  2004
EXEC add_PlayerStatsByName 'Malik Allen',  0,  3,  4,  0,  43,  0,  43,  1,  2002
EXEC add_PlayerStatsByName 'Malik Allen',  0,  5,  9,  1,  42,  0,  42,  2,  2003
EXEC add_PlayerStatsByName 'Chris Andersen',  0,  3,  3,  0,  33,  0,  33,  1,  2002
EXEC add_PlayerStatsByName 'Chris Andersen',  0,  4,  5,  1,  40,  0,  40,  1,  2003
EXEC add_PlayerStatsByName 'Chris Andersen',  0,  4,  3,  0,  44,  0,  44,  1,  2004
EXEC add_PlayerStatsByName 'Chris Andersen',  1,  6,  7,  1,  53,  0,  53,  2,  2005
EXEC add_PlayerStatsByName 'Gilbert Arenas',  3,  2,  10,  2,  45,  34,  50,  2,  2002
EXEC add_PlayerStatsByName 'Gilbert Arenas',  6,  4,  18,  3,  43,  34,  47,  3,  2003
EXEC add_PlayerStatsByName 'Gilbert Arenas',  5,  4,  19,  4,  39,  37,  46,  3,  2004
EXEC add_PlayerStatsByName 'Gilbert Arenas',  5,  4,  25,  3,  43,  36,  49,  3,  2005
EXEC add_PlayerStatsByName 'Brandon Armstrong',  0,  0,  1,  0,  31,  29,  34,  0,  2002
EXEC add_PlayerStatsByName 'Brandon Armstrong',  0,  0,  1,  0,  33,  16,  35,  0,  2003
EXEC add_PlayerStatsByName 'Brandon Armstrong',  0,  0,  2,  0,  37,  36,  42,  0,  2004
EXEC add_PlayerStatsByName 'Carlos Arroyo',  1,  1,  3,  0,  44,  0,  44,  0,  2002
EXEC add_PlayerStatsByName 'Carlos Arroyo',  1,  0,  2,  0,  45,  42,  47,  0,  2003
EXEC add_PlayerStatsByName 'Carlos Arroyo',  5,  2,  12,  2,  44,  32,  46,  2,  2004
EXEC add_PlayerStatsByName 'Carlos Arroyo',  4,  1,  6,  1,  38,  26,  39,  2,  2005
EXEC add_PlayerStatsByName 'Mengke Bateer',  0,  3,  5,  1,  40,  33,  41,  3,  2002
EXEC add_PlayerStatsByName 'Shane Battier',  2,  5,  14,  2,  42,  37,  48,  2,  2002
EXEC add_PlayerStatsByName 'Shane Battier',  1,  4,  9,  0,  48,  39,  55,  2,  2003
EXEC add_PlayerStatsByName 'Shane Battier',  1,  3,  8,  0,  44,  34,  50,  2,  2004
EXEC add_PlayerStatsByName 'Shane Battier',  1,  5,  9,  0,  44,  39,  49,  2,  2005
EXEC add_PlayerStatsByName 'Charlie Bell',  0,  0,  1,  0,  27,  0,  27,  0,  2002
EXEC add_PlayerStatsByName 'Michael Bradley',  0,  0,  1,  0,  52,  0,  52,  0,  2002
EXEC add_PlayerStatsByName 'Michael Bradley',  1,  6,  5,  1,  48,  16,  48,  1,  2003
EXEC add_PlayerStatsByName 'Michael Bradley',  0,  1,  1,  0,  62,  0,  62,  0,  2005
EXEC add_PlayerStatsByName 'Jamison Brewer',  0,  0,  0,  0,  40,  0,  40,  0,  2002
EXEC add_PlayerStatsByName 'Jamison Brewer',  1,  0,  2,  0,  52,  0,  52,  1,  2003
EXEC add_PlayerStatsByName 'Jamison Brewer',  1,  0,  2,  0,  37,  35,  44,  0,  2004
EXEC add_PlayerStatsByName 'Jamison Brewer',  0,  1,  1,  0,  29,  20,  33,  0,  2005
EXEC add_PlayerStatsByName 'Damone Brown',  0,  0,  1,  0,  38,  0,  38,  0,  2002
EXEC add_PlayerStatsByName 'Damone Brown',  0,  3,  5,  1,  31,  0,  31,  2,  2003
EXEC add_PlayerStatsByName 'Damone Brown',  1,  2,  3,  1,  37,  36,  40,  1,  2005
EXEC add_PlayerStatsByName 'Kedrick Brown',  0,  1,  2,  0,  32,  18,  36,  0,  2002
EXEC add_PlayerStatsByName 'Kedrick Brown',  0,  2,  2,  0,  35,  7,  36,  1,  2003
EXEC add_PlayerStatsByName 'Kedrick Brown',  1,  2,  5,  0,  46,  38,  53,  1,  2004
EXEC add_PlayerStatsByName 'Kedrick Brown',  0,  1,  1,  0,  33,  0,  33,  0,  2005
EXEC add_PlayerStatsByName 'Kwame Brown',  0,  3,  4,  0,  38,  0,  38,  1,  2002
EXEC add_PlayerStatsByName 'Kwame Brown',  0,  5,  7,  1,  44,  0,  44,  2,  2003
EXEC add_PlayerStatsByName 'Kwame Brown',  1,  7,  10,  1,  48,  50,  49,  1,  2004
EXEC add_PlayerStatsByName 'Tierre Brown',  1,  1,  3,  1,  42,  33,  44,  0,  2002
EXEC add_PlayerStatsByName 'Tierre Brown',  2,  2,  4,  1,  45,  0,  45,  0,  2003
EXEC add_PlayerStatsByName 'Tierre Brown',  2,  1,  4,  1,  35,  36,  39,  0,  2005
EXEC add_PlayerStatsByName 'Tyson Chandler',  0,  7,  6,  1,  42,  0,  42,  2,  2004
EXEC add_PlayerStatsByName 'Tyson Chandler',  0,  9,  8,  1,  49,  0,  49,  3,  2005
EXEC add_PlayerStatsByName 'Speedy Claxton',  3,  2,  7,  1,  40,  12,  40,  2,  2002
EXEC add_PlayerStatsByName 'Speedy Claxton',  2,  1,  5,  1,  46,  0,  46,  1,  2003
EXEC add_PlayerStatsByName 'Speedy Claxton',  4,  2,  10,  1,  42,  18,  43,  2,  2004
EXEC add_PlayerStatsByName 'Speedy Claxton',  6,  3,  11,  1,  42,  18,  43,  3,  2005
EXEC add_PlayerStatsByName 'Jarron Collins',  0,  4,  6,  0,  46,  0,  46,  3,  2002
EXEC add_PlayerStatsByName 'Jarron Collins',  0,  2,  5,  0,  44,  0,  44,  3,  2003
EXEC add_PlayerStatsByName 'Jarron Collins',  1,  3,  6,  1,  49,  0,  49,  3,  2004
EXEC add_PlayerStatsByName 'Jarron Collins',  1,  3,  4,  0,  41,  0,  41,  2,  2005
EXEC add_PlayerStatsByName 'Jason Collins',  1,  3,  4,  0,  42,  50,  42,  2,  2002
EXEC add_PlayerStatsByName 'Jason Collins',  1,  4,  5,  1,  41,  0,  41,  3,  2003
EXEC add_PlayerStatsByName 'Jason Collins',  2,  5,  5,  1,  42,  0,  42,  3,  2004
EXEC add_PlayerStatsByName 'Jason Collins',  1,  6,  6,  1,  41,  33,  41,  4,  2005
EXEC add_PlayerStatsByName 'Joe Crispin',  1,  0,  3,  0,  38,  38,  49,  0,  2002
EXEC add_PlayerStatsByName 'Eddy Curry',  0,  6,  14,  2,  49,  100,  49,  3,  2004
EXEC add_PlayerStatsByName 'Samuel Dalembert',  0,  7,  8,  1,  54,  0,  54,  3,  2004
EXEC add_PlayerStatsByName 'DeSagana Diop',  0,  1,  1,  0,  28,  0,  28,  1,  2005
EXEC add_PlayerStatsByName 'Predrag Drobnjak',  0,  3,  6,  0,  46,  0,  46,  1,  2002
EXEC add_PlayerStatsByName 'Predrag Drobnjak',  1,  3,  9,  0,  41,  35,  43,  2,  2003
EXEC add_PlayerStatsByName 'Predrag Drobnjak',  0,  3,  6,  0,  39,  30,  40,  1,  2004
EXEC add_PlayerStatsByName 'Predrag Drobnjak',  0,  3,  8,  1,  43,  35,  46,  1,  2005
EXEC add_PlayerStatsByName 'Maurice Evans',  0,  0,  2,  0,  47,  0,  47,  0,  2002
EXEC add_PlayerStatsByName 'Maurice Evans',  0,  3,  6,  0,  44,  32,  47,  1,  2005
EXEC add_PlayerStatsByName 'Isaac Fontaine',  0,  0,  1,  0,  21,  20,  25,  1,  2002
EXEC add_PlayerStatsByName 'Joseph Forte',  0,  0,  0,  0,  8,  0,  8,  0,  2002
EXEC add_PlayerStatsByName 'Joseph Forte',  0,  0,  1,  0,  28,  0,  28,  0,  2003
EXEC add_PlayerStatsByName 'Antonis Fotsis',  0,  2,  3,  0,  40,  30,  43,  0,  2002
EXEC add_PlayerStatsByName 'Tremaine Fowlkes',  0,  2,  4,  0,  43,  22,  44,  1,  2003
EXEC add_PlayerStatsByName 'Tremaine Fowlkes',  0,  1,  1,  0,  31,  12,  32,  1,  2004
EXEC add_PlayerStatsByName 'Tremaine Fowlkes',  0,  1,  2,  0,  52,  33,  55,  0,  2005
EXEC add_PlayerStatsByName 'Pau Gasol',  2,  8,  17,  2,  51,  20,  51,  2,  2002
EXEC add_PlayerStatsByName 'Pau Gasol',  2,  8,  19,  2,  51,  10,  51,  2,  2003
EXEC add_PlayerStatsByName 'Pau Gasol',  2,  7,  17,  2,  48,  26,  48,  2,  2004
EXEC add_PlayerStatsByName 'Pau Gasol',  2,  7,  17,  2,  51,  16,  51,  2,  2005
EXEC add_PlayerStatsByName 'Eddie Griffin',  0,  5,  8,  0,  36,  33,  43,  1,  2002
EXEC add_PlayerStatsByName 'Eddie Griffin',  1,  6,  8,  1,  40,  33,  44,  1,  2003
EXEC add_PlayerStatsByName 'Eddie Griffin',  0,  6,  7,  0,  38,  32,  45,  1,  2005
EXEC add_PlayerStatsByName 'Tang Hamilton',  0,  2,  2,  0,  52,  0,  52,  1,  2002
EXEC add_PlayerStatsByName 'Trenton Hassell',  2,  3,  8,  1,  42,  36,  47,  2,  2002
EXEC add_PlayerStatsByName 'Trenton Hassell',  1,  3,  4,  1,  36,  32,  38,  2,  2003
EXEC add_PlayerStatsByName 'Trenton Hassell',  1,  3,  5,  0,  46,  30,  47,  2,  2004
EXEC add_PlayerStatsByName 'Trenton Hassell',  1,  2,  6,  0,  47,  9,  47,  2,  2005
EXEC add_PlayerStatsByName 'Kirk Haston',  0,  1,  1,  0,  28,  0,  28,  0,  2002
EXEC add_PlayerStatsByName 'Kirk Haston',  0,  0,  0,  0,  11,  0,  11,  0,  2003
EXEC add_PlayerStatsByName 'Brendan Haywood',  0,  5,  7,  1,  51,  0,  51,  2,  2004
EXEC add_PlayerStatsByName 'Steven Hunter',  0,  3,  4,  0,  61,  0,  61,  1,  2005
EXEC add_PlayerStatsByName 'Mike James',  1,  0,  2,  0,  34,  38,  44,  1,  2002
EXEC add_PlayerStatsByName 'Mike James',  3,  1,  7,  1,  37,  29,  43,  2,  2003
EXEC add_PlayerStatsByName 'Mike James',  4,  2,  9,  1,  41,  37,  49,  1,  2004
EXEC add_PlayerStatsByName 'Mike James',  3,  2,  11,  1,  44,  38,  50,  2,  2005
EXEC add_PlayerStatsByName 'Richard Jefferson',  1,  3,  9,  1,  45,  23,  46,  2,  2002
EXEC add_PlayerStatsByName 'Richard Jefferson',  2,  6,  15,  2,  50,  25,  50,  2,  2003
EXEC add_PlayerStatsByName 'Richard Jefferson',  3,  5,  18,  2,  49,  36,  51,  2,  2004
EXEC add_PlayerStatsByName 'Richard Jefferson',  4,  7,  22,  4,  42,  33,  44,  3,  2005
EXEC add_PlayerStatsByName 'Joe Johnson',  2,  3,  7,  0,  43,  29,  46,  1,  2002
EXEC add_PlayerStatsByName 'Joe Johnson',  2,  3,  9,  1,  39,  36,  44,  1,  2003
EXEC add_PlayerStatsByName 'Joe Johnson',  4,  4,  16,  2,  43,  30,  46,  2,  2004
EXEC add_PlayerStatsByName 'Joe Johnson',  3,  5,  17,  1,  46,  47,  53,  2,  2005
EXEC add_PlayerStatsByName 'Andrei Kirilenko',  1,  4,  10,  1,  45,  25,  47,  1,  2002
EXEC add_PlayerStatsByName 'Andrei Kirilenko',  1,  5,  12,  1,  49,  32,  51,  2,  2003
EXEC add_PlayerStatsByName 'Andrei Kirilenko',  3,  8,  16,  2,  44,  33,  47,  2,  2004
EXEC add_PlayerStatsByName 'Andrei Kirilenko',  3,  6,  15,  2,  49,  29,  52,  2,  2005
EXEC add_PlayerStatsByName 'Terence Morris',  0,  3,  3,  0,  38,  19,  41,  1,  2002
EXEC add_PlayerStatsByName 'Terence Morris',  0,  2,  3,  0,  46,  21,  48,  0,  2003
EXEC add_PlayerStatsByName 'Troy Murphy',  0,  3,  5,  1,  42,  33,  42,  2,  2002
EXEC add_PlayerStatsByName 'Troy Murphy',  1,  10,  11,  1,  45,  21,  45,  3,  2003
EXEC add_PlayerStatsByName 'Troy Murphy',  0,  6,  10,  1,  44,  29,  45,  2,  2004
EXEC add_PlayerStatsByName 'Dean Oliver',  1,  0,  2,  0,  37,  15,  39,  0,  2002
EXEC add_PlayerStatsByName 'Dean Oliver',  1,  1,  1,  0,  24,  16,  25,  0,  2003
EXEC add_PlayerStatsByName 'Tony Parker',  4,  2,  9,  2,  41,  32,  46,  2,  2002
EXEC add_PlayerStatsByName 'Tony Parker',  5,  2,  15,  2,  46,  33,  50,  2,  2003
EXEC add_PlayerStatsByName 'Tony Parker',  5,  3,  14,  2,  44,  31,  48,  2,  2004
EXEC add_PlayerStatsByName 'Vladimir Radmanovic',  1,  3,  6,  1,  41,  42,  50,  2,  2002
EXEC add_PlayerStatsByName 'Vladimir Radmanovic',  1,  4,  10,  1,  41,  35,  48,  1,  2003
EXEC add_PlayerStatsByName 'Vladimir Radmanovic',  1,  5,  12,  1,  42,  37,  51,  2,  2004
EXEC add_PlayerStatsByName 'Zach Randolph',  0,  4,  8,  0,  51,  0,  51,  1,  2003
EXEC add_PlayerStatsByName 'Zach Randolph',  2,  10,  20,  3,  48,  20,  48,  2,  2004
EXEC add_PlayerStatsByName 'Jason Richardson',  3,  4,  14,  2,  42,  33,  46,  2,  2002
EXEC add_PlayerStatsByName 'Jason Richardson',  3,  4,  15,  2,  41,  36,  46,  2,  2003
EXEC add_PlayerStatsByName 'Jason Richardson',  2,  6,  18,  2,  43,  28,  46,  2,  2004
EXEC add_PlayerStatsByName 'Norm Richardson',  0,  0,  2,  0,  38,  50,  46,  0,  2002
EXEC add_PlayerStatsByName 'Jeryl Sasser',  0,  2,  2,  0,  30,  29,  34,  1,  2003
EXEC add_PlayerStatsByName 'Kenny Satterfield',  3,  1,  5,  1,  36,  25,  38,  1,  2002
EXEC add_PlayerStatsByName 'Kenny Satterfield',  1,  1,  3,  1,  30,  17,  31,  0,  2003
EXEC add_PlayerStatsByName 'Brian Scalabrine',  0,  1,  2,  0,  34,  30,  36,  1,  2002
EXEC add_PlayerStatsByName 'Brian Scalabrine',  0,  2,  3,  0,  40,  35,  44,  1,  2003
EXEC add_PlayerStatsByName 'Brian Scalabrine',  0,  2,  3,  0,  39,  24,  41,  1,  2004
EXEC add_PlayerStatsByName 'Ansu Sesay',  0,  1,  3,  0,  45,  28,  47,  1,  2004
EXEC add_PlayerStatsByName 'Bobby Simmons',  0,  1,  3,  0,  45,  28,  47,  1,  2002
EXEC add_PlayerStatsByName 'Bobby Simmons',  0,  2,  3,  0,  39,  0,  39,  1,  2003
EXEC add_PlayerStatsByName 'Bobby Simmons',  1,  4,  7,  1,  39,  16,  39,  3,  2004
EXEC add_PlayerStatsByName 'Will Solomon',  1,  1,  5,  1,  34,  28,  41,  1,  2002
EXEC add_PlayerStatsByName 'Jamaal Tinsley',  8,  3,  9,  3,  38,  24,  40,  3,  2002
EXEC add_PlayerStatsByName 'Jamaal Tinsley',  7,  3,  7,  2,  39,  27,  43,  2,  2003
EXEC add_PlayerStatsByName 'Jamaal Tinsley',  5,  2,  8,  2,  41,  37,  51,  2,  2004
EXEC add_PlayerStatsByName 'Jeff Trepagnier',  1,  1,  1,  0,  30,  0,  30,  0,  2002
EXEC add_PlayerStatsByName 'Jeff Trepagnier',  0,  2,  5,  1,  42,  50,  47,  0,  2003
EXEC add_PlayerStatsByName 'Jeff Trepagnier',  0,  1,  2,  0,  26,  50,  28,  0,  2004
EXEC add_PlayerStatsByName 'Gerald Wallace',  0,  1,  3,  0,  42,  0,  42,  0,  2002
EXEC add_PlayerStatsByName 'Gerald Wallace',  0,  2,  4,  0,  49,  25,  49,  1,  2003
EXEC add_PlayerStatsByName 'Gerald Wallace',  0,  2,  2,  0,  36,  0,  36,  1,  2004
EXEC add_PlayerStatsByName 'Earl Watson',  2,  1,  3,  0,  45,  36,  49,  1,  2002
EXEC add_PlayerStatsByName 'Earl Watson',  2,  2,  5,  1,  43,  34,  47,  1,  2003
EXEC add_PlayerStatsByName 'Earl Watson',  5,  2,  5,  1,  37,  24,  39,  2,  2004
EXEC add_PlayerStatsByName 'Rodney White',  0,  1,  3,  0,  35,  22,  36,  0,  2002
EXEC add_PlayerStatsByName 'Rodney White',  1,  3,  9,  2,  40,  23,  43,  1,  2003
EXEC add_PlayerStatsByName 'Rodney White',  0,  2,  7,  1,  45,  37,  49,  1,  2004
EXEC add_PlayerStatsByName 'Loren Woods',  0,  2,  1,  0,  34,  0,  34,  1,  2002
EXEC add_PlayerStatsByName 'Loren Woods',  0,  2,  2,  0,  38,  33,  38,  1,  2003
EXEC add_PlayerStatsByName 'Lonny Baxter',  0,  3,  4,  0,  46,  0,  46,  2,  2003
EXEC add_PlayerStatsByName 'Lonny Baxter',  0,  3,  4,  0,  49,  33,  49,  2,  2004
EXEC add_PlayerStatsByName 'Carlos Boozer',  1,  7,  10,  1,  53,  0,  53,  2,  2003
EXEC add_PlayerStatsByName 'Carlos Boozer',  2,  11,  15,  1,  52,  16,  52,  2,  2004
EXEC add_PlayerStatsByName 'Carlos Boozer',  2,  9,  17,  2,  52,  0,  52,  3,  2005
EXEC add_PlayerStatsByName 'J.R. Bremer',  2,  2,  8,  0,  36,  35,  47,  1,  2003
EXEC add_PlayerStatsByName 'J.R. Bremer',  1,  1,  3,  0,  27,  25,  33,  0,  2004
EXEC add_PlayerStatsByName 'Devin Brown',  0,  1,  3,  0,  34,  0,  34,  1,  2003
EXEC add_PlayerStatsByName 'Devin Brown',  0,  2,  4,  0,  43,  28,  44,  1,  2004
EXEC add_PlayerStatsByName 'Devin Brown',  1,  2,  7,  0,  42,  37,  47,  1,  2005
EXEC add_PlayerStatsByName 'Pat Burke',  0,  2,  4,  0,  38,  14,  38,  1,  2003
EXEC add_PlayerStatsByName 'Caron Butler',  2,  5,  15,  2,  41,  31,  43,  2,  2003
EXEC add_PlayerStatsByName 'Caron Butler',  1,  4,  9,  1,  38,  23,  38,  2,  2004
EXEC add_PlayerStatsByName 'Caron Butler',  1,  5,  15,  1,  44,  30,  46,  2,  2005
EXEC add_PlayerStatsByName 'Rasual Butler',  1,  2,  7,  1,  36,  29,  40,  1,  2003
EXEC add_PlayerStatsByName 'Rasual Butler',  0,  1,  6,  0,  47,  46,  57,  1,  2004
EXEC add_PlayerStatsByName 'Rasual Butler',  1,  2,  6,  0,  39,  37,  46,  1,  2005
EXEC add_PlayerStatsByName 'Dan Dickau',  1,  0,  3,  1,  41,  36,  47,  1,  2003
EXEC add_PlayerStatsByName 'Dan Dickau',  0,  0,  2,  0,  37,  33,  42,  1,  2004
EXEC add_PlayerStatsByName 'Dan Dickau',  4,  2,  12,  2,  40,  34,  46,  2,  2005
EXEC add_PlayerStatsByName 'Juan Dixon',  1,  1,  6,  1,  38,  29,  43,  1,  2003
EXEC add_PlayerStatsByName 'Juan Dixon',  1,  2,  9,  1,  38,  29,  43,  1,  2004
EXEC add_PlayerStatsByName 'Juan Dixon',  1,  1,  8,  1,  41,  32,  47,  1,  2005
EXEC add_PlayerStatsByName 'Melvin Ely',  0,  2,  3,  0,  43,  0,  43,  1,  2004
EXEC add_PlayerStatsByName 'Reggie Evans',  0,  5,  2,  0,  40,  0,  40,  2,  2004
EXEC add_PlayerStatsByName 'Reggie Evans',  0,  9,  4,  1,  47,  0,  47,  2,  2005
EXEC add_PlayerStatsByName 'Dan Gadzuric',  0,  4,  3,  0,  48,  0,  48,  2,  2003
EXEC add_PlayerStatsByName 'Dan Gadzuric',  0,  4,  5,  0,  52,  0,  52,  2,  2004
EXEC add_PlayerStatsByName 'Gordan Giricek',  1,  3,  12,  1,  43,  34,  48,  2,  2003
EXEC add_PlayerStatsByName 'Gordan Giricek',  1,  3,  11,  1,  43,  39,  47,  2,  2004
EXEC add_PlayerStatsByName 'Gordan Giricek',  1,  2,  8,  1,  44,  36,  47,  1,  2005
EXEC add_PlayerStatsByName 'Drew Gooden',  1,  6,  12,  2,  45,  29,  46,  2,  2003
EXEC add_PlayerStatsByName 'Drew Gooden',  1,  6,  11,  1,  44,  21,  45,  2,  2004
EXEC add_PlayerStatsByName 'Drew Gooden',  1,  9,  14,  1,  49,  17,  49,  2,  2005
EXEC add_PlayerStatsByName 'Marcus Haislip',  0,  1,  4,  0,  43,  25,  44,  1,  2003
EXEC add_PlayerStatsByName 'Marcus Haislip',  0,  1,  3,  0,  48,  50,  49,  0,  2004
EXEC add_PlayerStatsByName 'Marcus Haislip',  0,  1,  3,  0,  34,  0,  34,  1,  2005
EXEC add_PlayerStatsByName 'Adam Harrington',  0,  0,  1,  0,  29,  35,  36,  0,  2003
EXEC add_PlayerStatsByName 'Junior Harrington',  3,  3,  5,  1,  36,  25,  36,  3,  2003
EXEC add_PlayerStatsByName 'Junior Harrington',  2,  2,  5,  1,  36,  31,  37,  2,  2005
EXEC add_PlayerStatsByName 'Juaquin Hawkins',  0,  1,  2,  0,  38,  41,  41,  1,  2003
EXEC add_PlayerStatsByName 'Ryan Humphrey',  0,  1,  1,  1,  25,  0,  25,  1,  2004
EXEC add_PlayerStatsByName 'Ryan Humphrey',  0,  2,  2,  0,  40,  0,  40,  1,  2005
EXEC add_PlayerStatsByName 'Casey Jacobsen',  1,  1,  5,  0,  37,  31,  45,  1,  2003
EXEC add_PlayerStatsByName 'Casey Jacobsen',  1,  2,  6,  0,  41,  41,  52,  1,  2004
EXEC add_PlayerStatsByName 'Casey Jacobsen',  1,  2,  6,  0,  40,  37,  48,  1,  2005
EXEC add_PlayerStatsByName 'Marko Jaric',  2,  2,  7,  1,  40,  31,  46,  1,  2003
EXEC add_PlayerStatsByName 'Marko Jaric',  4,  3,  8,  2,  38,  34,  44,  2,  2004
EXEC add_PlayerStatsByName 'Marko Jaric',  6,  3,  9,  2,  41,  37,  47,  2,  2005
EXEC add_PlayerStatsByName 'Chris Jefferies',  0,  1,  3,  0,  38,  33,  43,  1,  2003
EXEC add_PlayerStatsByName 'Chris Jefferies',  0,  1,  4,  0,  37,  40,  49,  1,  2004
EXEC add_PlayerStatsByName 'Jared Jeffries',  0,  2,  4,  1,  47,  50,  50,  1,  2003
EXEC add_PlayerStatsByName 'Jared Jeffries',  1,  5,  5,  1,  37,  16,  38,  2,  2004
EXEC add_PlayerStatsByName 'Jared Jeffries',  2,  4,  6,  1,  46,  31,  48,  2,  2005
EXEC add_PlayerStatsByName 'Fred Jones',  0,  0,  1,  0,  37,  28,  41,  0,  2003
EXEC add_PlayerStatsByName 'Fred Jones',  2,  1,  4,  0,  39,  30,  43,  1,  2004
EXEC add_PlayerStatsByName 'Fred Jones',  2,  3,  10,  1,  42,  38,  49,  2,  2005
EXEC add_PlayerStatsByName 'Sean Lampley',  0,  2,  4,  0,  43,  0,  43,  1,  2003
EXEC add_PlayerStatsByName 'Tito Maddox',  0,  0,  1,  0,  25,  0,  25,  0,  2003
EXEC add_PlayerStatsByName 'Roger Mason',  0,  0,  1,  0,  35,  33,  45,  1,  2003
EXEC add_PlayerStatsByName 'Roger Mason',  1,  1,  3,  0,  32,  33,  39,  1,  2004
EXEC add_PlayerStatsByName 'Ronald Murray',  0,  0,  1,  0,  35,  0,  35,  0,  2003
EXEC add_PlayerStatsByName 'Ronald Murray',  2,  2,  12,  1,  42,  29,  46,  1,  2004
EXEC add_PlayerStatsByName 'Mehmet Okur',  1,  4,  6,  0,  42,  33,  47,  2,  2003
EXEC add_PlayerStatsByName 'Mehmet Okur',  1,  5,  9,  1,  46,  37,  48,  1,  2004
EXEC add_PlayerStatsByName 'Jannero Pargo',  1,  1,  2,  0,  39,  29,  43,  1,  2003
EXEC add_PlayerStatsByName 'Jannero Pargo',  2,  1,  6,  1,  40,  35,  46,  1,  2004
EXEC add_PlayerStatsByName 'Smush Parker',  2,  1,  6,  2,  40,  32,  45,  1,  2003
EXEC add_PlayerStatsByName 'Tayshaun Prince',  0,  1,  3,  0,  44,  42,  53,  0,  2003
EXEC add_PlayerStatsByName 'Tayshaun Prince',  2,  4,  10,  1,  46,  36,  50,  1,  2004
EXEC add_PlayerStatsByName 'Igor Rakocevic',  0,  0,  1,  0,  37,  41,  42,  0,  2003
EXEC add_PlayerStatsByName 'Antoine Rigaudeau',  0,  0,  1,  0,  22,  20,  24,  1,  2003
EXEC add_PlayerStatsByName 'Kareem Rush',  0,  1,  3,  0,  39,  27,  43,  0,  2003
EXEC add_PlayerStatsByName 'Kareem Rush',  0,  1,  6,  0,  44,  34,  49,  1,  2004
EXEC add_PlayerStatsByName 'John Salmons',  0,  0,  2,  0,  41,  32,  45,  0,  2003
EXEC add_PlayerStatsByName 'John Salmons',  1,  2,  5,  1,  38,  34,  44,  1,  2004
EXEC add_PlayerStatsByName 'Predrag Savovic',  0,  0,  3,  0,  31,  15,  33,  1,  2003
EXEC add_PlayerStatsByName 'Paul Shirley',  0,  2,  3,  1,  43,  0,  43,  1,  2004
EXEC add_PlayerStatsByName 'Tamar Slay',  0,  0,  2,  0,  37,  28,  41,  0,  2003
EXEC add_PlayerStatsByName 'Tamar Slay',  0,  1,  2,  0,  35,  33,  38,  0,  2004
EXEC add_PlayerStatsByName 'Amar"e Stoudemire',  1,  8,  13,  2,  47,  20,  47,  3,  2003
EXEC add_PlayerStatsByName 'Amar"e Stoudemire',  1,  9,  20,  3,  47,  20,  47,  3,  2004
EXEC add_PlayerStatsByName 'Nikoloz Tskitishvili',  1,  2,  3,  1,  29,  24,  34,  1,  2003
EXEC add_PlayerStatsByName 'Nikoloz Tskitishvili',  0,  1,  2,  0,  32,  27,  34,  1,  2004
EXEC add_PlayerStatsByName 'Dajuan Wagner',  2,  1,  13,  1,  36,  31,  41,  2,  2003
EXEC add_PlayerStatsByName 'Dajuan Wagner',  1,  1,  6,  0,  36,  36,  41,  2,  2004
EXEC add_PlayerStatsByName 'Chris Wilcox',  0,  4,  8,  1,  52,  0,  52,  2,  2004
EXEC add_PlayerStatsByName 'Mike Wilks',  2,  1,  3,  0,  33,  28,  37,  1,  2003
EXEC add_PlayerStatsByName 'Mike Wilks',  0,  0,  1,  0,  47,  60,  55,  0,  2004
EXEC add_PlayerStatsByName 'Frank Williams',  1,  0,  1,  0,  27,  37,  36,  1,  2003
EXEC add_PlayerStatsByName 'Frank Williams',  2,  0,  3,  1,  38,  30,  42,  1,  2004
EXEC add_PlayerStatsByName 'Jay Williams',  4,  2,  9,  2,  39,  32,  44,  2,  2003
EXEC add_PlayerStatsByName 'Qyntel Woods',  0,  1,  2,  0,  50,  33,  51,  0,  2003
EXEC add_PlayerStatsByName 'Qyntel Woods',  0,  2,  3,  0,  37,  34,  39,  1,  2004
EXEC add_PlayerStatsByName 'Vincent Yarbrough',  2,  2,  6,  1,  39,  26,  41,  2,  2003
EXEC add_PlayerStatsByName 'Carmelo Anthony',  2,  6,  21,  3,  42,  32,  44,  2,  2004
EXEC add_PlayerStatsByName 'Carmelo Anthony',  2,  5,  20,  3,  43,  26,  44,  3,  2005
EXEC add_PlayerStatsByName 'Marcus Banks',  1,  1,  4,  1,  40,  35,  43,  1,  2005
EXEC add_PlayerStatsByName 'Leandro Barbosa',  2,  2,  7,  1,  47,  36,  54,  2,  2005
EXEC add_PlayerStatsByName 'Matt Barnes',  1,  3,  3,  1,  41,  22,  42,  1,  2005
EXEC add_PlayerStatsByName 'Troy Bell',  0,  0,  1,  1,  22,  0,  22,  1,  2004
EXEC add_PlayerStatsByName 'Steve Blake',  2,  1,  5,  1,  38,  37,  47,  1,  2004
EXEC add_PlayerStatsByName 'Steve Blake',  1,  1,  4,  0,  32,  38,  42,  1,  2005
EXEC add_PlayerStatsByName 'Keith Bogans',  1,  4,  6,  1,  40,  35,  47,  1,  2004
EXEC add_PlayerStatsByName 'Keith Bogans',  1,  3,  9,  1,  38,  32,  42,  2,  2005
EXEC add_PlayerStatsByName 'Curtis Borchardt',  0,  3,  3,  1,  39,  0,  39,  2,  2004
EXEC add_PlayerStatsByName 'Matt Carroll',  0,  0,  1,  0,  43,  33,  46,  0,  2004
EXEC add_PlayerStatsByName 'Matt Carroll',  0,  2,  9,  1,  38,  33,  42,  1,  2005
EXEC add_PlayerStatsByName 'Maurice Carter',  0,  1,  4,  0,  31,  36,  37,  1,  2004
EXEC add_PlayerStatsByName 'Brian Cook',  0,  2,  4,  0,  47,  0,  47,  1,  2004
EXEC add_PlayerStatsByName 'Brian Cook',  0,  3,  6,  0,  41,  39,  50,  1,  2005
EXEC add_PlayerStatsByName 'Omar Cook',  1,  0,  0,  0,  25,  0,  25,  0,  2004
EXEC add_PlayerStatsByName 'Omar Cook',  4,  1,  4,  1,  41,  0,  41,  1,  2005
EXEC add_PlayerStatsByName 'Marquis Daniels',  2,  2,  8,  0,  49,  30,  50,  0,  2004
EXEC add_PlayerStatsByName 'Marquis Daniels',  2,  3,  9,  1,  43,  20,  44,  2,  2005
EXEC add_PlayerStatsByName 'Josh Davis',  0,  1,  1,  0,  40,  0,  40,  0,  2004
EXEC add_PlayerStatsByName 'Josh Davis',  0,  1,  2,  0,  37,  35,  46,  1,  2005
EXEC add_PlayerStatsByName 'Boris Diaw',  2,  4,  4,  1,  44,  23,  45,  2,  2004
EXEC add_PlayerStatsByName 'Boris Diaw',  2,  2,  4,  1,  42,  18,  43,  1,  2005
EXEC add_PlayerStatsByName 'Kaniel Dickens',  0,  0,  1,  0,  28,  33,  39,  0,  2005
EXEC add_PlayerStatsByName 'Ronald Dupree',  1,  3,  6,  1,  39,  44,  40,  2,  2004
EXEC add_PlayerStatsByName 'Ronald Dupree',  0,  2,  3,  0,  48,  50,  48,  1,  2005
EXEC add_PlayerStatsByName 'Ndudi Ebi',  0,  8,  13,  1,  52,  0,  52,  3,  2005
EXEC add_PlayerStatsByName 'Francisco Elson',  0,  3,  3,  0,  47,  0,  47,  2,  2004
EXEC add_PlayerStatsByName 'Francisco Elson',  0,  3,  3,  0,  46,  33,  47,  1,  2005
EXEC add_PlayerStatsByName 'Desmond Ferguson',  0,  0,  1,  0,  41,  37,  54,  0,  2004
EXEC add_PlayerStatsByName 'T.J. Ford',  6,  3,  7,  2,  38,  23,  39,  2,  2004
EXEC add_PlayerStatsByName 'Richie Frahm',  0,  1,  3,  0,  45,  37,  57,  0,  2004
EXEC add_PlayerStatsByName 'Richie Frahm',  0,  1,  3,  0,  40,  38,  51,  0,  2005
EXEC add_PlayerStatsByName 'Reece Gaines',  1,  1,  1,  0,  29,  30,  30,  0,  2004
EXEC add_PlayerStatsByName 'Reece Gaines',  0,  0,  2,  0,  34,  28,  38,  0,  2005
EXEC add_PlayerStatsByName 'Alex Garcia',  2,  1,  5,  1,  34,  27,  39,  1,  2005
EXEC add_PlayerStatsByName 'Willie Green',  1,  1,  6,  1,  40,  31,  42,  1,  2004
EXEC add_PlayerStatsByName 'Willie Green',  1,  2,  7,  1,  36,  28,  40,  2,  2005
EXEC add_PlayerStatsByName 'Ben Handlogten',  0,  3,  4,  0,  51,  0,  51,  2,  2005
EXEC add_PlayerStatsByName 'Travis Hansen',  0,  1,  3,  0,  35,  30,  38,  1,  2004
EXEC add_PlayerStatsByName 'Udonis Haslem',  0,  6,  7,  1,  45,  0,  45,  2,  2004
EXEC add_PlayerStatsByName 'Udonis Haslem',  1,  9,  10,  1,  54,  0,  54,  3,  2005
EXEC add_PlayerStatsByName 'Jarvis Hayes',  1,  3,  9,  1,  40,  30,  42,  2,  2004
EXEC add_PlayerStatsByName 'Jarvis Hayes',  1,  4,  10,  1,  38,  34,  42,  2,  2005
EXEC add_PlayerStatsByName 'Kirk Hinrich',  6,  3,  12,  2,  38,  39,  47,  3,  2004
EXEC add_PlayerStatsByName 'Kirk Hinrich',  6,  3,  15,  2,  39,  35,  46,  3,  2005
EXEC add_PlayerStatsByName 'Josh Howard',  1,  5,  8,  1,  43,  30,  44,  2,  2004
EXEC add_PlayerStatsByName 'Josh Howard',  1,  6,  12,  1,  47,  29,  49,  2,  2005
EXEC add_PlayerStatsByName 'Brandon Hunter',  0,  3,  3,  0,  45,  0,  45,  1,  2004
EXEC add_PlayerStatsByName 'LeBron James',  5,  5,  20,  3,  41,  28,  43,  1,  2004
EXEC add_PlayerStatsByName 'LeBron James',  7,  7,  27,  3,  47,  35,  50,  1,  2005
EXEC add_PlayerStatsByName 'Britton Johnsen',  0,  2,  2,  0,  28,  8,  29,  1,  2004
EXEC add_PlayerStatsByName 'Britton Johnsen',  0,  1,  2,  0,  27,  0,  27,  1,  2005
EXEC add_PlayerStatsByName 'Linton Johnson',  0,  4,  4,  0,  35,  21,  37,  2,  2004
EXEC add_PlayerStatsByName 'Linton Johnson',  0,  1,  0,  0,  0,  0,  0,  0,  2005
EXEC add_PlayerStatsByName 'Dahntay Jones',  0,  1,  1,  0,  28,  25,  29,  1,  2004
EXEC add_PlayerStatsByName 'Dahntay Jones',  0,  1,  4,  0,  43,  38,  49,  1,  2005
EXEC add_PlayerStatsByName 'James Jones',  0,  0,  1,  0,  22,  25,  27,  0,  2004
EXEC add_PlayerStatsByName 'James Jones',  0,  2,  4,  0,  39,  39,  50,  1,  2005
EXEC add_PlayerStatsByName 'Chris Kaman',  1,  5,  6,  1,  46,  0,  46,  2,  2004
EXEC add_PlayerStatsByName 'Chris Kaman',  1,  6,  9,  1,  49,  0,  49,  2,  2005
EXEC add_PlayerStatsByName 'Jason Kapono',  0,  1,  3,  0,  40,  47,  48,  1,  2004
EXEC add_PlayerStatsByName 'Jason Kapono',  0,  2,  8,  0,  40,  41,  46,  1,  2005
EXEC add_PlayerStatsByName 'Kyle Korver',  0,  1,  4,  0,  35,  39,  47,  1,  2004
EXEC add_PlayerStatsByName 'Kyle Korver',  2,  4,  11,  1,  41,  40,  56,  3,  2005
EXEC add_PlayerStatsByName 'Maciej Lampe',  0,  2,  4,  0,  48,  0,  48,  1,  2004
EXEC add_PlayerStatsByName 'Maciej Lampe',  0,  2,  3,  0,  37,  50,  37,  1,  2005
EXEC add_PlayerStatsByName 'Keith McLeod',  1,  1,  2,  0,  32,  10,  33,  1,  2004
EXEC add_PlayerStatsByName 'Keith McLeod',  4,  2,  7,  1,  35,  25,  37,  2,  2005
EXEC add_PlayerStatsByName 'Darko Milicic',  0,  1,  1,  0,  26,  0,  26,  1,  2004
EXEC add_PlayerStatsByName 'Sasha Pavlovic',  0,  2,  4,  0,  39,  27,  42,  2,  2004
EXEC add_PlayerStatsByName 'Kirk Penney',  0,  0,  1,  1,  16,  33,  25,  0,  2004
EXEC add_PlayerStatsByName 'Zoran Planinic',  1,  1,  3,  0,  41,  28,  44,  1,  2004
EXEC add_PlayerStatsByName 'Luke Ridnour',  2,  1,  5,  1,  41,  33,  45,  1,  2004
EXEC add_PlayerStatsByName 'Theron Smith',  0,  2,  2,  0,  37,  50,  44,  0,  2004
EXEC add_PlayerStatsByName 'Mike Sweetney',  0,  3,  4,  0,  49,  0,  49,  1,  2004
EXEC add_PlayerStatsByName 'Ime Udoka',  0,  1,  2,  0,  33,  0,  33,  0,  2004
EXEC add_PlayerStatsByName 'Dwyane Wade',  4,  4,  16,  3,  46,  30,  47,  2,  2004
EXEC add_PlayerStatsByName 'Luke Walton',  1,  1,  2,  0,  42,  33,  46,  1,  2004
EXEC add_PlayerStatsByName 'David West',  0,  4,  3,  0,  47,  0,  47,  1,  2004
EXEC add_PlayerStatsByName 'Mo Williams',  1,  1,  5,  0,  38,  25,  39,  1,  2004
EXEC add_PlayerStatsByName 'Tony Allen',  0,  2,  6,  1,  47,  38,  49,  2,  2005
EXEC add_PlayerStatsByName 'Trevor Ariza',  1,  3,  5,  0,  44,  23,  44,  1,  2005
EXEC add_PlayerStatsByName 'Andre Barrett',  1,  1,  3,  0,  36,  26,  41,  1,  2005
EXEC add_PlayerStatsByName 'Tony Bobbitt',  0,  1,  2,  0,  40,  50,  50,  0,  2005
EXEC add_PlayerStatsByName 'Matt Bonner',  0,  3,  7,  0,  53,  42,  57,  2,  2005
EXEC add_PlayerStatsByName 'Antonio Burks',  1,  0,  3,  0,  46,  27,  49,  1,  2005
EXEC add_PlayerStatsByName 'Lionel Chalmers',  1,  0,  3,  0,  33,  24,  38,  0,  2005
EXEC add_PlayerStatsByName 'Josh Childress',  1,  6,  10,  1,  47,  23,  48,  2,  2005
EXEC add_PlayerStatsByName 'Nick Collison',  0,  4,  5,  0,  53,  0,  53,  3,  2005
EXEC add_PlayerStatsByName 'Erik Daniels',  0,  0,  0,  0,  33,  50,  36,  0,  2005
EXEC add_PlayerStatsByName 'Carlos Delfino',  1,  1,  3,  0,  35,  25,  39,  1,  2005
EXEC add_PlayerStatsByName 'Luol Deng',  2,  5,  11,  1,  43,  26,  45,  1,  2005
EXEC add_PlayerStatsByName 'Chris Duhon',  4,  2,  5,  1,  35,  35,  44,  2,  2005
EXEC add_PlayerStatsByName 'Luis Flores',  0,  0,  2,  0,  48,  50,  56,  0,  2005
EXEC add_PlayerStatsByName 'Matt Freije',  0,  2,  4,  0,  29,  25,  34,  1,  2005
EXEC add_PlayerStatsByName 'Ben Gordon',  2,  2,  15,  2,  41,  40,  47,  2,  2005
EXEC add_PlayerStatsByName 'Devin Harris',  2,  1,  5,  1,  42,  33,  48,  1,  2005
EXEC add_PlayerStatsByName 'Dwight Howard',  0,  10,  12,  2,  52,  0,  52,  2,  2005
EXEC add_PlayerStatsByName 'Kris Humphries',  0,  2,  4,  0,  40,  33,  40,  1,  2005
EXEC add_PlayerStatsByName 'Andre Iguodala',  3,  5,  9,  1,  49,  33,  53,  2,  2005
EXEC add_PlayerStatsByName 'Royal Ivey',  1,  1,  3,  0,  42,  33,  43,  2,  2005
EXEC add_PlayerStatsByName 'Al Jefferson',  0,  4,  6,  0,  52,  0,  52,  2,  2005
EXEC add_PlayerStatsByName 'Horace Jenkins',  0,  0,  2,  0,  33,  0,  33,  0,  2005
EXEC add_PlayerStatsByName 'Mario Kasun',  0,  2,  2,  0,  48,  0,  48,  1,  2005
EXEC add_PlayerStatsByName 'Viktor Khryapa',  0,  3,  4,  1,  43,  36,  45,  2,  2005
EXEC add_PlayerStatsByName 'Nenad Krstic',  1,  5,  10,  1,  49,  0,  49,  3,  2005
EXEC add_PlayerStatsByName 'Shaun Livingston',  5,  3,  7,  2,  41,  0,  41,  2,  2005
EXEC add_PlayerStatsByName 'Kevin Martin',  0,  1,  2,  0,  38,  20,  40,  0,  2005

--ADD TEAM STATS

EXEC add_TeamStatsByName 'Atlanta Hawks', 50, 32, 1980, 46, 104, 17, 18
EXEC add_TeamStatsByName 'Atlanta Hawks', 31, 51, 1981, 47, 104, 12, 19
EXEC add_TeamStatsByName 'Atlanta Hawks', 42, 40, 1982, 47, 100, 21, 16
EXEC add_TeamStatsByName 'Atlanta Hawks', 43, 39, 1983, 46, 101, 23, 17
EXEC add_TeamStatsByName 'Atlanta Hawks', 40, 42, 1984, 47, 101, 21, 16
EXEC add_TeamStatsByName 'Atlanta Hawks', 34, 48, 1985, 48, 106, 31, 17
EXEC add_TeamStatsByName 'Atlanta Hawks', 50, 32, 1986, 49, 108, 19, 18
EXEC add_TeamStatsByName 'Atlanta Hawks', 57, 25, 1987, 48, 110, 31, 15
EXEC add_TeamStatsByName 'Atlanta Hawks', 50, 32, 1988, 48, 107, 30, 14
EXEC add_TeamStatsByName 'Atlanta Hawks', 52, 30, 1989, 47, 111, 27, 15
EXEC add_TeamStatsByName 'Atlanta Hawks', 41, 41, 1990, 48, 108, 30, 15
EXEC add_TeamStatsByName 'Atlanta Hawks', 43, 39, 1991, 46, 109, 32, 15
EXEC add_TeamStatsByName 'Atlanta Hawks', 38, 44, 1992, 46, 106, 31, 15
EXEC add_TeamStatsByName 'Atlanta Hawks', 43, 39, 1993, 46, 107, 35, 16
EXEC add_TeamStatsByName 'Atlanta Hawks', 57, 25, 1994, 46, 101, 32, 15
EXEC add_TeamStatsByName 'Atlanta Hawks', 42, 40, 1995, 44, 96, 34, 14
EXEC add_TeamStatsByName 'Atlanta Hawks', 46, 36, 1996, 44, 98, 35, 14
EXEC add_TeamStatsByName 'Atlanta Hawks', 56, 26, 1997, 44, 94, 35, 14
EXEC add_TeamStatsByName 'Atlanta Hawks', 50, 32, 1998, 45, 95, 33, 14
EXEC add_TeamStatsByName 'Atlanta Hawks', 31, 19, 1999, 40, 86, 30, 14
EXEC add_TeamStatsByName 'Atlanta Hawks', 28, 54, 2000, 44, 94, 31, 15
EXEC add_TeamStatsByName 'Atlanta Hawks', 25, 57, 2001, 43, 90, 35, 16
EXEC add_TeamStatsByName 'Atlanta Hawks', 33, 49, 2002, 43, 94, 35, 15
EXEC add_TeamStatsByName 'Atlanta Hawks', 35, 47, 2003, 44, 94, 35, 16
EXEC add_TeamStatsByName 'Atlanta Hawks', 28, 54, 2004, 43, 92, 33, 16
EXEC add_TeamStatsByName 'Atlanta Hawks', 13, 69, 2005, 44, 92, 31, 16
EXEC add_TeamStatsByName 'Atlanta Hawks', 26, 56, 2006, 45, 97, 36, 15
EXEC add_TeamStatsByName 'Atlanta Hawks', 30, 52, 2007, 44, 93, 32, 15
EXEC add_TeamStatsByName 'Atlanta Hawks', 37, 45, 2008, 45, 98, 35, 14
EXEC add_TeamStatsByName 'Atlanta Hawks', 47, 35, 2009, 45, 98, 36, 12
EXEC add_TeamStatsByName 'Atlanta Hawks', 53, 29, 2010, 46, 101, 36, 11
EXEC add_TeamStatsByName 'Atlanta Hawks', 44, 38, 2011, 46, 95, 35, 13
EXEC add_TeamStatsByName 'Atlanta Hawks', 40, 26, 2012, 45, 96, 37, 13
EXEC add_TeamStatsByName 'Atlanta Hawks', 44, 38, 2013, 46, 97, 37, 14
EXEC add_TeamStatsByName 'Atlanta Hawks', 38, 44, 2014, 45, 101, 36, 15
EXEC add_TeamStatsByName 'Atlanta Hawks', 60, 22, 2015, 46, 102, 38, 14
EXEC add_TeamStatsByName 'Atlanta Hawks', 48, 34, 2016, 45, 102, 35, 14
EXEC add_TeamStatsByName 'Atlanta Hawks', 43, 39, 2017, 45, 103, 34, 15
EXEC add_TeamStatsByName 'Atlanta Hawks', 24, 58, 2018, 44, 103, 36, 15
EXEC add_TeamStatsByName 'Atlanta Hawks', 29, 53, 2019, 45, 113, 35, 17
EXEC add_TeamStatsByName 'Atlanta Hawks', 20, 47, 2020, 44, 111, 33, 16
EXEC add_TeamStatsByName 'Atlanta Hawks', 41, 31, 2021, 46, 113, 37, 13
EXEC add_TeamStatsByName 'Atlanta Hawks', 29, 31, 2022, 46, 115, 37, 12
EXEC add_TeamStatsByName 'Boston Celtics', 61, 21, 1980, 49, 113, 38, 18
EXEC add_TeamStatsByName 'Boston Celtics', 62, 20, 1981, 50, 109, 27, 19
EXEC add_TeamStatsByName 'Boston Celtics', 63, 19, 1982, 49, 111, 26, 17
EXEC add_TeamStatsByName 'Boston Celtics', 56, 26, 1983, 49, 112, 21, 18
EXEC add_TeamStatsByName 'Boston Celtics', 62, 20, 1984, 50, 112, 24, 17
EXEC add_TeamStatsByName 'Boston Celtics', 63, 19, 1985, 50, 114, 35, 16
EXEC add_TeamStatsByName 'Boston Celtics', 67, 15, 1986, 50, 114, 35, 16
EXEC add_TeamStatsByName 'Boston Celtics', 59, 23, 1987, 51, 112, 36, 15
EXEC add_TeamStatsByName 'Boston Celtics', 57, 25, 1988, 52, 113, 38, 15
EXEC add_TeamStatsByName 'Boston Celtics', 42, 40, 1989, 49, 109, 25, 16
EXEC add_TeamStatsByName 'Boston Celtics', 52, 30, 1990, 49, 110, 26, 15
EXEC add_TeamStatsByName 'Boston Celtics', 56, 26, 1991, 51, 111, 31, 16
EXEC add_TeamStatsByName 'Boston Celtics', 51, 31, 1992, 49, 106, 30, 14
EXEC add_TeamStatsByName 'Boston Celtics', 48, 34, 1993, 48, 103, 28, 14
EXEC add_TeamStatsByName 'Boston Celtics', 32, 50, 1994, 47, 100, 28, 15
EXEC add_TeamStatsByName 'Boston Celtics', 35, 47, 1995, 46, 102, 36, 15
EXEC add_TeamStatsByName 'Boston Celtics', 33, 49, 1996, 45, 103, 37, 15
EXEC add_TeamStatsByName 'Boston Celtics', 15, 67, 1997, 44, 100, 35, 16
EXEC add_TeamStatsByName 'Boston Celtics', 36, 46, 1998, 43, 95, 33, 16
EXEC add_TeamStatsByName 'Boston Celtics', 19, 31, 1999, 43, 93, 36, 16
EXEC add_TeamStatsByName 'Boston Celtics', 35, 47, 2000, 44, 99, 33, 15
EXEC add_TeamStatsByName 'Boston Celtics', 36, 46, 2001, 42, 94, 36, 15
EXEC add_TeamStatsByName 'Boston Celtics', 49, 33, 2002, 42, 96, 35, 13
EXEC add_TeamStatsByName 'Boston Celtics', 44, 38, 2003, 41, 92, 33, 13
EXEC add_TeamStatsByName 'Boston Celtics', 36, 46, 2004, 44, 95, 34, 16
EXEC add_TeamStatsByName 'Boston Celtics', 45, 37, 2005, 46, 101, 34, 15
EXEC add_TeamStatsByName 'Boston Celtics', 33, 49, 2006, 46, 97, 36, 16
EXEC add_TeamStatsByName 'Boston Celtics', 24, 58, 2007, 44, 95, 36, 16
EXEC add_TeamStatsByName 'Boston Celtics', 66, 16, 2008, 47, 100, 38, 15
EXEC add_TeamStatsByName 'Boston Celtics', 62, 20, 2009, 48, 100, 39, 15
EXEC add_TeamStatsByName 'Boston Celtics', 50, 32, 2010, 48, 99, 34, 14
EXEC add_TeamStatsByName 'Boston Celtics', 56, 26, 2011, 48, 96, 36, 14
EXEC add_TeamStatsByName 'Boston Celtics', 39, 27, 2012, 46, 91, 36, 14
EXEC add_TeamStatsByName 'Boston Celtics', 41, 40, 2013, 46, 96, 35, 14
EXEC add_TeamStatsByName 'Boston Celtics', 25, 57, 2014, 43, 96, 33, 15
EXEC add_TeamStatsByName 'Boston Celtics', 40, 42, 2015, 44, 101, 32, 13
EXEC add_TeamStatsByName 'Boston Celtics', 48, 34, 2016, 43, 105, 33, 13
EXEC add_TeamStatsByName 'Boston Celtics', 53, 29, 2017, 45, 108, 35, 13
EXEC add_TeamStatsByName 'Boston Celtics', 55, 27, 2018, 45, 104, 37, 14
EXEC add_TeamStatsByName 'Boston Celtics', 49, 33, 2019, 46, 112, 36, 12
EXEC add_TeamStatsByName 'Boston Celtics', 48, 24, 2020, 46, 113, 36, 13
EXEC add_TeamStatsByName 'Boston Celtics', 36, 36, 2021, 46, 112, 37, 14
EXEC add_TeamStatsByName 'Boston Celtics', 36, 27, 2022, 45, 111, 34, 14
EXEC add_TeamStatsByName 'Brooklyn Nets', 49, 33, 2013, 45, 96, 35, 14
EXEC add_TeamStatsByName 'Brooklyn Nets', 44, 38, 2014, 45, 98, 36, 14
EXEC add_TeamStatsByName 'Brooklyn Nets', 38, 44, 2015, 45, 98, 33, 13
EXEC add_TeamStatsByName 'Brooklyn Nets', 21, 61, 2016, 45, 98, 35, 14
EXEC add_TeamStatsByName 'Brooklyn Nets', 20, 62, 2017, 44, 105, 33, 16
EXEC add_TeamStatsByName 'Brooklyn Nets', 28, 54, 2018, 44, 106, 35, 15
EXEC add_TeamStatsByName 'Brooklyn Nets', 42, 40, 2019, 44, 112, 35, 15
EXEC add_TeamStatsByName 'Brooklyn Nets', 35, 37, 2020, 44, 111, 34, 15
EXEC add_TeamStatsByName 'Brooklyn Nets', 48, 24, 2021, 49, 118, 39, 13
EXEC add_TeamStatsByName 'Brooklyn Nets', 32, 30, 2022, 46, 111, 34, 13
EXEC add_TeamStatsByName 'Chicago Bulls', 30, 52, 1980, 48, 107, 25, 20
EXEC add_TeamStatsByName 'Chicago Bulls', 45, 37, 1981, 50, 108, 21, 20
EXEC add_TeamStatsByName 'Chicago Bulls', 34, 48, 1982, 50, 106, 25, 19
EXEC add_TeamStatsByName 'Chicago Bulls', 28, 54, 1983, 48, 111, 21, 21
EXEC add_TeamStatsByName 'Chicago Bulls', 27, 55, 1984, 47, 103, 17, 19
EXEC add_TeamStatsByName 'Chicago Bulls', 38, 44, 1985, 50, 108, 18, 17
EXEC add_TeamStatsByName 'Chicago Bulls', 30, 52, 1986, 48, 109, 27, 17
EXEC add_TeamStatsByName 'Chicago Bulls', 40, 42, 1987, 47, 104, 26, 15
EXEC add_TeamStatsByName 'Chicago Bulls', 50, 32, 1988, 49, 104, 23, 15
EXEC add_TeamStatsByName 'Chicago Bulls', 47, 35, 1989, 49, 106, 32, 16
EXEC add_TeamStatsByName 'Chicago Bulls', 55, 27, 1990, 49, 109, 37, 15
EXEC add_TeamStatsByName 'Chicago Bulls', 61, 21, 1991, 51, 110, 36, 14
EXEC add_TeamStatsByName 'Chicago Bulls', 67, 15, 1992, 50, 109, 30, 13
EXEC add_TeamStatsByName 'Chicago Bulls', 57, 25, 1993, 48, 105, 36, 13
EXEC add_TeamStatsByName 'Chicago Bulls', 55, 27, 1994, 47, 97, 35, 15
EXEC add_TeamStatsByName 'Chicago Bulls', 47, 35, 1995, 47, 101, 37, 15
EXEC add_TeamStatsByName 'Chicago Bulls', 72, 10, 1996, 47, 105, 40, 14
EXEC add_TeamStatsByName 'Chicago Bulls', 69, 13, 1997, 47, 103, 37, 13
EXEC add_TeamStatsByName 'Chicago Bulls', 62, 20, 1998, 45, 96, 32, 14
EXEC add_TeamStatsByName 'Chicago Bulls', 13, 37, 1999, 40, 81, 28, 15
EXEC add_TeamStatsByName 'Chicago Bulls', 17, 65, 2000, 41, 84, 32, 18
EXEC add_TeamStatsByName 'Chicago Bulls', 15, 67, 2001, 42, 87, 34, 15
EXEC add_TeamStatsByName 'Chicago Bulls', 21, 61, 2002, 43, 89, 34, 15
EXEC add_TeamStatsByName 'Chicago Bulls', 30, 52, 2003, 44, 94, 35, 16
EXEC add_TeamStatsByName 'Chicago Bulls', 23, 59, 2004, 41, 89, 34, 16
EXEC add_TeamStatsByName 'Chicago Bulls', 47, 35, 2005, 43, 94, 35, 16
EXEC add_TeamStatsByName 'Chicago Bulls', 41, 41, 2006, 44, 97, 37, 14
EXEC add_TeamStatsByName 'Chicago Bulls', 49, 33, 2007, 45, 98, 38, 15
EXEC add_TeamStatsByName 'Chicago Bulls', 33, 49, 2008, 43, 97, 36, 14
EXEC add_TeamStatsByName 'Chicago Bulls', 41, 41, 2009, 45, 102, 38, 14
EXEC add_TeamStatsByName 'Chicago Bulls', 41, 41, 2010, 45, 97, 33, 14
EXEC add_TeamStatsByName 'Chicago Bulls', 62, 20, 2011, 46, 98, 36, 14
EXEC add_TeamStatsByName 'Chicago Bulls', 50, 16, 2012, 45, 96, 37, 13
EXEC add_TeamStatsByName 'Chicago Bulls', 45, 37, 2013, 43, 93, 35, 14
EXEC add_TeamStatsByName 'Chicago Bulls', 48, 34, 2014, 43, 93, 34, 14
EXEC add_TeamStatsByName 'Chicago Bulls', 50, 32, 2015, 44, 100, 35, 13
EXEC add_TeamStatsByName 'Chicago Bulls', 42, 40, 2016, 44, 101, 37, 13
EXEC add_TeamStatsByName 'Chicago Bulls', 41, 41, 2017, 44, 102, 34, 13
EXEC add_TeamStatsByName 'Chicago Bulls', 27, 55, 2018, 43, 102, 35, 13
EXEC add_TeamStatsByName 'Chicago Bulls', 22, 60, 2019, 45, 104, 35, 14
EXEC add_TeamStatsByName 'Chicago Bulls', 22, 43, 2020, 44, 106, 34, 15
EXEC add_TeamStatsByName 'Chicago Bulls', 31, 41, 2021, 47, 110, 37, 15
EXEC add_TeamStatsByName 'Chicago Bulls', 39, 23, 2022, 48, 113, 37, 13
EXEC add_TeamStatsByName 'Charlotte Hornets', 20, 62, 1989, 46, 104, 31, 16
EXEC add_TeamStatsByName 'Charlotte Hornets', 19, 63, 1990, 45, 100, 33, 14
EXEC add_TeamStatsByName 'Charlotte Hornets', 26, 56, 1991, 46, 102, 31, 15
EXEC add_TeamStatsByName 'Charlotte Hornets', 31, 51, 1992, 47, 109, 31, 15
EXEC add_TeamStatsByName 'Charlotte Hornets', 44, 38, 1993, 48, 110, 32, 16
EXEC add_TeamStatsByName 'Charlotte Hornets', 41, 41, 1994, 47, 106, 36, 15
EXEC add_TeamStatsByName 'Charlotte Hornets', 50, 32, 1995, 47, 100, 39, 14
EXEC add_TeamStatsByName 'Charlotte Hornets', 41, 41, 1996, 47, 102, 38, 15
EXEC add_TeamStatsByName 'Charlotte Hornets', 54, 28, 1997, 47, 98, 42, 14
EXEC add_TeamStatsByName 'Charlotte Hornets', 51, 31, 1998, 46, 96, 38, 15
EXEC add_TeamStatsByName 'Charlotte Hornets', 26, 24, 1999, 44, 92, 36, 15
EXEC add_TeamStatsByName 'Charlotte Hornets', 49, 33, 2000, 44, 98, 33, 14
EXEC add_TeamStatsByName 'Charlotte Hornets', 46, 36, 2001, 43, 91, 34, 14
EXEC add_TeamStatsByName 'Charlotte Hornets', 44, 38, 2002, 44, 93, 34, 14
EXEC add_TeamStatsByName 'Charlotte Hornets', 33, 49, 2015, 42, 94, 31, 11
EXEC add_TeamStatsByName 'Charlotte Hornets', 48, 34, 2016, 43, 103, 36, 12
EXEC add_TeamStatsByName 'Charlotte Hornets', 36, 46, 2017, 44, 104, 35, 11
EXEC add_TeamStatsByName 'Charlotte Hornets', 36, 46, 2018, 45, 108, 36, 12
EXEC add_TeamStatsByName 'Charlotte Hornets', 39, 43, 2019, 44, 110, 35, 12
EXEC add_TeamStatsByName 'Charlotte Hornets', 23, 42, 2020, 43, 102, 35, 14
EXEC add_TeamStatsByName 'Charlotte Hornets', 33, 39, 2021, 45, 109, 36, 14
EXEC add_TeamStatsByName 'Charlotte Hornets', 30, 33, 2022, 45, 111, 35, 13
EXEC add_TeamStatsByName 'Cleveland Cavaliers', 37, 45, 1980, 47, 114, 19, 16
EXEC add_TeamStatsByName 'Cleveland Cavaliers', 28, 54, 1981, 46, 105, 28, 17
EXEC add_TeamStatsByName 'Cleveland Cavaliers', 15, 67, 1982, 46, 103, 18, 16
EXEC add_TeamStatsByName 'Cleveland Cavaliers', 23, 59, 1983, 46, 97, 25, 18
EXEC add_TeamStatsByName 'Cleveland Cavaliers', 28, 54, 1984, 46, 102, 26, 16
EXEC add_TeamStatsByName 'Cleveland Cavaliers', 36, 46, 1985, 47, 108, 28, 16
EXEC add_TeamStatsByName 'Cleveland Cavaliers', 29, 53, 1986, 48, 107, 33, 17
EXEC add_TeamStatsByName 'Cleveland Cavaliers', 31, 51, 1987, 47, 104, 24, 19
EXEC add_TeamStatsByName 'Cleveland Cavaliers', 42, 40, 1988, 49, 104, 37, 17
EXEC add_TeamStatsByName 'Cleveland Cavaliers', 57, 25, 1989, 50, 108, 35, 16
EXEC add_TeamStatsByName 'Cleveland Cavaliers', 42, 40, 1990, 46, 102, 40, 15
EXEC add_TeamStatsByName 'Cleveland Cavaliers', 33, 49, 1991, 47, 101, 33, 15
EXEC add_TeamStatsByName 'Cleveland Cavaliers', 57, 25, 1992, 48, 108, 35, 13
EXEC add_TeamStatsByName 'Cleveland Cavaliers', 54, 28, 1993, 49, 107, 38, 13
EXEC add_TeamStatsByName 'Cleveland Cavaliers', 47, 35, 1994, 46, 101, 36, 13
EXEC add_TeamStatsByName 'Cleveland Cavaliers', 43, 39, 1995, 44, 90, 38, 14
EXEC add_TeamStatsByName 'Cleveland Cavaliers', 47, 35, 1996, 46, 91, 37, 13
EXEC add_TeamStatsByName 'Cleveland Cavaliers', 42, 40, 1997, 45, 87, 37, 14
EXEC add_TeamStatsByName 'Cleveland Cavaliers', 47, 35, 1998, 45, 92, 37, 17
EXEC add_TeamStatsByName 'Cleveland Cavaliers', 22, 28, 1999, 43, 86, 34, 15
EXEC add_TeamStatsByName 'Cleveland Cavaliers', 32, 50, 2000, 44, 96, 37, 17
EXEC add_TeamStatsByName 'Cleveland Cavaliers', 30, 52, 2001, 44, 92, 33, 16
EXEC add_TeamStatsByName 'Cleveland Cavaliers', 29, 53, 2002, 44, 95, 37, 14
EXEC add_TeamStatsByName 'Cleveland Cavaliers', 17, 65, 2003, 42, 91, 32, 18
EXEC add_TeamStatsByName 'Cleveland Cavaliers', 35, 47, 2004, 43, 92, 31, 14
EXEC add_TeamStatsByName 'Cleveland Cavaliers', 42, 40, 2005, 44, 96, 33, 13
EXEC add_TeamStatsByName 'Cleveland Cavaliers', 50, 32, 2006, 45, 97, 33, 13
EXEC add_TeamStatsByName 'Cleveland Cavaliers', 50, 32, 2007, 44, 96, 35, 14
EXEC add_TeamStatsByName 'Cleveland Cavaliers', 45, 37, 2008, 43, 96, 35, 13
EXEC add_TeamStatsByName 'Cleveland Cavaliers', 66, 16, 2009, 46, 100, 39, 12
EXEC add_TeamStatsByName 'Cleveland Cavaliers', 61, 21, 2010, 48, 102, 38, 13
EXEC add_TeamStatsByName 'Cleveland Cavaliers', 19, 63, 2011, 43, 95, 34, 14
EXEC add_TeamStatsByName 'Cleveland Cavaliers', 21, 45, 2012, 42, 93, 34, 15
EXEC add_TeamStatsByName 'Cleveland Cavaliers', 24, 58, 2013, 43, 96, 34, 14
EXEC add_TeamStatsByName 'Cleveland Cavaliers', 33, 49, 2014, 43, 98, 35, 14
EXEC add_TeamStatsByName 'Cleveland Cavaliers', 53, 29, 2015, 45, 103, 36, 14
EXEC add_TeamStatsByName 'Cleveland Cavaliers', 57, 25, 2016, 46, 104, 36, 13
EXEC add_TeamStatsByName 'Cleveland Cavaliers', 51, 31, 2017, 47, 110, 38, 13
EXEC add_TeamStatsByName 'Cleveland Cavaliers', 50, 32, 2018, 47, 110, 37, 13
EXEC add_TeamStatsByName 'Cleveland Cavaliers', 19, 63, 2019, 44, 104, 35, 13
EXEC add_TeamStatsByName 'Cleveland Cavaliers', 19, 46, 2020, 45, 106, 35, 16
EXEC add_TeamStatsByName 'Cleveland Cavaliers', 22, 50, 2021, 45, 103, 33, 15
EXEC add_TeamStatsByName 'Cleveland Cavaliers', 36, 25, 2022, 46, 110, 35, 15
EXEC add_TeamStatsByName 'Dallas Mavericks', 15, 67, 1981, 46, 101, 27, 17
EXEC add_TeamStatsByName 'Dallas Mavericks', 28, 54, 1982, 46, 104, 28, 16
EXEC add_TeamStatsByName 'Dallas Mavericks', 38, 44, 1983, 48, 112, 23, 16
EXEC add_TeamStatsByName 'Dallas Mavericks', 43, 39, 1984, 50, 110, 22, 15
EXEC add_TeamStatsByName 'Dallas Mavericks', 44, 38, 1985, 48, 111, 34, 14
EXEC add_TeamStatsByName 'Dallas Mavericks', 44, 38, 1986, 50, 115, 31, 15
EXEC add_TeamStatsByName 'Dallas Mavericks', 55, 27, 1987, 48, 116, 35, 14
EXEC add_TeamStatsByName 'Dallas Mavericks', 53, 29, 1988, 47, 109, 29, 15
EXEC add_TeamStatsByName 'Dallas Mavericks', 38, 44, 1989, 46, 103, 31, 15
EXEC add_TeamStatsByName 'Dallas Mavericks', 47, 35, 1990, 47, 102, 32, 14
EXEC add_TeamStatsByName 'Dallas Mavericks', 28, 54, 1991, 47, 99, 32, 14
EXEC add_TeamStatsByName 'Dallas Mavericks', 22, 60, 1992, 43, 97, 33, 14
EXEC add_TeamStatsByName 'Dallas Mavericks', 11, 71, 1993, 43, 99, 33, 17
EXEC add_TeamStatsByName 'Dallas Mavericks', 13, 69, 1994, 43, 95, 31, 16
EXEC add_TeamStatsByName 'Dallas Mavericks', 36, 46, 1995, 44, 103, 32, 16
EXEC add_TeamStatsByName 'Dallas Mavericks', 26, 56, 1996, 42, 102, 36, 15
EXEC add_TeamStatsByName 'Dallas Mavericks', 24, 58, 1997, 43, 90, 32, 16
EXEC add_TeamStatsByName 'Dallas Mavericks', 20, 62, 1998, 42, 91, 35, 14
EXEC add_TeamStatsByName 'Dallas Mavericks', 19, 31, 1999, 43, 91, 33, 13
EXEC add_TeamStatsByName 'Dallas Mavericks', 40, 42, 2000, 45, 101, 39, 13
EXEC add_TeamStatsByName 'Dallas Mavericks', 53, 29, 2001, 45, 100, 38, 13
EXEC add_TeamStatsByName 'Dallas Mavericks', 57, 25, 2002, 46, 105, 37, 12
EXEC add_TeamStatsByName 'Dallas Mavericks', 60, 22, 2003, 45, 102, 38, 11
EXEC add_TeamStatsByName 'Dallas Mavericks', 52, 30, 2004, 45, 105, 34, 12
EXEC add_TeamStatsByName 'Dallas Mavericks', 58, 24, 2005, 45, 102, 36, 13
EXEC add_TeamStatsByName 'Dallas Mavericks', 60, 22, 2006, 46, 99, 37, 13
EXEC add_TeamStatsByName 'Dallas Mavericks', 67, 15, 2007, 46, 100, 38, 13
EXEC add_TeamStatsByName 'Dallas Mavericks', 51, 31, 2008, 46, 100, 35, 12
EXEC add_TeamStatsByName 'Dallas Mavericks', 50, 32, 2009, 46, 101, 35, 12
EXEC add_TeamStatsByName 'Dallas Mavericks', 55, 27, 2010, 46, 102, 37, 12
EXEC add_TeamStatsByName 'Dallas Mavericks', 57, 25, 2011, 47, 100, 36, 13
EXEC add_TeamStatsByName 'Dallas Mavericks', 36, 30, 2012, 44, 95, 33, 14
EXEC add_TeamStatsByName 'Dallas Mavericks', 41, 41, 2013, 46, 101, 37, 13
EXEC add_TeamStatsByName 'Dallas Mavericks', 49, 33, 2014, 47, 104, 38, 13
EXEC add_TeamStatsByName 'Dallas Mavericks', 50, 32, 2015, 46, 105, 35, 12
EXEC add_TeamStatsByName 'Dallas Mavericks', 42, 40, 2016, 44, 102, 34, 12
EXEC add_TeamStatsByName 'Dallas Mavericks', 33, 49, 2017, 44, 97, 35, 11
EXEC add_TeamStatsByName 'Dallas Mavericks', 24, 58, 2018, 44, 102, 36, 12
EXEC add_TeamStatsByName 'Dallas Mavericks', 33, 49, 2019, 44, 108, 34, 14
EXEC add_TeamStatsByName 'Dallas Mavericks', 43, 32, 2020, 46, 117, 36, 12
EXEC add_TeamStatsByName 'Dallas Mavericks', 42, 30, 2021, 47, 112, 36, 12
EXEC add_TeamStatsByName 'Dallas Mavericks', 36, 25, 2022, 45, 111, 34, 13
EXEC add_TeamStatsByName 'Denver Nuggets', 30, 52, 1980, 46, 108, 32, 18
EXEC add_TeamStatsByName 'Denver Nuggets', 37, 45, 1981, 47, 121, 20, 17
EXEC add_TeamStatsByName 'Denver Nuggets', 46, 36, 1982, 52, 126, 26, 17
EXEC add_TeamStatsByName 'Denver Nuggets', 45, 37, 1983, 49, 123, 19, 18
EXEC add_TeamStatsByName 'Denver Nuggets', 38, 44, 1984, 49, 123, 30, 16
EXEC add_TeamStatsByName 'Denver Nuggets', 52, 30, 1985, 48, 120, 31, 16
EXEC add_TeamStatsByName 'Denver Nuggets', 47, 35, 1986, 47, 114, 23, 16
EXEC add_TeamStatsByName 'Denver Nuggets', 37, 45, 1987, 47, 116, 27, 14
EXEC add_TeamStatsByName 'Denver Nuggets', 54, 28, 1988, 47, 116, 34, 14
EXEC add_TeamStatsByName 'Denver Nuggets', 44, 38, 1989, 46, 117, 33, 14
EXEC add_TeamStatsByName 'Denver Nuggets', 43, 39, 1990, 46, 114, 33, 13
EXEC add_TeamStatsByName 'Denver Nuggets', 20, 62, 1991, 44, 119, 28, 16
EXEC add_TeamStatsByName 'Denver Nuggets', 24, 58, 1992, 44, 99, 30, 17
EXEC add_TeamStatsByName 'Denver Nuggets', 36, 46, 1993, 46, 105, 30, 17
EXEC add_TeamStatsByName 'Denver Nuggets', 42, 40, 1994, 46, 100, 28, 17
EXEC add_TeamStatsByName 'Denver Nuggets', 41, 41, 1995, 47, 101, 35, 16
EXEC add_TeamStatsByName 'Denver Nuggets', 35, 47, 1996, 45, 97, 34, 15
EXEC add_TeamStatsByName 'Denver Nuggets', 21, 61, 1997, 43, 97, 37, 16
EXEC add_TeamStatsByName 'Denver Nuggets', 11, 71, 1998, 41, 89, 32, 15
EXEC add_TeamStatsByName 'Denver Nuggets', 14, 36, 1999, 42, 93, 32, 14
EXEC add_TeamStatsByName 'Denver Nuggets', 35, 47, 2000, 44, 98, 33, 15
EXEC add_TeamStatsByName 'Denver Nuggets', 40, 42, 2001, 43, 96, 35, 13
EXEC add_TeamStatsByName 'Denver Nuggets', 27, 55, 2002, 42, 92, 32, 14
EXEC add_TeamStatsByName 'Denver Nuggets', 17, 65, 2003, 41, 84, 27, 18
EXEC add_TeamStatsByName 'Denver Nuggets', 43, 39, 2004, 44, 97, 33, 15
EXEC add_TeamStatsByName 'Denver Nuggets', 49, 33, 2005, 45, 99, 34, 14
EXEC add_TeamStatsByName 'Denver Nuggets', 44, 38, 2006, 46, 100, 32, 14
EXEC add_TeamStatsByName 'Denver Nuggets', 45, 37, 2007, 46, 105, 33, 16
EXEC add_TeamStatsByName 'Denver Nuggets', 50, 32, 2008, 47, 110, 35, 14
EXEC add_TeamStatsByName 'Denver Nuggets', 54, 28, 2009, 47, 104, 37, 15
EXEC add_TeamStatsByName 'Denver Nuggets', 53, 29, 2010, 46, 106, 35, 13
EXEC add_TeamStatsByName 'Denver Nuggets', 50, 32, 2011, 47, 107, 38, 14
EXEC add_TeamStatsByName 'Denver Nuggets', 38, 28, 2012, 47, 104, 33, 15
EXEC add_TeamStatsByName 'Denver Nuggets', 57, 25, 2013, 47, 106, 34, 15
EXEC add_TeamStatsByName 'Denver Nuggets', 36, 46, 2014, 44, 104, 35, 15
EXEC add_TeamStatsByName 'Denver Nuggets', 30, 52, 2015, 43, 101, 32, 14
EXEC add_TeamStatsByName 'Denver Nuggets', 33, 49, 2016, 44, 101, 33, 14
EXEC add_TeamStatsByName 'Denver Nuggets', 40, 42, 2017, 46, 111, 36, 14
EXEC add_TeamStatsByName 'Denver Nuggets', 46, 36, 2018, 47, 110, 37, 14
EXEC add_TeamStatsByName 'Denver Nuggets', 54, 28, 2019, 46, 110, 35, 13
EXEC add_TeamStatsByName 'Denver Nuggets', 46, 27, 2020, 47, 111, 35, 13
EXEC add_TeamStatsByName 'Denver Nuggets', 47, 25, 2021, 48, 115, 37, 13
EXEC add_TeamStatsByName 'Denver Nuggets', 36, 25, 2022, 47, 112, 35, 14
EXEC add_TeamStatsByName 'Detroit Pistons', 16, 66, 1980, 48, 108, 26, 21
EXEC add_TeamStatsByName 'Detroit Pistons', 21, 61, 1981, 46, 99, 15, 21
EXEC add_TeamStatsByName 'Detroit Pistons', 39, 43, 1982, 48, 111, 24, 19
EXEC add_TeamStatsByName 'Detroit Pistons', 37, 45, 1983, 47, 112, 26, 18
EXEC add_TeamStatsByName 'Detroit Pistons', 49, 33, 1984, 48, 117, 22, 15
EXEC add_TeamStatsByName 'Detroit Pistons', 46, 36, 1985, 48, 115, 22, 16
EXEC add_TeamStatsByName 'Detroit Pistons', 46, 36, 1986, 48, 114, 30, 16
EXEC add_TeamStatsByName 'Detroit Pistons', 52, 30, 1987, 49, 111, 23, 17
EXEC add_TeamStatsByName 'Detroit Pistons', 54, 28, 1988, 49, 109, 28, 16
EXEC add_TeamStatsByName 'Detroit Pistons', 63, 19, 1989, 49, 106, 30, 16
EXEC add_TeamStatsByName 'Detroit Pistons', 59, 23, 1990, 47, 104, 32, 15
EXEC add_TeamStatsByName 'Detroit Pistons', 50, 32, 1991, 46, 100, 29, 14
EXEC add_TeamStatsByName 'Detroit Pistons', 48, 34, 1992, 46, 98, 31, 14
EXEC add_TeamStatsByName 'Detroit Pistons', 40, 42, 1993, 45, 100, 32, 14
EXEC add_TeamStatsByName 'Detroit Pistons', 20, 62, 1994, 45, 96, 34, 15
EXEC add_TeamStatsByName 'Detroit Pistons', 28, 54, 1995, 46, 98, 35, 16
EXEC add_TeamStatsByName 'Detroit Pistons', 46, 36, 1996, 45, 95, 40, 14
EXEC add_TeamStatsByName 'Detroit Pistons', 54, 28, 1997, 46, 94, 38, 12
EXEC add_TeamStatsByName 'Detroit Pistons', 37, 45, 1998, 44, 94, 31, 14
EXEC add_TeamStatsByName 'Detroit Pistons', 29, 21, 1999, 44, 90, 36, 15
EXEC add_TeamStatsByName 'Detroit Pistons', 42, 40, 2000, 45, 103, 35, 15
EXEC add_TeamStatsByName 'Detroit Pistons', 32, 50, 2001, 42, 95, 35, 15
EXEC add_TeamStatsByName 'Detroit Pistons', 50, 32, 2002, 45, 94, 37, 14
EXEC add_TeamStatsByName 'Detroit Pistons', 50, 32, 2003, 43, 91, 35, 13
EXEC add_TeamStatsByName 'Detroit Pistons', 54, 28, 2004, 43, 90, 34, 15
EXEC add_TeamStatsByName 'Detroit Pistons', 54, 28, 2005, 44, 93, 34, 13
EXEC add_TeamStatsByName 'Detroit Pistons', 64, 18, 2006, 45, 96, 38, 11
EXEC add_TeamStatsByName 'Detroit Pistons', 53, 29, 2007, 45, 96, 34, 12
EXEC add_TeamStatsByName 'Detroit Pistons', 59, 23, 2008, 45, 97, 36, 11
EXEC add_TeamStatsByName 'Detroit Pistons', 39, 43, 2009, 45, 94, 34, 11
EXEC add_TeamStatsByName 'Detroit Pistons', 27, 55, 2010, 44, 94, 31, 13
EXEC add_TeamStatsByName 'Detroit Pistons', 30, 52, 2011, 46, 96, 37, 13
EXEC add_TeamStatsByName 'Detroit Pistons', 25, 41, 2012, 43, 90, 34, 15
EXEC add_TeamStatsByName 'Detroit Pistons', 29, 53, 2013, 44, 94, 35, 15
EXEC add_TeamStatsByName 'Detroit Pistons', 29, 53, 2014, 44, 101, 32, 14
EXEC add_TeamStatsByName 'Detroit Pistons', 32, 50, 2015, 43, 98, 34, 13
EXEC add_TeamStatsByName 'Detroit Pistons', 44, 38, 2016, 43, 101, 34, 13
EXEC add_TeamStatsByName 'Detroit Pistons', 37, 45, 2017, 44, 101, 33, 11
EXEC add_TeamStatsByName 'Detroit Pistons', 39, 43, 2018, 45, 103, 37, 13
EXEC add_TeamStatsByName 'Detroit Pistons', 41, 41, 2019, 44, 107, 34, 13
EXEC add_TeamStatsByName 'Detroit Pistons', 20, 46, 2020, 45, 107, 36, 15
EXEC add_TeamStatsByName 'Detroit Pistons', 20, 52, 2021, 45, 106, 35, 14
EXEC add_TeamStatsByName 'Detroit Pistons', 15, 46, 2022, 42, 103, 32, 14
EXEC add_TeamStatsByName 'Golden State Warriors', 24, 58, 1980, 48, 103, 22, 18
EXEC add_TeamStatsByName 'Golden State Warriors', 39, 43, 1981, 48, 109, 28, 18
EXEC add_TeamStatsByName 'Golden State Warriors', 45, 37, 1982, 49, 110, 28, 17
EXEC add_TeamStatsByName 'Golden State Warriors', 30, 52, 1983, 48, 108, 22, 19
EXEC add_TeamStatsByName 'Golden State Warriors', 37, 45, 1984, 46, 109, 24, 18
EXEC add_TeamStatsByName 'Golden State Warriors', 22, 60, 1985, 46, 110, 28, 17
EXEC add_TeamStatsByName 'Golden State Warriors', 30, 52, 1986, 48, 113, 31, 17
EXEC add_TeamStatsByName 'Golden State Warriors', 42, 40, 1987, 47, 112, 31, 16
EXEC add_TeamStatsByName 'Golden State Warriors', 20, 62, 1988, 46, 106, 29, 17
EXEC add_TeamStatsByName 'Golden State Warriors', 43, 39, 1989, 46, 116, 30, 18
EXEC add_TeamStatsByName 'Golden State Warriors', 37, 45, 1990, 48, 116, 32, 17
EXEC add_TeamStatsByName 'Golden State Warriors', 44, 38, 1991, 48, 116, 33, 16
EXEC add_TeamStatsByName 'Golden State Warriors', 55, 27, 1992, 50, 118, 33, 16
EXEC add_TeamStatsByName 'Golden State Warriors', 34, 48, 1993, 48, 109, 35, 17
EXEC add_TeamStatsByName 'Golden State Warriors', 50, 32, 1994, 49, 107, 33, 17
EXEC add_TeamStatsByName 'Golden State Warriors', 26, 56, 1995, 46, 105, 34, 18
EXEC add_TeamStatsByName 'Golden State Warriors', 36, 46, 1996, 45, 101, 37, 16
EXEC add_TeamStatsByName 'Golden State Warriors', 30, 52, 1997, 45, 99, 35, 17
EXEC add_TeamStatsByName 'Golden State Warriors', 19, 63, 1998, 41, 88, 27, 16
EXEC add_TeamStatsByName 'Golden State Warriors', 21, 29, 1999, 41, 88, 28, 15
EXEC add_TeamStatsByName 'Golden State Warriors', 19, 63, 2000, 42, 95, 32, 15
EXEC add_TeamStatsByName 'Golden State Warriors', 17, 65, 2001, 40, 92, 29, 15
EXEC add_TeamStatsByName 'Golden State Warriors', 21, 61, 2002, 42, 97, 32, 16
EXEC add_TeamStatsByName 'Golden State Warriors', 38, 44, 2003, 44, 102, 34, 15
EXEC add_TeamStatsByName 'Golden State Warriors', 37, 45, 2004, 44, 93, 33, 14
EXEC add_TeamStatsByName 'Golden State Warriors', 34, 48, 2005, 43, 98, 35, 13
EXEC add_TeamStatsByName 'Golden State Warriors', 34, 48, 2006, 43, 98, 34, 14
EXEC add_TeamStatsByName 'Golden State Warriors', 42, 40, 2007, 46, 106, 35, 15
EXEC add_TeamStatsByName 'Golden State Warriors', 48, 34, 2008, 45, 111, 34, 13
EXEC add_TeamStatsByName 'Golden State Warriors', 29, 53, 2009, 45, 108, 37, 14
EXEC add_TeamStatsByName 'Golden State Warriors', 26, 56, 2010, 46, 108, 37, 14
EXEC add_TeamStatsByName 'Golden State Warriors', 36, 46, 2011, 46, 103, 39, 14
EXEC add_TeamStatsByName 'Golden State Warriors', 23, 43, 2012, 45, 97, 38, 13
EXEC add_TeamStatsByName 'Golden State Warriors', 47, 35, 2013, 45, 101, 40, 15
EXEC add_TeamStatsByName 'Golden State Warriors', 51, 31, 2014, 46, 104, 38, 15
EXEC add_TeamStatsByName 'Golden State Warriors', 67, 15, 2015, 47, 109, 39, 14
EXEC add_TeamStatsByName 'Golden State Warriors', 73, 9, 2016, 48, 114, 41, 15
EXEC add_TeamStatsByName 'Golden State Warriors', 67, 15, 2017, 49, 115, 38, 14
EXEC add_TeamStatsByName 'Golden State Warriors', 58, 24, 2018, 50, 113, 39, 15
EXEC add_TeamStatsByName 'Golden State Warriors', 57, 25, 2019, 49, 117, 38, 14
EXEC add_TeamStatsByName 'Golden State Warriors', 15, 50, 2020, 43, 106, 33, 14
EXEC add_TeamStatsByName 'Golden State Warriors', 39, 33, 2021, 46, 113, 37, 15
EXEC add_TeamStatsByName 'Golden State Warriors', 43, 18, 2022, 46, 110, 36, 15
EXEC add_TeamStatsByName 'Houston Rockets', 41, 41, 1980, 48, 110, 27, 19
EXEC add_TeamStatsByName 'Houston Rockets', 40, 42, 1981, 48, 108, 17, 17
EXEC add_TeamStatsByName 'Houston Rockets', 46, 36, 1982, 47, 105, 28, 16
EXEC add_TeamStatsByName 'Houston Rockets', 14, 68, 1983, 44, 99, 24, 19
EXEC add_TeamStatsByName 'Houston Rockets', 29, 53, 1984, 49, 110, 19, 19
EXEC add_TeamStatsByName 'Houston Rockets', 48, 34, 1985, 50, 111, 22, 19
EXEC add_TeamStatsByName 'Houston Rockets', 51, 31, 1986, 49, 114, 27, 16
EXEC add_TeamStatsByName 'Houston Rockets', 42, 40, 1987, 47, 106, 27, 16
EXEC add_TeamStatsByName 'Houston Rockets', 46, 36, 1988, 47, 108, 23, 16
EXEC add_TeamStatsByName 'Houston Rockets', 45, 37, 1989, 47, 108, 31, 19
EXEC add_TeamStatsByName 'Houston Rockets', 41, 41, 1990, 48, 106, 31, 18
EXEC add_TeamStatsByName 'Houston Rockets', 52, 30, 1991, 46, 106, 32, 17
EXEC add_TeamStatsByName 'Houston Rockets', 42, 40, 1992, 47, 102, 34, 16
EXEC add_TeamStatsByName 'Houston Rockets', 55, 27, 1993, 48, 104, 36, 15
EXEC add_TeamStatsByName 'Houston Rockets', 58, 24, 1994, 47, 101, 33, 16
EXEC add_TeamStatsByName 'Houston Rockets', 47, 35, 1995, 48, 103, 36, 16
EXEC add_TeamStatsByName 'Houston Rockets', 48, 34, 1996, 46, 102, 36, 15
EXEC add_TeamStatsByName 'Houston Rockets', 57, 25, 1997, 46, 100, 36, 16
EXEC add_TeamStatsByName 'Houston Rockets', 41, 41, 1998, 45, 98, 34, 15
EXEC add_TeamStatsByName 'Houston Rockets', 31, 19, 1999, 46, 94, 36, 16
EXEC add_TeamStatsByName 'Houston Rockets', 34, 48, 2000, 45, 99, 35, 17
EXEC add_TeamStatsByName 'Houston Rockets', 45, 37, 2001, 45, 97, 35, 14
EXEC add_TeamStatsByName 'Houston Rockets', 28, 54, 2002, 42, 92, 33, 14
EXEC add_TeamStatsByName 'Houston Rockets', 43, 39, 2003, 44, 93, 34, 15
EXEC add_TeamStatsByName 'Houston Rockets', 45, 37, 2004, 44, 89, 36, 16
EXEC add_TeamStatsByName 'Houston Rockets', 51, 31, 2005, 44, 95, 36, 13
EXEC add_TeamStatsByName 'Houston Rockets', 34, 48, 2006, 43, 90, 33, 14
EXEC add_TeamStatsByName 'Houston Rockets', 52, 30, 2007, 44, 96, 37, 14
EXEC add_TeamStatsByName 'Houston Rockets', 55, 27, 2008, 44, 96, 34, 13
EXEC add_TeamStatsByName 'Houston Rockets', 53, 29, 2009, 45, 98, 37, 14
EXEC add_TeamStatsByName 'Houston Rockets', 42, 40, 2010, 44, 102, 35, 14
EXEC add_TeamStatsByName 'Houston Rockets', 43, 39, 2011, 45, 105, 36, 13
EXEC add_TeamStatsByName 'Houston Rockets', 34, 32, 2012, 44, 98, 35, 14
EXEC add_TeamStatsByName 'Houston Rockets', 45, 37, 2013, 46, 105, 36, 16
EXEC add_TeamStatsByName 'Houston Rockets', 54, 28, 2014, 47, 107, 35, 16
EXEC add_TeamStatsByName 'Houston Rockets', 56, 26, 2015, 44, 103, 34, 16
EXEC add_TeamStatsByName 'Houston Rockets', 41, 41, 2016, 45, 106, 34, 15
EXEC add_TeamStatsByName 'Houston Rockets', 55, 27, 2017, 46, 115, 35, 15
EXEC add_TeamStatsByName 'Houston Rockets', 65, 17, 2018, 46, 112, 36, 13
EXEC add_TeamStatsByName 'Houston Rockets', 53, 29, 2019, 44, 113, 35, 13
EXEC add_TeamStatsByName 'Houston Rockets', 44, 28, 2020, 45, 117, 34, 14
EXEC add_TeamStatsByName 'Houston Rockets', 17, 55, 2021, 44, 108, 33, 14
EXEC add_TeamStatsByName 'Houston Rockets', 15, 45, 2022, 45, 107, 34, 16
EXEC add_TeamStatsByName 'Indiana Pacers', 37, 45, 1980, 47, 111, 28, 18
EXEC add_TeamStatsByName 'Indiana Pacers', 44, 38, 1981, 48, 107, 17, 18
EXEC add_TeamStatsByName 'Indiana Pacers', 35, 47, 1982, 46, 102, 32, 16
EXEC add_TeamStatsByName 'Indiana Pacers', 20, 62, 1983, 48, 108, 21, 18
EXEC add_TeamStatsByName 'Indiana Pacers', 26, 56, 1984, 48, 104, 23, 18
EXEC add_TeamStatsByName 'Indiana Pacers', 22, 60, 1985, 47, 108, 19, 19
EXEC add_TeamStatsByName 'Indiana Pacers', 26, 56, 1986, 48, 103, 16, 18
EXEC add_TeamStatsByName 'Indiana Pacers', 41, 41, 1987, 47, 106, 29, 15
EXEC add_TeamStatsByName 'Indiana Pacers', 38, 44, 1988, 48, 104, 33, 16
EXEC add_TeamStatsByName 'Indiana Pacers', 28, 54, 1989, 48, 106, 32, 18
EXEC add_TeamStatsByName 'Indiana Pacers', 42, 40, 1990, 49, 109, 38, 16
EXEC add_TeamStatsByName 'Indiana Pacers', 41, 41, 1991, 49, 111, 33, 16
EXEC add_TeamStatsByName 'Indiana Pacers', 40, 42, 1992, 49, 112, 35, 17
EXEC add_TeamStatsByName 'Indiana Pacers', 41, 41, 1993, 48, 107, 32, 15
EXEC add_TeamStatsByName 'Indiana Pacers', 47, 35, 1994, 48, 100, 36, 17
EXEC add_TeamStatsByName 'Indiana Pacers', 52, 30, 1995, 47, 99, 38, 16
EXEC add_TeamStatsByName 'Indiana Pacers', 52, 30, 1996, 48, 99, 37, 16
EXEC add_TeamStatsByName 'Indiana Pacers', 39, 43, 1997, 45, 95, 38, 16
EXEC add_TeamStatsByName 'Indiana Pacers', 58, 24, 1998, 46, 96, 39, 14
EXEC add_TeamStatsByName 'Indiana Pacers', 33, 17, 1999, 44, 94, 36, 12
EXEC add_TeamStatsByName 'Indiana Pacers', 56, 26, 2000, 45, 101, 39, 14
EXEC add_TeamStatsByName 'Indiana Pacers', 41, 41, 2001, 44, 92, 34, 15
EXEC add_TeamStatsByName 'Indiana Pacers', 42, 40, 2002, 44, 96, 33, 15
EXEC add_TeamStatsByName 'Indiana Pacers', 48, 34, 2003, 44, 96, 33, 14
EXEC add_TeamStatsByName 'Indiana Pacers', 61, 21, 2004, 43, 91, 35, 14
EXEC add_TeamStatsByName 'Indiana Pacers', 44, 38, 2005, 43, 93, 34, 14
EXEC add_TeamStatsByName 'Indiana Pacers', 41, 41, 2006, 44, 93, 34, 15
EXEC add_TeamStatsByName 'Indiana Pacers', 35, 47, 2007, 43, 95, 34, 16
EXEC add_TeamStatsByName 'Indiana Pacers', 36, 46, 2008, 44, 103, 37, 15
EXEC add_TeamStatsByName 'Indiana Pacers', 36, 46, 2009, 45, 105, 37, 14
EXEC add_TeamStatsByName 'Indiana Pacers', 32, 50, 2010, 44, 100, 34, 15
EXEC add_TeamStatsByName 'Indiana Pacers', 37, 45, 2011, 44, 99, 35, 15
EXEC add_TeamStatsByName 'Indiana Pacers', 42, 24, 2012, 43, 97, 36, 14
EXEC add_TeamStatsByName 'Indiana Pacers', 49, 32, 2013, 43, 94, 34, 15
EXEC add_TeamStatsByName 'Indiana Pacers', 56, 26, 2014, 44, 96, 35, 15
EXEC add_TeamStatsByName 'Indiana Pacers', 38, 44, 2015, 43, 97, 35, 13
EXEC add_TeamStatsByName 'Indiana Pacers', 45, 37, 2016, 45, 102, 35, 14
EXEC add_TeamStatsByName 'Indiana Pacers', 42, 40, 2017, 46, 105, 37, 13
EXEC add_TeamStatsByName 'Indiana Pacers', 48, 34, 2018, 47, 105, 36, 13
EXEC add_TeamStatsByName 'Indiana Pacers', 48, 34, 2019, 47, 108, 37, 13
EXEC add_TeamStatsByName 'Indiana Pacers', 45, 28, 2020, 47, 109, 36, 13
EXEC add_TeamStatsByName 'Indiana Pacers', 34, 38, 2021, 47, 115, 36, 13
EXEC add_TeamStatsByName 'Indiana Pacers', 21, 42, 2022, 45, 111, 33, 14
EXEC add_TeamStatsByName 'Los Angeles Clippers', 31, 51, 1985, 49, 107, 29, 19
EXEC add_TeamStatsByName 'Los Angeles Clippers', 32, 50, 1986, 47, 108, 27, 18
EXEC add_TeamStatsByName 'Los Angeles Clippers', 12, 70, 1987, 45, 104, 22, 18
EXEC add_TeamStatsByName 'Los Angeles Clippers', 17, 65, 1988, 44, 98, 24, 18
EXEC add_TeamStatsByName 'Los Angeles Clippers', 21, 61, 1989, 47, 106, 23, 20
EXEC add_TeamStatsByName 'Los Angeles Clippers', 30, 52, 1990, 48, 103, 24, 18
EXEC add_TeamStatsByName 'Los Angeles Clippers', 31, 51, 1991, 46, 103, 26, 17
EXEC add_TeamStatsByName 'Los Angeles Clippers', 45, 37, 1992, 47, 102, 28, 15
EXEC add_TeamStatsByName 'Los Angeles Clippers', 41, 41, 1993, 48, 107, 27, 16
EXEC add_TeamStatsByName 'Los Angeles Clippers', 27, 55, 1994, 46, 103, 30, 17
EXEC add_TeamStatsByName 'Los Angeles Clippers', 17, 65, 1995, 44, 96, 31, 16
EXEC add_TeamStatsByName 'Los Angeles Clippers', 29, 53, 1996, 47, 99, 37, 16
EXEC add_TeamStatsByName 'Los Angeles Clippers', 36, 46, 1997, 44, 97, 35, 15
EXEC add_TeamStatsByName 'Los Angeles Clippers', 17, 65, 1998, 43, 95, 35, 16
EXEC add_TeamStatsByName 'Los Angeles Clippers', 9, 41, 1999, 42, 90, 32, 15
EXEC add_TeamStatsByName 'Los Angeles Clippers', 15, 67, 2000, 42, 92, 33, 16
EXEC add_TeamStatsByName 'Los Angeles Clippers', 31, 51, 2001, 44, 92, 33, 15
EXEC add_TeamStatsByName 'Los Angeles Clippers', 39, 43, 2002, 44, 95, 35, 14
EXEC add_TeamStatsByName 'Los Angeles Clippers', 27, 55, 2003, 43, 93, 33, 15
EXEC add_TeamStatsByName 'Los Angeles Clippers', 28, 54, 2004, 42, 94, 32, 16
EXEC add_TeamStatsByName 'Los Angeles Clippers', 37, 45, 2005, 45, 95, 34, 15
EXEC add_TeamStatsByName 'Los Angeles Clippers', 47, 35, 2006, 46, 97, 34, 14
EXEC add_TeamStatsByName 'Los Angeles Clippers', 40, 42, 2007, 45, 95, 34, 15
EXEC add_TeamStatsByName 'Los Angeles Clippers', 23, 59, 2008, 43, 93, 32, 14
EXEC add_TeamStatsByName 'Los Angeles Clippers', 19, 63, 2009, 44, 95, 35, 14
EXEC add_TeamStatsByName 'Los Angeles Clippers', 29, 53, 2010, 45, 95, 33, 15
EXEC add_TeamStatsByName 'Los Angeles Clippers', 32, 50, 2011, 45, 98, 33, 16
EXEC add_TeamStatsByName 'Los Angeles Clippers', 40, 26, 2012, 45, 97, 35, 13
EXEC add_TeamStatsByName 'Los Angeles Clippers', 56, 26, 2013, 47, 101, 35, 14
EXEC add_TeamStatsByName 'Los Angeles Clippers', 57, 25, 2014, 47, 107, 35, 13
EXEC add_TeamStatsByName 'Los Angeles Clippers', 56, 26, 2015, 47, 106, 37, 12
EXEC add_TeamStatsByName 'Los Angeles Clippers', 53, 29, 2016, 46, 104, 36, 12
EXEC add_TeamStatsByName 'Los Angeles Clippers', 51, 31, 2017, 47, 108, 37, 12
EXEC add_TeamStatsByName 'Los Angeles Clippers', 42, 40, 2018, 47, 108, 35, 14
EXEC add_TeamStatsByName 'Los Angeles Clippers', 48, 34, 2019, 47, 115, 38, 14
EXEC add_TeamStatsByName 'Los Angeles Clippers', 49, 23, 2020, 46, 116, 37, 14
EXEC add_TeamStatsByName 'Los Angeles Clippers', 47, 25, 2021, 48, 114, 41, 13
EXEC add_TeamStatsByName 'Los Angeles Clippers', 32, 31, 2022, 45, 108, 36, 14
EXEC add_TeamStatsByName 'Los Angeles Lakers', 60, 22, 1980, 52, 115, 20, 19
EXEC add_TeamStatsByName 'Los Angeles Lakers', 54, 28, 1981, 51, 111, 18, 18
EXEC add_TeamStatsByName 'Los Angeles Lakers', 57, 25, 1982, 51, 114, 13, 17
EXEC add_TeamStatsByName 'Los Angeles Lakers', 58, 24, 1983, 52, 115, 10, 19
EXEC add_TeamStatsByName 'Los Angeles Lakers', 54, 28, 1984, 53, 115, 25, 19
EXEC add_TeamStatsByName 'Los Angeles Lakers', 62, 20, 1985, 54, 118, 30, 18
EXEC add_TeamStatsByName 'Los Angeles Lakers', 62, 20, 1986, 52, 117, 33, 17
EXEC add_TeamStatsByName 'Los Angeles Lakers', 65, 17, 1987, 51, 117, 36, 16
EXEC add_TeamStatsByName 'Los Angeles Lakers', 62, 20, 1988, 50, 112, 29, 16
EXEC add_TeamStatsByName 'Los Angeles Lakers', 57, 25, 1989, 50, 114, 34, 16
EXEC add_TeamStatsByName 'Los Angeles Lakers', 63, 19, 1990, 49, 110, 36, 14
EXEC add_TeamStatsByName 'Los Angeles Lakers', 58, 24, 1991, 48, 106, 30, 14
EXEC add_TeamStatsByName 'Los Angeles Lakers', 43, 39, 1992, 45, 100, 26, 13
EXEC add_TeamStatsByName 'Los Angeles Lakers', 39, 43, 1993, 47, 104, 29, 15
EXEC add_TeamStatsByName 'Los Angeles Lakers', 33, 49, 1994, 45, 100, 30, 14
EXEC add_TeamStatsByName 'Los Angeles Lakers', 48, 34, 1995, 46, 105, 35, 15
EXEC add_TeamStatsByName 'Los Angeles Lakers', 53, 29, 1996, 48, 102, 35, 14
EXEC add_TeamStatsByName 'Los Angeles Lakers', 56, 26, 1997, 45, 100, 36, 14
EXEC add_TeamStatsByName 'Los Angeles Lakers', 61, 21, 1998, 48, 105, 35, 15
EXEC add_TeamStatsByName 'Los Angeles Lakers', 31, 19, 1999, 46, 99, 35, 15
EXEC add_TeamStatsByName 'Los Angeles Lakers', 67, 15, 2000, 45, 100, 32, 13
EXEC add_TeamStatsByName 'Los Angeles Lakers', 56, 26, 2001, 46, 100, 34, 14
EXEC add_TeamStatsByName 'Los Angeles Lakers', 58, 24, 2002, 46, 101, 35, 12
EXEC add_TeamStatsByName 'Los Angeles Lakers', 50, 32, 2003, 45, 100, 35, 14
EXEC add_TeamStatsByName 'Los Angeles Lakers', 56, 26, 2004, 45, 98, 32, 13
EXEC add_TeamStatsByName 'Los Angeles Lakers', 34, 48, 2005, 43, 98, 35, 14
EXEC add_TeamStatsByName 'Los Angeles Lakers', 45, 37, 2006, 45, 99, 34, 13
EXEC add_TeamStatsByName 'Los Angeles Lakers', 42, 40, 2007, 46, 103, 35, 15
EXEC add_TeamStatsByName 'Los Angeles Lakers', 57, 25, 2008, 47, 108, 37, 14
EXEC add_TeamStatsByName 'Los Angeles Lakers', 65, 17, 2009, 47, 106, 36, 13
EXEC add_TeamStatsByName 'Los Angeles Lakers', 57, 25, 2010, 45, 101, 34, 13
EXEC add_TeamStatsByName 'Los Angeles Lakers', 57, 25, 2011, 46, 101, 35, 13
EXEC add_TeamStatsByName 'Los Angeles Lakers', 41, 25, 2012, 45, 97, 32, 15
EXEC add_TeamStatsByName 'Los Angeles Lakers', 45, 37, 2013, 45, 102, 35, 15
EXEC add_TeamStatsByName 'Los Angeles Lakers', 27, 55, 2014, 45, 102, 38, 15
EXEC add_TeamStatsByName 'Los Angeles Lakers', 21, 61, 2015, 43, 98, 34, 13
EXEC add_TeamStatsByName 'Los Angeles Lakers', 17, 65, 2016, 41, 97, 31, 13
EXEC add_TeamStatsByName 'Los Angeles Lakers', 26, 56, 2017, 45, 104, 34, 15
EXEC add_TeamStatsByName 'Los Angeles Lakers', 35, 47, 2018, 46, 108, 34, 15
EXEC add_TeamStatsByName 'Los Angeles Lakers', 37, 45, 2019, 47, 111, 33, 15
EXEC add_TeamStatsByName 'Los Angeles Lakers', 52, 19, 2020, 48, 113, 34, 15
EXEC add_TeamStatsByName 'Los Angeles Lakers', 42, 30, 2021, 47, 109, 35, 15
EXEC add_TeamStatsByName 'Los Angeles Lakers', 27, 33, 2022, 46, 108, 34, 14
EXEC add_TeamStatsByName 'Memphis Grizzlies', 23, 59, 2002, 43, 89, 30, 16
EXEC add_TeamStatsByName 'Memphis Grizzlies', 28, 54, 2003, 45, 97, 36, 15
EXEC add_TeamStatsByName 'Memphis Grizzlies', 50, 32, 2004, 44, 96, 34, 14
EXEC add_TeamStatsByName 'Memphis Grizzlies', 45, 37, 2005, 44, 93, 35, 14
EXEC add_TeamStatsByName 'Memphis Grizzlies', 49, 33, 2006, 44, 92, 37, 13
EXEC add_TeamStatsByName 'Memphis Grizzlies', 22, 60, 2007, 46, 101, 36, 16
EXEC add_TeamStatsByName 'Memphis Grizzlies', 22, 60, 2008, 45, 100, 34, 15
EXEC add_TeamStatsByName 'Memphis Grizzlies', 24, 58, 2009, 45, 93, 36, 15
EXEC add_TeamStatsByName 'Memphis Grizzlies', 40, 42, 2010, 46, 102, 33, 15
EXEC add_TeamStatsByName 'Memphis Grizzlies', 46, 36, 2011, 47, 99, 33, 13
EXEC add_TeamStatsByName 'Memphis Grizzlies', 41, 25, 2012, 44, 94, 32, 14
EXEC add_TeamStatsByName 'Memphis Grizzlies', 56, 26, 2013, 44, 93, 34, 13
EXEC add_TeamStatsByName 'Memphis Grizzlies', 50, 32, 2014, 46, 96, 35, 13
EXEC add_TeamStatsByName 'Memphis Grizzlies', 55, 27, 2015, 45, 98, 33, 13
EXEC add_TeamStatsByName 'Memphis Grizzlies', 42, 40, 2016, 44, 99, 33, 13
EXEC add_TeamStatsByName 'Memphis Grizzlies', 43, 39, 2017, 43, 100, 35, 12
EXEC add_TeamStatsByName 'Memphis Grizzlies', 22, 60, 2018, 44, 99, 35, 14
EXEC add_TeamStatsByName 'Memphis Grizzlies', 33, 49, 2019, 45, 103, 34, 13
EXEC add_TeamStatsByName 'Memphis Grizzlies', 34, 39, 2020, 46, 112, 34, 15
EXEC add_TeamStatsByName 'Memphis Grizzlies', 38, 34, 2021, 46, 113, 35, 13
EXEC add_TeamStatsByName 'Memphis Grizzlies', 43, 20, 2022, 45, 113, 34, 13
EXEC add_TeamStatsByName 'Miami Heat', 15, 67, 1989, 45, 97, 32, 21
EXEC add_TeamStatsByName 'Miami Heat', 18, 64, 1990, 46, 100, 29, 18
EXEC add_TeamStatsByName 'Miami Heat', 24, 58, 1991, 45, 101, 30, 18
EXEC add_TeamStatsByName 'Miami Heat', 38, 44, 1992, 46, 104, 34, 16
EXEC add_TeamStatsByName 'Miami Heat', 36, 46, 1993, 45, 103, 35, 15
EXEC add_TeamStatsByName 'Miami Heat', 42, 40, 1994, 46, 103, 33, 16
EXEC add_TeamStatsByName 'Miami Heat', 32, 50, 1995, 46, 101, 36, 15
EXEC add_TeamStatsByName 'Miami Heat', 42, 40, 1996, 45, 96, 37, 17
EXEC add_TeamStatsByName 'Miami Heat', 61, 21, 1997, 45, 94, 36, 15
EXEC add_TeamStatsByName 'Miami Heat', 55, 27, 1998, 45, 94, 35, 14
EXEC add_TeamStatsByName 'Miami Heat', 33, 17, 1999, 45, 88, 35, 14
EXEC add_TeamStatsByName 'Miami Heat', 52, 30, 2000, 46, 94, 37, 15
EXEC add_TeamStatsByName 'Miami Heat', 50, 32, 2001, 43, 88, 34, 13
EXEC add_TeamStatsByName 'Miami Heat', 36, 46, 2002, 43, 87, 34, 14
EXEC add_TeamStatsByName 'Miami Heat', 25, 57, 2003, 41, 85, 31, 14
EXEC add_TeamStatsByName 'Miami Heat', 42, 40, 2004, 42, 90, 35, 13
EXEC add_TeamStatsByName 'Miami Heat', 59, 23, 2005, 48, 101, 37, 13
EXEC add_TeamStatsByName 'Miami Heat', 52, 30, 2006, 47, 99, 34, 14
EXEC add_TeamStatsByName 'Miami Heat', 44, 38, 2007, 46, 94, 34, 14
EXEC add_TeamStatsByName 'Miami Heat', 15, 67, 2008, 44, 91, 35, 14
EXEC add_TeamStatsByName 'Miami Heat', 43, 39, 2009, 45, 98, 35, 12
EXEC add_TeamStatsByName 'Miami Heat', 47, 35, 2010, 45, 96, 34, 13
EXEC add_TeamStatsByName 'Miami Heat', 58, 24, 2011, 48, 102, 37, 13
EXEC add_TeamStatsByName 'Miami Heat', 46, 20, 2012, 46, 98, 35, 15
EXEC add_TeamStatsByName 'Miami Heat', 66, 16, 2013, 49, 102, 39, 13
EXEC add_TeamStatsByName 'Miami Heat', 54, 28, 2014, 50, 102, 36, 14
EXEC add_TeamStatsByName 'Miami Heat', 37, 45, 2015, 45, 94, 33, 14
EXEC add_TeamStatsByName 'Miami Heat', 48, 34, 2016, 47, 100, 33, 14
EXEC add_TeamStatsByName 'Miami Heat', 41, 41, 2017, 45, 103, 36, 13
EXEC add_TeamStatsByName 'Miami Heat', 44, 38, 2018, 45, 103, 36, 14
EXEC add_TeamStatsByName 'Miami Heat', 39, 43, 2019, 45, 105, 34, 14
EXEC add_TeamStatsByName 'Miami Heat', 44, 29, 2020, 46, 112, 37, 14
EXEC add_TeamStatsByName 'Miami Heat', 40, 32, 2021, 46, 108, 35, 14
EXEC add_TeamStatsByName 'Miami Heat', 41, 21, 2022, 46, 113, 37, 15
EXEC add_TeamStatsByName 'Milwaukee Bucks', 49, 33, 1980, 48, 110, 32, 18
EXEC add_TeamStatsByName 'Milwaukee Bucks', 60, 22, 1981, 49, 113, 22, 19
EXEC add_TeamStatsByName 'Milwaukee Bucks', 55, 27, 1982, 50, 108, 29, 19
EXEC add_TeamStatsByName 'Milwaukee Bucks', 51, 31, 1983, 48, 106, 21, 17
EXEC add_TeamStatsByName 'Milwaukee Bucks', 50, 32, 1984, 49, 105, 25, 17
EXEC add_TeamStatsByName 'Milwaukee Bucks', 59, 23, 1985, 49, 110, 30, 16
EXEC add_TeamStatsByName 'Milwaukee Bucks', 57, 25, 1986, 49, 114, 32, 16
EXEC add_TeamStatsByName 'Milwaukee Bucks', 50, 32, 1987, 47, 110, 32, 15
EXEC add_TeamStatsByName 'Milwaukee Bucks', 42, 40, 1988, 47, 106, 32, 15
EXEC add_TeamStatsByName 'Milwaukee Bucks', 49, 33, 1989, 47, 108, 31, 15
EXEC add_TeamStatsByName 'Milwaukee Bucks', 44, 38, 1990, 47, 105, 31, 16
EXEC add_TeamStatsByName 'Milwaukee Bucks', 48, 34, 1991, 48, 106, 34, 16
EXEC add_TeamStatsByName 'Milwaukee Bucks', 31, 51, 1992, 46, 104, 36, 16
EXEC add_TeamStatsByName 'Milwaukee Bucks', 28, 54, 1993, 47, 102, 33, 16
EXEC add_TeamStatsByName 'Milwaukee Bucks', 20, 62, 1994, 44, 96, 32, 16
EXEC add_TeamStatsByName 'Milwaukee Bucks', 34, 48, 1995, 45, 99, 36, 16
EXEC add_TeamStatsByName 'Milwaukee Bucks', 25, 57, 1996, 46, 95, 33, 15
EXEC add_TeamStatsByName 'Milwaukee Bucks', 33, 49, 1997, 47, 95, 35, 15
EXEC add_TeamStatsByName 'Milwaukee Bucks', 36, 46, 1998, 45, 94, 35, 16
EXEC add_TeamStatsByName 'Milwaukee Bucks', 28, 22, 1999, 45, 91, 37, 14
EXEC add_TeamStatsByName 'Milwaukee Bucks', 42, 40, 2000, 46, 101, 36, 15
EXEC add_TeamStatsByName 'Milwaukee Bucks', 52, 30, 2001, 45, 100, 37, 13
EXEC add_TeamStatsByName 'Milwaukee Bucks', 41, 41, 2002, 46, 97, 37, 14
EXEC add_TeamStatsByName 'Milwaukee Bucks', 42, 40, 2003, 45, 99, 38, 12
EXEC add_TeamStatsByName 'Milwaukee Bucks', 41, 41, 2004, 44, 98, 35, 13
EXEC add_TeamStatsByName 'Milwaukee Bucks', 30, 52, 2005, 45, 97, 35, 13
EXEC add_TeamStatsByName 'Milwaukee Bucks', 40, 42, 2006, 45, 97, 38, 14
EXEC add_TeamStatsByName 'Milwaukee Bucks', 28, 54, 2007, 46, 99, 35, 15
EXEC add_TeamStatsByName 'Milwaukee Bucks', 26, 56, 2008, 44, 97, 34, 14
EXEC add_TeamStatsByName 'Milwaukee Bucks', 34, 48, 2009, 44, 99, 36, 14
EXEC add_TeamStatsByName 'Milwaukee Bucks', 46, 36, 2010, 43, 97, 35, 13
EXEC add_TeamStatsByName 'Milwaukee Bucks', 35, 47, 2011, 43, 91, 34, 13
EXEC add_TeamStatsByName 'Milwaukee Bucks', 31, 35, 2012, 44, 99, 34, 14
EXEC add_TeamStatsByName 'Milwaukee Bucks', 38, 44, 2013, 43, 98, 36, 14
EXEC add_TeamStatsByName 'Milwaukee Bucks', 15, 67, 2014, 43, 95, 35, 15
EXEC add_TeamStatsByName 'Milwaukee Bucks', 41, 41, 2015, 45, 97, 36, 16
EXEC add_TeamStatsByName 'Milwaukee Bucks', 33, 49, 2016, 46, 99, 34, 15
EXEC add_TeamStatsByName 'Milwaukee Bucks', 42, 40, 2017, 47, 103, 37, 13
EXEC add_TeamStatsByName 'Milwaukee Bucks', 44, 38, 2018, 47, 106, 35, 13
EXEC add_TeamStatsByName 'Milwaukee Bucks', 60, 22, 2019, 47, 118, 35, 13
EXEC add_TeamStatsByName 'Milwaukee Bucks', 56, 17, 2020, 47, 118, 35, 15
EXEC add_TeamStatsByName 'Milwaukee Bucks', 46, 26, 2021, 48, 120, 38, 13
EXEC add_TeamStatsByName 'Milwaukee Bucks', 37, 25, 2022, 46, 113, 36, 13
EXEC add_TeamStatsByName 'Minnesota Timberwolv', 22, 60, 1990, 44, 95, 24, 14
EXEC add_TeamStatsByName 'Minnesota Timberwolv', 29, 53, 1991, 44, 99, 28, 12
EXEC add_TeamStatsByName 'Minnesota Timberwolv', 15, 67, 1992, 45, 100, 32, 14
EXEC add_TeamStatsByName 'Minnesota Timberwolv', 19, 63, 1993, 46, 98, 29, 17
EXEC add_TeamStatsByName 'Minnesota Timberwolv', 20, 62, 1994, 45, 96, 32, 18
EXEC add_TeamStatsByName 'Minnesota Timberwolv', 21, 61, 1995, 44, 94, 31, 17
EXEC add_TeamStatsByName 'Minnesota Timberwolv', 26, 56, 1996, 45, 97, 32, 17
EXEC add_TeamStatsByName 'Minnesota Timberwolv', 40, 42, 1997, 45, 96, 33, 15
EXEC add_TeamStatsByName 'Minnesota Timberwolv', 45, 37, 1998, 46, 101, 34, 13
EXEC add_TeamStatsByName 'Minnesota Timberwolv', 25, 25, 1999, 42, 92, 29, 12
EXEC add_TeamStatsByName 'Minnesota Timberwolv', 50, 32, 2000, 46, 98, 34, 13
EXEC add_TeamStatsByName 'Minnesota Timberwolv', 47, 35, 2001, 45, 97, 35, 13
EXEC add_TeamStatsByName 'Minnesota Timberwolv', 50, 32, 2002, 46, 99, 37, 13
EXEC add_TeamStatsByName 'Minnesota Timberwolv', 51, 31, 2003, 46, 98, 36, 13
EXEC add_TeamStatsByName 'Minnesota Timberwolv', 58, 24, 2004, 46, 94, 36, 12
EXEC add_TeamStatsByName 'Minnesota Timberwolv', 44, 38, 2005, 45, 96, 34, 13
EXEC add_TeamStatsByName 'Minnesota Timberwolv', 33, 49, 2006, 45, 91, 32, 14
EXEC add_TeamStatsByName 'Minnesota Timberwolv', 32, 50, 2007, 46, 96, 35, 15
EXEC add_TeamStatsByName 'Minnesota Timberwolv', 22, 60, 2008, 45, 95, 35, 14
EXEC add_TeamStatsByName 'Minnesota Timberwolv', 24, 58, 2009, 44, 97, 35, 14
EXEC add_TeamStatsByName 'Minnesota Timberwolv', 15, 67, 2010, 44, 98, 34, 16
EXEC add_TeamStatsByName 'Minnesota Timberwolv', 17, 65, 2011, 44, 101, 37, 17
EXEC add_TeamStatsByName 'Minnesota Timberwolv', 26, 40, 2012, 43, 97, 33, 15
EXEC add_TeamStatsByName 'Minnesota Timberwolv', 31, 51, 2013, 43, 95, 30, 14
EXEC add_TeamStatsByName 'Minnesota Timberwolv', 40, 42, 2014, 44, 106, 34, 13
EXEC add_TeamStatsByName 'Minnesota Timberwolv', 16, 66, 2015, 43, 97, 33, 15
EXEC add_TeamStatsByName 'Minnesota Timberwolv', 29, 53, 2016, 46, 102, 33, 15
EXEC add_TeamStatsByName 'Minnesota Timberwolv', 31, 51, 2017, 46, 105, 34, 14
EXEC add_TeamStatsByName 'Minnesota Timberwolv', 47, 35, 2018, 47, 109, 35, 12
EXEC add_TeamStatsByName 'Minnesota Timberwolv', 36, 46, 2019, 45, 112, 35, 13
EXEC add_TeamStatsByName 'Minnesota Timberwolv', 19, 45, 2020, 44, 113, 33, 15
EXEC add_TeamStatsByName 'Minnesota Timberwolv', 23, 49, 2021, 44, 112, 34, 14
EXEC add_TeamStatsByName 'Minnesota Timberwolv', 33, 29, 2022, 44, 113, 34, 14
EXEC add_TeamStatsByName 'New Orleans Pelicans', 34, 48, 2014, 45, 99, 37, 13
EXEC add_TeamStatsByName 'New Orleans Pelicans', 45, 37, 2015, 45, 99, 37, 13
EXEC add_TeamStatsByName 'New Orleans Pelicans', 30, 52, 2016, 44, 102, 36, 13
EXEC add_TeamStatsByName 'New Orleans Pelicans', 34, 48, 2017, 45, 104, 35, 12
EXEC add_TeamStatsByName 'New Orleans Pelicans', 48, 34, 2018, 48, 111, 36, 14
EXEC add_TeamStatsByName 'New Orleans Pelicans', 33, 49, 2019, 47, 115, 34, 14
EXEC add_TeamStatsByName 'New Orleans Pelicans', 30, 42, 2020, 46, 115, 37, 16
EXEC add_TeamStatsByName 'New Orleans Pelicans', 31, 41, 2021, 47, 114, 34, 14
EXEC add_TeamStatsByName 'New Orleans Pelicans', 25, 36, 2022, 44, 109, 32, 14
EXEC add_TeamStatsByName 'New York Knicks', 39, 43, 1980, 49, 113, 22, 19
EXEC add_TeamStatsByName 'New York Knicks', 50, 32, 1981, 48, 107, 23, 17
EXEC add_TeamStatsByName 'New York Knicks', 33, 49, 1982, 49, 106, 27, 18
EXEC add_TeamStatsByName 'New York Knicks', 44, 38, 1983, 48, 99, 25, 18
EXEC add_TeamStatsByName 'New York Knicks', 47, 35, 1984, 49, 106, 28, 19
EXEC add_TeamStatsByName 'New York Knicks', 24, 58, 1985, 48, 105, 25, 17
EXEC add_TeamStatsByName 'New York Knicks', 23, 59, 1986, 46, 98, 34, 17
EXEC add_TeamStatsByName 'New York Knicks', 24, 58, 1987, 47, 103, 33, 17
EXEC add_TeamStatsByName 'New York Knicks', 38, 44, 1988, 46, 105, 31, 18
EXEC add_TeamStatsByName 'New York Knicks', 52, 30, 1989, 48, 116, 33, 19
EXEC add_TeamStatsByName 'New York Knicks', 45, 37, 1990, 48, 108, 33, 17
EXEC add_TeamStatsByName 'New York Knicks', 39, 43, 1991, 48, 103, 33, 16
EXEC add_TeamStatsByName 'New York Knicks', 51, 31, 1992, 47, 101, 32, 15
EXEC add_TeamStatsByName 'New York Knicks', 60, 22, 1993, 46, 101, 32, 15
EXEC add_TeamStatsByName 'New York Knicks', 57, 25, 1994, 46, 98, 34, 16
EXEC add_TeamStatsByName 'New York Knicks', 55, 27, 1995, 46, 98, 36, 15
EXEC add_TeamStatsByName 'New York Knicks', 47, 35, 1996, 47, 97, 37, 15
EXEC add_TeamStatsByName 'New York Knicks', 57, 25, 1997, 46, 95, 36, 17
EXEC add_TeamStatsByName 'New York Knicks', 43, 39, 1998, 44, 91, 33, 15
EXEC add_TeamStatsByName 'New York Knicks', 27, 23, 1999, 43, 86, 35, 16
EXEC add_TeamStatsByName 'New York Knicks', 50, 32, 2000, 45, 92, 37, 14
EXEC add_TeamStatsByName 'New York Knicks', 48, 34, 2001, 44, 88, 35, 14
EXEC add_TeamStatsByName 'New York Knicks', 30, 52, 2002, 43, 91, 35, 14
EXEC add_TeamStatsByName 'New York Knicks', 37, 45, 2003, 44, 95, 38, 14
EXEC add_TeamStatsByName 'New York Knicks', 39, 43, 2004, 44, 91, 36, 15
EXEC add_TeamStatsByName 'New York Knicks', 33, 49, 2005, 45, 97, 35, 14
EXEC add_TeamStatsByName 'New York Knicks', 23, 59, 2006, 45, 95, 36, 17
EXEC add_TeamStatsByName 'New York Knicks', 33, 49, 2007, 45, 97, 34, 17
EXEC add_TeamStatsByName 'New York Knicks', 23, 59, 2008, 43, 96, 33, 14
EXEC add_TeamStatsByName 'New York Knicks', 32, 50, 2009, 44, 105, 36, 14
EXEC add_TeamStatsByName 'New York Knicks', 29, 53, 2010, 45, 102, 34, 14
EXEC add_TeamStatsByName 'New York Knicks', 42, 40, 2011, 45, 106, 36, 13
EXEC add_TeamStatsByName 'New York Knicks', 36, 30, 2012, 44, 97, 33, 16
EXEC add_TeamStatsByName 'New York Knicks', 54, 28, 2013, 44, 99, 37, 12
EXEC add_TeamStatsByName 'New York Knicks', 37, 45, 2014, 44, 98, 37, 12
EXEC add_TeamStatsByName 'New York Knicks', 17, 65, 2015, 42, 91, 34, 14
EXEC add_TeamStatsByName 'New York Knicks', 32, 50, 2016, 43, 98, 34, 13
EXEC add_TeamStatsByName 'New York Knicks', 31, 51, 2017, 44, 104, 34, 13
EXEC add_TeamStatsByName 'New York Knicks', 29, 53, 2018, 46, 104, 35, 14
EXEC add_TeamStatsByName 'New York Knicks', 17, 65, 2019, 43, 104, 34, 14
EXEC add_TeamStatsByName 'New York Knicks', 21, 45, 2020, 44, 105, 33, 14
EXEC add_TeamStatsByName 'New York Knicks', 41, 31, 2021, 45, 107, 39, 12
EXEC add_TeamStatsByName 'New York Knicks', 25, 36, 2022, 43, 108, 35, 14
EXEC add_TeamStatsByName 'Oklahoma City Thunde', 23, 59, 2009, 44, 96, 34, 16
EXEC add_TeamStatsByName 'Oklahoma City Thunde', 50, 32, 2010, 46, 101, 34, 14
EXEC add_TeamStatsByName 'Oklahoma City Thunde', 55, 27, 2011, 46, 104, 34, 14
EXEC add_TeamStatsByName 'Oklahoma City Thunde', 47, 19, 2012, 47, 103, 35, 16
EXEC add_TeamStatsByName 'Oklahoma City Thunde', 60, 22, 2013, 48, 105, 37, 15
EXEC add_TeamStatsByName 'Oklahoma City Thunde', 59, 23, 2014, 47, 106, 36, 15
EXEC add_TeamStatsByName 'Oklahoma City Thunde', 45, 37, 2015, 44, 103, 33, 14
EXEC add_TeamStatsByName 'Oklahoma City Thunde', 55, 27, 2016, 47, 110, 34, 15
EXEC add_TeamStatsByName 'Oklahoma City Thunde', 47, 35, 2017, 45, 106, 32, 15
EXEC add_TeamStatsByName 'Oklahoma City Thunde', 48, 34, 2018, 45, 107, 35, 13
EXEC add_TeamStatsByName 'Oklahoma City Thunde', 49, 33, 2019, 45, 114, 34, 13
EXEC add_TeamStatsByName 'Oklahoma City Thunde', 44, 28, 2020, 46, 110, 35, 13
EXEC add_TeamStatsByName 'Oklahoma City Thunde', 22, 50, 2021, 44, 105, 33, 16
EXEC add_TeamStatsByName 'Oklahoma City Thunde', 19, 42, 2022, 42, 101, 31, 13
EXEC add_TeamStatsByName 'Orlando Magic', 18, 64, 1990, 45, 110, 29, 17
EXEC add_TeamStatsByName 'Orlando Magic', 31, 51, 1991, 45, 105, 35, 16
EXEC add_TeamStatsByName 'Orlando Magic', 21, 61, 1992, 45, 101, 32, 16
EXEC add_TeamStatsByName 'Orlando Magic', 41, 41, 1993, 48, 105, 35, 17
EXEC add_TeamStatsByName 'Orlando Magic', 50, 32, 1994, 48, 105, 34, 16
EXEC add_TeamStatsByName 'Orlando Magic', 57, 25, 1995, 50, 110, 37, 15
EXEC add_TeamStatsByName 'Orlando Magic', 60, 22, 1996, 48, 104, 37, 14
EXEC add_TeamStatsByName 'Orlando Magic', 45, 37, 1997, 43, 94, 34, 15
EXEC add_TeamStatsByName 'Orlando Magic', 41, 41, 1998, 42, 90, 32, 15
EXEC add_TeamStatsByName 'Orlando Magic', 33, 17, 1999, 42, 89, 33, 16
EXEC add_TeamStatsByName 'Orlando Magic', 41, 41, 2000, 45, 100, 33, 17
EXEC add_TeamStatsByName 'Orlando Magic', 43, 39, 2001, 43, 97, 36, 15
EXEC add_TeamStatsByName 'Orlando Magic', 44, 38, 2002, 44, 100, 37, 13
EXEC add_TeamStatsByName 'Orlando Magic', 42, 40, 2003, 43, 98, 35, 14
EXEC add_TeamStatsByName 'Orlando Magic', 21, 61, 2004, 42, 94, 34, 13
EXEC add_TeamStatsByName 'Orlando Magic', 36, 46, 2005, 45, 99, 34, 16
EXEC add_TeamStatsByName 'Orlando Magic', 36, 46, 2006, 47, 94, 37, 15
EXEC add_TeamStatsByName 'Orlando Magic', 40, 42, 2007, 47, 94, 35, 16
EXEC add_TeamStatsByName 'Orlando Magic', 52, 30, 2008, 47, 104, 38, 14
EXEC add_TeamStatsByName 'Orlando Magic', 59, 23, 2009, 45, 101, 38, 13
EXEC add_TeamStatsByName 'Orlando Magic', 59, 23, 2010, 47, 102, 37, 14
EXEC add_TeamStatsByName 'Orlando Magic', 52, 30, 2011, 46, 99, 36, 14
EXEC add_TeamStatsByName 'Orlando Magic', 37, 29, 2012, 44, 94, 37, 14
EXEC add_TeamStatsByName 'Orlando Magic', 20, 62, 2013, 44, 94, 32, 14
EXEC add_TeamStatsByName 'Orlando Magic', 23, 59, 2014, 44, 96, 35, 14
EXEC add_TeamStatsByName 'Orlando Magic', 25, 57, 2015, 45, 95, 34, 14
EXEC add_TeamStatsByName 'Orlando Magic', 35, 47, 2016, 45, 102, 35, 14
EXEC add_TeamStatsByName 'Orlando Magic', 29, 53, 2017, 44, 101, 32, 13
EXEC add_TeamStatsByName 'Orlando Magic', 25, 57, 2018, 45, 103, 35, 14
EXEC add_TeamStatsByName 'Orlando Magic', 42, 40, 2019, 45, 107, 35, 13
EXEC add_TeamStatsByName 'Orlando Magic', 33, 40, 2020, 44, 107, 34, 12
EXEC add_TeamStatsByName 'Orlando Magic', 21, 51, 2021, 42, 104, 34, 12
EXEC add_TeamStatsByName 'Orlando Magic', 15, 47, 2022, 43, 104, 33, 14
EXEC add_TeamStatsByName 'Philadelphia 76ers', 59, 23, 1980, 49, 109, 21, 20
EXEC add_TeamStatsByName 'Philadelphia 76ers', 62, 20, 1981, 51, 111, 22, 20
EXEC add_TeamStatsByName 'Philadelphia 76ers', 58, 24, 1982, 51, 111, 29, 17
EXEC add_TeamStatsByName 'Philadelphia 76ers', 65, 17, 1983, 49, 112, 22, 19
EXEC add_TeamStatsByName 'Philadelphia 76ers', 52, 30, 1984, 49, 107, 27, 19
EXEC add_TeamStatsByName 'Philadelphia 76ers', 58, 24, 1985, 49, 112, 26, 19
EXEC add_TeamStatsByName 'Philadelphia 76ers', 54, 28, 1986, 48, 110, 22, 19
EXEC add_TeamStatsByName 'Philadelphia 76ers', 45, 37, 1987, 49, 106, 25, 18
EXEC add_TeamStatsByName 'Philadelphia 76ers', 36, 46, 1988, 47, 105, 32, 17
EXEC add_TeamStatsByName 'Philadelphia 76ers', 46, 36, 1989, 48, 111, 31, 14
EXEC add_TeamStatsByName 'Philadelphia 76ers', 53, 29, 1990, 48, 110, 34, 14
EXEC add_TeamStatsByName 'Philadelphia 76ers', 44, 38, 1991, 47, 105, 31, 15
EXEC add_TeamStatsByName 'Philadelphia 76ers', 35, 47, 1992, 47, 101, 33, 15
EXEC add_TeamStatsByName 'Philadelphia 76ers', 26, 56, 1993, 45, 104, 35, 16
EXEC add_TeamStatsByName 'Philadelphia 76ers', 25, 57, 1994, 45, 97, 33, 16
EXEC add_TeamStatsByName 'Philadelphia 76ers', 24, 58, 1995, 44, 95, 37, 16
EXEC add_TeamStatsByName 'Philadelphia 76ers', 18, 64, 1996, 43, 94, 34, 17
EXEC add_TeamStatsByName 'Philadelphia 76ers', 22, 60, 1997, 43, 100, 31, 17
EXEC add_TeamStatsByName 'Philadelphia 76ers', 31, 51, 1998, 44, 93, 30, 16
EXEC add_TeamStatsByName 'Philadelphia 76ers', 28, 22, 1999, 42, 89, 26, 16
EXEC add_TeamStatsByName 'Philadelphia 76ers', 49, 33, 2000, 44, 94, 32, 15
EXEC add_TeamStatsByName 'Philadelphia 76ers', 56, 26, 2001, 44, 94, 32, 15
EXEC add_TeamStatsByName 'Philadelphia 76ers', 43, 39, 2002, 43, 90, 29, 15
EXEC add_TeamStatsByName 'Philadelphia 76ers', 48, 34, 2003, 44, 96, 31, 14
EXEC add_TeamStatsByName 'Philadelphia 76ers', 33, 49, 2004, 42, 87, 34, 15
EXEC add_TeamStatsByName 'Philadelphia 76ers', 43, 39, 2005, 43, 99, 34, 15
EXEC add_TeamStatsByName 'Philadelphia 76ers', 38, 44, 2006, 45, 99, 36, 14
EXEC add_TeamStatsByName 'Philadelphia 76ers', 35, 47, 2007, 45, 94, 34, 15
EXEC add_TeamStatsByName 'Philadelphia 76ers', 40, 42, 2008, 46, 96, 31, 14
EXEC add_TeamStatsByName 'Philadelphia 76ers', 41, 41, 2009, 45, 97, 31, 14
EXEC add_TeamStatsByName 'Philadelphia 76ers', 27, 55, 2010, 46, 97, 34, 14
EXEC add_TeamStatsByName 'Philadelphia 76ers', 41, 41, 2011, 46, 99, 35, 12
EXEC add_TeamStatsByName 'Philadelphia 76ers', 35, 31, 2012, 44, 93, 36, 11
EXEC add_TeamStatsByName 'Philadelphia 76ers', 34, 48, 2013, 44, 93, 36, 13
EXEC add_TeamStatsByName 'Philadelphia 76ers', 19, 63, 2014, 43, 99, 31, 16
EXEC add_TeamStatsByName 'Philadelphia 76ers', 18, 64, 2015, 40, 91, 32, 17
EXEC add_TeamStatsByName 'Philadelphia 76ers', 10, 72, 2016, 43, 97, 33, 16
EXEC add_TeamStatsByName 'Philadelphia 76ers', 28, 54, 2017, 44, 102, 34, 16
EXEC add_TeamStatsByName 'Philadelphia 76ers', 52, 30, 2018, 47, 109, 36, 16
EXEC add_TeamStatsByName 'Philadelphia 76ers', 51, 31, 2019, 47, 115, 35, 14
EXEC add_TeamStatsByName 'Philadelphia 76ers', 43, 30, 2020, 46, 110, 36, 14
EXEC add_TeamStatsByName 'Philadelphia 76ers', 49, 23, 2021, 47, 113, 37, 14
EXEC add_TeamStatsByName 'Philadelphia 76ers', 37, 23, 2022, 46, 111, 35, 12
EXEC add_TeamStatsByName 'Phoenix Suns', 55, 27, 1980, 49, 111, 24, 19
EXEC add_TeamStatsByName 'Phoenix Suns', 57, 25, 1981, 49, 109, 21, 21
EXEC add_TeamStatsByName 'Phoenix Suns', 46, 36, 1982, 49, 106, 31, 18
EXEC add_TeamStatsByName 'Phoenix Suns', 53, 29, 1983, 49, 107, 25, 18
EXEC add_TeamStatsByName 'Phoenix Suns', 41, 41, 1984, 50, 110, 25, 17
EXEC add_TeamStatsByName 'Phoenix Suns', 36, 46, 1985, 49, 108, 28, 19
EXEC add_TeamStatsByName 'Phoenix Suns', 32, 50, 1986, 50, 110, 20, 21
EXEC add_TeamStatsByName 'Phoenix Suns', 36, 46, 1987, 49, 111, 24, 18
EXEC add_TeamStatsByName 'Phoenix Suns', 28, 54, 1988, 48, 108, 33, 17
EXEC add_TeamStatsByName 'Phoenix Suns', 55, 27, 1989, 49, 118, 34, 15
EXEC add_TeamStatsByName 'Phoenix Suns', 54, 28, 1990, 49, 114, 32, 15
EXEC add_TeamStatsByName 'Phoenix Suns', 55, 27, 1991, 49, 114, 31, 15
EXEC add_TeamStatsByName 'Phoenix Suns', 53, 29, 1992, 49, 112, 38, 15
EXEC add_TeamStatsByName 'Phoenix Suns', 62, 20, 1993, 49, 113, 36, 16
EXEC add_TeamStatsByName 'Phoenix Suns', 56, 26, 1994, 48, 108, 33, 15
EXEC add_TeamStatsByName 'Phoenix Suns', 59, 23, 1995, 48, 110, 36, 14
EXEC add_TeamStatsByName 'Phoenix Suns', 41, 41, 1996, 47, 104, 33, 14
EXEC add_TeamStatsByName 'Phoenix Suns', 40, 42, 1997, 46, 102, 36, 14
EXEC add_TeamStatsByName 'Phoenix Suns', 56, 26, 1998, 46, 99, 35, 15
EXEC add_TeamStatsByName 'Phoenix Suns', 27, 23, 1999, 44, 95, 37, 13
EXEC add_TeamStatsByName 'Phoenix Suns', 53, 29, 2000, 45, 98, 36, 16
EXEC add_TeamStatsByName 'Phoenix Suns', 51, 31, 2001, 43, 94, 31, 15
EXEC add_TeamStatsByName 'Phoenix Suns', 36, 46, 2002, 44, 95, 32, 14
EXEC add_TeamStatsByName 'Phoenix Suns', 44, 38, 2003, 44, 95, 34, 14
EXEC add_TeamStatsByName 'Phoenix Suns', 29, 53, 2004, 44, 94, 34, 15
EXEC add_TeamStatsByName 'Phoenix Suns', 62, 20, 2005, 47, 110, 39, 13
EXEC add_TeamStatsByName 'Phoenix Suns', 54, 28, 2006, 47, 108, 39, 13
EXEC add_TeamStatsByName 'Phoenix Suns', 61, 21, 2007, 49, 110, 39, 14
EXEC add_TeamStatsByName 'Phoenix Suns', 55, 27, 2008, 50, 110, 39, 14
EXEC add_TeamStatsByName 'Phoenix Suns', 46, 36, 2009, 50, 109, 38, 15
EXEC add_TeamStatsByName 'Phoenix Suns', 54, 28, 2010, 49, 110, 41, 14
EXEC add_TeamStatsByName 'Phoenix Suns', 40, 42, 2011, 47, 105, 37, 14
EXEC add_TeamStatsByName 'Phoenix Suns', 33, 33, 2012, 45, 98, 34, 14
EXEC add_TeamStatsByName 'Phoenix Suns', 25, 57, 2013, 44, 95, 33, 15
EXEC add_TeamStatsByName 'Phoenix Suns', 48, 34, 2014, 46, 105, 37, 15
EXEC add_TeamStatsByName 'Phoenix Suns', 39, 43, 2015, 45, 102, 34, 15
EXEC add_TeamStatsByName 'Phoenix Suns', 23, 59, 2016, 43, 100, 34, 17
EXEC add_TeamStatsByName 'Phoenix Suns', 24, 58, 2017, 45, 107, 33, 15
EXEC add_TeamStatsByName 'Phoenix Suns', 21, 61, 2018, 44, 103, 33, 15
EXEC add_TeamStatsByName 'Phoenix Suns', 19, 63, 2019, 45, 107, 32, 15
EXEC add_TeamStatsByName 'Phoenix Suns', 34, 39, 2020, 46, 113, 35, 14
EXEC add_TeamStatsByName 'Phoenix Suns', 51, 21, 2021, 49, 115, 37, 12
EXEC add_TeamStatsByName 'Phoenix Suns', 49, 12, 2022, 48, 114, 36, 13
EXEC add_TeamStatsByName 'Sacramento Kings', 37, 45, 1986, 49, 108, 22, 18
EXEC add_TeamStatsByName 'Sacramento Kings', 29, 53, 1987, 47, 110, 25, 17
EXEC add_TeamStatsByName 'Sacramento Kings', 24, 58, 1988, 47, 107, 32, 17
EXEC add_TeamStatsByName 'Sacramento Kings', 27, 55, 1989, 45, 105, 37, 16
EXEC add_TeamStatsByName 'Sacramento Kings', 23, 59, 1990, 46, 101, 33, 15
EXEC add_TeamStatsByName 'Sacramento Kings', 25, 57, 1991, 45, 96, 37, 15
EXEC add_TeamStatsByName 'Sacramento Kings', 29, 53, 1992, 46, 104, 35, 16
EXEC add_TeamStatsByName 'Sacramento Kings', 25, 57, 1993, 46, 107, 33, 16
EXEC add_TeamStatsByName 'Sacramento Kings', 28, 54, 1994, 45, 101, 35, 16
EXEC add_TeamStatsByName 'Sacramento Kings', 39, 43, 1995, 46, 98, 34, 17
EXEC add_TeamStatsByName 'Sacramento Kings', 39, 43, 1996, 45, 99, 38, 17
EXEC add_TeamStatsByName 'Sacramento Kings', 34, 48, 1997, 45, 96, 39, 16
EXEC add_TeamStatsByName 'Sacramento Kings', 27, 55, 1998, 44, 93, 35, 15
EXEC add_TeamStatsByName 'Sacramento Kings', 27, 23, 1999, 44, 100, 30, 16
EXEC add_TeamStatsByName 'Sacramento Kings', 44, 38, 2000, 45, 104, 32, 16
EXEC add_TeamStatsByName 'Sacramento Kings', 55, 27, 2001, 44, 101, 35, 14
EXEC add_TeamStatsByName 'Sacramento Kings', 61, 21, 2002, 46, 104, 36, 13
EXEC add_TeamStatsByName 'Sacramento Kings', 59, 23, 2003, 46, 101, 38, 14
EXEC add_TeamStatsByName 'Sacramento Kings', 55, 27, 2004, 46, 102, 40, 13
EXEC add_TeamStatsByName 'Sacramento Kings', 50, 32, 2005, 45, 103, 37, 13
EXEC add_TeamStatsByName 'Sacramento Kings', 44, 38, 2006, 45, 98, 35, 14
EXEC add_TeamStatsByName 'Sacramento Kings', 33, 49, 2007, 45, 101, 35, 14
EXEC add_TeamStatsByName 'Sacramento Kings', 38, 44, 2008, 46, 102, 37, 16
EXEC add_TeamStatsByName 'Sacramento Kings', 17, 65, 2009, 44, 100, 36, 15
EXEC add_TeamStatsByName 'Sacramento Kings', 25, 57, 2010, 45, 100, 34, 14
EXEC add_TeamStatsByName 'Sacramento Kings', 24, 58, 2011, 44, 99, 33, 16
EXEC add_TeamStatsByName 'Sacramento Kings', 22, 44, 2012, 43, 98, 31, 14
EXEC add_TeamStatsByName 'Sacramento Kings', 28, 54, 2013, 44, 100, 36, 14
EXEC add_TeamStatsByName 'Sacramento Kings', 28, 54, 2014, 44, 100, 33, 15
EXEC add_TeamStatsByName 'Sacramento Kings', 29, 53, 2015, 45, 101, 34, 16
EXEC add_TeamStatsByName 'Sacramento Kings', 33, 49, 2016, 46, 106, 35, 16
EXEC add_TeamStatsByName 'Sacramento Kings', 32, 50, 2017, 46, 102, 37, 14
EXEC add_TeamStatsByName 'Sacramento Kings', 27, 55, 2018, 45, 98, 37, 13
EXEC add_TeamStatsByName 'Sacramento Kings', 39, 43, 2019, 46, 114, 37, 13
EXEC add_TeamStatsByName 'Sacramento Kings', 31, 41, 2020, 46, 110, 36, 14
EXEC add_TeamStatsByName 'Sacramento Kings', 31, 41, 2021, 48, 113, 36, 13
EXEC add_TeamStatsByName 'Sacramento Kings', 23, 40, 2022, 45, 109, 34, 14
EXEC add_TeamStatsByName 'San Antonio Spurs', 41, 41, 1980, 49, 119, 25, 19
EXEC add_TeamStatsByName 'San Antonio Spurs', 52, 30, 1981, 49, 112, 17, 18
EXEC add_TeamStatsByName 'San Antonio Spurs', 48, 34, 1982, 48, 113, 25, 15
EXEC add_TeamStatsByName 'San Antonio Spurs', 53, 29, 1983, 50, 114, 30, 18
EXEC add_TeamStatsByName 'San Antonio Spurs', 37, 45, 1984, 50, 120, 30, 17
EXEC add_TeamStatsByName 'San Antonio Spurs', 41, 41, 1985, 51, 114, 27, 18
EXEC add_TeamStatsByName 'San Antonio Spurs', 35, 47, 1986, 50, 111, 23, 19
EXEC add_TeamStatsByName 'San Antonio Spurs', 28, 54, 1987, 47, 108, 28, 17
EXEC add_TeamStatsByName 'San Antonio Spurs', 31, 51, 1988, 49, 113, 32, 17
EXEC add_TeamStatsByName 'San Antonio Spurs', 21, 61, 1989, 46, 105, 21, 20
EXEC add_TeamStatsByName 'San Antonio Spurs', 56, 26, 1990, 48, 106, 23, 17
EXEC add_TeamStatsByName 'San Antonio Spurs', 55, 27, 1991, 48, 107, 27, 17
EXEC add_TeamStatsByName 'San Antonio Spurs', 47, 35, 1992, 47, 103, 29, 15
EXEC add_TeamStatsByName 'San Antonio Spurs', 49, 33, 1993, 49, 105, 34, 14
EXEC add_TeamStatsByName 'San Antonio Spurs', 55, 27, 1994, 47, 100, 34, 14
EXEC add_TeamStatsByName 'San Antonio Spurs', 62, 20, 1995, 48, 106, 37, 15
EXEC add_TeamStatsByName 'San Antonio Spurs', 59, 23, 1996, 47, 103, 39, 14
EXEC add_TeamStatsByName 'San Antonio Spurs', 20, 62, 1997, 44, 90, 32, 15
EXEC add_TeamStatsByName 'San Antonio Spurs', 56, 26, 1998, 46, 92, 35, 16
EXEC add_TeamStatsByName 'San Antonio Spurs', 37, 13, 1999, 45, 92, 33, 15
EXEC add_TeamStatsByName 'San Antonio Spurs', 53, 29, 2000, 46, 96, 37, 15
EXEC add_TeamStatsByName 'San Antonio Spurs', 58, 24, 2001, 46, 96, 40, 13
EXEC add_TeamStatsByName 'San Antonio Spurs', 58, 24, 2002, 45, 96, 36, 14
EXEC add_TeamStatsByName 'San Antonio Spurs', 60, 22, 2003, 46, 95, 35, 15
EXEC add_TeamStatsByName 'San Antonio Spurs', 57, 25, 2004, 44, 91, 35, 14
EXEC add_TeamStatsByName 'San Antonio Spurs', 59, 23, 2005, 45, 96, 36, 13
EXEC add_TeamStatsByName 'San Antonio Spurs', 63, 19, 2006, 47, 95, 38, 13
EXEC add_TeamStatsByName 'San Antonio Spurs', 58, 24, 2007, 47, 98, 38, 13
EXEC add_TeamStatsByName 'San Antonio Spurs', 56, 26, 2008, 45, 95, 36, 12
EXEC add_TeamStatsByName 'San Antonio Spurs', 54, 28, 2009, 46, 97, 38, 11
EXEC add_TeamStatsByName 'San Antonio Spurs', 50, 32, 2010, 47, 101, 35, 13
EXEC add_TeamStatsByName 'San Antonio Spurs', 61, 21, 2011, 47, 103, 39, 13
EXEC add_TeamStatsByName 'San Antonio Spurs', 50, 16, 2012, 47, 103, 39, 13
EXEC add_TeamStatsByName 'San Antonio Spurs', 58, 24, 2013, 48, 103, 37, 14
EXEC add_TeamStatsByName 'San Antonio Spurs', 62, 20, 2014, 48, 105, 39, 14
EXEC add_TeamStatsByName 'San Antonio Spurs', 55, 27, 2015, 46, 103, 36, 13
EXEC add_TeamStatsByName 'San Antonio Spurs', 67, 15, 2016, 48, 103, 37, 13
EXEC add_TeamStatsByName 'San Antonio Spurs', 61, 21, 2017, 46, 105, 39, 13
EXEC add_TeamStatsByName 'San Antonio Spurs', 47, 35, 2018, 45, 102, 35, 13
EXEC add_TeamStatsByName 'San Antonio Spurs', 48, 34, 2019, 47, 111, 39, 12
EXEC add_TeamStatsByName 'San Antonio Spurs', 32, 39, 2020, 47, 114, 37, 12
EXEC add_TeamStatsByName 'San Antonio Spurs', 33, 39, 2021, 46, 111, 35, 11
EXEC add_TeamStatsByName 'San Antonio Spurs', 24, 38, 2022, 46, 111, 35, 12
EXEC add_TeamStatsByName 'Toronto Raptors', 21, 61, 1996, 46, 97, 35, 18
EXEC add_TeamStatsByName 'Toronto Raptors', 30, 52, 1997, 43, 95, 36, 16
EXEC add_TeamStatsByName 'Toronto Raptors', 16, 66, 1998, 43, 94, 34, 16
EXEC add_TeamStatsByName 'Toronto Raptors', 23, 27, 1999, 42, 91, 34, 15
EXEC add_TeamStatsByName 'Toronto Raptors', 45, 37, 2000, 43, 97, 36, 13
EXEC add_TeamStatsByName 'Toronto Raptors', 47, 35, 2001, 43, 97, 36, 13
EXEC add_TeamStatsByName 'Toronto Raptors', 42, 40, 2002, 43, 91, 34, 14
EXEC add_TeamStatsByName 'Toronto Raptors', 24, 58, 2003, 42, 90, 34, 14
EXEC add_TeamStatsByName 'Toronto Raptors', 33, 49, 2004, 41, 85, 35, 14
EXEC add_TeamStatsByName 'Toronto Raptors', 33, 49, 2005, 44, 99, 38, 13
EXEC add_TeamStatsByName 'Toronto Raptors', 27, 55, 2006, 45, 101, 37, 13
EXEC add_TeamStatsByName 'Toronto Raptors', 47, 35, 2007, 46, 99, 36, 13
EXEC add_TeamStatsByName 'Toronto Raptors', 41, 41, 2008, 46, 100, 39, 11
EXEC add_TeamStatsByName 'Toronto Raptors', 33, 49, 2009, 45, 99, 37, 13
EXEC add_TeamStatsByName 'Toronto Raptors', 40, 42, 2010, 48, 104, 37, 13
EXEC add_TeamStatsByName 'Toronto Raptors', 22, 60, 2011, 46, 99, 31, 14
EXEC add_TeamStatsByName 'Toronto Raptors', 23, 43, 2012, 44, 90, 34, 15
EXEC add_TeamStatsByName 'Toronto Raptors', 34, 48, 2013, 44, 97, 34, 13
EXEC add_TeamStatsByName 'Toronto Raptors', 48, 34, 2014, 44, 101, 37, 14
EXEC add_TeamStatsByName 'Toronto Raptors', 49, 33, 2015, 45, 103, 35, 12
EXEC add_TeamStatsByName 'Toronto Raptors', 56, 26, 2016, 45, 102, 37, 13
EXEC add_TeamStatsByName 'Toronto Raptors', 51, 31, 2017, 46, 106, 36, 12
EXEC add_TeamStatsByName 'Toronto Raptors', 59, 23, 2018, 47, 111, 35, 13
EXEC add_TeamStatsByName 'Toronto Raptors', 58, 24, 2019, 47, 114, 36, 14
EXEC add_TeamStatsByName 'Toronto Raptors', 53, 19, 2020, 45, 112, 37, 14
EXEC add_TeamStatsByName 'Toronto Raptors', 27, 45, 2021, 44, 111, 36, 13
EXEC add_TeamStatsByName 'Toronto Raptors', 33, 27, 2022, 44, 112, 35, 13
EXEC add_TeamStatsByName 'Utah Jazz', 24, 58, 1980, 49, 102, 31, 18
EXEC add_TeamStatsByName 'Utah Jazz', 28, 54, 1981, 48, 101, 25, 17
EXEC add_TeamStatsByName 'Utah Jazz', 25, 57, 1982, 49, 110, 22, 17
EXEC add_TeamStatsByName 'Utah Jazz', 30, 52, 1983, 48, 109, 24, 20
EXEC add_TeamStatsByName 'Utah Jazz', 45, 37, 1984, 49, 114, 31, 18
EXEC add_TeamStatsByName 'Utah Jazz', 41, 41, 1985, 47, 108, 33, 19
EXEC add_TeamStatsByName 'Utah Jazz', 42, 40, 1986, 48, 108, 20, 18
EXEC add_TeamStatsByName 'Utah Jazz', 44, 38, 1987, 46, 107, 31, 17
EXEC add_TeamStatsByName 'Utah Jazz', 47, 35, 1988, 49, 108, 31, 18
EXEC add_TeamStatsByName 'Utah Jazz', 51, 31, 1989, 48, 104, 30, 18
EXEC add_TeamStatsByName 'Utah Jazz', 55, 27, 1990, 50, 106, 35, 17
EXEC add_TeamStatsByName 'Utah Jazz', 54, 28, 1991, 49, 103, 32, 15
EXEC add_TeamStatsByName 'Utah Jazz', 55, 27, 1992, 49, 108, 34, 15
EXEC add_TeamStatsByName 'Utah Jazz', 47, 35, 1993, 48, 106, 31, 15
EXEC add_TeamStatsByName 'Utah Jazz', 53, 29, 1994, 47, 101, 32, 14
EXEC add_TeamStatsByName 'Utah Jazz', 60, 22, 1995, 51, 106, 37, 15
EXEC add_TeamStatsByName 'Utah Jazz', 55, 27, 1996, 48, 102, 37, 14
EXEC add_TeamStatsByName 'Utah Jazz', 64, 18, 1997, 50, 103, 37, 15
EXEC add_TeamStatsByName 'Utah Jazz', 62, 20, 1998, 49, 100, 37, 15
EXEC add_TeamStatsByName 'Utah Jazz', 37, 13, 1999, 46, 93, 36, 16
EXEC add_TeamStatsByName 'Utah Jazz', 55, 27, 2000, 46, 96, 38, 14
EXEC add_TeamStatsByName 'Utah Jazz', 53, 29, 2001, 47, 97, 38, 15
EXEC add_TeamStatsByName 'Utah Jazz', 44, 38, 2002, 45, 95, 33, 16
EXEC add_TeamStatsByName 'Utah Jazz', 47, 35, 2003, 46, 94, 34, 16
EXEC add_TeamStatsByName 'Utah Jazz', 42, 40, 2004, 43, 88, 32, 16
EXEC add_TeamStatsByName 'Utah Jazz', 26, 56, 2005, 44, 92, 32, 15
EXEC add_TeamStatsByName 'Utah Jazz', 41, 41, 2006, 44, 92, 33, 15
EXEC add_TeamStatsByName 'Utah Jazz', 51, 31, 2007, 47, 101, 33, 15
EXEC add_TeamStatsByName 'Utah Jazz', 54, 28, 2008, 49, 106, 37, 14
EXEC add_TeamStatsByName 'Utah Jazz', 48, 34, 2009, 47, 103, 34, 14
EXEC add_TeamStatsByName 'Utah Jazz', 53, 29, 2010, 49, 104, 36, 15
EXEC add_TeamStatsByName 'Utah Jazz', 39, 43, 2011, 46, 99, 34, 14
EXEC add_TeamStatsByName 'Utah Jazz', 36, 30, 2012, 45, 99, 32, 14
EXEC add_TeamStatsByName 'Utah Jazz', 43, 39, 2013, 45, 98, 36, 14
EXEC add_TeamStatsByName 'Utah Jazz', 25, 57, 2014, 44, 95, 34, 14
EXEC add_TeamStatsByName 'Utah Jazz', 38, 44, 2015, 44, 95, 34, 15
EXEC add_TeamStatsByName 'Utah Jazz', 40, 42, 2016, 44, 97, 35, 14
EXEC add_TeamStatsByName 'Utah Jazz', 51, 31, 2017, 46, 100, 37, 13
EXEC add_TeamStatsByName 'Utah Jazz', 48, 34, 2018, 46, 104, 36, 14
EXEC add_TeamStatsByName 'Utah Jazz', 50, 32, 2019, 46, 111, 35, 15
EXEC add_TeamStatsByName 'Utah Jazz', 44, 28, 2020, 47, 111, 38, 15
EXEC add_TeamStatsByName 'Utah Jazz', 52, 20, 2021, 46, 116, 38, 14
EXEC add_TeamStatsByName 'Utah Jazz', 38, 22, 2022, 47, 116, 36, 14
EXEC add_TeamStatsByName 'Washington Wizards', 42, 40, 1998, 45, 97, 33, 14
EXEC add_TeamStatsByName 'Washington Wizards', 18, 32, 1999, 44, 91, 30, 14
EXEC add_TeamStatsByName 'Washington Wizards', 29, 53, 2000, 45, 96, 37, 16
EXEC add_TeamStatsByName 'Washington Wizards', 19, 63, 2001, 43, 93, 32, 16
EXEC add_TeamStatsByName 'Washington Wizards', 37, 45, 2002, 44, 92, 38, 13
EXEC add_TeamStatsByName 'Washington Wizards', 37, 45, 2003, 44, 91, 31, 13
EXEC add_TeamStatsByName 'Washington Wizards', 25, 57, 2004, 42, 91, 34, 17
EXEC add_TeamStatsByName 'Washington Wizards', 45, 37, 2005, 43, 100, 34, 14
EXEC add_TeamStatsByName 'Washington Wizards', 42, 40, 2006, 44, 101, 35, 13
EXEC add_TeamStatsByName 'Washington Wizards', 41, 41, 2007, 45, 104, 34, 13
EXEC add_TeamStatsByName 'Washington Wizards', 43, 39, 2008, 44, 98, 35, 13
EXEC add_TeamStatsByName 'Washington Wizards', 19, 63, 2009, 45, 96, 33, 13
EXEC add_TeamStatsByName 'Washington Wizards', 26, 56, 2010, 44, 96, 35, 14
EXEC add_TeamStatsByName 'Washington Wizards', 23, 59, 2011, 44, 97, 33, 15
EXEC add_TeamStatsByName 'Washington Wizards', 20, 46, 2012, 44, 93, 32, 15
EXEC add_TeamStatsByName 'Washington Wizards', 29, 53, 2013, 43, 93, 36, 15
EXEC add_TeamStatsByName 'Washington Wizards', 44, 38, 2014, 45, 100, 38, 14
EXEC add_TeamStatsByName 'Washington Wizards', 46, 36, 2015, 46, 98, 36, 15
EXEC add_TeamStatsByName 'Washington Wizards', 41, 41, 2016, 46, 104, 35, 14
EXEC add_TeamStatsByName 'Washington Wizards', 49, 33, 2017, 47, 109, 37, 14
EXEC add_TeamStatsByName 'Washington Wizards', 43, 39, 2018, 46, 106, 37, 14
EXEC add_TeamStatsByName 'Washington Wizards', 32, 50, 2019, 46, 114, 34, 14
EXEC add_TeamStatsByName 'Washington Wizards', 25, 47, 2020, 45, 114, 36, 14
EXEC add_TeamStatsByName 'Washington Wizards', 34, 38, 2021, 47, 116, 35, 14
EXEC add_TeamStatsByName 'Washington Wizards', 27, 33, 2022, 46, 109, 33, 13
EXEC add_TeamStatsByName 'New Orleans Hornets', 47, 35, 2003, 43, 93, 37, 14
EXEC add_TeamStatsByName 'New Orleans Hornets', 41, 41, 2004, 42, 91, 31, 14
EXEC add_TeamStatsByName 'New Orleans Hornets', 18, 64, 2005, 41, 88, 31, 14
EXEC add_TeamStatsByName 'New Orleans Hornets', 56, 26, 2008, 46, 100, 38, 11
EXEC add_TeamStatsByName 'New Orleans Hornets', 49, 33, 2009, 45, 95, 36, 12
EXEC add_TeamStatsByName 'New Orleans Hornets', 37, 45, 2010, 46, 100, 36, 13
EXEC add_TeamStatsByName 'New Orleans Hornets', 46, 36, 2011, 45, 94, 36, 13
EXEC add_TeamStatsByName 'New Orleans Hornets', 21, 45, 2012, 45, 89, 33, 15
EXEC add_TeamStatsByName 'New Orleans Hornets', 27, 55, 2013, 44, 94, 36, 14
EXEC add_TeamStatsByName 'New Jersey Nets', 34, 48, 1980, 46, 108, 28, 20
EXEC add_TeamStatsByName 'New Jersey Nets', 24, 58, 1981, 47, 106, 24, 20
EXEC add_TeamStatsByName 'New Jersey Nets', 44, 38, 1982, 48, 106, 20, 20
EXEC add_TeamStatsByName 'New Jersey Nets', 49, 33, 1983, 49, 105, 20, 22
EXEC add_TeamStatsByName 'New Jersey Nets', 45, 37, 1984, 49, 109, 21, 19
EXEC add_TeamStatsByName 'New Jersey Nets', 42, 40, 1985, 49, 109, 23, 16
EXEC add_TeamStatsByName 'New Jersey Nets', 39, 43, 1986, 48, 109, 20, 19
EXEC add_TeamStatsByName 'New Jersey Nets', 24, 58, 1987, 47, 108, 32, 19
EXEC add_TeamStatsByName 'New Jersey Nets', 19, 63, 1988, 46, 100, 30, 18
EXEC add_TeamStatsByName 'New Jersey Nets', 26, 56, 1989, 46, 103, 32, 17
EXEC add_TeamStatsByName 'New Jersey Nets', 17, 65, 1990, 42, 100, 27, 16
EXEC add_TeamStatsByName 'New Jersey Nets', 26, 56, 1991, 44, 102, 27, 17
EXEC add_TeamStatsByName 'New Jersey Nets', 40, 42, 1992, 45, 105, 33, 16
EXEC add_TeamStatsByName 'New Jersey Nets', 43, 39, 1993, 46, 102, 31, 16
EXEC add_TeamStatsByName 'New Jersey Nets', 45, 37, 1994, 44, 103, 32, 14
EXEC add_TeamStatsByName 'New Jersey Nets', 30, 52, 1995, 43, 98, 31, 15
EXEC add_TeamStatsByName 'New Jersey Nets', 30, 52, 1996, 42, 93, 33, 16
EXEC add_TeamStatsByName 'New Jersey Nets', 26, 56, 1997, 42, 97, 35, 15
EXEC add_TeamStatsByName 'New Jersey Nets', 43, 39, 1998, 44, 99, 33, 14
EXEC add_TeamStatsByName 'New Jersey Nets', 16, 34, 1999, 40, 91, 33, 15
EXEC add_TeamStatsByName 'New Jersey Nets', 31, 51, 2000, 43, 98, 34, 13
EXEC add_TeamStatsByName 'New Jersey Nets', 26, 56, 2001, 42, 92, 33, 14
EXEC add_TeamStatsByName 'New Jersey Nets', 52, 30, 2002, 44, 96, 33, 14
EXEC add_TeamStatsByName 'New Jersey Nets', 49, 33, 2003, 44, 95, 33, 14
EXEC add_TeamStatsByName 'New Jersey Nets', 47, 35, 2004, 44, 90, 33, 14
EXEC add_TeamStatsByName 'New Jersey Nets', 42, 40, 2005, 42, 91, 36, 14
EXEC add_TeamStatsByName 'New Jersey Nets', 49, 33, 2006, 44, 93, 33, 13
EXEC add_TeamStatsByName 'New Jersey Nets', 41, 41, 2007, 45, 97, 36, 14
EXEC add_TeamStatsByName 'New Jersey Nets', 34, 48, 2008, 44, 95, 34, 14
EXEC add_TeamStatsByName 'New Jersey Nets', 34, 48, 2009, 44, 98, 37, 13
EXEC add_TeamStatsByName 'New Jersey Nets', 12, 70, 2010, 42, 92, 31, 14
EXEC add_TeamStatsByName 'New Jersey Nets', 24, 58, 2011, 44, 94, 34, 14
EXEC add_TeamStatsByName 'New Jersey Nets', 22, 44, 2012, 42, 93, 34, 15
EXEC add_TeamStatsByName 'Seattle SuperSonics', 56, 26, 1980, 47, 108, 31, 18
EXEC add_TeamStatsByName 'Seattle SuperSonics', 34, 48, 1981, 46, 104, 27, 18
EXEC add_TeamStatsByName 'Seattle SuperSonics', 52, 30, 1982, 48, 107, 24, 16
EXEC add_TeamStatsByName 'Seattle SuperSonics', 48, 34, 1983, 49, 109, 21, 18
EXEC add_TeamStatsByName 'Seattle SuperSonics', 42, 40, 1984, 48, 108, 19, 16
EXEC add_TeamStatsByName 'Seattle SuperSonics', 31, 51, 1985, 47, 102, 24, 18
EXEC add_TeamStatsByName 'Seattle SuperSonics', 31, 51, 1986, 47, 104, 26, 17
EXEC add_TeamStatsByName 'Seattle SuperSonics', 39, 43, 1987, 48, 113, 33, 18
EXEC add_TeamStatsByName 'Seattle SuperSonics', 44, 38, 1988, 47, 111, 34, 16
EXEC add_TeamStatsByName 'Seattle SuperSonics', 47, 35, 1989, 47, 112, 37, 17
EXEC add_TeamStatsByName 'Seattle SuperSonics', 41, 41, 1990, 47, 106, 35, 16
EXEC add_TeamStatsByName 'Seattle SuperSonics', 41, 41, 1991, 49, 106, 31, 17
EXEC add_TeamStatsByName 'Seattle SuperSonics', 47, 35, 1992, 47, 106, 31, 16
EXEC add_TeamStatsByName 'Seattle SuperSonics', 55, 27, 1993, 48, 108, 35, 15
EXEC add_TeamStatsByName 'Seattle SuperSonics', 63, 19, 1994, 48, 105, 33, 15
EXEC add_TeamStatsByName 'Seattle SuperSonics', 57, 25, 1995, 49, 110, 37, 15
EXEC add_TeamStatsByName 'Seattle SuperSonics', 64, 18, 1996, 48, 104, 36, 17
EXEC add_TeamStatsByName 'Seattle SuperSonics', 57, 25, 1997, 46, 100, 35, 15
EXEC add_TeamStatsByName 'Seattle SuperSonics', 61, 21, 1998, 47, 100, 39, 13
EXEC add_TeamStatsByName 'Seattle SuperSonics', 25, 25, 1999, 44, 94, 34, 15
EXEC add_TeamStatsByName 'Seattle SuperSonics', 45, 37, 2000, 44, 99, 33, 14
EXEC add_TeamStatsByName 'Seattle SuperSonics', 44, 38, 2001, 45, 97, 39, 15
EXEC add_TeamStatsByName 'Seattle SuperSonics', 45, 37, 2002, 46, 97, 37, 13
EXEC add_TeamStatsByName 'Seattle SuperSonics', 40, 42, 2003, 43, 92, 35, 13
EXEC add_TeamStatsByName 'Seattle SuperSonics', 37, 45, 2004, 44, 97, 37, 14
EXEC add_TeamStatsByName 'Seattle SuperSonics', 52, 30, 2005, 44, 98, 36, 13
EXEC add_TeamStatsByName 'Seattle SuperSonics', 35, 47, 2006, 45, 102, 37, 14
EXEC add_TeamStatsByName 'Seattle SuperSonics', 31, 51, 2007, 46, 99, 36, 15
EXEC add_TeamStatsByName 'Seattle SuperSonics', 20, 62, 2008, 44, 97, 33, 15
EXEC add_TeamStatsByName 'Vancouver Grizzlies', 15, 67, 1996, 42, 89, 32, 16
EXEC add_TeamStatsByName 'Vancouver Grizzlies', 14, 68, 1997, 43, 89, 34, 15
EXEC add_TeamStatsByName 'Vancouver Grizzlies', 19, 63, 1998, 45, 96, 36, 17
EXEC add_TeamStatsByName 'Vancouver Grizzlies', 8, 42, 1999, 42, 88, 32, 16
EXEC add_TeamStatsByName 'Vancouver Grizzlies', 22, 60, 2000, 44, 93, 36, 16
EXEC add_TeamStatsByName 'Vancouver Grizzlies', 23, 59, 2001, 43, 91, 34, 15
EXEC add_TeamStatsByName 'Washington Bullets', 39, 43, 1980, 45, 106, 30, 16
EXEC add_TeamStatsByName 'Washington Bullets', 39, 43, 1981, 47, 105, 27, 17
EXEC add_TeamStatsByName 'Washington Bullets', 43, 39, 1982, 47, 103, 25, 16
EXEC add_TeamStatsByName 'Washington Bullets', 42, 40, 1983, 46, 99, 29, 19
EXEC add_TeamStatsByName 'Washington Bullets', 35, 47, 1984, 48, 102, 25, 17
EXEC add_TeamStatsByName 'Washington Bullets', 40, 42, 1985, 47, 105, 27, 15
EXEC add_TeamStatsByName 'Washington Bullets', 39, 43, 1986, 46, 102, 28, 16
EXEC add_TeamStatsByName 'Washington Bullets', 42, 40, 1987, 45, 105, 19, 15
EXEC add_TeamStatsByName 'Washington Bullets', 38, 44, 1988, 46, 105, 21, 16
EXEC add_TeamStatsByName 'Washington Bullets', 40, 42, 1989, 46, 108, 21, 15
EXEC add_TeamStatsByName 'Washington Bullets', 31, 51, 1990, 47, 107, 18, 14
EXEC add_TeamStatsByName 'Washington Bullets', 30, 52, 1991, 46, 101, 19, 16
EXEC add_TeamStatsByName 'Washington Bullets', 25, 57, 1992, 46, 102, 27, 15
EXEC add_TeamStatsByName 'Washington Bullets', 22, 60, 1993, 46, 101, 30, 16
EXEC add_TeamStatsByName 'Washington Bullets', 24, 58, 1994, 46, 100, 29, 17
EXEC add_TeamStatsByName 'Washington Bullets', 21, 61, 1995, 46, 100, 34, 15
EXEC add_TeamStatsByName 'Washington Bullets', 39, 43, 1996, 48, 102, 40, 16
EXEC add_TeamStatsByName 'Washington Bullets', 44, 38, 1997, 48, 99, 33, 15
EXEC add_TeamStatsByName 'Kansas City Kings', 47, 35, 1980, 47, 108, 21, 17
EXEC add_TeamStatsByName 'Kansas City Kings', 40, 42, 1981, 50, 106, 29, 17
EXEC add_TeamStatsByName 'Kansas City Kings', 30, 52, 1982, 49, 107, 20, 18
EXEC add_TeamStatsByName 'Kansas City Kings', 45, 37, 1983, 49, 113, 23, 20
EXEC add_TeamStatsByName 'Kansas City Kings', 38, 44, 1984, 48, 110, 27, 18
EXEC add_TeamStatsByName 'Kansas City Kings', 31, 51, 1985, 50, 114, 26, 19
EXEC add_TeamStatsByName 'San Diego Clippers', 35, 47, 1980, 47, 107, 32, 17
EXEC add_TeamStatsByName 'San Diego Clippers', 36, 46, 1981, 47, 106, 32, 17
EXEC add_TeamStatsByName 'San Diego Clippers', 17, 65, 1982, 50, 108, 29, 19
EXEC add_TeamStatsByName 'San Diego Clippers', 25, 57, 1983, 47, 108, 24, 19
EXEC add_TeamStatsByName 'San Diego Clippers', 30, 52, 1984, 49, 110, 18, 18



