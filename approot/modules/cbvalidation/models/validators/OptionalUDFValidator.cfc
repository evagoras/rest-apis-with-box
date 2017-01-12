component accessors="true" implements="cbvalidation.models.validators.IValidator" singleton
{


	property name="name";


	OptionalUDFValidator function init()
	{
		name = "optionalUdf";
		return this;
	}


	/**
	* Will check if an incoming value validates
	* @validationResult.hint The result object of the validation
	* @target.hint The target object to validate on
	* @field.hint The field on the target object to validate on
	* @targetValue.hint The target value to validate
	* @validationData.hint The validation data the validator was created with
	*/
	boolean function validate
	(
		required cbvalidation.models.result.IValidationResult validationResult,
		required any target,
		required string field,
		any targetValue,
		any validationData
	)
	{
		if ( isNull( arguments.targetValue ) )
			return true;
		if ( arguments.validationData( arguments.targetValue, arguments.target ) )
			return true;
		var args = {
			message = "The '#arguments.field#' value does not validate",
			field = arguments.field,
			validationType = getName(),
			validationData = arguments.validationData
		};
		validationResult.addError( validationResult.newError(argumentCollection=args) );
		return false;
	}


	/**
	* Get the name of the validator
	*/
	string function getName()
	{
		return name;
	}

}
