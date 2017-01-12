component
singleton = true
{


	property name="dsn" inject="coldbox:datasource:gallery";


	function init()
	{
		return this;
	}


	public any function updateArtist
	( required any bean )
	{
		// dump(arguments.bean);abort;
		var startingSQL = "UPDATE artists SET ";
		var sql = [];
		var params = {};
		sql.append( "firstName = :firstName")
		params[ "firstName" ] = {
			"cfsqltype" = "cf_sql_varchar",
			"value" = arguments.bean.getFirstName()
		};
		sql.append( "lastName = :lastName")
		params[ "lastName" ] = {
			"cfsqltype" = "cf_sql_varchar",
			"value" = arguments.bean.getLastName()
		};
		sql.append( "address = :address")
		params[ "address" ] = {
			"cfsqltype" = "cf_sql_varchar",
			"value" = arguments.bean.getAddress()
		};
		sql.append( "city = :city")
		params[ "city" ] = {
			"cfsqltype" = "cf_sql_varchar",
			"value" = arguments.bean.getCity()
		};
		sql.append( "state = :state")
		params[ "state" ] = {
			"cfsqltype" = "cf_sql_varchar",
			"value" = arguments.bean.getstate()
		};
		sql.append( "postalCode = :postalCode")
		params[ "postalCode" ] = {
			"cfsqltype" = "cf_sql_varchar",
			"value" = arguments.bean.getpostalCode()
		};
		sql.append( "email = :email")
		params[ "email" ] = {
			"cfsqltype" = "cf_sql_varchar",
			"value" = arguments.bean.getemail()
		};
		sql.append( "phone = :phone")
		params[ "phone" ] = {
			"cfsqltype" = "cf_sql_varchar",
			"value" = arguments.bean.getphone()
		};
		sql.append( "fax = :fax")
		params[ "fax" ] = {
			"cfsqltype" = "cf_sql_varchar",
			"value" = arguments.bean.getfax()
		};
		sql.append( "active = :active")
		params[ "active" ] = {
			"cfsqltype" = "cf_sql_varchar",
			"value" = arguments.bean.getactive()
		};
		var endingSQL = " WHERE ARTISTID = :artistID";
		params[ "artistID" ] = {
			"cfsqltype" = "cf_sql_integer",
			"value" = arguments.bean.getID()
		};
		var sqlQuery = startingSQL & sql.toList( ", " ) & endingSQL;
		var qry = queryExecute
		(
			sqlQuery,
			params,
			{
				datasource = dsn.name,
				result = "qryResult"
			}
		);
		return qryResult.recordcount;
	}


	public boolean function removeArtist
	( required numeric artistID )
	{
		queryExecute
		(
			'
				DELETE FROM artists
				WHERE ARTISTID = :artistID
			',
			{
				artistID = {
					cfsqltype = "cf_sql_integer",
					value = arguments.artistID
				}
			},
			{
				datasource = dsn.name,
				result = "qryResults"
			}
		);
		return qryResults.recordcount;
	}


	// public any function getArtists
	// (
	// 	required numeric offset,
	// 	required numeric limit
	// )
	// {
	// 	var qry = queryExecute
	// 	(
	// 		'
	// 			SELECT *, 0 as totalcount
	// 			FROM artists
	// 			order by "ARTISTID" DESC
	// 			LIMIT :limit
	// 			OFFSET :offset
	// 		',
	// 		{
	// 			offset = {
	// 				cfsqltype = "cf_sql_integer",
	// 				value = arguments.offset
	// 			},
	// 			limit = {
	// 				cfsqltype = "cf_sql_integer",
	// 				value = arguments.limit
	// 			}
	// 		},
	// 		{ datasource = dsn.name }
	// 	);
	// 	var qryCount = queryExecute
	// 	(
	// 		'
	// 			SELECT count(*) as totalcount
	// 			FROM artists
	// 		',
	// 		{},
	// 		{ datasource = dsn.name }
	// 	);
	// 	for ( var row=1; row <= qry.recordcount; row++ )
	// 	{
	// 		querySetCell( qry, "totalcount", qryCount.totalcount, row );
	// 	}
	// 	return qry;
	// }


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