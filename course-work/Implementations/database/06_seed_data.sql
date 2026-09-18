USE SpotifyDB;
GO

SET NOCOUNT ON;
SET XACT_ABORT ON;
GO

BEGIN TRANSACTION;

SET IDENTITY_INSERT dbo.Countries ON;
INSERT INTO dbo.Countries (CountryID, CountryCode, CountryName, Region)
VALUES ( 1, 'BG', 'Bulgaria',       'Europe'),
       ( 2, 'US', 'United States',  'North America'),
       ( 3, 'GB', 'United Kingdom', 'Europe'),
       ( 4, 'DE', 'Germany',        'Europe'),
       ( 5, 'FR', 'France',         'Europe'),
       ( 6, 'ES', 'Spain',          'Europe'),
       ( 7, 'IT', 'Italy',          'Europe'),
       ( 8, 'SE', 'Sweden',         'Europe'),
       ( 9, 'NL', 'Netherlands',    'Europe'),
       (10, 'PL', 'Poland',         'Europe');
SET IDENTITY_INSERT dbo.Countries OFF;

SET IDENTITY_INSERT dbo.DeviceTypes ON;
INSERT INTO dbo.DeviceTypes (DeviceTypeID, DeviceCategory, OperatingSystem)
VALUES (1, 'Smartphone',    'Android'),
       (2, 'Smartphone',    'iOS'),
       (3, 'Desktop',       'Windows'),
       (4, 'Desktop',       'macOS'),
       (5, 'Tablet',        'iPadOS'),
       (6, 'Smart speaker', 'Other');
SET IDENTITY_INSERT dbo.DeviceTypes OFF;

SET IDENTITY_INSERT dbo.SubscriptionPlans ON;
INSERT INTO dbo.SubscriptionPlans (PlanID, PlanName, MonthlyPrice, HasAds)
VALUES (1, 'Free',    0.00, 1),
       (2, 'Premium', 10.99, 0),
       (3, 'Family',  17.99, 0);
SET IDENTITY_INSERT dbo.SubscriptionPlans OFF;

SET IDENTITY_INSERT dbo.Genres ON;
INSERT INTO dbo.Genres (GenreID, GenreName)
VALUES (1, 'Pop'),       (2, 'Rock'),  (3, 'Hip-Hop'),   (4, 'Electronic'),
       (5, 'Jazz'),      (6, 'Classical'), (7, 'Folk'),  (8, 'R&B');
SET IDENTITY_INSERT dbo.Genres OFF;

SET IDENTITY_INSERT dbo.Artists ON;
INSERT INTO dbo.Artists (ArtistID, ArtistName, CountryID, DebutYear, IsVerified)
VALUES ( 1, 'Neon Harbour',    3, 2015, 1),
       ( 2, 'Mila Vance',      2, 2018, 1),
       ( 3, 'The Paper Tides', 3, 2011, 1),
       ( 4, 'Kaspar Holt',     4, 2016, 0),
       ( 5, 'Aurora Fields',   8, 2019, 1),
       ( 6, 'Rue Lafleur',     5, 2014, 1),
       ( 7, 'Marco Santini',   7, 2012, 0),
       ( 8, 'Velvet Static',   2, 2020, 1),
       ( 9, 'Ilina Petrova',   1, 2017, 1),
       (10, 'Northbound',      9, 2013, 0),
       (11, 'Sierra Cole',     2, 2021, 1),
       (12, 'Duo Cassis',      5, 2010, 0),
       (13, 'Wiktor Nowak',   10, 2018, 0),
       (14, 'Elena Marquez',   6, 2015, 1),
       (15, 'Glass Avenue',    3, 2022, 0);
SET IDENTITY_INSERT dbo.Artists OFF;

