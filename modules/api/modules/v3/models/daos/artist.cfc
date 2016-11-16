component
	singleton = true
{


	property name="dsn" inject="coldbox:datasource:gallery";


	function init()
	{
		return this;
	}


	/**
	 * @hint Returns a CF Query of an User details
	 * @ID The User ID
	 */
	public query function getArtistDetails
	( required numeric ID )
	{
		var qry = queryExecute
		(
			'
				SELECT *
				FROM artists
				WHERE ARTISTID = :ID
			',
			{
				ID = {
					cfsqltype = "cf_sql_integer",
					value = arguments.ID
				}
			},
			{ datasource = dsn.name }
		);
		return qry;
	}


}