import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'email_address.freezed.dart';

class EmailAddress { 
  
final Either<ValueFailure<String>,String>value;

  factory EmailAddress(String input){
     assert ( input != null )  ;
     return EmailAddress._(
       validateEmailAddress(input),
     );

  }
}
  const EmailAddress._(this.value);



@override

String toString () => 'EmailAddress($value)';
@override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is EmailAddress && o.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}

String validateEmailAddress(String input){
  const emailRegex =
  r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
  if (RegExp(emailRegex).hasMatch(input)){
    return input;
  }else{
    throw InvalidEmailException (failedValue:input);
  }
}

@freezed
abstract class ValueFailure<T>with _$ValueFailure<T>{

const factory ValueFailure.invalidEmail({
  @required String failedValue,
}) = InvalidEmail<T>;
}
void showingTheEmailAddressOrFailure(EmailAddress emailAddress) {
  // Longer to write but we can get the failure instance
  final emailText1 = emailAddress.value.fold(
    (left) => 'Failure happened, more precisely: $left',
    (right) => right,
  );

  // Shorter to write but we cannot get the failure instance
  final emailText2 =
      emailAddress.value.getOrElse(() => 'Some failure happened');
}
