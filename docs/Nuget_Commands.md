# Terminal Commands

## Clear NuGet local caches
```cli
dotnet nuget locals all --clear
nuget locals all -clear
```

## Restore NuGet packages

Navigate to the the .sln file.

```cli
dotnet restore
```

## Update NuGet packages

Navigate to the the .sln file.

```cli
dotnet list package --outdated
dotnet outdated -- upgrade
```

### Errors

If there are errors running dotnet-outdated, run the following

```cli
dotnet tool install --global dotnet-outdated-tool
```

Then rerun the commands.

## Add a package

```cli
dotnet add package <PACKAGE_NAME>
```

## Remove a package

```cli
dotnet remove package <PACKAGE_NAME>
```

## List installed packages

```cli
dotnet list package
```

## Create a package for your project.

Navigate to the project file location.

```cli
dotnet pack
```

## Push the package to a server

```cli
dotnet nuget push <PACKAGE_FILE> --source <SOURCE_URL> --api-key <API_KEY>
```

## Search for Packages
```cli
 dotnet nuget search <SEARCH_TERM>
```

