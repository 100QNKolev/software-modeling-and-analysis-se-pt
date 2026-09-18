# Spotify - Database, Data Warehouse and Power BI Report

| `2401322004` | `Стоян Колев` |

This project models the music streaming platform Spotify: listeners, subscription plans and payments,
the music catalogue (artists, albums, tracks and genres), playlists and the listening history. The
relational database is built in SQL Server and filled with synthetic data, a data warehouse with three
star schemas is loaded from it, and a Power BI report visualises the results.

## Diagrams (draw.io)

- **`01_conceptual_model_chen.drawio`** - Conceptual model in Chen notation: the entities, their main
  attributes and the relationships between them, including the two many-to-many relationships
  (a track has many genres, a playlist has many tracks).
- **`02_logical_model_crows_foot.drawio`** - Logical model in Crow's Foot notation: all 14 tables with
  their columns and keys. The many-to-many relationships become the tables `TrackGenres` and `PlaylistTracks`.
- **`03_data_warehouse_uml.drawio`** - Data warehouse in UML notation: 3 fact tables and 7 dimension
  tables. The first page shows all of them, the next three pages show one star schema each.

## How to run

1. Install SQL Server and [sqlcmd](https://learn.microsoft.com/sql/tools/sqlcmd/sqlcmd-utility), then run
   the scripts in order from the `database` folder in PowerShell (the scripts create the database, so
   drop it first if it already exists; for SQL Server Express use `-S localhost\SQLEXPRESS`):

   ```powershell
   Get-ChildItem *.sql | Sort-Object Name | ForEach-Object { sqlcmd -S localhost -E -C -b -I -i $_.FullName }
   ```

2. Open the `.pbip` file in the `powerbi` folder in Power BI Desktop and click **Refresh**. If your
   server isn't `localhost`, change the `SqlServer` parameter under *Transform data > Edit parameters*.
