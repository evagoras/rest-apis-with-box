component singleton
{


	public any function init()
	{
		return this;
	}


	/**
	 * @hint Converts struct into delimited key/value list
	 * @s Structure. (Required)
	 * @excludeKeys Array of keys to not include in the output
	 * @delimiter Defaults to a comma
	 * @author Greg Nettles (gregnettles@calvarychapel.com)
	 * @version 2, July 25, 2006
	 */
	public string function structToList
	(
		struct s = {},
		array excludeKeys = [],
		string delimiter = ","
	)
	{
		for ( var excludeKey in arguments.excludeKeys ) {
			arguments.s.delete( excludeKey );
		}
		var params = [];
		for ( var key in arguments.s ) {
			params.append( key & "=" & arguments.s[ key ] );
		}
		return params.toList( arguments.delimiter );
	}


	public struct function createPaginationSchema
	(
		required numeric total,
		required numeric offset,
		required numeric limit
	)
	{
		var paging = {
			"next" = {},
			"last" = {},
			"prev" = {},
			"first" = {}
		};
		if ( arguments.offset > 0 )
		{
			// prev
			paging.prev[ "offset" ] = arguments.offset - arguments.limit;
			if ( arguments.offset > arguments.total )
				paging.prev.offset = arguments.total - arguments.limit
			;
			if ( paging.prev.offset < 0 )
				paging.prev.offset = 0
			;
			paging.prev[ "limit" ] = arguments.limit;
			if ( paging.prev.limit > arguments.offset )
				paging.prev.limit = arguments.offset
			;
			if ( arguments.limit > arguments.total )
				paging.prev.limit = arguments.total
			;
			// first
			paging.first[ "offset" ] = 0;
			paging.first[ "limit" ] = arguments.limit;
			if ( paging.first.limit > arguments.offset )
				paging.first.limit = arguments.offset
			;
			if ( arguments.limit > arguments.total )
				paging.prev.limit = paging.first.limit = arguments.total
			;
		}
		if ( arguments.total > ( arguments.offset + arguments.limit ) )
		{
			// next
			paging.next[ "offset" ] = arguments.offset + arguments.limit;
			if ( paging.next.offset > arguments.total )
				paging.next.offset = arguments.offset
			;
			paging.next[ "limit" ] = arguments.limit;
			if ( ( paging.next.offset + paging.next.limit ) > arguments.total )
				paging.next.limit = arguments.total - paging.next.offset
			;
			// last
			paging.last[ "offset" ] = arguments.total - arguments.limit;
			if ( paging.last.offset < ( arguments.offset + arguments.limit ) )
				paging.last.offset = arguments.offset + arguments.limit
			;
			if ( paging.last.offset < 0 )
				paging.last.offset = 0
			;
			paging.last[ "limit" ] = arguments.limit;
			if ( ( paging.last.offset + paging.last.limit ) > arguments.total )
				paging.last.limit = arguments.total - paging.last.offset
			;
		}
		/*
			Special case when the offset was bigger than the total.
			Add the "last" key when this is the case.
		 */
		if ( arguments.offset >= arguments.total )
		{
			paging.last[ "offset" ] = arguments.total - arguments.limit;
			paging.last[ "limit" ] = arguments.limit;
		}
		return paging;
	}


	/**
	 * @hint Formats a date into the ISO-8601 format
	 */
	public string function getIsoTimeString
	(
		string datetime = "",
		boolean convertToUTC = true
	)
	{
		if ( len(arguments.dateTime ) ) {
			if ( convertToUTC )
				arguments.datetime = dateConvert( "local2utc", arguments.datetime )
			;
			/*
				When formatting the time, make sure to use "HH" so that the
				time is formatted using 24-hour time.
			 */
			return
			(
				dateFormat( arguments.datetime, "yyyy-mm-dd" ) &
				"T" &
				timeFormat( arguments.datetime, "HH:mm:ss" ) &
				"Z"
			);
		}
		else {
			//return arguments.dateTime;
			return javaCast("null", 0);
		}
	}


	/**
	 * @hint Returns the partial or full URL of the request
	 * @serverCGI The CGI scope of the server
	 * @includeHost Wherther to include the cgi.http_host part
	 */
	public string function getRequestUrl
	(
		required struct serverCGI,
		boolean includeHost = false
	)
	{
		var out = "";
		if ( arguments.includeHost )
		{
			var out &= "http";
			if ( arguments.serverCGI.https eq "on" )
				out &= "s"
			;
			out &= "://" & arguments.serverCGI.http_host;
		}
		out	&= arguments.serverCGI.path_info;
		if ( len( arguments.serverCGI.query_string ) )
			out &= "?" & arguments.serverCGI.query_string
		;
		return out;
	}


	public any function removeBeginningChar2
	( required any value )
	{
		if ( ! isNull( arguments.value ) && left( arguments.value, 1 ) == chr( 2 ) )
		{
			if ( arguments.value.len() == 1 )
			{
				return "";
			}
			else
			{
				return arguments.value.right( len( arguments.value ) - 1 );
			}
		}
		else
		{
			return arguments.value;
		}
	}


	public any function removeChar2
	( required any value )
	{
		var returnValue = arguments.value;
		if ( isNull( arguments.value ) )
		{
			return arguments.value;
		}
		else
		{
			returnValue = replaceNoCase( arguments.value, chr( 2 ), "", "all" );
			returnValue = replace( returnValue, "\u0002", "", "all" );
		}
		return returnValue;
	}


	public any function removeChar
	(
		required any value,
		required numeric character
	)
	{
		if ( isNull( arguments.value ) )
		{
			return arguments.value;
		}
		else
		{
			return replaceNoCase( arguments.value, chr( arguments.character ), "", "all" );
		}
	}


	public any function convertUKDateTimeToUTC
	(
		required string datetime,
		string timezone="Europe/London"
	)
	{
		var dateTimeToConvert = new approot.models.moment
		(
			time = arguments.datetime,
			zone = arguments.timezone
		);

		if ( dateTimeToConvert.isDST() )
		{
			return dateConvert( "local2utc", arguments.dateTime );
		}
		else
		{
			return dateConvert( "utc2local", arguments.dateTime );
		}
	}


	/**
	 * @hint Returns the key value of a structure or NULL if not found or undefined
	 * @memento The struct to look in
	 * @key The name of the key to look for
	 */
	public any function getStructKeyValueOrNull
	(
		required struct memento,
		required string key
	)
	{
		if ( arguments.memento.keyExists( arguments.key ) )
		{
			return arguments.memento[ arguments.key ];
		}
		else
		{
			return javacast( "null", 0 );
		}
	}


	/**
	 * @hint Strips out all characters that are not normal
	 * @input The string to work against
	 */
	public string function removeInvalidCharacters
	( required string input )
	{
		input = javaCast( "string", input );
		var length = input.length();
		var cleanText = "";
		var javaCharacterObj = createObject( "java", "java.lang.Character" );
		for ( var i = 1 ; i <= length ; i++ )
		{
			var charCode = input.codePointAt( javaCast( "int", i - 1 ) );
			var character = input.mid( i, 1 );
			if
			(
				charCode < 32
				||
				javaCharacterObj.isWhitespace( character ) == true
			)
			{
				cleanText &= " ";
			}
			else
			{
				cleanText &= chr( charCode );
			}
		}
		// change input into an array to eliminate extraneous spaces
		var words = cleanText.listToArray( " " );
		// concatenate the input back from the array
		return words.toList( " " );
	}


}