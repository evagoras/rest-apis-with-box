component
{


	private string function getCFEngine()
	{
		var engine = "adobe";
		if ( server.coldfusion.productname == "Railo" )
		{
			engine = "railo";
		}
		else if ( server.coldfusion.productname == "Lucee" )
		{
			engine = "lucee";
		}
		return engine;
	}


	/**
	 * @hint Uses underlying Java functionality to change a QUERY into a STRUCT
	 * @memento The query data to transform
	 */
	private struct function queryToStructA
	( required query memento )
	{
		var data = {};
		// get array of query columns in the proper case as defined in the SELECT query
		if ( getCFEngine() == "adobe" )
		{
			var queryColumns = arguments.memento.getMetaData().getColumnLabels();
		}
		else
		{
			var queryColumns = arguments.memento.getColumnList( false );
		}
		// loop through the query and construct valid data and nulls
		for ( var column in queryColumns )
		{
			// java hooks for determining if a column is really a NULL
			if
			(
				isQueryColumnNull
				(
					qry = arguments.memento,
					column = column
				)
			)
			{
				data[ column ] = javaCast( "null", 0 );
			}
			else
			{
				data[ column ] = arguments.memento[ column ][ 1 ];
			}
		}
		return data;
	}


	/**
	 * @hint Java underlying checks for a query NULL value in a column
	 * @qry The query to check against
	 * @column The column name in the query
	 * @row The row to check against
	 */
	private any function isQueryColumnNull
	(
		required query qry,
		required string column,
		numeric row = 1
	)
	{
		arguments.qry.absolute( row );
		var value = arguments.qry.getObject( column );
		var valueIsNull = isNull( value );
		return valueIsNull;
	}



	private any function QueryToStruct
	(
		required query Query,
		numeric row = 0
	)
	{

		// Define the local scope.
		var LOCAL = StructNew();

		// Determine the indexes that we will need to loop over.
		// To do so, check to see if we are working with a given row,
		// or the whole record set.
		if ( arguments.row ){

			// We are only looping over one row.
			LOCAL.FromIndex = arguments.row;
			LOCAL.ToIndex = arguments.row;

		} else {

			// We are looping over the entire query.
			LOCAL.FromIndex = 1;
			LOCAL.ToIndex = arguments.Query.RecordCount;

		}

		// Get the list of columns as an array and the column count.
		LOCAL.Columns = ListToArray( arguments.Query.ColumnList );
		LOCAL.ColumnCount = ArrayLen( LOCAL.Columns );

		// Create an array to keep all the objects.
		LOCAL.DataArray = ArrayNew( 1 );

		// Loop over the rows to create a structure for each row.
		for (LOCAL.rowIndex = LOCAL.FromIndex ; LOCAL.rowIndex LTE LOCAL.ToIndex ; LOCAL.rowIndex = (LOCAL.rowIndex + 1)){

			// Create a new structure for this row.
			ArrayAppend( LOCAL.DataArray, StructNew() );

			// Get the index of the current data array object.
			LOCAL.DataArrayIndex = ArrayLen( LOCAL.DataArray );

			// Loop over the columns to set the structure values.
			for (LOCAL.ColumnIndex = 1 ; LOCAL.ColumnIndex LTE LOCAL.ColumnCount ; LOCAL.ColumnIndex = (LOCAL.ColumnIndex + 1)){

				// Get the column value.
				LOCAL.ColumnName = LOCAL.Columns[ LOCAL.ColumnIndex ];

				// Set column value into the structure.
				LOCAL.DataArray[ LOCAL.DataArrayIndex ][ LOCAL.ColumnName ] = arguments.Query[ LOCAL.ColumnName ][ LOCAL.rowIndex ];

			}

		}


		// At this point, we have an array of structure objects that
		// represent the rows in the query over the indexes that we
		// wanted to convert. If we did not want to convert a specific
		// record, return the array. If we wanted to convert a single
		// row, then return the just that STRUCTURE, not the array.
		if (arguments.row){

			// Return the first array item.
			return( LOCAL.DataArray[ 1 ] );

		} else {

			// Return the entire array.
			return( LOCAL.DataArray );

		}
	}


}