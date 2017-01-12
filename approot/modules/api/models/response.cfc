/**
* ********************************************************************************
* Copyright 2005-2007 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
* www.ortussolutions.com
* ********************************************************************************
* HTTP Response model, spice up as needed
*/
component accessors="true" {

	property name="utils" inject="utils";
	property name="environment" inject="coldbox:setting:environment";
	property name="pagingSetings" inject="coldbox:setting:paging";


	property name="format" 			type="string" 		default="plain";
	property name="data" 			type="any"			default="";
	property name="error" 			type="boolean"		default="false";
	property name="binary" 			type="boolean"		default="false";
	property name="messages" 		type="array";
	property name="location" 		type="string"		default="";
	property name="jsonCallback" 	type="string"		default="";
	property name="jsonQueryFormat" type="string"		default="query";
	property name="contentType" 	type="string"		default="";
	property name="statusCode" 		type="numeric"		default=200;
	property name="statusText" 		type="string"		default="OK";
	property name="errorCode"		type="numeric"		default=0;
	property name="responsetime"	type="numeric"		default=0;
	property name="cachedResponse" 	type="boolean"		default=false;
	property name="headers" 		type="array";
	// custom properties
	property name="totalCount" 		type="numeric" 		default=0;
	property name="url" 			type="string" 		default="";
	property name="link" 			type="string" 		default="";


	/**
	* Constructor
	*/
	Response function init(){
		// Init properties
		variables.format 			= "plain";
		variables.data 				= "";
		variables.error 			= false;
		variables.binary 			= false;
		variables.messages 			= [];
		variables.location 			= "";
		variables.jsonCallBack 		= "";
		variables.jsonQueryFormat 	= "query";
		variables.contentType 		= "";
		variables.statusCode 		= 200;
		variables.statusText 		=  "OK";
		variables.errorCode			= 0;
		variables.responsetime		= 0;
		variables.cachedResponse 	= false;
		variables.headers 			= [];
		// init custom properties
		variables.totalCount		= 0;
		variables.url				= "";
		variables.link				= "";

		return this;
	}

	/**
	* Add some messages
	* @message Array or string of message to incorporate
	*/
	function addMessage( required any message ){
		if( isSimpleValue( arguments.message ) ){ arguments.message = listToArray( arguments.message ); }
		variables.messages.addAll( arguments.message );
		return this;
	}

	/**
	* Add a header
	* @name header name
	* @value header value
	*/
	function addHeader( required string name, required string value ){
		arrayAppend( variables.headers, { name=arguments.name, value=arguments.value } );
		return this;
	}

	/**
	* Returns a standard response formatted data packet
	*/
	// function getDataPacket() {
		// return {
		// 	"error" 		 = variables.error ? true : false,
		// 	"errorcode"		 = variables.errorCode,
		// 	"messages" 		 = variables.messages,
		// 	"data" 			 = variables.data
		// };
		// return variables.data;
	// }


	/**
	 * @hint Adds the pagination headers and returns the data
	 */
	public any function getPagingData()
	{
		if ( getTotalCount() > 0 )
			addPaginationHeaders()
		;
		return getData();
	}


	/**
	 * @hint Calculates and populates the pagination properties.
	 */
	public void function addPaginationHeaders()
	{
		urlParams = {
			"offset" = 0,
			"limit" = variables.pagingSetings.maxDefault
		};
		urlParts = getUrl().listToArray( "?" );
		if ( urlParts.len() > 1 )
		{
			for ( var param in urlParts[ 2 ].listToArray( "&" ) )
			{
				urlParams[ param.listGetAt( 1, "=" ) ] = param.listLen( "=" ) > 1
					? param.listGetAt( 2, "=" )
					: ""
				;
			}
		}
		// Create the pagination keys and their corresponding values.
		var paging = utils.createPaginationSchema
		(
			total = getTotalCount(),
			offset = urlParams.offset,
			limit = urlParams.limit
		);
		// Holder for any link headers which will need to be added.
		var linkHeaders = [];
		for ( var key in paging )
		{
			/*
				Only use the paging keys which actually have
				pagination values.
			 */
			if ( paging[ key ].count() > 0 )
			{
				paging[ key ].append( urlParams, false );
				variables[ key & "Url" ] =
					urlParts[ 1 ] &
					"?" &
					utils.structToList
					(
						s = paging[ key ],
						delimiter = "&"
					)
				;
				linkHeaders.append( '<' & variables[ key & "Url" ] & '>; rel="' & key & '"' );
			}
		}
		// Set the link property value
		setLink( linkHeaders.toList( ", " ) );
		// Add needed headers
		addHeader( "X-Total-Count", getTotalCount() );
		addHeader( "Link", getLink() );
	}


}