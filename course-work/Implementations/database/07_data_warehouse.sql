USE SpotifyDB;
GO

IF SCHEMA_ID('dw') IS NULL
    EXEC ('CREATE SCHEMA dw AUTHORIZATION dbo;');
GO

CREATE TABLE dw.DimDate
(
    DateKey          INT         NOT NULL,
    FullDate         DATE        NOT NULL,
    MonthNumber      TINYINT     NOT NULL,
    MonthName        VARCHAR(9)  NOT NULL,
    MonthYear        CHAR(8)     NOT NULL,
    YearMonthNumber  INT         NOT NULL,
    Quarter          TINYINT     NOT NULL,
    Year             SMALLINT    NOT NULL,
    CONSTRAINT PK_DimDate PRIMARY KEY (DateKey),
    CONSTRAINT UQ_DimDate_FullDate UNIQUE (FullDate)
);

CREATE TABLE dw.DimUser
(
    UserKey     INT           NOT NULL,
    UserID      INT           NOT NULL,
    Username    NVARCHAR(50)  NOT NULL,
    Gender      VARCHAR(13)   NOT NULL,
    AgeGroup    VARCHAR(5)    NOT NULL,
    SignupDate  DATE          NOT NULL,
    IsActive    BIT           NOT NULL,
    CONSTRAINT PK_DimUser PRIMARY KEY (UserKey),
    CONSTRAINT UQ_DimUser_UserID UNIQUE (UserID)
);

CREATE TABLE dw.DimGeography
(
    GeographyKey  INT            NOT NULL,
    CountryID     INT            NOT NULL,
    CountryCode   CHAR(2)        NOT NULL,
    CountryName   NVARCHAR(100)  NOT NULL,
    Region        NVARCHAR(50)   NOT NULL,
    CONSTRAINT PK_DimGeography PRIMARY KEY (GeographyKey),
    CONSTRAINT UQ_DimGeography_CountryID UNIQUE (CountryID)
);

CREATE TABLE dw.DimArtist
(
    ArtistKey      INT            NOT NULL,
    ArtistID       INT            NOT NULL,
    ArtistName     NVARCHAR(100)  NOT NULL,
    ArtistCountry  NVARCHAR(100)  NOT NULL,
    DebutYear      SMALLINT       NOT NULL,
    IsVerified     BIT            NOT NULL,
    CONSTRAINT PK_DimArtist PRIMARY KEY (ArtistKey),
    CONSTRAINT UQ_DimArtist_ArtistID UNIQUE (ArtistID)
);

CREATE TABLE dw.DimTrack
(
    TrackKey        INT            NOT NULL,
    TrackID         INT            NOT NULL,
    TrackTitle      NVARCHAR(200)  NOT NULL,
    ArtistName      NVARCHAR(100)  NOT NULL,
    AlbumTitle      NVARCHAR(200)  NOT NULL,
    PrimaryGenre    NVARCHAR(50)   NOT NULL,
    DurationSec     SMALLINT       NOT NULL,
    DurationBucket  VARCHAR(7)     NOT NULL,
    CONSTRAINT PK_DimTrack PRIMARY KEY (TrackKey),
    CONSTRAINT UQ_DimTrack_TrackID UNIQUE (TrackID)
);

CREATE TABLE dw.DimDevice
(
    DeviceKey        INT           NOT NULL,
    DeviceTypeID     INT           NOT NULL,
    DeviceCategory   NVARCHAR(30)  NOT NULL,
    OperatingSystem  NVARCHAR(30)  NOT NULL,
    IsMobile         BIT           NOT NULL,
    CONSTRAINT PK_DimDevice PRIMARY KEY (DeviceKey),
    CONSTRAINT UQ_DimDevice_DeviceTypeID UNIQUE (DeviceTypeID)
);

