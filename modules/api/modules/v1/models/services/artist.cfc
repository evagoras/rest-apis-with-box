component singleton
{


	// DAOs
	property name="artistDao" inject="daos.artist@v1";
	// Framework Services
	property name="wirebox" inject="wirebox";


	public any function init()
	{
		return this;
	}


	public any function getArtists
	(
		required numeric offset,
		required numeric limit
	)
	{
		var responseBean = wirebox.getInstance( "response@api" );
		var artistCollection = [];
		var artists = artistDao.getArtists
		(
			offset = arguments.offset,
			limit = arguments.limit
		);
		if ( artists.recordCount == 0 )
		{
			responseBean
				.setFormat( "json" )
				.setStatusCode( 200 )
				.setStatusText( "OK" )
				.setData( [] )
			;
		}
		else
		{
			var totalCount = artists.totalCount[ 1 ];
			for
			(
				var row = 1;
				row <= artists.recordCount;
				row++
			)
			{
				var order = artists.getRow( row );
				var artistResponseBean = wirebox.getInstance( "beans.response.artistList@v1" );
				artistResponseBean.populate( order );
				artistCollection.append( artistResponseBean );
			}
			responseBean
				.setStatusCode( 200 )
				.setStatusText( "OK" )
				.setContentType( "application/json" )
				.setTotalCount( totalCount )
				.setData( artistCollection )
			;
		}
		return responseBean;
	}


	/**
	 * @hint Returns the order details of a Single Resource
	 * @ID The user ID
	 */
	// public any function getArtist
	// ( required numeric ID )
	// {
	// 	// Order Details Response Bean
	// 	var responseViewBean = wirebox.getInstance( "beans.response.artistView@v1" );
	// 	var artistDetails = artistDao.getArtistDetails( ID = arguments.ID );
	// 	// If a record for order details is found
	// 	if ( artistDetails.recordCount == 1 )
	// 	{
	// 		// populate the response Bean
	// 		responseViewBean.populate( memento = artistDetails );
	// 	}
	// 	return responseViewBean;
	// }


}