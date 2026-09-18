USE SpotifyDB;
GO

CREATE TABLE dbo.Countries
(
    CountryID    INT IDENTITY(1, 1) NOT NULL,
    CountryCode  CHAR(2)            NOT NULL,
    CountryName  NVARCHAR(100)      NOT NULL,
    Region       NVARCHAR(50)       NOT NULL,
    CONSTRAINT PK_Countries PRIMARY KEY (CountryID),
    CONSTRAINT UQ_Countries_CountryCode UNIQUE (CountryCode)
);
GO

CREATE TABLE dbo.DeviceTypes
(
    DeviceTypeID     INT IDENTITY(1, 1) NOT NULL,
    DeviceCategory   NVARCHAR(30)       NOT NULL,
    OperatingSystem  NVARCHAR(30)       NOT NULL,
    CONSTRAINT PK_DeviceTypes PRIMARY KEY (DeviceTypeID),
    CONSTRAINT UQ_DeviceTypes_Category_OS UNIQUE (DeviceCategory, OperatingSystem)
);
GO

CREATE TABLE dbo.Users
(
    UserID     INT IDENTITY(1, 1) NOT NULL,
    Username   NVARCHAR(50)       NOT NULL,
    Email      NVARCHAR(255)      NOT NULL,
    BirthDate  DATE               NOT NULL,
    Gender     CHAR(1)            NULL,
    CountryID  INT                NOT NULL,
    CreatedAt  DATETIME2(0)       NOT NULL CONSTRAINT DF_Users_CreatedAt DEFAULT (SYSDATETIME()),
    IsActive   BIT                NOT NULL CONSTRAINT DF_Users_IsActive DEFAULT (1),
    CONSTRAINT PK_Users PRIMARY KEY (UserID),
    CONSTRAINT UQ_Users_Username UNIQUE (Username),
    CONSTRAINT UQ_Users_Email UNIQUE (Email),
    CONSTRAINT FK_Users_Countries FOREIGN KEY (CountryID) REFERENCES dbo.Countries (CountryID),
    CONSTRAINT CK_Users_Email CHECK (Email LIKE '%_@_%._%'),
    CONSTRAINT CK_Users_Gender CHECK (Gender IN ('M', 'F', 'O'))
);
GO

CREATE TABLE dbo.SubscriptionPlans
(
    PlanID        INT IDENTITY(1, 1) NOT NULL,
    PlanName      NVARCHAR(50)       NOT NULL,
    MonthlyPrice  DECIMAL(6, 2)      NOT NULL,
    HasAds        BIT                NOT NULL CONSTRAINT DF_SubscriptionPlans_HasAds DEFAULT (0),
    CONSTRAINT PK_SubscriptionPlans PRIMARY KEY (PlanID),
    CONSTRAINT UQ_SubscriptionPlans_PlanName UNIQUE (PlanName),
    CONSTRAINT CK_SubscriptionPlans_MonthlyPrice CHECK (MonthlyPrice >= 0)
);
GO

CREATE TABLE dbo.Subscriptions
(
    SubscriptionID  INT IDENTITY(1, 1) NOT NULL,
    UserID          INT                NOT NULL,
    PlanID          INT                NOT NULL,
    StartDate       DATE               NOT NULL,
    EndDate         DATE               NULL,
    Status          VARCHAR(10)        NOT NULL CONSTRAINT DF_Subscriptions_Status DEFAULT ('Active'),
    CONSTRAINT PK_Subscriptions PRIMARY KEY (SubscriptionID),
    CONSTRAINT FK_Subscriptions_Users FOREIGN KEY (UserID) REFERENCES dbo.Users (UserID),
    CONSTRAINT FK_Subscriptions_SubscriptionPlans FOREIGN KEY (PlanID) REFERENCES dbo.SubscriptionPlans (PlanID),
    CONSTRAINT CK_Subscriptions_Status CHECK (Status IN ('Active', 'Cancelled', 'Expired')),
    CONSTRAINT CK_Subscriptions_Dates CHECK (EndDate IS NULL OR EndDate >= StartDate)
);
GO