SET IDENTITY_INSERT dbo.Albums ON;
INSERT INTO dbo.Albums (AlbumID, ArtistID, Title, ReleaseDate)
VALUES ( 1,  1, 'Harbour Lights',  '2021-03-12'),
       ( 2,  1, 'Signal Drift',    '2023-09-01'),
       ( 3,  2, 'Paper Hearts',    '2020-06-19'),
       ( 4,  2, 'Neon Summer',     '2022-05-06'),
       ( 5,  3, 'Slow Rivers',     '2019-11-15'),
       ( 6,  3, 'Tidewater',       '2024-02-23'),
       ( 7,  4, 'Kalter Morgen',   '2021-08-27'),
       ( 8,  5, 'Midnight Fields', '2022-01-14'),
       ( 9,  5, 'Golden Hour',     '2024-06-07'),
       (10,  6, 'Rue de Sel',      '2020-10-02'),
       (11,  7, 'Sette Notti',     '2018-04-20'),
       (12,  8, 'Static Bloom',    '2021-07-16'),
       (13,  8, 'Concrete Garden', '2023-11-10'),
       (14,  9, 'Sofia Nights',    '2022-09-30'),
       (15,  9, 'Vetrove',         '2025-01-17'),
       (16, 10, 'Low Country',     '2019-05-24'),
       (17, 11, 'Coral',           '2022-03-04'),
       (18, 11, 'Afterglow',       '2024-08-16'),
       (19, 12, 'Cassis',          '2017-09-08'),
       (20, 13, 'Warszawa 3AM',    '2021-11-26'),
       (21, 13, 'Beton',           '2024-04-12'),
       (22, 14, 'Sal y Sol',       '2020-07-10'),
       (23, 14, 'Marea',           '2023-05-19'),
       (24, 15, 'Glass Avenue',    '2023-02-03'),
       (25, 15, 'Second Storey',   '2025-03-21');
SET IDENTITY_INSERT dbo.Albums OFF;

SET IDENTITY_INSERT dbo.Tracks ON;
INSERT INTO dbo.Tracks (TrackID, AlbumID, Title, DurationSec, IsExplicit)
VALUES ( 1,  1, 'Low Tide',           214, 0),
       ( 2,  1, 'Harbour Lights',     251, 0),
       ( 3,  1, 'Sodium Glow',        188, 0),
       ( 4,  2, 'Signal Drift',       276, 0),
       ( 5,  2, 'Night Ferry',        233, 0),
       ( 6,  2, 'Radio Silence',      197, 0),
       ( 7,  3, 'Paper Hearts',       203, 0),
       ( 8,  3, 'Closer Than This',   186, 0),
       ( 9,  3, 'Backseat',           171, 1),
       (10,  4, 'Neon Summer',        195, 0),
       (11,  4, 'Cherry Soda',        164, 0),
       (12,  4, 'Ten Missed Calls',   208, 1),
       (13,  5, 'Slow Rivers',        262, 0),
       (14,  5, 'Bootprints',         241, 0),
       (15,  5, 'Iron Weather',       298, 0),
       (16,  6, 'Tidewater',          254, 0),
       (17,  6, 'Salt and Rust',      227, 0),
       (18,  6, 'The Long Way Down',  312, 0),
       (19,  7, 'Kalter Morgen',      289, 0),
       (20,  7, 'Grauwerk',           244, 0),
       (21,  7, 'Nachtzug',           318, 0),
       (22,  8, 'Midnight Fields',    219, 0),
       (23,  8, 'Paper Planes',       182, 0),
       (24,  8, 'Honey Weather',      176, 0),
       (25,  9, 'Golden Hour',        201, 0),
       (26,  9, 'Sixteen Summers',    193, 0),
       (27,  9, 'Little Fires',       224, 0),
       (28, 10, 'Rue de Sel',         305, 0),
       (29, 10, 'Pigalle Blue',       268, 0),
       (30, 10, 'Dernier Metro',      287, 0),
       (31, 11, 'Notturno',           324, 0),
       (32, 11, 'Sette Notti',        356, 0),
       (33, 12, 'Static Bloom',       172, 1),
       (34, 12, 'Corner Store',       158, 1),
       (35, 13, 'Concrete Garden',    184, 1),
       (36, 13, 'No Ceiling',         167, 1),
       (37, 14, 'Sofia Nights',       212, 0),
       (38, 14, 'Vitosha',            236, 0),
       (39, 15, 'Vetrove',            198, 0),
       (40, 15, 'Dve Reki',           221, 0),
       (41, 16, 'Low Country',        273, 0),
       (42, 16, 'Polder',             246, 0),
       (43, 17, 'Coral',              205, 0),
       (44, 17, 'Slow Burn',          231, 0),
       (45, 18, 'Afterglow',          217, 0),
       (46, 18, 'Blue Hour',          243, 0),
       (47, 19, 'Cassis',             259, 0),
       (48, 19, 'Verger',             238, 0),
       (49, 20, 'Warszawa 3AM',       191, 1),
       (50, 20, 'Praga',              177, 1),
       (51, 21, 'Beton',              163, 1),
       (52, 21, 'Wisla',              185, 0),
       (53, 22, 'Sal y Sol',          209, 0),
       (54, 22, 'Marisma',            226, 0),
       (55, 23, 'Marea',              215, 0),
       (56, 23, 'Levante',            248, 0),
       (57, 24, 'Glass Avenue',       234, 0),
       (58, 24, 'Streetlight Hymn',   279, 0),
       (59, 25, 'Second Storey',      222, 0),
       (60, 25, 'Fire Escape',        256, 0);
