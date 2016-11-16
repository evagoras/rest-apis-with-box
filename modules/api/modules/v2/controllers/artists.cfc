component
	singleton
	extends = "api.controllers.baseHandler"
{


	// Services
	property name="artistService" inject="services.artist@v2";


	/**
	 * @hint Returns a single instance of an user's details
	 * @event ColdBox Event Model
	 * @rc Request Collection
	 * @prc Private Request Collection
	 */
	public any function view
	( event, rc, prc )
	{
		var requestViewBean = wirebox.getInstance( "beans.request.artistView@v2" );
		// populate Bean from the arguments collection
		requestViewBean.populate( memento = rc );
		if ( requestViewBean.validates() )
		{
			var artistBean = artistService.getArtist( ID = rc.ID );
			if ( artistBean.isPopulated() )
			{
				prc.response
					.setStatusCode( 200 )
					.setStatusText( "OK" )
					.setData( artistBean.serializeAs( "json" ) )
				;
			}
			else
			{
				prc.response
					.setStatusCode( 404 )
					.setStatusText( "Not Found" )
					.setData( "" )
				;
			}
		}
		// validation errors found
		else
		{
			prc.response
				.setFormat( "json" )
				.setError( true )
				.setStatusCode( 400 )
				.setStatusText( "Bad Request" )
				.setData( requestViewBean.returnErrors() )
			;
		}
	}


}