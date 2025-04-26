# EFCore database scaffolding﻿

EFCore offers some interesting tooling to help with database-first development efforts.

## Prerequisites

NuGet Package: Microsoft.EntityFrameworkCore.Design

I find life is easier with the ef tools installed globally
```console
dotnet tool install --global dotnet-ef
```

## Execution

In the Package Manager Console.  

```console
Scaffold-DbContext 
	"Server=<Your Database Server Address>;Initial Catalog=<Your Database Name>;User ID=<Your UID>;Password=<Your Password>;" 
	Microsoft.EntityFrameworkCore.SqlServer 
	--context-dir .
	--namespace <Your Company Name>.Database.<YourDatabaseName>.Internal
	--output-dir /Models/ 
	--force
        --no-onconfiguring
	--use-database-names
```

### Preferences

- I prefer to have my DbContext file at the root level of my ORM project. 
- I prefer to place the models for the tables in a subfolder '/Models
- I prefer to add 'Internal' to the namespace to remind the team to not leak these models outside of the component.  I am firmly opposed to directly using entities as dtos.  Tight coupling your database implementation is not always a good long-term approach.  I get better outcomes if I have the option to manage the two concepts independently.
- Force overwrites any previous mappings.
- no-onconfiguring skips hardcoding your connection string into the DbContext file.  You will get a warning if you omit this command.

## References

https://learn.microsoft.com/en-us/ef/core/managing-schemas/scaffolding/?tabs=dotnet-core-cli
