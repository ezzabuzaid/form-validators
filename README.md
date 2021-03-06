# Form Validator

Don't forget to follow the project's author, [Ezz](https://github.com/ezzabuzaid), and consider starring the project to show your ❤️ and support.

A library to validate form fields for Flutter framework

## Validators

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
**CreditCardCVCValidator([String message])** | cvc/cvv card validator
**CreditCardNumberValidator([String message])** | credit card number validator
**CreditCardMonthValidator** | credit card date validator

## Usage

Invoke validate function to execute the list of predefined validators

``` dart
TextFormField(
        validator: validate([
            Required('This field is required'),
            Email('Please enter the email correctly'),
    ]))
```

and the result will be getting by setting `autovalidate` property, using global key of the Form widget or the Form Field, click [Here](https://flutter.dev/docs/cookbook/forms/validation) for more information about flutter validation.

*please note that the validators functions will be executed in the same order that was defined*

*the validators are simple functions that returns `true` when the value is not as supposed* so you can build your validators the works the same as the predefined ones

``` dart
    class CustomValidator implements IValidator {
        final String message = 'Message to be used as error message';
        CustomClass(this.message);
        call(String value) {
            return ("if meets my condition") ? false : true;
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

## Contributing

Don't hesitate to open issues and make a pull request to help improve code

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -m 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

  

## Versioning

This library will be maintained under the semantic versioning guidelines.
Releases will be numbered with the following format:
 `<major>.<minor>.<patch>`

For more information on SemVer, please visit http://semver.org.

## Developer

##### [Ezzabuzaid](mailto:ezzabuzaid@hotmail.com)

* [Dev.to](https://dev.to/ezzabuzaid)
* [GitHub](https://github.com/ezzabuzaid)
* [Linkedin](https://www.linkedin.com/in/ezzabuzaid)

## License

##### The MIT License (MIT)
