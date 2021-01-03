library form_validators;

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

/// Check if the field value contain a certain string
class Contains implements IValidator {
  final String seed;
  final String message;
  @override
  call(String value) {
    return !value.contains(this.seed);
  }

  Contains(this.seed, [this.message = '']);
}

/// Check if the field value equal to a certain string
class Equals implements IValidator {
  final String seed;
  final String message;
  @override
  call(String value) {
    return this.seed != value;
  }

  Equals(this.seed, [this.message = '']);
}

/// Mark the field is required
class Required implements IValidator {
  final String message;
  call(String value) => value.isEmpty;
  Required([this.message = '']);
}

/// Set the maximum amount of character
class MaxLength implements IValidator {
  final int limit;
  final String message;
  call(String value) {
    if (value.length > this.limit) {
      return true;
    }
    return false;
  }

  MaxLength(this.limit, [this.message]);
}

/// Set the minimum amount of character
class MinLength implements IValidator {
  final int limit;
  final String message;
  call(String value) {
    if (value.length < this.limit) {
      return true;
    }
    return false;
  }

  MinLength(this.limit, [this.message]);
}

/// Limit the field digits to be between limited range
/// it use MaxLength and MinLength validators
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

  Between(this.message, {int max, int min})
      : this.maxLength = MaxLength(max, message),
        this.minLength = MinLength(min, message);
}

/// Composs multiple validator into one singular validator.
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
/// It uses a common regexp to validate the string, but you can use your own
class Email implements IValidator {
  final Pattern pattern;
  final String message;
  call(String value) => this.pattern(value);
  Email([this.message = '', regexp = r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+"]) : this.pattern = Pattern(regexp);
}

/// check if the field value matches the pattern
class Pattern implements IValidator {
  final RegExp regexp;
  final String message;
  call(String value) => !this.regexp.hasMatch(value);
  Pattern(String regexb, [this.message = '']) : this.regexp = RegExp(regexb);
}

class CreditCardMonthValidator implements IValidator {
  /// A message that will be used as default if non if other messages are provided
  String defaultMessage;
  String message;

  /// error message that will be shown in case of date expiration or format
  String dateInvalidMessage;
  String yearInvalidMessage;
  String monthInvalidMessage;
  CreditCardMonthValidator({
    this.defaultMessage,
    this.dateInvalidMessage,
    this.yearInvalidMessage,
    this.monthInvalidMessage,
  });

  int fullYear(int year) {
    if (year < 100 && year >= 0) {
      var now = DateTime.now();
      String currentYear = now.year.toString();
      String prefix = currentYear.substring(0, currentYear.length - 2);
      year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
    }
    return year;
  }

  bool expired(int month, int year) {
    var now = DateTime.now();
    int fourDigitsYear = fullYear(year);
    if (fourDigitsYear < now.year && month != now.month) {
      return true;
    }
    return false;
  }

  bool call(String value) {
    int year;
    int month;

    try {
      var split = value.split(RegExp(r'(\/)'));
      month = int.parse(split[0]);
      year = int.parse(split[1]);
    } catch (e) {
      this.message = this.dateInvalidMessage ?? this.defaultMessage ?? 'Date is invalid';
      return true;
    }

    if ((month < 1) || (month > 12)) {
      this.message = this.monthInvalidMessage ?? this.defaultMessage ?? 'Month is invalid';
      return true;
    }

    var fourDigitsYear = fullYear(year);
    if ((fourDigitsYear < 1) || (fourDigitsYear > 2099)) {
      this.message = this.yearInvalidMessage ?? this.defaultMessage ?? 'Year is invalid';

      return true;
    }

    if (expired(month, year)) {
      this.message = this.dateInvalidMessage ?? this.defaultMessage ?? 'Date is invalid';
      return true;
    }
    return false;
  }
}

class CreditCardNumberValidator implements IValidator {
  final String message;

  CreditCardNumberValidator([this.message = "Number is not valid"]);

  bool call(String value) {
    final formattedValue = keepNumbersOnly(value);
    return !(Pattern(r"[^0-9]").call(formattedValue) && luhnCheck(formattedValue));
  }

  String keepNumbersOnly(String value) {
    RegExp regExp = RegExp(r"[^0-9]");
    return value.replaceAll(regExp, '');
  }

  bool luhnCheck(String data) {
    if (data == null || data.length < 2) {
      return false;
    }

    var isDouble = false;
    var sum = 0;

    // 1. From the rightmost digit and moving left.
    for (var i = data.length - 1; i >= 0; i--) {
      final digit = data.codeUnitAt(i) - 48;

      if (digit < 0 || digit > 9) {
        throw ArgumentError('Digit at index $i must be a number');
      }

      // The first digit doubled is the digit located
      // immediately left of the check digit.
      if (isDouble) {
        final doubledDigit = digit * 2;
        // 2. Take the sum of all the digits.
        // If the result of this doubling operation
        // is greater than 9 (e.g., 8 × 2 = 16),
        // then add the digits of the result.
        if (doubledDigit > 9) {
          // sum += doubledDigit ~/ 10 + doubledDigit % 10;
          sum += doubledDigit - 9;
        } else {
          sum += doubledDigit;
        }
      } else {
        sum += digit;
      }

      // ...double the value of every second digit.
      isDouble = !isDouble;
    }

    return sum % 10 == 0;
  }
}

class CreditCardCVCValidator implements IValidator {
  final String message;
  CreditCardCVCValidator([this.message = "Number is not valid"]);

  @override
  bool call(String value) {
    return value.length < 3 || value.length > 4;
  }
}
