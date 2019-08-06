# Form Validator

A library to validate form fields for Flutter framework


**This library only for flutter framework.**

to use the JS-based please see [Web form validators](https://github.com/ezzabuzaid/web-validators)

## Validators

  

Here is a list of the validators currently available.

Validator | Description

-------------------------------------- | --------------------------------------

  

**Contains(seed, [message])** | check if the string contains the seed.

  

**Equals(seed, [message])** | check if the field value equal to a certain string

  

**Required([message])** | Mark the field is required.

  

**MaxLength(limit, [message])** | Set the maximum amount of character.

  

**MinLength(limit, [message])** | Set the minimum amount of character.

  

**Between(message, {int max, int min})** | Limit the field digits to be between limited range<br></br>it use MaxLength and MinLength validators.<br></br> the `message` argument is required here

  

**Composs(message, List validators)** | Composs multiple validator into one singular validator.<br></br> the `message` argument is required here

  

**Email([message, regexp])** | Indicate that the field should be an email<br></br>It uses a common regexp to validate the string, but you can use your own<br></br> the regexp is `r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+"]`

  

**Pattern(pattern, [this.message])** | check if the field value matches the pattern.

## Contributing

Don't hesitate to open issues and make pull request to help improve this plugin.

## Maintainers

-  [**ezzabuzaid**](https://github.com/ezzabuzaid) - (author)


## Made with love
 

#### This lib inspired by
 
[https://www.npmjs.com/package/validator](https://www.npmjs.com/package/validator)