component {

	// Module Properties
	this.title 				= "v2";
	this.author 			= "";
	this.webURL 			= "";
	this.description 		= "";
	this.version			= "1.0.0";
	// If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
	this.viewParentLookup 	= true;
	// If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
	this.layoutParentLookup = true;
	// Module Entry Point
	this.entryPoint			= "/api/v2";
	// Model Namespace
	this.modelNamespace		= "v2";
	// CF Mapping
	this.cfmapping			= "v2";
	// Auto-map models
	this.autoMapModels		= false;
	// Module Dependencies
	this.dependencies 		= [];

	function configure(){

		// parent settings
		parentSettings = {

		};

		// module settings - stored in modules.name.settings
		settings = {

		};

		// Layout Settings
		layoutSettings = {
			defaultLayout = ""
		};

		// datasources
		datasources = {

		};

		// SES Routes
		routes = [
			// Module Entry Point
			{ pattern="/", handler="echo",action="index" },
			{ pattern="/artists/:ID", handler="artists", action={GET="view", PATCH="patch", DELETE="remove", OPTIONS="options"} },
			{ pattern="/artists", handler="artists", action={GET="list", OPTIONS="options"} },
			// Convention Route
			{ pattern="/:handler/:action?" }
		];

		// Custom Declared Points
		interceptorSettings = {
			customInterceptionPoints = ""
		};

		// Custom Declared Interceptors
		interceptors = [
		];

		//Conventions
		conventions = {
			handlersLocation = "controllers"
		};

		registerCustomBinderMappings();

	}


	/**
	* Fired when the module is registered and activated.
	*/
	function onLoad()
	{}


	/**
	* Fired when the module is unregistered and unloaded
	*/
	function onUnload()
	{}


	private void function registerCustomBinderMappings()
	{
		var modulesModelDirectory = expandPath( "#moduleMapping#/models/" );
		// list of all model objects
		cfdirectory
		(
			action = "list",
			directory = modulesModelDirectory,
			filter = "*.cfc",
			recurse = true,
			listinfo = "all",
			name = "qObjects"
		);
		modulesModelDirectory = modulesModelDirectory.replace( "\", "/", "all" );
		// start point of the module in object path
		var moduleMappingStart = findNoCase( replace(moduleMapping, "\", "/", "all"), replace(qObjects.directory, "\", "/", "all" ) );
		// loop through all the found objects
		for ( var file in qObjects )
		{
			file.directory = replace( file.directory, "\", "/", "all" );
			// just the object file name without the extension
			var fileWithNoExtension = file.name.replaceNoCase( ".cfc", "" );
			// figure out the module path array
			var directoryPart = file.directory.replaceNoCase( modulesModelDirectory, "" );
			var localModulePaths = file.directory.replaceNoCase( modulesModelDirectory, "" ).listToArray( "/" );
			localModulePaths.append( fileWithNoExtension );
			// figure out the complete object binding path that needs to go in WireBox
			var trimmedDirectory = mid
			(
				file.directory,
				moduleMappingStart,
				file.directory.len()
			);
			var objectPath = trimmedDirectory.listToArray( "/" );
			objectPath.append( fileWithNoExtension );
			var localModulePath = localModulePaths.toList( "." );
			var moduleName = objectPath[4];
			var binderPath = objectPath.toList( "." );
			binder.map( "#localModulePath#@#moduleName#" ).to( binderPath );
		}
	}


}