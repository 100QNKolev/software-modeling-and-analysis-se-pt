USE SpotifyDB;
GO

CREATE OR ALTER TRIGGER dbo.trg_Streams_UpdateTrackStreams
ON dbo.Streams
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM inserted)
        RETURN;

    IF EXISTS (SELECT 1
               FROM inserted AS i
               INNER JOIN dbo.Tracks AS t ON t.TrackID = i.TrackID
               WHERE i.SecondsPlayed > t.DurationSec)
        THROW 50100, 'SecondsPlayed cannot be greater than the duration of the track.', 1;

    UPDATE t
       SET t.TotalStreams = t.TotalStreams + i.NewStreams
    FROM dbo.Tracks AS t
    INNER JOIN (SELECT TrackID, COUNT(*) AS NewStreams
                FROM inserted
                GROUP BY TrackID) AS i
            ON i.TrackID = t.TrackID;
END;
GO

CREATE OR ALTER TRIGGER dbo.trg_Users_SoftDelete
ON dbo.Users
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Today DATE = CAST(SYSDATETIME() AS DATE);

    UPDATE u
       SET u.IsActive = 0
    FROM dbo.Users AS u
    INNER JOIN deleted AS d ON d.UserID = u.UserID;

    UPDATE s
       SET s.Status  = 'Cancelled',
           s.EndDate = CASE WHEN s.StartDate > @Today THEN s.StartDate ELSE @Today END
    FROM dbo.Subscriptions AS s
    INNER JOIN deleted AS d ON d.UserID = s.UserID
    WHERE s.Status = 'Active';
END;
GO
