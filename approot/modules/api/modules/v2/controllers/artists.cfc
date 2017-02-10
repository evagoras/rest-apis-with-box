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
	// cache=true
	// cacheTimeout="10"
	// cacheLastAccessTimeout="5"
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
					.setContentType( "application/json" )
					.setData( artistBean.serializeAs( "json" ) )
				;
			}
			else
			{
				prc.response
					.setStatusCode( 404 )
					.setStatusText( "Not Found" )
					.setData( "" )
					.setContentType( "application/json" )
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


	public any function list
	( event, rc, prc )
	{
		param name="rc.offset" default=0;
		param name="rc.limit" default=getSetting( "paging" ).maxDefault;
		// Validate the request
		var requestArtistBean = getInstance( "beans.request.artistList@v2" );
		requestArtistBean.populate( memento = rc );
		// No validation errors
		if ( requestArtistBean.validates() )
		{
			var results = artistService.getArtists
			(
				offset = rc.offset,
				limit = rc.limit
			);
			prc.response
				.setStatusCode( 200 )
				.setStatusText( "OK" )
				.setTotalCount( results.totalcount )
				.setContentType( "application/json" )
			;
			if ( results.totalcount > 0 )
			{
				var responseData = "";
				var elements = [];
				for ( var element in results.data )
				{
					elements.append( element.serializeAs( "json" ) );
					responseData = "[" & elements.toList( ", " ) & "]";
				}
				prc.response.setData( responseData );
			}
			else
			{
				prc.response.setData( [] );
			}
		}
		// Has validation errors
		else
		{
			prc.response
				.setStatusCode( 400 )
				.setStatusText( "Bad Request" )
				.setData( requestArtistBean.returnErrors() )
			;
		}
	}


	public any function put
	( event, rc, prc )
	{
		var requestBean = wirebox.getInstance( "beans.request.artistUpdate@v2" );
		var postedData = deserializeJson( getHTTPRequestData().content );
		rc.append( postedData );
		populateModel( requestBean );
		var vResults = validateModel( requestBean );
		if ( vResults.hasErrors() == true )
		{
			prc.response
				.setErrorCode( 400 )
				.setError( true )
				.setStatusCode( 400 )
				.setStatusText( "Bad Request" )
				.addMessage( vResults.getAllErrors() )
				.setData( vResults.getAllErrorsAsStruct() )
			;
		}
		else
		{
			var userDetails = artistDao.getArtistDetails( ID = rc.ID );
			if ( userDetails.recordcount == 1 )
			{
				var updated = artistDao.updateArtist( bean = requestBean );
				if ( updated )
				{
					var artistDetails = artistDao.getArtistDetails( ID = rc.ID );
					prc.response
						.setStatusCode( 201 )
						.setStatusText( "Updated" )
						.setData( queryGetRow(artistDetails, 1) )
					;
				}
			}
			else
			{
				prc.response
					.setStatusCode( 404 )
					.setStatusText( "Not Found" )
					.setError( true )
					.setErrorCode( 404 )
					.addHeader( "X-Resource-Not-Found", true );
				;
			}
		}
	}


	public any function remove
	( event, rc, prc )
	{
		var requestBean = wirebox.getInstance( "beans.request.artistView@v2" );
		// populate Bean from the arguments collection
		populateModel( requestBean );
		var vResults = validateModel( requestBean );
		if ( vResults.hasErrors() == true )
		{
			prc.response
				.setErrorCode( 400 )
				.setError( true )
				.setStatusCode( 400 )
				.setStatusText( "Bad Request" )
				.addMessage( vResults.getAllErrors() )
				.setData( vResults.getAllErrorsAsStruct() )
			;
		}
		else
		{
			var userDetails = artistDao.getArtistDetails( ID = rc.ID );
			if ( userDetails.recordcount == 1 )
			{
				var deleted = artistDao.removeArtist( artistID = rc.ID );
				if ( deleted )
				{
					prc.response
						.setStatusCode( 201 )
						.setStatusText( "Deleted" )
					;
				}
			}
			else
			{
				prc.response
					.setStatusCode( 404 )
					.setStatusText( "Not Found" )
					.setError( true )
					.setErrorCode( 404 )
					.addHeader( "X-Resource-Not-Found", true )
				;
			}
		}
	}

}