/**
* My BDD Test
*/
component extends="coldbox.system.testing.BaseTestCase" {

/*********************************** LIFE CYCLE Methods ***********************************/

	// executes before all suites+specs in the run() method
	function beforeAll(){
		super.beforeAll();
	}

	// executes after all suites+specs in the run() method
	function afterAll(){
		super.afterAll();
	}

/*********************************** BDD SUITES ***********************************/

	function run( testResults, testBox ){
		// all your suites go here.
		describe( "Artist Manager", function(){

			it( "can return all artists", function(){
			});

			it( "can save a new contact", function(){

			});

			it( "can remove a contact", function(){

			});

		});
	}

}