REM Rebuilding the LocalDB
REM Idea from https://stackoverflow.com/questions/23154763/visual-studio-code-map-unable-to-connect-to-the-specified-database
sqllocaldb stop "MSSQLLocalDB" -k
sqllocaldb delete "MSSQLLocalDB"
sqllocaldb create "MSSQLLocalDB" 
sqllocaldb start "MSSQLLocalDB"