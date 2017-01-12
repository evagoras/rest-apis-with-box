component
	accessors = true
	extends = "api.models.beanBase"
{


	property name="ID" jsontype="number";


	this.constraints = {
		"ID" = {
			type = "integer",
			min = 1,
			required = true
		}
	};


	function init()
	{
		super.init();
		return this;
	}


}