CREATE TABLE dw.DimPlan
(
    PlanKey       INT            NOT NULL,
    PlanID        INT            NOT NULL,
    PlanName      NVARCHAR(50)   NOT NULL,
    PlanTier      VARCHAR(7)     NOT NULL,
    MonthlyPrice  DECIMAL(6, 2)  NOT NULL,
    HasAds        BIT            NOT NULL,
    CONSTRAINT PK_DimPlan PRIMARY KEY (PlanKey),
    CONSTRAINT UQ_DimPlan_PlanID UNIQUE (PlanID)
);
GO

CREATE TABLE dw.FactStreams
(
    StreamID       INT      NOT NULL,
    DateKey        INT      NOT NULL,
    UserKey        INT      NOT NULL,
    TrackKey       INT      NOT NULL,
    ArtistKey      INT      NOT NULL,
    DeviceKey      INT      NOT NULL,
    GeographyKey   INT      NOT NULL,
    PlanKey        INT      NOT NULL,
    SecondsPlayed  INT      NOT NULL,
    IsSkipped      TINYINT  NOT NULL,
    CONSTRAINT PK_FactStreams PRIMARY KEY (StreamID),
    CONSTRAINT FK_FactStreams_DimDate      FOREIGN KEY (DateKey)      REFERENCES dw.DimDate (DateKey),
    CONSTRAINT FK_FactStreams_DimUser      FOREIGN KEY (UserKey)      REFERENCES dw.DimUser (UserKey),
    CONSTRAINT FK_FactStreams_DimTrack     FOREIGN KEY (TrackKey)     REFERENCES dw.DimTrack (TrackKey),
    CONSTRAINT FK_FactStreams_DimArtist    FOREIGN KEY (ArtistKey)    REFERENCES dw.DimArtist (ArtistKey),
    CONSTRAINT FK_FactStreams_DimDevice    FOREIGN KEY (DeviceKey)    REFERENCES dw.DimDevice (DeviceKey),
    CONSTRAINT FK_FactStreams_DimGeography FOREIGN KEY (GeographyKey) REFERENCES dw.DimGeography (GeographyKey),
    CONSTRAINT FK_FactStreams_DimPlan      FOREIGN KEY (PlanKey)      REFERENCES dw.DimPlan (PlanKey)
);

CREATE TABLE dw.FactPayments
(
    PaymentID      INT            NOT NULL,
    DateKey        INT            NOT NULL,
    UserKey        INT            NOT NULL,
    PlanKey        INT            NOT NULL,
    GeographyKey   INT            NOT NULL,
    PaymentMethod  VARCHAR(20)    NOT NULL,
    Amount         DECIMAL(8, 2)  NOT NULL,
    IsSuccessful   TINYINT        NOT NULL,
    CONSTRAINT PK_FactPayments PRIMARY KEY (PaymentID),
    CONSTRAINT FK_FactPayments_DimDate      FOREIGN KEY (DateKey)      REFERENCES dw.DimDate (DateKey),
    CONSTRAINT FK_FactPayments_DimUser      FOREIGN KEY (UserKey)      REFERENCES dw.DimUser (UserKey),
    CONSTRAINT FK_FactPayments_DimPlan      FOREIGN KEY (PlanKey)      REFERENCES dw.DimPlan (PlanKey),
    CONSTRAINT FK_FactPayments_DimGeography FOREIGN KEY (GeographyKey) REFERENCES dw.DimGeography (GeographyKey)
);