CREATE TABLE dbo.Payments
(
    PaymentID       INT IDENTITY(1, 1) NOT NULL,
    SubscriptionID  INT                NOT NULL,
    PaymentDate     DATETIME2(0)       NOT NULL,
    Amount          DECIMAL(8, 2)      NOT NULL,
    PaymentMethod   VARCHAR(20)        NOT NULL,
    Status          VARCHAR(10)        NOT NULL CONSTRAINT DF_Payments_Status DEFAULT ('Completed'),
    CONSTRAINT PK_Payments PRIMARY KEY (PaymentID),
    CONSTRAINT FK_Payments_Subscriptions FOREIGN KEY (SubscriptionID) REFERENCES dbo.Subscriptions (SubscriptionID),
    CONSTRAINT CK_Payments_Amount CHECK (Amount > 0),
    CONSTRAINT CK_Payments_Status CHECK (Status IN ('Completed', 'Failed', 'Refunded'))
);
GO

CREATE TABLE dbo.Artists
(
    ArtistID    INT IDENTITY(1, 1) NOT NULL,
    ArtistName  NVARCHAR(100)      NOT NULL,
    CountryID   INT                NOT NULL,
    DebutYear   SMALLINT           NOT NULL,
    IsVerified  BIT                NOT NULL CONSTRAINT DF_Artists_IsVerified DEFAULT (0),
    CONSTRAINT PK_Artists PRIMARY KEY (ArtistID),
    CONSTRAINT UQ_Artists_ArtistName UNIQUE (ArtistName),
    CONSTRAINT FK_Artists_Countries FOREIGN KEY (CountryID) REFERENCES dbo.Countries (CountryID)
);
GO

CREATE TABLE dbo.Albums
(
    AlbumID      INT IDENTITY(1, 1) NOT NULL,
    ArtistID     INT                NOT NULL,
    Title        NVARCHAR(200)      NOT NULL,
    ReleaseDate  DATE               NOT NULL,
    CONSTRAINT PK_Albums PRIMARY KEY (AlbumID),
    CONSTRAINT FK_Albums_Artists FOREIGN KEY (ArtistID) REFERENCES dbo.Artists (ArtistID),
    CONSTRAINT UQ_Albums_Artist_Title UNIQUE (ArtistID, Title)
);
GO

CREATE TABLE dbo.Tracks
(
    TrackID       INT IDENTITY(1, 1) NOT NULL,
    AlbumID       INT                NOT NULL,
    Title         NVARCHAR(200)      NOT NULL,
    DurationSec   SMALLINT           NOT NULL,
    IsExplicit    BIT                NOT NULL CONSTRAINT DF_Tracks_IsExplicit DEFAULT (0),
    TotalStreams  INT                NOT NULL CONSTRAINT DF_Tracks_TotalStreams DEFAULT (0),
    CONSTRAINT PK_Tracks PRIMARY KEY (TrackID),
    CONSTRAINT FK_Tracks_Albums FOREIGN KEY (AlbumID) REFERENCES dbo.Albums (AlbumID),
    CONSTRAINT CK_Tracks_DurationSec CHECK (DurationSec BETWEEN 30 AND 1800)
);
GO

CREATE TABLE dbo.Genres
(
    GenreID    INT IDENTITY(1, 1) NOT NULL,
    GenreName  NVARCHAR(50)       NOT NULL,
    CONSTRAINT PK_Genres PRIMARY KEY (GenreID),
    CONSTRAINT UQ_Genres_GenreName UNIQUE (GenreName)
);
GO

CREATE TABLE dbo.TrackGenres
(
    TrackID    INT NOT NULL,
    GenreID    INT NOT NULL,
    IsPrimary  BIT NOT NULL CONSTRAINT DF_TrackGenres_IsPrimary DEFAULT (0),
    CONSTRAINT PK_TrackGenres PRIMARY KEY (TrackID, GenreID),
    CONSTRAINT FK_TrackGenres_Tracks FOREIGN KEY (TrackID) REFERENCES dbo.Tracks (TrackID) ON DELETE CASCADE,
    CONSTRAINT FK_TrackGenres_Genres FOREIGN KEY (GenreID) REFERENCES dbo.Genres (GenreID)
);
GO

