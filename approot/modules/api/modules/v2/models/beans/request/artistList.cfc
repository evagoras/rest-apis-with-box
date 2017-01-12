component
	accessors = true
	extends = "api.models.beanBase"
{


	property name="offset" jsonType="number";
	property name="limit" jsonType="number";


	this.constraints = {
		"offset" = {
			type = "integer",
			min = 0
		},
		"limit" = {
			type = "integer",
			min = 0
		}
	};


	function init()
	{
		super.init();
		return this;
	}


}