CREATE TABLE dw.FactSubscriptions
(
    SubscriptionID  INT             NOT NULL,
    StartDateKey    INT             NOT NULL,
    EndDateKey      INT             NULL,
    UserKey         INT             NOT NULL,
    PlanKey         INT             NOT NULL,
    GeographyKey    INT             NOT NULL,
    Status          VARCHAR(10)     NOT NULL,
    DurationDays    INT             NOT NULL,
    IsActive        TINYINT         NOT NULL,
    TotalPaid       DECIMAL(10, 2)  NOT NULL,
    CONSTRAINT PK_FactSubscriptions PRIMARY KEY (SubscriptionID),
    CONSTRAINT FK_FactSubscriptions_StartDate    FOREIGN KEY (StartDateKey) REFERENCES dw.DimDate (DateKey),
    CONSTRAINT FK_FactSubscriptions_EndDate      FOREIGN KEY (EndDateKey)   REFERENCES dw.DimDate (DateKey),
    CONSTRAINT FK_FactSubscriptions_DimUser      FOREIGN KEY (UserKey)      REFERENCES dw.DimUser (UserKey),
    CONSTRAINT FK_FactSubscriptions_DimPlan      FOREIGN KEY (PlanKey)      REFERENCES dw.DimPlan (PlanKey),
    CONSTRAINT FK_FactSubscriptions_DimGeography FOREIGN KEY (GeographyKey) REFERENCES dw.DimGeography (GeographyKey)
);
GO