SET IDENTITY_INSERT dbo.Tracks OFF;

INSERT INTO dbo.TrackGenres (TrackID, GenreID, IsPrimary)
SELECT t.TrackID, ag.GenreID, 1
FROM dbo.Tracks AS t
INNER JOIN dbo.Albums AS al ON al.AlbumID = t.AlbumID
INNER JOIN (VALUES (1, 4), (2, 1), (3, 2), (4, 4), (5, 1), (6, 5), (7, 6), (8, 3),
                   (9, 1), (10, 2), (11, 8), (12, 7), (13, 3), (14, 1), (15, 2))
           AS ag (ArtistID, GenreID) ON ag.ArtistID = al.ArtistID;

INSERT INTO dbo.TrackGenres (TrackID, GenreID, IsPrimary)
SELECT tg.TrackID, 1 + tg.GenreID % 8, 0
FROM dbo.TrackGenres AS tg
WHERE tg.IsPrimary = 1
  AND tg.TrackID % 3 = 0;

SET IDENTITY_INSERT dbo.Users ON;
INSERT INTO dbo.Users (UserID, Username, Email, BirthDate, Gender, CountryID, CreatedAt)
VALUES ( 1, 'ivan_beats',     'ivan.beats@example.com',      '1995-04-12', 'M',  1, '2024-01-08T10:15:00'),
       ( 2, 'maria_vibes',    'maria.vibes@example.com',     '1999-11-23', 'F',  1, '2024-01-19T18:42:00'),
       ( 3, 'james_wave',     'james.wave@example.com',      '1988-07-05', 'M',  3, '2024-01-27T09:03:00'),
       ( 4, 'olivia_tunes',   'olivia.tunes@example.com',    '2003-02-17', 'F',  2, '2024-02-03T21:30:00'),
       ( 5, 'lucas_groove',   'lucas.groove@example.com',    '1991-09-30', 'M',  5, '2024-02-11T14:22:00'),
       ( 6, 'emma_echo',      'emma.echo@example.com',       '2006-05-14', 'F',  4, '2024-02-20T08:51:00'),
       ( 7, 'georgi_bass',    'georgi.bass@example.com',     '1993-12-02', 'M',  1, '2024-02-28T19:16:00'),
       ( 8, 'sofia_melody',   'sofia.melody@example.com',    '2001-06-08', 'F',  7, '2024-03-06T11:47:00'),
       ( 9, 'noah_rhythm',    'noah.rhythm@example.com',     '1997-03-21', 'M',  2, '2024-03-14T16:05:00'),
       (10, 'elena_chord',    'elena.chord@example.com',     '1985-10-11', 'F',  6, '2024-03-22T07:38:00'),
       (11, 'martin_loop',    'martin.loop@example.com',     '2000-08-26', 'M',  4, '2024-03-29T20:54:00'),
       (12, 'chloe_note',     'chloe.note@example.com',      '2004-01-09', 'F',  5, '2024-04-05T13:12:00'),
       (13, 'daniel_mix',     'daniel.mix@example.com',      '1990-05-18', 'M',  9, '2024-04-13T09:26:00'),
       (14, 'hannah_verse',   'hannah.verse@example.com',    '1996-12-29', 'F',  8, '2024-04-21T22:41:00'),
       (15, 'oscar_riff',     'oscar.riff@example.com',      '1987-02-06', 'M',  8, '2024-04-30T12:03:00'),
       (16, 'zofia_track',    'zofia.track@example.com',     '2002-07-24', 'F', 10, '2024-05-07T17:35:00'),
       (17, 'liam_pulse',     'liam.pulse@example.com',      '1994-11-13', 'M',  3, '2024-05-15T10:58:00'),
       (18, 'giulia_sound',   'giulia.sound@example.com',    '1998-04-02', 'F',  7, '2024-05-23T19:44:00'),
       (19, 'hugo_tempo',     'hugo.tempo@example.com',      '1992-08-15', 'M',  5, '2024-05-31T08:09:00'),
       (20, 'freja_lyric',    'freja.lyric@example.com',     '2005-03-27', 'F',  8, '2024-06-07T15:21:00'),
       (21, 'andrei_drop',    'andrei.drop@example.com',     '1989-06-19', 'M', 10, '2024-06-14T20:12:00'),
       (22, 'camila_tone',    'camila.tone@example.com',     '2003-09-04', 'F',  6, '2024-06-22T11:33:00'),
       (23, 'jan_static',     'jan.static@example.com',      '1986-01-31', 'M',  9, '2024-06-29T18:47:00'),
       (24, 'nikol_reverb',   'nikol.reverb@example.com',    '2000-10-16', 'F',  1, '2024-07-06T09:52:00'),
       (25, 'leon_fader',     'leon.fader@example.com',      '1997-05-08', 'M',  4, '2024-07-14T21:05:00'),
       (26, 'ana_harmony',    'ana.harmony@example.com',     '2001-12-20', 'F',  6, '2024-07-22T13:29:00'),
       (27, 'luca_synth',     'luca.synth@example.com',      '1993-03-03', 'M',  7, '2024-07-30T16:41:00'),
       (28, 'ioana_octave',   'ioana.octave@example.com',    '1999-08-11', 'F', 10, '2024-08-06T08:14:00'),
       (29, 'mateo_cadence',  'mateo.cadence@example.com',   '1991-02-25', 'M',  2, '2024-08-14T19:58:00'),
       (30, 'eleni_refrain',  'eleni.refrain@example.com',   '2004-06-13', 'F',  7, '2024-08-22T12:36:00'),
       (31, 'victor_bridge',  'victor.bridge@example.com',   '1988-09-07', 'M',  3, '2024-08-30T10:24:00'),
       (32, 'mia_chorus',     'mia.chorus@example.com',      '2006-11-19', 'F',  2, '2024-09-06T22:17:00'),
       (33, 'alex_encore',    'alex.encore@example.com',     '1995-07-01', 'M',  1, '2024-09-13T14:49:00'),
       (34, 'priya_tremolo',  'priya.tremolo@example.com',   '1996-04-28', 'F',  3, '2024-09-21T07:31:00'),
       (35, 'emre_bassline',  'emre.bassline@example.com',   '1990-12-09', 'M',  4, '2024-09-29T18:06:00'),
       (36, 'yuna_falsetto',  'yuna.falsetto@example.com',   '2002-02-14', 'F',  2, '2024-10-06T11:52:00'),
       (37, 'nikos_crescendo','nikos.crescendo@example.com', '1984-05-22', 'M',  7, '2024-10-14T20:38:00'),
       (38, 'olga_sustain',   'olga.sustain@example.com',    '1998-10-30', 'F', 10, '2024-10-22T09:15:00'),
       (39, 'haruto_timbre',  'haruto.timbre@example.com',   '1994-01-17', 'M',  9, '2024-10-30T16:44:00'),
       (40, 'clara_vinyl',    'clara.vinyl@example.com',     '2005-08-06', 'F',  5, '2024-11-07T13:27:00');
