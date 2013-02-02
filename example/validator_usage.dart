
import 'package:dart_validation/validator.dart';
import 'package:dart_validation/constraint.dart';
import 'package:dart_validation/spec.dart';

main () {
  
  var validator = new Validator<Person>(Person.constraint);
  var person = new PersonEntry(name:"", age:10);
  
  // do validation. you can catch each constraint violations or all.
  validator.validate(person)
    ..thenError(Person.constraint.name, (v) => print("name is invalid"))
    ..violations.forEach(print);
  
  // and, you can validate one of field constraints by PersonConstraint.
  var ageValidator = new Validator<int>(Person.constraint.age);
  var personAge = -20;
  
  try {
    ageValidator.validate(personAge).rejectError();  
  } catch (e, s) {
    print(s);
  }
}

class Person {
  final String name;
  final int age;
  Person(this.name, this.age) {
    new Validator<Person>(constraint).validate(this).rejectError();
  }
  static final PersonConstraint constraint = new PersonConstraint();
}

class PersonEntry implements Person {
  String name;
  int age;
  PersonEntry({this.name, this.age});
}

class PersonConstraint implements Constraint<Person> {
  
  final Constraint<String> name;
  final Constraint<int> age;
  
  PersonConstraint()
    : name = new StringConstraint((name) => name.isNotEmpty() & name.length(10)),
      age = new IntConstraint((age) => age.notNegative()) {
    assert(name != null);
    assert(age != null);
  }
  
  void isFulfilledBy(Person person, OnViolation onViolation) {
    this.name.isFulfilledBy(person.name, onViolation);
    this.age.isFulfilledBy(person.age, onViolation);
  }
}

class StringConstraint extends SpecificationConstraint<String> {
  
  StringConstraint(Specification<String> buildSpec(StringSpecs spec))
    : super(buildSpec(new StringSpecs()));
}

class IntConstraint extends SpecificationConstraint<int> {
  
  IntConstraint(Specification<int> buildSpec(IntSpecs spec))
    : super(buildSpec(new IntSpecs()));
}