CREATE OR ALTER PROCEDURE dw.usp_LoadDataWarehouse
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    DECLARE @AsOfDate  DATE = CAST(SYSDATETIME() AS DATE),
            @FirstDate DATE,
            @LastDate  DATE;

    BEGIN TRANSACTION;

    TRUNCATE TABLE dw.FactStreams;
    TRUNCATE TABLE dw.FactPayments;
    TRUNCATE TABLE dw.FactSubscriptions;
    DELETE FROM dw.DimDate;
    DELETE FROM dw.DimUser;
    DELETE FROM dw.DimGeography;
    DELETE FROM dw.DimArtist;
    DELETE FROM dw.DimTrack;
    DELETE FROM dw.DimDevice;
    DELETE FROM dw.DimPlan;

    SELECT @FirstDate = DATEFROMPARTS(YEAR(MIN(x.d)), 1, 1),
           @LastDate  = DATEFROMPARTS(YEAR(MAX(x.d)), 12, 31)
    FROM (SELECT MIN(StartDate)                        FROM dbo.Subscriptions
          UNION ALL SELECT MAX(COALESCE(EndDate, StartDate)) FROM dbo.Subscriptions
          UNION ALL SELECT CAST(MIN(PaymentDate) AS DATE)    FROM dbo.Payments
          UNION ALL SELECT CAST(MAX(PaymentDate) AS DATE)    FROM dbo.Payments
          UNION ALL SELECT CAST(MIN(StartedAt) AS DATE)      FROM dbo.Streams
          UNION ALL SELECT CAST(MAX(StartedAt) AS DATE)      FROM dbo.Streams) AS x (d);

    WITH Days AS
    (
        SELECT TOP (DATEDIFF(DAY, @FirstDate, @LastDate) + 1)
               DATEADD(DAY, CAST(ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) - 1 AS INT), @FirstDate) AS FullDate
        FROM sys.all_objects AS a
        CROSS JOIN sys.all_objects AS b
    )
    INSERT INTO dw.DimDate (DateKey, FullDate, MonthNumber, MonthName, MonthYear, YearMonthNumber, Quarter, Year)
    SELECT CONVERT(INT, CONVERT(CHAR(8), d.FullDate, 112)),
           d.FullDate,
           MONTH(d.FullDate),
           m.MonthName,
           CONCAT(LEFT(m.MonthName, 3), ' ', YEAR(d.FullDate)),
           YEAR(d.FullDate) * 100 + MONTH(d.FullDate),
           DATEPART(QUARTER, d.FullDate),
           YEAR(d.FullDate)
    FROM Days AS d
    CROSS APPLY (SELECT CHOOSE(MONTH(d.FullDate), 'January', 'February', 'March', 'April', 'May', 'June',
                               'July', 'August', 'September', 'October', 'November', 'December') AS MonthName) AS m;

    INSERT INTO dw.DimGeography (GeographyKey, CountryID, CountryCode, CountryName, Region)
    SELECT ROW_NUMBER() OVER (ORDER BY c.CountryID), c.CountryID, c.CountryCode, c.CountryName, c.Region
    FROM dbo.Countries AS c;

    INSERT INTO dw.DimUser (UserKey, UserID, Username, Gender, AgeGroup, SignupDate, IsActive)
    SELECT ROW_NUMBER() OVER (ORDER BY u.UserID),
           u.UserID,
           u.Username,
           CASE u.Gender WHEN 'M' THEN 'Male' WHEN 'F' THEN 'Female' WHEN 'O' THEN 'Other'
                         ELSE 'Not specified' END,
           CASE WHEN a.Age < 18 THEN '13-17' WHEN a.Age < 25 THEN '18-24' WHEN a.Age < 35 THEN '25-34'
                WHEN a.Age < 45 THEN '35-44' WHEN a.Age < 55 THEN '45-54' ELSE '55+' END,
           CAST(u.CreatedAt AS DATE),
           u.IsActive
    FROM dbo.Users AS u
    CROSS APPLY (SELECT dbo.fn_CalculateAge(u.BirthDate, @AsOfDate) AS Age) AS a;

    INSERT INTO dw.DimArtist (ArtistKey, ArtistID, ArtistName, ArtistCountry, DebutYear, IsVerified)
    SELECT ROW_NUMBER() OVER (ORDER BY a.ArtistID), a.ArtistID, a.ArtistName, c.CountryName,
           a.DebutYear, a.IsVerified
    FROM dbo.Artists AS a
    INNER JOIN dbo.Countries AS c ON c.CountryID = a.CountryID;

    INSERT INTO dw.DimTrack (TrackKey, TrackID, TrackTitle, ArtistName, AlbumTitle, PrimaryGenre,
                             DurationSec, DurationBucket)
    SELECT ROW_NUMBER() OVER (ORDER BY t.TrackID),
           t.TrackID,
           t.Title,
           ar.ArtistName,
           al.Title,
           COALESCE(g.GenreName, 'Unknown'),
           t.DurationSec,
           CASE WHEN t.DurationSec < 180 THEN '0-3 min'
                WHEN t.DurationSec < 240 THEN '3-4 min'
                ELSE '4+ min' END
    FROM dbo.Tracks AS t
    INNER JOIN dbo.Albums  AS al ON al.AlbumID  = t.AlbumID
    INNER JOIN dbo.Artists AS ar ON ar.ArtistID = al.ArtistID
    LEFT JOIN dbo.TrackGenres AS tg ON tg.TrackID = t.TrackID AND tg.IsPrimary = 1
    LEFT JOIN dbo.Genres      AS g  ON g.GenreID  = tg.GenreID;

    INSERT INTO dw.DimDevice (DeviceKey, DeviceTypeID, DeviceCategory, OperatingSystem, IsMobile)
    SELECT ROW_NUMBER() OVER (ORDER BY d.DeviceTypeID), d.DeviceTypeID, d.DeviceCategory, d.OperatingSystem,
           CASE WHEN d.DeviceCategory IN ('Smartphone', 'Tablet') THEN 1 ELSE 0 END
    FROM dbo.DeviceTypes AS d;

    INSERT INTO dw.DimPlan (PlanKey, PlanID, PlanName, PlanTier, MonthlyPrice, HasAds)
    SELECT ROW_NUMBER() OVER (ORDER BY p.PlanID), p.PlanID, p.PlanName,
           CASE WHEN p.MonthlyPrice = 0 THEN 'Free' ELSE 'Premium' END,
           p.MonthlyPrice, p.HasAds
    FROM dbo.SubscriptionPlans AS p;

    INSERT INTO dw.FactStreams (StreamID, DateKey, UserKey, TrackKey, ArtistKey, DeviceKey,
                                GeographyKey, PlanKey, SecondsPlayed, IsSkipped)
    SELECT s.StreamID,
           CONVERT(INT, CONVERT(CHAR(8), s.StartedAt, 112)),
           du.UserKey,
           dt.TrackKey,
           da.ArtistKey,
           dd.DeviceKey,
           dg.GeographyKey,
           dp.PlanKey,
           s.SecondsPlayed,
           CASE WHEN s.SecondsPlayed < 30 THEN 1 ELSE 0 END
    FROM dbo.Streams AS s
    INNER JOIN dbo.Tracks AS t  ON t.TrackID  = s.TrackID
    INNER JOIN dbo.Albums AS al ON al.AlbumID = t.AlbumID
    INNER JOIN dbo.Users  AS u  ON u.UserID   = s.UserID
    INNER JOIN dw.DimUser      AS du ON du.UserID       = s.UserID
    INNER JOIN dw.DimTrack     AS dt ON dt.TrackID      = s.TrackID
    INNER JOIN dw.DimArtist    AS da ON da.ArtistID     = al.ArtistID
    INNER JOIN dw.DimDevice    AS dd ON dd.DeviceTypeID = s.DeviceTypeID
    INNER JOIN dw.DimGeography AS dg ON dg.CountryID    = u.CountryID
    CROSS APPLY (SELECT TOP (1) sub.PlanID
                 FROM dbo.Subscriptions AS sub
                 WHERE sub.UserID = s.UserID
                   AND sub.StartDate <= CAST(s.StartedAt AS DATE)
                 ORDER BY sub.StartDate DESC, sub.SubscriptionID DESC) AS planAtTheTime
    INNER JOIN dw.DimPlan AS dp ON dp.PlanID = planAtTheTime.PlanID;

    INSERT INTO dw.FactPayments (PaymentID, DateKey, UserKey, PlanKey, GeographyKey,
                                 PaymentMethod, Amount, IsSuccessful)
    SELECT p.PaymentID,
           CONVERT(INT, CONVERT(CHAR(8), p.PaymentDate, 112)),
           du.UserKey,
           dp.PlanKey,
           dg.GeographyKey,
           p.PaymentMethod,
           p.Amount,
           CASE WHEN p.Status = 'Completed' THEN 1 ELSE 0 END
    FROM dbo.Payments AS p
    INNER JOIN dbo.Subscriptions AS s ON s.SubscriptionID = p.SubscriptionID
    INNER JOIN dbo.Users         AS u ON u.UserID         = s.UserID
    INNER JOIN dw.DimUser      AS du ON du.UserID    = s.UserID
    INNER JOIN dw.DimPlan      AS dp ON dp.PlanID    = s.PlanID
    INNER JOIN dw.DimGeography AS dg ON dg.CountryID = u.CountryID;

    INSERT INTO dw.FactSubscriptions (SubscriptionID, StartDateKey, EndDateKey, UserKey, PlanKey,
                                      GeographyKey, Status, DurationDays, IsActive, TotalPaid)
    SELECT s.SubscriptionID,
           CONVERT(INT, CONVERT(CHAR(8), s.StartDate, 112)),
           CASE WHEN s.EndDate IS NOT NULL THEN CONVERT(INT, CONVERT(CHAR(8), s.EndDate, 112)) END,
           du.UserKey,
           dp.PlanKey,
           dg.GeographyKey,
           s.Status,
           DATEDIFF(DAY, s.StartDate, COALESCE(s.EndDate, @AsOfDate)),
           CASE WHEN s.Status = 'Active' THEN 1 ELSE 0 END,
           COALESCE(paid.TotalPaid, 0)
    FROM dbo.Subscriptions AS s
    INNER JOIN dbo.Users AS u ON u.UserID = s.UserID
    INNER JOIN dw.DimUser      AS du ON du.UserID    = s.UserID
    INNER JOIN dw.DimPlan      AS dp ON dp.PlanID    = s.PlanID
    INNER JOIN dw.DimGeography AS dg ON dg.CountryID = u.CountryID
    OUTER APPLY (SELECT SUM(CASE WHEN p.Status = 'Completed' THEN p.Amount ELSE 0 END) AS TotalPaid
                 FROM dbo.Payments AS p
                 WHERE p.SubscriptionID = s.SubscriptionID) AS paid;

    COMMIT TRANSACTION;
END;
GO
