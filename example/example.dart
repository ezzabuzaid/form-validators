import '../lib/form_validators.dart';

class CustomBadWordValidator implements IValidator {
  String message = 'Message to be used as error message';
  CustomBadWordValidator([this.message]);
  call(String value) {
    return value != "BadWord" ? false : true;
  }
}
