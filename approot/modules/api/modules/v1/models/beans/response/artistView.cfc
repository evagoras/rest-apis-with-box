component
	accessors = true
	extends = "api.models.beanBase"
{


	property name="firstName"	jsontype="string";
	property name="lastName"	jsontype="string";
	property name="address"		jsontype="string";
	property name="city"		jsontype="string";
	property name="state"		jsontype="string";
	property name="postalCode"	jsontype="string";
	property name="email"		jsontype="string";
	property name="phone"		jsontype="string";
	property name="fax"			jsontype="string";
	property name="dateCreated"	jsontype="date";
	property name="active"	jsontype="boolean";


	function init()
	{
		super.init();
		return this;
	}


}