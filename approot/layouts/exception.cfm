<cfscript>
/*
	Use a placeholder for creating an exception object,
	regardless of where the exception is coming from.
 */
commonException = {
	"Detail" = "",
	"Message" = "",
	"Type" = "",
	"TagContext" = []
};
// There was an error thrown from the Application. Lowest level.
if ( isDefined( "error" ) && isStruct( error ) )
{
	commonException = {
		"Detail" = error.RootCause.Detail,
		"Message" = error.RootCause.Message,
		"Type" = error.RootCause.Type,
		"TagContext" = error.RootCause.TagContext
	};
}
// Error coming from ColdBox
else if ( isDefined( "oException" ) && isObject( oException ) )
{
	commonException = {
		"Detail" = oException.getDetail(),
		"Message" = oException.getMessage(),
		"Type" = oException.getType(),
		"TagContext" = oException.getTagContext()
	};
}
// Error coming from ColdFusion
else
{
	commonException = {
		"Detail" = exception.cause.detail,
		"Message" = exception.cause.message,
		"Type" = exception.cause.type,
		"TagContext" = exception.cause.tagContext
	};
}
// vars needed
responseErrors = [];
exceptionDetails = {};
errorID = "";
/*
	Try to log the error, and if it fails then show 2 exceptions in the response:
	one for the original error, and another one that the logging failed.
 */

exceptionDetails = {
	"Message" = commonException.message,
	"MessageDetail" = commonException.detail
};
// if ( application.apiSettings.environment != "production" )
// {
	exceptionDetails[ "ErrorID" ] = errorID;
	exceptionDetails[ "StackTrace" ] = commonException.tagContext;
// }
responseErrors.append( exceptionDetails );
cfcontent( reset=true );
cfheader( name="Content-Type", value="application/json" );
cfheader( statuscode="500", statustext="Error - ExceptionBaseApplication" );
writeOutput( serializeJSON( responseErrors ) );
</cfscript>