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

		describe( "Given I call the function 'getArtistDetails' in the Service layer", function() {

			beforeEach( function( currentSpec ) {
			});

			afterEach( function( currentSpec ) {
			});

			it( title="It should return a populated Response ArtistView object with valid data if the DAO returns a valid query", body=function( data ) {
				// // construct a mocked query of a User
				// var validArtistQuery = getValidArtistQuery();
				// // Mock the DAO
				// var mockedArtistDAO = new modules.api.modules.v1.models.daos.artist();
				// createEmptyMock( object = mockedArtistDAO );
				// mockedArtistDAO.$( "getArtistDetails", validArtistQuery );
				// // Mock the Service
				// var artistService = new modules.api.modules.v1.models.services.artist();
				// prepareMock( object = artistService );
				// artistService
				// 	.$property( propertyName = "artistDao", mock = mockedArtistDAO )
				// 	.$property( propertyName = "wirebox", mock = getWireBox() )
				// ;
				// // call the service method passing the same userCode as the query above
				// var artistViewResponse = artistService.getArtist( ID = 100 );

				// // expectations
				// expect( artistViewResponse ).toBeInstanceOf( "modules.api.modules.v1.models.beans.response.artistView" );
				// expect( artistViewResponse.isPopulated() ).toBeTrue();

				// var deserializedResponseData = deserializeJson( artistViewResponse.serializeAs( "json" ) );
				// expect( deserializedResponseData ).toBeStruct();

				// expect( deserializedResponseData[ "firstName" ] ).toBe( validArtistQuery["firstName"][ 1 ] );
				// expect( deserializedResponseData[ "lastName" ] ).toBe( validArtistQuery["lastName"][ 1 ] );
				// expect( deserializedResponseData[ "address" ] ).toBe( validArtistQuery["address"][ 1 ] );
				// expect( deserializedResponseData[ "city" ] ).toBe( validArtistQuery["city"][ 1 ] );
				// expect( deserializedResponseData[ "state" ] ).toBe( validArtistQuery["state"][ 1 ] );
				// expect( deserializedResponseData[ "postalCode" ] ).toBe( validArtistQuery["postalCode"][ 1 ] );
				// expect( deserializedResponseData[ "email" ] ).toBe( validArtistQuery["email"][ 1 ] );
				// expect( deserializedResponseData[ "phone" ] ).toBe( validArtistQuery["phone"][ 1 ] );
				// expect( deserializedResponseData[ "fax" ] ).toBe( validArtistQuery["fax"][ 1 ] );

			}, data={} );

			it( title="It should return an empty Response ArtistView object with no data if the DAO returns an empty query", body=function( data ) {
				// construct a mocked query of a User
				// var emptyArtistQuery = getEmptyArtistQuery();
				// // Mock the DAO
				// var mockedArtistDAO = new modules.api.modules.v1.models.daos.artist();
				// createEmptyMock( object = mockedArtistDAO );
				// mockedArtistDAO.$( "getArtistDetails", emptyArtistQuery );
				// // Mock the Service
				// var artistService = new modules.api.modules.v1.models.services.artist();
				// prepareMock( object = artistService );
				// artistService
				// 	.$property( propertyName = "artistDao", mock = mockedArtistDAO )
				// 	.$property( propertyName = "wirebox", mock = getWireBox() )
				// ;
				// // call the service method passing the same userCode as the query above
				// var artistViewResponse = artistService.getArtist( ID = 100 );

				// // expectations
				// expect( artistViewResponse ).toBeInstanceOf( "modules.api.modules.v1.models.beans.response.artistView" );
				// expect( artistViewResponse.isPopulated() ).toBeFalse();

				// writedump( artistViewResponse.serializeAs( "json" ) ); abort;

				// var deserializedResponseData = deserializeJson( artistViewResponse.serializeAs( "json" ) );
				// expect( deserializedResponseData ).toBeStruct();

			}, data={} );

		});

	}


	// private any function getWireBox()
	// {
	// 	var responseBean = new modules.api.models.response();
	// 	var model = createEmptyMock( "coldbox.system.ioc.Injector" );
	// 	model.$( "getInstance" ).$args( "beans.response.artistView@v1" ).$results( getUser() );
	// 	return model;
	// }

	// private any function getUser()
	// {
	// 	var artistResponse = createObject( "component", "modules.api.modules.v1.models.beans.response.artistView" ).init();
	// 	prepareMock( object = artistResponse );
	// 	var mockedUtils = new models.utils();
	// 	prepareMock( object = mockedUtils );
	// 	artistResponse.$property( propertyName = "utils", mock = mockedUtils );
	// 	return artistResponse;
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