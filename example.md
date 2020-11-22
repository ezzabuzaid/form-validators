Just use the validate function to execute the list of predefined validators

``` dart
    TextFormField(
	    validator: validate([
		    Required('This field is required'),
		    Email('Please enter the email correctly'),
    ]))
```

and the validator function will be executed using either the global key of the Form widget or the Form Field, click [Here](https://flutter.dev/docs/cookbook/forms/validation) for more information about flutter validation.

*please note that the validators functions will be executed in the same order that was defined*

*the validators are simple functions that returns `true` when the value is not as supposed* so you can build your validators the works the same as the predefined ones

``` dart
class BadWordValidator implements IValidator {
  String message = 'Message to be used as error message';
  BadWordValidator([this.message]);
  call(String value) {
    return value != "BadWord" ? false : true;
  }
}
```

also, you can always see the source code to learn more.

The last thing that you can use a 3rd lib to facilitate the process, you can see [this](https://pub.dev/packages/validators) one, here's one of it's function `isDate()` that validates if the string is date, because it's a function that returns boolean we can use it with our interface to form a validator function, like this:

``` dart

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

```
