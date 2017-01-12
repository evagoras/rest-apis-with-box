/**
* My RESTFul Event Handler
*/
component extends="baseHandler" {

	// OPTIONAL HANDLER PROPERTIES
	this.prehandler_only 	= "";
	this.prehandler_except 	= "";
	this.posthandler_only 	= "";
	this.posthandler_except = "";
	this.aroundHandler_only = "";
	this.aroundHandler_except = "";

	// REST Allowed HTTP Methods Ex: this.allowedMethods = {delete='POST,DELETE',index='GET'}
	this.allowedMethods = {};

	/**
	* Index
	*/
	any function index( event, rc, prc ){
		prc.response.setData( "Welcome to my ColdBox RESTFul Service" );
	}

	/**
	* secure
	*/
	function secure( event, rc, prc ){
		return "<h1>Hello Hola</h1>";
	}

	/**
	* withPermissions
	*/
	function withPermissions( event, rc, prc ) secured="admin,write,whatever"{

		event.setView( "Echo.cfc/secure" );
	}
}