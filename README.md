
  

# Form Validator

  

[![Downloads][downloads-image]][npm-url]

  

A library to validate form fields for Flutter framework

  

**This library only for flutter framework.**

  

to use the JS-based please see [Web form validators](https://github.com/ezzabuzaid/web-validators)

  

## Usage

- Add dependency to your package's `pubspec.yaml`<br></br>form_validators: ^0.0.1

  

## Contributors

  

**Any help is welcomed**

  

## Validators

  

Here is a list of the validators currently available.

  

Validator | Description

  

------------------------------------------------------- | --------------------------------------

  

**Contains(seed, [message])** | check if the string contains the seed.

  

**Equals(seed, [message])** | check if the field value equal to a certain string

  

**Required([message])** | Mark the field is required.

  

**MaxLength(limit, [message])** | Set the maximum amount of character.

  

**MinLength(limit, [message])** | Set the minimum amount of character.

  

**Between(this.message, {int max, int min})** | Limit the field digits to be between limited range<br></br>it use MaxLength and MinLength validators.<br></br> the `message` argument is required here

  

**Composs(this.message, this.validators)** | Composs multiple validator into one singular validator.<br></br> the `message` argument is required here

  

**Email([this.message, regexp])** | Indicate that the field should be an email<br></br>It uses a common regexp to validate the string, but you can use your own<br></br> the regexp is `r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+"]`

  

**Pattern(pattern, [this.message])** | check if the field value matches the pattern.

  

## Example

`import 'package:form_validators:form_validators.dart' as validators;`

  

`

TextFormField(

validator: validators.validate([

validators.Required('This field is required'),

validators.Email('Please enter the email correctly'),

]),

),

`

  
  

`TextFormField(

validator: validators.validate([validators.Equals( 'myValue', "Passwords doesn't matches",),],),),`

  
  

## Contributing

  

In general, we follow the "fork-and-pull" Git workflow.

  

1. Fork the repo on GitHub

  

2. Clone the project to your own machine

  

3. Work on your fork

  

1. Make your changes and additions

  

2. Change or add tests if needed

  

3. Run tests and make sure they pass (No test yet)

  

4. Add changes to [README.md](http://readme.md/) if needed

  

4. Commit changes to your own branch

  

5.  **Make sure** you merge the latest from "upstream" and resolve conflicts if there is any

  

6. Repeat step 3(3) above

  

7. Push your work back up to your fork

  

8. Submit a Pull request so that we can review your changes

  

## Maintainers

  

-  [ **ezzabuzaid**](https://github.com/ezzabuzaid) - (author)

  

## Made with love
 

#### This lib inspired by
 
[https://www.npmjs.com/package/validator](https://www.npmjs.com/package/validator)