In the Package Manager Console.  Run the following to rebuild the models from the Blink database:

Scaffold-DbContext 
	"Server=&lt;Server Address&gt;;Initial Catalog=&lt;Database Name&gt;;User ID=&lt;UID&gt;;Password=&lt;PWD&gt;;" 
	Microsoft.EntityFrameworkCore.SqlServer 
	-Force 
	-OutputDir &lt;path/to/models/&gt; 
	-Tables &lt;Limit To Listed Tables&gt;

