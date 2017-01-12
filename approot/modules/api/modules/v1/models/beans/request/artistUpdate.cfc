component
accessors = true
{


	property name="ID";
	property name="firstName";
	property name="lastName";
	property name="address";
	property name="city";
	property name="state";
	property name="postalCode";
	property name="email";
	property name="phone";
	property name="fax";
	property name="active";


	this.constraints = {
		"ID" = {
			type = "integer",
			min = 1,
			required = true
		},
		"firstName" = {
			type = "string",
			required = true
		},
		"lastName" = {
			required = true
		},
		"state" = {
			type = "string",
			size = 2
		}
	};


	function init()
	{
		return this;
	}


}