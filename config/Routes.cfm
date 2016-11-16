<cfscript>
	// Allow unique URL or combination of URLs, we recommend both enabled
	setUniqueURLS(false);
	// Auto reload configuration, true in dev makes sense to reload the routes on every request
	//setAutoReload(false);
	// Sets automatic route extension detection and places the extension in the rc.format variable
	// setExtensionDetection(true);
	// The valid extensions this interceptor will detect
	// setValidExtensions('xml,json,jsont,rss,html,htm');
	// If enabled, the interceptor will throw a 406 exception that an invalid format was detected or just ignore it
	// setThrowOnInvalidExtension(true);

	// Base URL
	if( len(getSetting('AppMapping') ) lte 1){
		setBaseURL("http://#cgi.HTTP_HOST#/index.cfm");
	}
	else{
		setBaseURL("http://#cgi.HTTP_HOST#/#getSetting('AppMapping')#/index.cfm");
	}

	// addRoute(
	// 	pattern="/users/:username",
	// 	handler="users",
	// 	action={
	// 		GET = "view"
	// 	}
	// );

	// addRoute(
	// 	pattern="/users",
	// 	handler="users",
	// 	action={
	// 		GET = "list",
	// 		POST = "create",
	// 		PUT = "save",
	// 		DELETE = "remove",
	// 		HEAD = "info",
	// 		OPTIONS = "options"
	// 	}
	// );

	// Your Application Routes
	addRoute(pattern=":handler/:action?");


	/** Developers can modify the CGI.PATH_INFO value in advance of the SES
		interceptor to do all sorts of manipulations in advance of route
		detection. If provided, this function will be called by the SES
		interceptor instead of referencing the value CGI.PATH_INFO.

		This is a great place to perform custom manipulations to fix systemic
		URL issues your Web site may have or simplify routes for i18n sites.

		@Event The ColdBox RequestContext Object
	**/
	// Example PathInfoProvider for detecting a mobile request
	public string function PathInfoProvider( event )
	{
		var URI = CGI.PATH_INFO;
		var apiVersion = 1;
		// Account for IIS Rewrite rule when calling the root "/"
		if ( URI eq "/index.cfm" ) {
			URI = "";
		}
		// Generic Application Routes
		addRoute( pattern=":handler/:action?" );
		// Get the latest version if defined - defaults to 0
		var latestVersion = getEndpointLatestVersion( URI );
		if ( latestVersion > 0 )
		{
			event.setPrivateValue( "Latest-Version", latestVersion );
			apiVersion = latestVersion;
			var acceptHeader = event.getHTTPHeader( "Accept", "" );
			if ( acceptHeader.len() > 0 )
			{
				var arrAcceptHeader = acceptHeader.listToArray( ";" );
				if ( arrAcceptHeader.len() > 1 )
				{
					var secondPartAcceptHeader = arrAcceptHeader[2].listToArray( "=" );
					if
					(
						secondPartAcceptHeader.len() > 1
						&& isNumeric( secondPartAcceptHeader[2].trim() )
						&& compareNoCase( secondPartAcceptHeader[1].trim(), "version" ) == 0
					)
					{
						apiVersion = secondPartAcceptHeader[2].trim();
					}
				}
			}
			//change the module path
			if ( URI.left( 6 ) != "/api/v" )
				URI = "/api/v#apiVersion#" & URI
			;
		}
		return URI;
	}


	//------------------ PRIVATE METHODS ------------------


	/**
	 * @hint All resources have to be registered here with their latest version
	 */
	private numeric function getEndpointLatestVersion
	( string route = "" )
	{
		writedump(arguments.route);
		var version = 0;
		var latestVersions = {
			"/artists" 	= 2
		};
		for ( var key in latestVersions )
		{
			if ( arguments.route.left( key.len() ) == key )
			{
				version = latestVersions[ key ];
				break;
			}
		}
		return version;
	}
</cfscript>