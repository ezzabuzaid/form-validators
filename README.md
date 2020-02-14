# Form Validator

A library to validate form fields for Flutter framework

**This library only for flutter framework.**

to use the JS-based please see [Web form validators](https://github.com/ezzabuzaid/web-validators) (Under development yet)

## Validators

Here is a list of the validators currently available.

  
| Validator | Description |
|--|--|
| **Contains(String seed, [String message])** | check if the string contains the seed. |
**Equals(String seed, [String message])** | check if the field value equal to a certain string
**Required([String message])** | Mark the field is required.
**MaxLength(int limit, [String message])** | Set the maximum amount of character.
**MinLength(int limit, [String message])** | Set the minimum amount of character.
**Between(String message, {int max, int min})** | Limit the field digits to be between limited range<br></br>it use MaxLength and MinLength validators.<br></br> the `message` argument is required here
**Composs(String message, List validators)** | Composs multiple validator into one singular validator.<br></br> the `message` argument is required here
**Email([String message, String regexp])** | Indicate that the field should be an email<br></br>It uses a common regexp to validate the string, but you can use your own<br></br> the regexp is `r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+"]`
**Pattern(String regexp, [String message])** | check if the field value matches the pattern.


## Usage
Just use the validate function to execute the list of predefined validators
		
    TextFormField(
	    validator: validate([
		    Required('This field is required'),
		    Email('Please enter the email correctly'),
    ]))

and the validator function will be executed using either the global key of the Form widget or the Form Field, click [Here](https://flutter.dev/docs/cookbook/forms/validation) for more information about flutter validation.

*please note that the validators functions will be executed in the same order that was defined*

*the validators are simple functions that returns `true` when the value is not as supposed* so you can build your validators the works the same as the predefined ones

	 class CustomValidator implements IValidator {
		 final String message = 'Message to be used as error message';
		 CustomClass(this.message);
		 call(String value) {
			 return ("if meets my condition") ? false : true;
		}
	}
also, you can always see the source code to learn more.

The last thing that you can use a 3rd lib to facilitate the process, you can see [this](https://pub.dev/packages/validators) one, here's one of it's function `isDate()` that validates if the string is date, because it's a function that returns boolean we can use it with our interface to form a validator function, like this:

	 class IsDate implements IValidator {
		 final String message = 'Message to be used as error message';
		 IsDate(this.message);
		 call(String value) {
			 return isDate(value);
		}
	}
		
    TextFormField(
	    key: myFormKey,
	    validator: validate([
		    IsDate('Please enter correct date')
    ]))

## Contributing
Don't hesitate to open issues and make pull request to help improve code
1.  Fork it!
2.  Create your feature branch: `git checkout -b my-new-feature`
3.  Commit your changes: `git commit -m 'Add some feature'`
4.  Push to the branch: `git push origin my-new-feature`
5.  Submit a pull request :D


## Maintainers
 [**ezzabuzaid**](https://github.com/ezzabuzaid) - (author) - ezzabuzaid@hotmail.com

## Made with love

#### This lib inspired by
https://www.npmjs.com/package/validator
https://pub.dev/packages/validators
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTIzMTI5NjUyNywxNjAxNDkyNzAsLTEwMD
cyNDQyNjldfQ==
-->