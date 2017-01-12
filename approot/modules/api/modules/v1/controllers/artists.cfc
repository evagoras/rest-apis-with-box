component
singleton
extends = "v1.controllers.baseHandler"
{


	// Services
	property name="artistService" inject="services.artist@v1";
	property name="artistDao" inject="daos.artist@v1";


	public any function put
	( event, rc, prc )
	{
		var requestBean = wirebox.getInstance( "beans.request.artistUpdate@v1" );
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
		var requestBean = wirebox.getInstance( "beans.request.artistView@v1" );
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
					.addHeader( "X-Resource-Not-Found", true );
				;
			}
		}

		// requestBean.populate( memento = rc );
		// if ( requestBean.validates() )
		// {
		// 	var userDetails = artistDao.getArtistDetails( ID = rc.ID );
		// 	if ( userDetails.recordcount == 1 )
		// 	{
		// 		var deleted = artistDao.removeArtist( artistID = rc.ID );
		// 		if ( deleted )
		// 		{
		// 			prc.response
		// 				.setStatusCode( 201 )
		// 				.setStatusText( "Deleted" )
		// 			;
		// 		}
		// 	}
		// 	else
		// 	{
		// 		prc.response
		// 			.setStatusCode( 404 )
		// 			.setStatusText( "Not Found" )
		// 		;
		// 		prc.response.addHeader( "Resource-Not-Found", true );
		// 	}
		// }
		// else
		// {
		// 	prc.response
		// 		.setFormat( "json" )
		// 		// .setError( true )
		// 		.setStatusCode( 400 )
		// 		.setStatusText( "Bad Request" )
		// 		.setData( requestBean.returnErrors() )
		// 	;
		// }
	}


	// public any function list
	// ( event, rc, prc )
	// {
	// 	param name="rc.offset" default=0;
	// 	param name="rc.limit" default=getSetting( "paging" ).maxDefault;
	// 	// Validate the request
	// 	var requestArtistBean = wirebox.getInstance( "beans.request.artistList@v1" );
	// 	requestArtistBean.populate( memento = rc );
	// 	// No validation errors
	// 	if ( requestArtistBean.validates() )
	// 	{
	// 		// Order list returns a Response Bean
	// 		var responseBean = artistService.getArtists
	// 		(
	// 			offset = rc.offset,
	// 			limit = rc.limit
	// 		);
	// 		if ( responseBean.getTotalCount() == 0 )
	// 		{
	// 			responseData = "[]";
	// 		}
	// 		else
	// 		{
	// 			var responseData = "";
	// 			var elements = [];
	// 			for ( var element in responseBean.getData() )
	// 			{
	// 				elements.append( element.serializeAs( "json" ) );
	// 				responseData = "[" & elements.toList( ", " ) & "]";
	// 			}
	// 		}
	// 		prc.response
	// 			.setStatusCode( responseBean.getStatusCode() )
	// 			.setStatusText( responseBean.getStatusText() )
	// 			.setError( responseBean.getError() )
	// 			// .setTotalCount( responseBean.getTotalCount() )
	// 			.setContentType( responseBean.getContentType() )
	// 			.setData( responseData )
	// 			// .setFormat( "plain" )
	// 		;
	// 	}
	// 	// Has validation errors
	// 	else
	// 	{
	// 		prc.response
	// 			.setError( true )
	// 			.setStatusCode( 400 )
	// 			.setStatusText( "Bad Request" )
	// 			.setData( requestArtistBean.returnErrors() )
	// 		;
	// 	}
	// }


	/**
	 * @hint Returns a single instance of an user's details
	 * @event ColdBox Event Model
	 * @rc Request Collection
	 * @prc Private Request Collection
	 */
	public any function view
	( event, rc, prc )
	// cache = true
	// cacheTimeout = 1
	// cacheLastAccessTimeout = 1
	{
		var requestViewBean = wirebox.getInstance( "beans.request.artistView@v1" );
		populateModel( model=requestViewBean );
		var vResults = validateModel( requestViewBean );
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
            var artistDetails = artistDao.getArtistDetails( ID = rc.ID );
			if ( artistDetails.recordcount == 1 )
			{
				prc.response
					.setStatusCode( 200 )
					.setStatusText( "OK" )
					.setData( queryGetRow(artistDetails, 1) )
				;
			}
			else
			{
				prc.response
					.setStatusCode( 404 )
					.setStatusText( "Not Found" )
					.setError( true )
					.setErrorCode( 404 )
				;
				prc.response.addHeader( "X-Resource-Not-Found", true );
			}
        }
	}


}