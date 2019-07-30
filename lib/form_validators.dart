library form_validators;

/// Mark the field is required
class Required implements IValidator {
  final String message;
  call(String value) => value.isEmpty;
  Required([this.message = '']);
}

/// Set the maximum amount of character
class MaxLength implements IValidator {
  final int constraint;
  final String message;
  call(String value) {
    if (value.length > this.constraint) {
      return true;
    }
    return false;
  }

  MaxLength(this.constraint, [this.message]);
}

/// Set the minimum amount of character
class MinLength implements IValidator {
  final int constraint;
  final String message;
  call(String value) {
    if (value.length < this.constraint) {
      return true;
    }
    return false;
  }

  MinLength(this.constraint, [this.message]);
}

/// Make the field digit to be between limited amount of length
/// it uses MaxLength and MinLength validators
class Between implements IValidator {
  final MinLength minLength;
  final MaxLength maxLength;
  final String message;

  call(String value) {
    if (this.maxLength(value) || this.minLength(value)) {
      return true;
    }
    return false;
  }

  Between(this.message, {max, min})
      : this.maxLength = MaxLength(max, message),
        this.minLength = MinLength(min, message);
}

/// Composs mulitple validators into one singular validator

class Composs implements IValidator {
  final String message;
  final List<IValidator> validators;
  call(String value) {
    for (var validator in this.validators) {
      if (validator(value)) {
        return true;
      }
    }
    return false;
  }

  Composs(this.message, this.validators);
}

/// Indicate that the field should be an email
/// It uses a common regexp to validate the string, but you can use own
class Email implements IValidator {
  final Pattern pattern;
  final String message;
  call(String value) => this.pattern(value);
  Email([this.message = '', regexp = r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+"])
      : this.pattern = Pattern(regexp);
}

/// Make the field obey to regexp rules
class Pattern implements IValidator {
  final RegExp regexp;
  final String message;
  call(String value) => !this.regexp.hasMatch(value);
  Pattern(pattern, [this.message = '']) : this.regexp = RegExp(pattern);
}

/// Check if the field value equal to a certin string
class Equals implements IValidator {
  final String password;
  final String message;
  @override
  call(String value) {
    if (this.password != value) {
      return true;
    }
    return false;
  }

  Equals(this.password, [this.message = '']);
}

/// Check if the field value contain a certin string
class Contains implements IValidator {
  final String seed;
  final String message;
  @override
  call(String value) {
    if (value.contains(this.seed)) {
      return true;
    }
    return false;
  }

  Contains(this.seed, [this.message = '']);
}

/// An interface used to create a validator class
/// you can also used to create your own validation class
/// ```
/// class CustomClass implements IValidator {
///   final String message = 'Message to be used';
/// 
///   you can mark the message prop as optional with [this.message]
///   CustomClass(this.message) {
///   
///   }
///   
///   call(String value) {
///     should return true;
///     return ("if meets my condition") ? false : true;
///     this means if every thing is good return false, no message needed to display otherwise return true to show the message  
///   }
///   
/// }
/// ```
class IValidator {
  final String message;
  IValidator(this.message);
  call(String value) => bool;
}

/// Used to run the validators in sequence
/// this function must be used in validate function
/// ```
/// TextFormField(
///   validator: validate([
///     validators.Required('This field is required'),
///     validators.Email('Please enter the email correctly'),
/// ]))
/// ```
validate(List<IValidator> validators) {
  return (String value) {
    for (var validator in validators) {
      if (validator(value)) {
        return validator.message;
      }
    }
    return null;
  };
}
