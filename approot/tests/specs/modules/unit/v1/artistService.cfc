component extends="coldbox.system.testing.BaseTestCase"
{


	function beforeAll()
	{
		super.beforeAll();
	}


	function afterAll()
	{
		super.afterAll();
	}


	function run( testResults, testBox )
	{

		describe( "Given I call the function 'getUser' in the Service layer", function() {

			beforeEach( function( currentSpec ) {
			});

			afterEach( function( currentSpec ) {
			});

			it( title="It should return a populated Response object with valid data if the DAO returns a valid query", body=function( data ) {
				// construct a mocked query of a User
				// var validUserQuery = getValidArtistQuery();
				// // Mock the DAO
				// var mockedUserDAO = new approot.modules.v1.models.daos.pws.user();
				// createEmptyMock( object = mockedUserDAO );
				// mockedUserDAO.$( "getUserQuery", validUserQuery );
				// // mock the Validator Service
				// var mockedValidatorService = new approot.modules.v1.models.services.validator();
				// createEmptyMock( object = mockedValidatorService );
				// mockedValidatorService.$( "validateID", {} );
				// // Mock the Service
				// var userService = new approot.modules.v1.models.services.pws.user();
				// prepareMock( object = userService );
				// userService
				// 	.$property( propertyName = "userDao", mock = mockedUserDAO )
				// 	.$property( propertyName = "wirebox", mock = getWireBox() )
				// 	.$property( propertyName = "validatorService", mock = mockedValidatorService );
				// // call the service method passing the same userCode as the query above
				// var userResponse = userService.getUser( userCode = 100 );

				// // expectations
				// expect( userResponse ).toBeInstanceOf( "approot.modules.v1.models.beans.response" );
				// expect( userResponse.getStatusCode() ).toBe( 200 );
				// expect( userResponse.getStatusText() ).toBe( "OK" );
				// expect( userResponse.getContentType() ).toBe( "application/json" );
				// expect( userResponse.getFormat() ).toBe( "plain" );

				// var responseData = userResponse.getData();
				// expect( responseData ).toBeInstanceOf( "approot.modules.v1.models.beans.response.pws.user" );

				// var deserializedResponseData = deserializeJson( responseData.serializeAs( "json" ) );
				// expect( deserializedResponseData ).toBeStruct();

				// expect( deserializedResponseData[ "defaultLanguage" ] ).toBe( validUserQuery["defaultLanguage"][ 1 ] );
				// expect( deserializedResponseData[ "title" ] ).toBe( validUserQuery["title"][ 1 ] );
				// expect( deserializedResponseData[ "firstName" ] ).toBe( validUserQuery["firstName"][ 1 ] );
				// expect( deserializedResponseData[ "familyName" ] ).toBe( validUserQuery["familyName"][ 1 ] );
				// expect( deserializedResponseData[ "email" ] ).toBe( validUserQuery["email"][ 1 ] );
				// expect( deserializedResponseData[ "firstNameNative" ] ).toBe( validUserQuery["firstNameNative"][ 1 ] );
				// expect( deserializedResponseData[ "familyNameNative" ] ).toBe( validUserQuery["familyNameNative"][ 1 ] );
				// expect( deserializedResponseData[ "position" ] ).toBe( validUserQuery["position"][ 1 ] );
				// expect( deserializedResponseData[ "privacy" ] ).toBe( "AllMarketing" );
				// expect( deserializedResponseData[ "distributorID" ] ).toBe( validUserQuery["distributorID"][ 1 ] );

			}, data={} );

			// check the return
			it( title="It should return a 'BadRequestException' if the DAO 'getUserQuery()' returns a 500", body=function( data ) {
				// construct a mocked query of a User
				// var emptyUserQuery = getEmptyUserQuery();
				// // Mock the DAO
				// var mockedUserDAO = new approot.modules.v1.models.daos.pws.user();
				// createEmptyMock( object = mockedUserDAO );
				// // Mock the exception
				// var exceptionMessage = "Legacy Code Message";
				// var exceptionType = "BadRequestException";
				// var exceptionDetail = "Legacy Code Detail";
				// var mockedDaoWithException = createMock( object = mockedUserDAO ).$
				// (
				// 	method = "getUserQuery",
				// 	throwException = true,
				// 	throwType = exceptionType,
				// 	throwMessage = exceptionMessage,
				// 	throwDetail = exceptionDetail
				// );
				// // mock the Validator Service
				// var mockedValidatorService = new approot.modules.v1.models.services.validator();
				// createEmptyMock( object = mockedValidatorService );
				// mockedValidatorService.$( "validateID", {} );
				// // Mock the Service
				// var userService = new approot.modules.v1.models.services.pws.user();
				// prepareMock( object = userService );
				// userService
				// 	.$property( propertyName = "userDao", mock = mockedUserDAO )
				// 	.$property( propertyName = "wirebox", mock = getWireBox() )
				// 	.$property( propertyName = "validatorService", mock = mockedValidatorService );
				// // The ID of the User to get
				// var userCode = 200;
				// /*
				// Call the service method passing the same userCode as the query above,
				// and run all expectations in the CATCH
				//  */
				// expect
				// (
				// 	function()
				// 	{
				// 		userService.getUser( userCode = userCode );
				// 	}
				// )
				// .toThrow
				// (
				// 	type = exceptionType
				// );
				// try
				// {
				// 	userService.getUser( userCode = userCode );
				// }
				// catch ( any exception )
				// {
				// 	expect( exception.type ).toBe( exceptionType );
				// 	expect( exception.message ).toBe( exceptionMessage );
				// 	expect( exception.detail ).toBe( exceptionDetail );
				// }
			}, data={} );

			it( title="It should return a 'ResourceNotFoundException' if the DAO 'getUserQuery()' returns no results", body=function( data ) {
				// The ID of the User to get
				// var userCode = 200;
				// // construct a mocked query of a User
				// var emptyUserQuery = getEmptyUserQuery();
				// // Mock the DAO
				// var mockedUserDAO = new approot.modules.v1.models.daos.pws.user();
				// createEmptyMock( object = mockedUserDAO );
				// mockedUserDAO.$( "getUserQuery", emptyUserQuery );
				// // Mock the exception
				// var exceptionMessage = "No such user exists.";
				// var exceptionDetail = "User with userCode #userCode# not found.";
				// var exceptionType = "ResourceNotFoundException";
				// // mock the Validator Service
				// var mockedValidatorService = new approot.modules.v1.models.services.validator();
				// createEmptyMock( object = mockedValidatorService );
				// mockedValidatorService.$( "validateID", {} );
				// // Mock the Service
				// var userService = new approot.modules.v1.models.services.pws.user();
				// prepareMock( object = userService );
				// userService
				// 	.$property( propertyName = "userDao", mock = mockedUserDAO )
				// 	.$property( propertyName = "wirebox", mock = getWireBox() )
				// 	.$property( propertyName = "validatorService", mock = mockedValidatorService );
				// /*
				// Call the service method passing the same userCode as the query above,
				// and run all expectations in the CATCH
				//  */
				// expect(
				// 	function()
				// 	{
				// 		userService.getUser( userCode = userCode );
				// 	}
				// )
				// .toThrow
				// (
				// 	type = exceptionType
				// );
				// try
				// {
				// 	userService.getUser( userCode = userCode );
				// }
				// catch ( any exception )
				// {
				// 	expect( exception.type ).toBe( exceptionType );
				// 	expect( exception.message ).toBe( exceptionMessage );
				// 	expect( exception.detail ).toBe( exceptionDetail );
				// }
			}, data={} );

		});

	}


	// private any function getWireBox()
	// {
	// 	var responseBean = new approot.modules.v1.models.beans.response();
	// 	var model = createEmptyMock( "coldbox.system.ioc.Injector" );
	// 	model.$( "getInstance" ).$args( "beans.response.pws.user@v1" ).$results( getUser() );
	// 	model.$( "getInstance" ).$args( "beans.response@v1" ).$results( responseBean );
	// 	return model;
	// }

	// private any function getUser()
	// {
	// 	var userResponse = createObject( "component", "approot.modules.v1.models.beans.response.pws.user" ).init();
	// 	prepareMock( object = userResponse );
	// 	var mockedUtils = new approot.models.utils();
	// 	prepareMock( object = mockedUtils );
	// 	userResponse
	// 		.$property( propertyName = "nullValueReplacementToken", mock = "[---MyCustomNullValueReplacementToken---]" )
	// 		.$property( propertyName = "utils", mock = mockedUtils )
	// 	;
	// 	return userResponse;
	// }


	// private query function getValidArtistQuery()
	// {
	// 	var validArtistQuery = getEmptyArtistQuery();
	// 	queryAddRow( validArtistQuery, 1 );
	// 	querySetCell( validArtistQuery, "firstName", 	"my first name", 		1 );
	// 	querySetCell( validArtistQuery, "lastName", 	"my last name", 		1 );
	// 	querySetCell( validArtistQuery, "address", 		"my address", 			1 );
	// 	querySetCell( validArtistQuery, "city", 		"my city", 				1 );
	// 	querySetCell( validArtistQuery, "state", 		"my state", 			1 );
	// 	querySetCell( validArtistQuery, "postalCode", 	"my postal code", 		1 );
	// 	querySetCell( validArtistQuery, "email", 		"myemail@test.com", 	1 );
	// 	querySetCell( validArtistQuery, "phone", 		"123456789", 			1 );
	// 	querySetCell( validArtistQuery, "fax", 			"987654321", 			1 );
	// 	return validArtistQuery;
	// }


	// private query function getEmptyArtistQuery()
	// {
	// 	var userQuery = queryNew
	// 	(
	// 		"firstName,lastName,address,city,state,postalCode,email,phone,fax",
	// 		"varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar"
	// 	);
	// 	return userQuery;
	// }


}