CREATE TABLE dbo.Playlists
(
    PlaylistID   INT IDENTITY(1, 1) NOT NULL,
    OwnerUserID  INT                NOT NULL,
    Name         NVARCHAR(100)      NOT NULL,
    IsPublic     BIT                NOT NULL CONSTRAINT DF_Playlists_IsPublic DEFAULT (1),
    CreatedAt    DATETIME2(0)       NOT NULL CONSTRAINT DF_Playlists_CreatedAt DEFAULT (SYSDATETIME()),
    CONSTRAINT PK_Playlists PRIMARY KEY (PlaylistID),
    CONSTRAINT FK_Playlists_Users FOREIGN KEY (OwnerUserID) REFERENCES dbo.Users (UserID)
);
GO

CREATE TABLE dbo.PlaylistTracks
(
    PlaylistID  INT           NOT NULL,
    TrackID     INT           NOT NULL,
    Position    INT           NOT NULL,
    AddedAt     DATETIME2(0)  NOT NULL CONSTRAINT DF_PlaylistTracks_AddedAt DEFAULT (SYSDATETIME()),
    CONSTRAINT PK_PlaylistTracks PRIMARY KEY (PlaylistID, TrackID),
    CONSTRAINT UQ_PlaylistTracks_Position UNIQUE (PlaylistID, Position),
    CONSTRAINT FK_PlaylistTracks_Playlists FOREIGN KEY (PlaylistID) REFERENCES dbo.Playlists (PlaylistID) ON DELETE CASCADE,
    CONSTRAINT FK_PlaylistTracks_Tracks FOREIGN KEY (TrackID) REFERENCES dbo.Tracks (TrackID)
);
GO

CREATE TABLE dbo.Streams
(
    StreamID       INT IDENTITY(1, 1) NOT NULL,
    UserID         INT                NOT NULL,
    TrackID        INT                NOT NULL,
    DeviceTypeID   INT                NOT NULL,
    StartedAt      DATETIME2(0)       NOT NULL,
    SecondsPlayed  SMALLINT           NOT NULL,
    CONSTRAINT PK_Streams PRIMARY KEY (StreamID),
    CONSTRAINT FK_Streams_Users FOREIGN KEY (UserID) REFERENCES dbo.Users (UserID),
    CONSTRAINT FK_Streams_Tracks FOREIGN KEY (TrackID) REFERENCES dbo.Tracks (TrackID),
    CONSTRAINT FK_Streams_DeviceTypes FOREIGN KEY (DeviceTypeID) REFERENCES dbo.DeviceTypes (DeviceTypeID),
    CONSTRAINT CK_Streams_SecondsPlayed CHECK (SecondsPlayed >= 0)
);
GO

CREATE INDEX IX_Users_CountryID           ON dbo.Users (CountryID);
CREATE INDEX IX_Subscriptions_UserID      ON dbo.Subscriptions (UserID);
CREATE INDEX IX_Subscriptions_PlanID      ON dbo.Subscriptions (PlanID);
CREATE INDEX IX_Payments_SubscriptionID   ON dbo.Payments (SubscriptionID);
CREATE INDEX IX_Payments_PaymentDate      ON dbo.Payments (PaymentDate);
CREATE INDEX IX_Artists_CountryID         ON dbo.Artists (CountryID);
CREATE INDEX IX_Albums_ArtistID           ON dbo.Albums (ArtistID);
CREATE INDEX IX_Tracks_AlbumID            ON dbo.Tracks (AlbumID);
CREATE INDEX IX_TrackGenres_GenreID       ON dbo.TrackGenres (GenreID);
CREATE INDEX IX_Playlists_OwnerUserID     ON dbo.Playlists (OwnerUserID);
CREATE INDEX IX_PlaylistTracks_TrackID    ON dbo.PlaylistTracks (TrackID);
CREATE INDEX IX_Streams_UserID_StartedAt  ON dbo.Streams (UserID, StartedAt);
CREATE INDEX IX_Streams_TrackID_StartedAt ON dbo.Streams (TrackID, StartedAt);
CREATE INDEX IX_Streams_DeviceTypeID      ON dbo.Streams (DeviceTypeID);
GO
