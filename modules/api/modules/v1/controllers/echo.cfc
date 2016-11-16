/**
* A normal ColdBox Event Handler
*/
component extends="api.controllers.baseHandler"
{


	/**
	* Echo API Version
	*/
	function index
	( event, rc, prc )
	{
		prc.response.setData( "Welcome to the API v1" );
	}


	/**
	* cached
	*/
	function cached
	( event, rc, prc )
	cache=true
	cacheTimeout="10"
	cacheLastAccessTimeout="5"
	{
		var data = [
			{ id=createUUID(), name="luis" },
			{ id=createUUID(), name="john" },
			{ id=createUUID(), name="brad" },
			{ id=createUUID(), name="jorge" }
		];
		prc.response
			.setFormat( rc.format ?: 'json' )
			.setData( data )
		;
	}


}