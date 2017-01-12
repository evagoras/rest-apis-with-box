component singleton extends="coldbox.system.EventHandler" {


	// Services
	property name="utils" inject="utils";


	/**
	 * @hint Displays the API Dashboard
	 * @event {any} The request context object reference (coldbox.system.web.context.RequestContext)
	 * @rc {struct}  A reference to the request collection inside of the request context object
	 * @prc {struct} A reference to the private request collection inside of the request context object
	 */
	public any function index
	( event, rc, prc )
	{
		// make the timeout for this page 3 minutes
		setting requesttimeout = "180";
		// The Postman Resource file
		var postmanFile = expandPath( "/postman/Building%20RESTful%20APIs%20using%20Box%20Products.postman_collection.json" );
		// last modified timestamp of the file
		var fileLastModifiedMoment = wirebox.getInstance( "moment" ).init( getFileInfo( postmanFile ).lastModified );
		// deserialize the JSON into a Struct
		var jsonPostmanFile = deserializeJson( fileRead( postmanFile ) );
		// create a Moment object based on the file last modifed date
		var fileLastModifiedMoment = wirebox.getInstance( "moment" ).init( getFileInfo( postmanFile ).lastModified );
		// create another Moment object based on the current time
		var nowMoment = wirebox.getInstance( "moment" ).init();
		// fuzzy time difference between the 2 Moment objects
		prc.postmanFileLastModified = fileLastModifiedMoment.from( nowMoment );
		// Postman Public Share ID
		// prc.postmanShareID = jsonPostmanFile[ "info" ][ "_postman_id" ];
		// Get the environment we are running on
		prc.environment = getSetting( "environment" );
		prc.hostaddress = createObject("java", "java.net.InetAddress").getLocalHost().getHostAddress();
	}


	/**
	 * Handle invalid controller events
	 * @param  {struct} event [description]
	 * @param  {struct} rc    [description]
	 * @param  {struct} prc   [description]
	 * @return {any}          [description]
	 */
	function onInvalidEvent
	( event, rc, prc )
	{
		var uri = utils.getRequestUrl( cgi );
		event.renderData
		(
			data = {
				"Message" = "No HTTP resource was found that matches the request URI '#uri#'.",
				"MessageDetail" = "No controller was selected to handle this request."
			},
			type = "json",
			statusCode = 404,
			statusText = "Not Found"
		);
	}


	public void function onColdBoxRequestStart
	( event, rc, prc )
	{
		/*
			Any changes to this method will require a ColdFusion
			instance restart for them to take effect.
		 */
		if ( rc.keyExists( "cfreinit" ) )
		{
			// code plucked from coldbox.system.Bootstrap.cfc
			var appKey = "cbController";
			var reinitPass = "";
			var isReinitPasswordCorrect = false;
			// Check if app exists already in scope
			if ( ! application.keyExists( appKey ) )
				isReinitPasswordCorrect = true;
			// Check if we have a reinit password at hand.
			if ( application[ appKey ].settingExists( "ReinitPassword" ) )
				reinitPass = application[ appKey ].getSetting( "ReinitPassword" );
			// pass Checks
			if ( len( reinitPass ) == 0 )
				isReinitPasswordCorrect = true;
			if ( compare( reinitPass, hash( rc.cfreinit ) ) == 0 )
				isReinitPasswordCorrect = true;
			if ( isReinitPasswordCorrect )
			{
				applicationStop();
				location( "/", false );
			}
			else
			{
				/*
					If the cfreinit was unsuccessful
					then respond with a 400 so that we know it didn't work.
					The abort is needed to avoid reloading the same page
					it was called from.
				 */
				var responseErrors = {
					"Message" = "Could not reinit ColdFusion.",
					"MessageDetail" = "The 'cfReinit' password is wrong."
				};
				cfcontent( reset=true );
				cfheader( name="Content-Type", value="application/json" );
				cfheader( statuscode="400", statustext="Bad Request" );
				writeOutput( serializeJSON( responseErrors ) );
				abort;
			}
		}
	}


}