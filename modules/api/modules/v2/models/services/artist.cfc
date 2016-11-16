component singleton
{


	// DAOs
	property name="artistDao" inject="daos.artist@v2";
	// Framework Services
	property name="wirebox" inject="wirebox";


	public any function init()
	{
		return this;
	}


	/**
	 * @hint Returns the order details of a Single Resource
	 * @ID The user ID
	 */
	public any function getArtist
	( required numeric ID )
	{
		// Order Details Response Bean
		var responseViewBean = wirebox.getInstance( "beans.response.artistView@v2" );
		var artistDetails = artistDao.getArtistDetails( ID = arguments.ID );
		// If a record for order details is found
		if ( artistDetails.recordCount == 1 )
		{
			// populate the response Bean
			responseViewBean.populate( memento = artistDetails );
		}
		return responseViewBean;
	}


}