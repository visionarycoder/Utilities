# Terminal Commands

## Clear NuGet local caches
```
dotnet nuget locals all --clear
nuget locals all -clear
```

## Clear
```
cls
```

## Manage SQL Server
```
net stop MSSQLSERVER
net start MSSQLSERVER
```

## Manage LocalDB
*Warning: this will delete all your databases located in MSSQLLocalDB. Proceed with caution.*

```
sqllocaldb stop mssqllocaldb
sqllocaldb delete mssqllocaldb
sqllocaldb start "MSSQLLocalDB"
```

Kill the running instance
```
sqllocaldb stop mssqllocaldb -k
```
