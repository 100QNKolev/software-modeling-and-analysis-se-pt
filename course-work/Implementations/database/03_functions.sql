USE SpotifyDB;
GO

CREATE OR ALTER FUNCTION dbo.fn_CalculateAge
(
    @BirthDate DATE,
    @AsOfDate  DATE
)
RETURNS INT
WITH SCHEMABINDING
AS
BEGIN
    IF @BirthDate IS NULL OR @AsOfDate IS NULL OR @BirthDate > @AsOfDate
        RETURN NULL;

    RETURN DATEDIFF(YEAR, @BirthDate, @AsOfDate)
         - CASE WHEN DATEADD(YEAR, DATEDIFF(YEAR, @BirthDate, @AsOfDate), @BirthDate) > @AsOfDate
                THEN 1 ELSE 0 END;
END;
GO

CREATE OR ALTER FUNCTION dbo.fn_GetPlaylistTracks
(
    @PlaylistID INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT pt.Position,
           t.TrackID,
           t.Title    AS TrackTitle,
           ar.ArtistName,
           al.Title   AS AlbumTitle,
           t.DurationSec,
           t.IsExplicit,
           pt.AddedAt
    FROM dbo.PlaylistTracks AS pt
    INNER JOIN dbo.Tracks  AS t  ON t.TrackID   = pt.TrackID
    INNER JOIN dbo.Albums  AS al ON al.AlbumID  = t.AlbumID
    INNER JOIN dbo.Artists AS ar ON ar.ArtistID = al.ArtistID
    WHERE pt.PlaylistID = @PlaylistID
);
GO
