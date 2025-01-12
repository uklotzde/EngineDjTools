--------------------------------------------------------------------------
-- !!! BACKUP YOUR ENGINE DJ LIBRARY BEFORE RUNNING THIS SQL SCRIPT !!! --
--                                                                      --
-- USAGE (Unix/Bash):                                                   --
--   sqlite3 \                                                          --
--         "Engine Library/Database2/m.db" \                            --
--         < db_cleanup.sql                                             --
--                                                                      --

--------------------------------------------------------------------------
-- Pre-cleanup checks                                                   --
--------------------------------------------------------------------------

PRAGMA integrity_check;

--------------------------------------------------------------------------
-- Cleanup database                                                     --
--------------------------------------------------------------------------

-- AlbumArt: Delete orphaned records.
DELETE FROM AlbumArt WHERE id NOT IN (SELECT albumArtId FROM Track);

-- Track: Reset bogus albumArt column values.
-- Engine DJ started to insert these values for all tracks with id >= 5000.
-- Uncomment at your own risk.
--UPDATE Track SET albumArt=NULL where albumArt='image://planck/0';

--------------------------------------------------------------------------
-- Post-cleanup maintenance                                             --
--------------------------------------------------------------------------

-- Rebuild the entire database file
-- https://www.sqlite.org/lang_vacuum.html
VACUUM;

-- According to Richard Hipp himself executing VACUUM before ANALYZE is the
-- recommended order: https://sqlite.org/forum/forumpost/62fb63a29c5f7810?t=h

-- Update statistics for the query planner
-- https://www.sqlite.org/lang_analyze.html
ANALYZE;
