# Commands

## SCAN family
Works as a cursor, returning a pair where the first value is the next cursor to be applied (as an argument), and the second value is the scanned set of values in the database (or set, if it's a command in the SCAN family other than SCAN itself).
If starting at 0 (SCAN 0) and the next cursor is 0, then the database/set has been fully scanned. However, the scan is done concurrently with any changes, and therefore may not return values that were added in the scan, or return values that were removed as well.
