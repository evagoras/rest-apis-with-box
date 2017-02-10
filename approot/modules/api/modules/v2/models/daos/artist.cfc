component
singleton = true
{


	property name="dsn" inject="coldbox:datasource:gallery";
	property name="utils" inject="utils";


	function init()
	{
		return this;
	}


	public any function updateArtist
	( required any bean )
	{
		var startingSQL = "UPDATE artists SET ";
		var sql = [];
		var params = {};
		var propertiesToUpdate = arguments.bean.serialize();
		// var propertiesToUpdate = arguments.bean.serialize().keyArray();
		for ( var property in propertiesToUpdate )
		{
			switch ( property )
			{
				case "firstName":
					if ( propertiesToUpdate.keyExists( property ) )
					{
						sql.append( "firstName = :firstName");
						params[ "firstName" ] = {
							"cfsqltype" = "cf_sql_varchar",
							"value" = utils.removeBeginningChar2( propertiesToUpdate[ property ] )
						};
					}
					else
					{
						sql.append( "firstName = NULL");
					}
				break;
				case "lastName":
					if ( propertiesToUpdate.keyExists( property ) )
					{
						sql.append( "lastName = :lastName");
						params[ "lastName" ] = {
							"cfsqltype" = "cf_sql_varchar",
							"value" = utils.removeBeginningChar2( propertiesToUpdate[ property ] )
						};
					}
					else
					{
						sql.append( "lastName = NULL");
					}
				break;
				case "address":
					sql.append( "address = :address");
					params[ "address" ] = {
						"cfsqltype" = "cf_sql_varchar",
						"value" = ""
					};
					if ( propertiesToUpdate.keyExists( property ) )
					{
						params.address[ "value" ] = utils.removeBeginningChar2( propertiesToUpdate[ property ] );
					}
					else
					{
						params.address[ "null" ] = true;
					}
				break;
				case "city":
					sql.append( "city = :city");
					params[ "city" ] = {
						"cfsqltype" = "cf_sql_varchar",
						"value" = ""
					};
					if ( propertiesToUpdate.keyExists( property ) )
					{
						params.city[ "value" ] = utils.removeBeginningChar2( propertiesToUpdate[ property ] );
					}
					else
					{
						params.city[ "null" ] = true;
					}
				break;
				case "state":
					sql.append( "state = :state");
					params[ "state" ] = {
						"cfsqltype" = "cf_sql_varchar",
						"value" = ""
					};
					if ( propertiesToUpdate.keyExists( property ) )
					{
						params.state[ "value" ] = utils.removeBeginningChar2( propertiesToUpdate[ property ] );
					}
					else
					{
						params.state[ "null" ] = true;
					}
				break;
				case "postalCode":
					sql.append( "postalCode = :postalCode");
					params[ "postalCode" ] = {
						"cfsqltype" = "cf_sql_varchar",
						"value" = ""
					};
					if ( propertiesToUpdate.keyExists( property ) )
					{
						params.postalCode[ "value" ] = utils.removeBeginningChar2( propertiesToUpdate[ property ] );
					}
					else
					{
						params.postalCode[ "null" ] = true;
					}
				break;
				case "email":
					sql.append( "email = :email");
					params[ "email" ] = {
						"cfsqltype" = "cf_sql_varchar",
						"value" = ""
					};
					if ( propertiesToUpdate.keyExists( property ) )
					{
						params.email[ "value" ] = utils.removeBeginningChar2( propertiesToUpdate[ property ] );
					}
					else
					{
						params.email[ "null" ] = true;
					}
				break;
				case "phone":
					sql.append( "phone = :phone");
					params[ "phone" ] = {
						"cfsqltype" = "cf_sql_varchar",
						"value" = ""
					};
					if ( propertiesToUpdate.keyExists( property ) )
					{
						params.phone[ "value" ] = utils.removeBeginningChar2( propertiesToUpdate[ property ] );
					}
					else
					{
						params.phone[ "null" ] = true;
					}
				break;
				case "fax":
					sql.append( "fax = :fax");
					params[ "fax" ] = {
						"cfsqltype" = "cf_sql_varchar",
						"value" = ""
					};
					if ( propertiesToUpdate.keyExists( property ) )
					{
						params.fax[ "value" ] = utils.removeBeginningChar2( propertiesToUpdate[ property ] );
					}
					else
					{
						params.fax[ "null" ] = true;
					}
				break;
				case "active":
					sql.append( "active = :active");
					params[ "active" ] = {
						"cfsqltype" = "cf_sql_varchar",
						"value" = ""
					};
					if ( propertiesToUpdate.keyExists( property ) )
					{
						params.active[ "value" ] = utils.removeBeginningChar2( propertiesToUpdate[ property ] );
					}
					else
					{
						params.active[ "null" ] = true;
					}
				break;
			}
		}
		var endingSQL = " WHERE ARTISTID = :artistID";
		params[ "artistID" ] = {
			"cfsqltype" = "cf_sql_integer",
			"value" = propertiesToUpdate[ "ID" ]
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


	public any function getArtists
	(
		required numeric offset,
		required numeric limit
	)
	{
		var qry = queryExecute
		(
			'
				SELECT *, 0 as totalcount
				FROM artists
				order by "ARTISTID" DESC
				LIMIT :limit
				OFFSET :offset
			',
			{
				offset = {
					cfsqltype = "cf_sql_integer",
					value = arguments.offset
				},
				limit = {
					cfsqltype = "cf_sql_integer",
					value = arguments.limit
				}
			},
			{ datasource = dsn.name }
		);
		var qryCount = queryExecute
		(
			'
				SELECT count(*) as totalcount
				FROM artists
			',
			{},
			{ datasource = dsn.name }
		);
		for ( var row=1; row <= qry.recordcount; row++ )
		{
			querySetCell( qry, "totalcount", qryCount.totalcount, row );
		}
		return qry;
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