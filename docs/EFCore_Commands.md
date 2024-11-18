In the Package Manager Console.  Run the following to rebuild the models from the Blink database:

Scaffold-DbContext 
	"Server=<<Server Address>>;Initial Catalog=<<Database Name>>;User ID=<<UID>>;Password=<<PWD>>;" 
	Microsoft.EntityFrameworkCore.SqlServer 
	-Force 
	-OutputDir <<path/to/models/>> 
	-Tables <<Limit To Listed Tables>>

