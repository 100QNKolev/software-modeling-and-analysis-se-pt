USE SpotifyDB;
GO

SET NOCOUNT ON;
GO

EXEC dw.usp_LoadDataWarehouse;
GO

SELECT TableName, Rows
FROM (VALUES ( 1, 'dw.DimDate',           (SELECT COUNT(*) FROM dw.DimDate)),
             ( 2, 'dw.DimUser',           (SELECT COUNT(*) FROM dw.DimUser)),
             ( 3, 'dw.DimGeography',      (SELECT COUNT(*) FROM dw.DimGeography)),
             ( 4, 'dw.DimArtist',         (SELECT COUNT(*) FROM dw.DimArtist)),
             ( 5, 'dw.DimTrack',          (SELECT COUNT(*) FROM dw.DimTrack)),
             ( 6, 'dw.DimDevice',         (SELECT COUNT(*) FROM dw.DimDevice)),
             ( 7, 'dw.DimPlan',           (SELECT COUNT(*) FROM dw.DimPlan)),
             ( 8, 'dw.FactStreams',       (SELECT COUNT(*) FROM dw.FactStreams)),
             ( 9, 'dw.FactPayments',      (SELECT COUNT(*) FROM dw.FactPayments)),
             (10, 'dw.FactSubscriptions', (SELECT COUNT(*) FROM dw.FactSubscriptions))) AS c (SortOrder, TableName, Rows)
ORDER BY SortOrder;
GO
