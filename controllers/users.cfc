component singleton extends="coldbox.system.EventHandler" {


	// this.allowedMethods = {
	// 	list 		= "GET",
	// 	view 		= "GET",
	// 	create 		= "POST,GET",
	// 	remove 		= "DELETE",
	// 	patch 		= "PATCH",
	// 	options 	= "OPTIONS",
	// 	index 		= "GET"
	// };


	public any function view
	( event, rc, prc )
	{
		writedump( var=rc, label="rc" );
		abort;
	}


	public any function create
	( event, rc, prc )
	{
		writedump( var=deserializeJson( toString( getHTTPRequestData().content ) ), label="payload" );
		writedump( var=rc, label="rc" );
		abort;
	}


	public any function remove
	( event, rc, prc )
	{
		return "REMOVE";
	}


	public any function index
	( event, rc, prc )
	{
		return "<h1>Hello from my handler today at :#now()#</h1>";
	}



	public any function list
	( event, rc, prc )
	{
		event.paramValue( "format", "json" );
		prc.users = [
			{"id" = 1, "name" = "John Doe"},
			{"id" = 2, "name" = "Han Solo"},
			{"id" = 3, "name" = "Jack Ryan"}
		];

		switch( rc.format )
		{
			case "json" : case "jsonp" : case "xml" :
			{
				event.renderData( data=prc.users, type=rc.format );
				break;
			}
			case "pdf" :
			{
				event.renderData( data=renderView("users/simple"), type="pdf" );
				break;
			}
		};
		event.renderData
		(
			formats="json,jsonp,xml,pdf",
			statusCode = 200,
			statusText = "OK",
			data = prc.users
		);
	}


}