component{

	// Configure ColdBox Application
	function configure(){

		// coldbox directives
		coldbox = {
			//Application Setup
			appName 				= "Your RESTFul app name here",
			eventName 				= "event",

			//Development Settings
			debugMode               = true,
			handlersIndexAutoReload = true,
			debugPassword           = "",
			reinitPassword          = "",

			//Implicit Events
			defaultEvent            = "main.index",
			requestStartHandler     = "main.onColdBoxRequestStart",
			requestEndHandler		= "",
			applicationStartHandler = "",
			applicationEndHandler	= "",
			sessionStartHandler 	= "",
			sessionEndHandler		= "",
			missingTemplateHandler	= "",

			//Extension Points
			applicationHelper 			= "",
			viewsHelper					= "",
			modulesExternalLocation		= [],
			viewsExternalLocation		= "",
			layoutsExternalLocation 	= "",
			handlersExternalLocation  	= "",
			requestContextDecorator 	= "",
			controllerDecorator			= "",

			//Error/Exception Handling
			exceptionHandler		= "",
			onInvalidEvent          = "main.onInvalidEvent",
			customErrorTemplate		= "",

			//Application Aspects
			handlerCaching 			= false,
			eventCaching			= false,
			proxyReturnCollection 	= false
		};

		// custom settings
		settings = {
			"paging" = {
				"maxLimit" = 500,
				"maxDefault" = 50
			}
		};

		// environment settings, create a detectEnvironment() method to detect it yourself.
		// create a function with the name of the environment so it can be executed if that environment is detected
		// the value of the environment is a list of regex patterns to match the cgi.http_host.
		environments = {
			development = "localhost,^127",
			production = "pressocfcamp.com$"
		};

		// Module Directives
		modules = {
			//Turn to false in production
			autoReload = false,
			// An array of modules names to load, empty means all of them
			include = [],
			// An array of modules names to NOT load, empty means none
			exclude = []
		};

		//LogBox DSL
		logBox = {
			// Define Appenders
			appenders = {
				coldboxTracer = { class="coldbox.system.logging.appenders.ConsoleAppender" }
			},
			// Root Logger
			root = { levelmax="INFO", appenders="*" },
			// Implicit Level Categories
			info = [ "coldbox.system" ]
		};

		//Layout Settings
		layoutSettings = {
			defaultLayout = "",
			defaultView   = ""
		};

		//Interceptor Settings
		interceptorSettings = {
			throwOnInvalidStates = false,
			customInterceptionPoints = ""
		};

		//Register interceptors as an array, we need order
		interceptors = [
			//SES
			{
				class = "coldbox.system.interceptors.SES",
				properties = {
					configFile = "/approot/config/Routes.cfm"
				}
			}
			// ,{ class = "approot.interceptors.sesBaseUrl" }

		];

		//Register interceptors as an array, we need order
		interceptors = [
			{class="coldbox.system.interceptors.SES",
			 properties={}
			}
		];

		//WireBox Integration
		wireBox = {
			enabled = true,
			binder = "approot.config.WireBox",
			singletonReload = false
		};

		// flash scope configuration
		flash = {
			scope           = "approot.models.flashStorage", //session,client,cluster,cache,or full path
			properties      = {}, // constructor properties for the flash scope implementation
			inflateToRC     = false, // automatically inflate flash data into the RC scope
			inflateToPRC    = false, // automatically inflate flash data into the PRC scope
			autoPurge       = true, // automatically purge flash data for you
			autoSave        = false // automatically save flash scopes at end of a request and on relocations.
		};

		//Conventions
		conventions = {
			handlersLocation = "controllers",
			viewsLocation    = "views",
			layoutsLocation  = "layouts",
			modelsLocation   = "models",
			eventAction      = "index"
		};

		//Datasourcesl
		datasources = {
			gallery = {
				name = "cfartgallery",
				dbtype = "sqlite"
			}
		};

	}


	/**
	* Development environment
	*/
	function development(){
		coldbox.customErrorTemplate = "/coldbox/system/includes/BugReport.cfm";
		coldbox.append
		(
			{
				handlerCaching          	= true,
				eventCaching            	= true,
				handlersIndexAutoReload 	= true,
				debugPassword           	= "",
				reinitPassword          	= ""
			}
		);
		coldbox.wirebox.singletonReload 	= true;
		debugger = {
			// Activate debugger for everybody
			debugMode = false,
			// Setup a password for the panel
			debugPassword = "",
			enableDumpVar = true,
			persistentRequestProfiler = true,
			maxPersistentRequestProfilers = 10,
			maxRCPanelQueryRows = 50,
			showTracerPanel = true,
			expandedTracerPanel = true,
			showInfoPanel = true,
			expandedInfoPanel = false,
			showCachePanel = true,
			expandedCachePanel = false,
			showRCPanel = true,
			expandedRCPanel = false,
			showModulesPanel = true,
			expandedModulesPanel = false,
			showRCSnapshots = true,
			wireboxCreationProfiler=true
		};
	}


	function production()
	{
		coldbox.append({
			handlerCaching          		= true,
			eventCaching            		= true,
			handlersIndexAutoReload 		= false,
			debugMode 						= false,
			debugPassword           		= "54321",
			reinitPassword          		= "12345"
		});
		coldbox.wirebox.singletonReload 	= false;
		debugger = {
			debugMode = false
		};
	}


}