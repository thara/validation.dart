part of validator;

/**
 * A [Validator] for any [Constraiont].
 */
abstract class Validator<T> {
  
  factory Validator(Constraint<T> constraint) => 
    new ConstraintValidator<T>(constraint);
  
  void validate(T target, [OnViolation<T> onViolation]);
}

//abstract class SkeletonValidator<T> implements Validator<T> {
//  
//  void validate(T target, [OnViolation<T> onViolation]) {
//    Validatable<T> validatable = new Validatable();
//    validatable.value = target;
//    
//    if (?onViolation) {
//      validatable.onViolation = onViolation;
//    }
//    
//    doValidate(validatable);
//  }
//  
//  void doValidate(Validatable<T> validatable);
//}

class ConstraintValidator<T> implements Validator<T> {
  
  final Constraint<T> _constraint;
  
  ConstraintValidator(this._constraint) {
    Expect.isNotNull(_constraint, "constraint must not be nul.");
  }
  
  void validate(T target, [OnViolation<T> onViolation]) {
    Validatable<T> validatable = new Validatable();
    validatable.value = target;
    
    if (?onViolation) {
      validatable.onViolation = onViolation;
    }
    
    _constraint.isFulfilledBy(validatable);
  }
}

class CombinedConstraintsValidator<T> extends ConstraintValidator<T> {
  
  static Constraint combineConstraints(List<Constraint> constraints) {
    return toConstraint((_) {
      return constraints.every((constraint) => constraint.isFulfilledBy(_));
    });
  }
  
  CombinedConstraintsValidator(List<Constraint> constraints) 
    : super(combineConstraints(constraints));
}

/**
 * A [Validatable] something.
 */
class Validatable<T> implements Commitment<T> {
  
  T value;
  
  OnViolation<T> onViolation = Commitment.defaultOnViolation;
  
  Validatable([this.value, this.onViolation]);
}
