/*
This validator validates if an incoming value exists in a certain list
but is different from the original in that it only validates if the value
is not a null or an empty string.
 */
component accessors="true" implements="cbvalidation.models.validators.IValidator" singleton
{


	property name="name";


	OptionalInListValidator function init()
	{
		name = "optionalInList";
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
		if ( isNull( arguments.targetValue ) || arguments.targetValue == "" )
			return true;
		if ( arguments.validationData.findNoCase( arguments.targetValue ))
			return true;
		var args = {
			message = "The '#arguments.field#' value is not in the constraint list: #arguments.validationData#",
			field = arguments.field,
			validationType = getName(),
			validationData = arguments.validationData
		};
		var error = validationResult.newError( argumentCollection = args ).setErrorMetadata(
			{ inlist = arguments.validationData }
		);
		validationResult.addError( error );
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