using System;
using System.IO;
using System.Linq;

static void Clean(string[] args)
{

    string rootDirectory = @"C:\MySolution";

    // Recursively find and delete 'bin' and 'obj' directories
    foreach (var directory in Directory.GetDirectories(rootDirectory, "*", SearchOption.AllDirectories))
    {
        if (directory.EndsWith("bin", StringComparison.OrdinalIgnoreCase) || 
            directory.EndsWith("obj", StringComparison.OrdinalIgnoreCase))
        {
            // Check if the parent folder contains a .csproj file
            string parentDirectory = Directory.GetParent(directory).FullName;
            bool hasCsproj = Directory.GetFiles(parentDirectory, "*.csproj", SearchOption.TopDirectoryOnly).Any();

            if (hasCsproj)
            {
                Console.WriteLine($"Deleting: {directory}");
                Directory.Delete(directory, true); // true => Delete recursively
            }
        }
    }

}