SET IDENTITY_INSERT dbo.Users OFF;

SET IDENTITY_INSERT dbo.Playlists ON;
INSERT INTO dbo.Playlists (PlaylistID, OwnerUserID, Name, IsPublic, CreatedAt)
VALUES ( 1,  1, 'Chill Vibes',      1, '2025-01-12T19:20:00'),
       ( 2,  3, 'Workout Mix',      1, '2025-01-28T07:45:00'),
       ( 3,  5, 'Road Trip',        1, '2025-02-14T16:10:00'),
       ( 4,  8, 'Late Night',       0, '2025-03-02T23:55:00'),
       ( 5, 11, 'Focus Flow',       0, '2025-03-19T09:30:00'),
       ( 6, 14, 'Summer Hits',      1, '2025-04-06T14:05:00'),
       ( 7, 17, 'Throwbacks',       1, '2025-04-25T20:40:00'),
       ( 8, 21, 'Sunday Morning',   1, '2025-05-11T10:15:00'),
       ( 9, 24, 'Party Starters',   1, '2025-06-01T22:30:00'),
       (10, 28, 'Rainy Day',        0, '2025-06-22T18:50:00'),
       (11, 33, 'Coding Beats',     1, '2025-07-09T13:35:00'),
       (12, 37, 'Study Session',    0, '2025-08-03T17:25:00');
SET IDENTITY_INSERT dbo.Playlists OFF;

INSERT INTO dbo.PlaylistTracks (PlaylistID, TrackID, Position, AddedAt)
SELECT p.PlaylistID,
       t.TrackID,
       ROW_NUMBER() OVER (PARTITION BY p.PlaylistID ORDER BY t.TrackID),
       DATEADD(DAY, t.TrackID % 30, p.CreatedAt)
FROM dbo.Playlists AS p
INNER JOIN dbo.Tracks AS t ON (t.TrackID + p.PlaylistID) % 6 = 0;

