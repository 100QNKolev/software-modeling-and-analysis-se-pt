USE SpotifyDB;
GO

CREATE OR ALTER PROCEDURE dbo.usp_RegisterUser
    @Username     NVARCHAR(50),
    @Email        NVARCHAR(255),
    @BirthDate    DATE,
    @CountryCode  CHAR(2),
    @Gender       CHAR(1) = NULL,
    @NewUserID    INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    DECLARE @Today      DATE = CAST(SYSDATETIME() AS DATE);
    DECLARE @CountryID  INT  = (SELECT CountryID FROM dbo.Countries WHERE CountryCode = @CountryCode);
    DECLARE @FreePlanID INT  = (SELECT PlanID FROM dbo.SubscriptionPlans WHERE PlanName = 'Free');

    IF @CountryID IS NULL
        THROW 50001, 'Unknown country code.', 1;
    IF EXISTS (SELECT 1 FROM dbo.Users WHERE Username = @Username OR Email = @Email)
        THROW 50002, 'This username or email is already registered.', 1;
    IF dbo.fn_CalculateAge(@BirthDate, @Today) IS NULL OR dbo.fn_CalculateAge(@BirthDate, @Today) < 13
        THROW 50003, 'Users must be at least 13 years old.', 1;
    IF @FreePlanID IS NULL
        THROW 50004, 'The Free plan is missing from SubscriptionPlans.', 1;

    BEGIN TRANSACTION;

    INSERT INTO dbo.Users (Username, Email, BirthDate, Gender, CountryID)
    VALUES (@Username, @Email, @BirthDate, @Gender, @CountryID);

    SET @NewUserID = CAST(SCOPE_IDENTITY() AS INT);

    INSERT INTO dbo.Subscriptions (UserID, PlanID, StartDate, Status)
    VALUES (@NewUserID, @FreePlanID, @Today, 'Active');

    COMMIT TRANSACTION;
END;
GO

CREATE OR ALTER PROCEDURE dbo.usp_GetTopTracks
    @FromDate  DATE,
    @ToDate    DATE,
    @TopN      INT = 10
AS
BEGIN
    SET NOCOUNT ON;

    IF @FromDate IS NULL OR @ToDate IS NULL OR @FromDate > @ToDate
        THROW 50030, '@FromDate must be on or before @ToDate.', 1;
    IF @TopN IS NULL OR @TopN NOT BETWEEN 1 AND 100
        THROW 50031, '@TopN must be between 1 and 100.', 1;

    SELECT TOP (@TopN)
           t.TrackID,
           t.Title                  AS TrackTitle,
           ar.ArtistName,
           COUNT(*)                 AS Streams,
           COUNT(DISTINCT s.UserID) AS UniqueListeners
    FROM dbo.Streams AS s
    INNER JOIN dbo.Tracks  AS t  ON t.TrackID   = s.TrackID
    INNER JOIN dbo.Albums  AS al ON al.AlbumID  = t.AlbumID
    INNER JOIN dbo.Artists AS ar ON ar.ArtistID = al.ArtistID
    WHERE s.StartedAt >= @FromDate
      AND s.StartedAt <  DATEADD(DAY, 1, @ToDate)
    GROUP BY t.TrackID, t.Title, ar.ArtistName
    ORDER BY Streams DESC, t.TrackID;
END;
GO