INSERT INTO dbo.Subscriptions (UserID, PlanID, StartDate, EndDate, Status)
SELECT u.UserID,
       1,
       CAST(u.CreatedAt AS DATE),
       CASE WHEN u.UserID % 3 <> 0
            THEN DATEADD(DAY, 30 + (u.UserID * 7) % 90, CAST(u.CreatedAt AS DATE)) END,
       CASE WHEN u.UserID % 3 <> 0 THEN 'Cancelled' ELSE 'Active' END
FROM dbo.Users AS u;

INSERT INTO dbo.Subscriptions (UserID, PlanID, StartDate, EndDate, Status)
SELECT s.UserID,
       CASE WHEN s.UserID % 5 = 0 THEN 3 ELSE 2 END,
       s.EndDate,
       NULL,
       'Active'
FROM dbo.Subscriptions AS s
WHERE s.Status = 'Cancelled';

INSERT INTO dbo.Payments (SubscriptionID, PaymentDate, Amount, PaymentMethod, Status)
SELECT s.SubscriptionID,
       DATEADD(MONTH, m.MonthsSinceStart, CAST(s.StartDate AS DATETIME2(0))),
       sp.MonthlyPrice,
       CHOOSE(1 + (s.SubscriptionID + m.MonthsSinceStart) % 5,
              'Credit Card', 'Debit Card', 'PayPal', 'Apple Pay', 'Google Pay'),
       CASE WHEN (s.SubscriptionID * 7 + m.MonthsSinceStart) % 25 = 0 THEN 'Failed' ELSE 'Completed' END
FROM dbo.Subscriptions AS s
INNER JOIN dbo.SubscriptionPlans AS sp ON sp.PlanID = s.PlanID
CROSS JOIN (SELECT TOP (24) CAST(ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) - 1 AS INT) AS MonthsSinceStart
            FROM sys.all_objects) AS m
WHERE sp.MonthlyPrice > 0
  AND DATEADD(MONTH, m.MonthsSinceStart, s.StartDate) <= '2026-08-31';

WITH Plays AS
(
    SELECT TOP (2000) CAST(ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS INT) AS PlayNo
    FROM sys.all_objects AS a
    CROSS JOIN sys.all_objects AS b
)
INSERT INTO dbo.Streams (UserID, TrackID, DeviceTypeID, StartedAt, SecondsPlayed)
SELECT 1 + (pl.PlayNo * 17) % 40,
       t.TrackID,
       1 + (pl.PlayNo * 11) % 6,
       DATEADD(MINUTE, (pl.PlayNo * 97) % 1440, DATEADD(DAY, (pl.PlayNo * 13) % 608, '2025-01-01')),
       CASE WHEN pl.PlayNo % 7 = 0 THEN 5 + pl.PlayNo % 20
            ELSE t.DurationSec - pl.PlayNo % 11 END
FROM Plays AS pl
INNER JOIN dbo.Tracks AS t
        ON t.TrackID = CASE WHEN pl.PlayNo % 3 = 0 THEN 1 + (pl.PlayNo * 29) % 15
                            ELSE 1 + (pl.PlayNo * 29) % 60 END;

COMMIT TRANSACTION;
GO

SELECT TableName, Rows
FROM (VALUES ( 1, 'Countries',         (SELECT COUNT(*) FROM dbo.Countries)),
             ( 2, 'DeviceTypes',       (SELECT COUNT(*) FROM dbo.DeviceTypes)),
             ( 3, 'Users',             (SELECT COUNT(*) FROM dbo.Users)),
             ( 4, 'SubscriptionPlans', (SELECT COUNT(*) FROM dbo.SubscriptionPlans)),
             ( 5, 'Subscriptions',     (SELECT COUNT(*) FROM dbo.Subscriptions)),
             ( 6, 'Payments',          (SELECT COUNT(*) FROM dbo.Payments)),
             ( 7, 'Artists',           (SELECT COUNT(*) FROM dbo.Artists)),
             ( 8, 'Albums',            (SELECT COUNT(*) FROM dbo.Albums)),
             ( 9, 'Tracks',            (SELECT COUNT(*) FROM dbo.Tracks)),
             (10, 'Genres',            (SELECT COUNT(*) FROM dbo.Genres)),
             (11, 'TrackGenres',       (SELECT COUNT(*) FROM dbo.TrackGenres)),
             (12, 'Playlists',         (SELECT COUNT(*) FROM dbo.Playlists)),
             (13, 'PlaylistTracks',    (SELECT COUNT(*) FROM dbo.PlaylistTracks)),
             (14, 'Streams',           (SELECT COUNT(*) FROM dbo.Streams))) AS c (SortOrder, TableName, Rows)
ORDER BY SortOrder;
GO
