part of validator;

/**
 * A [Validator].
 */
abstract class Validator<T> {
  
  factory Validator(Constraint<T> constraint) => 
    new ConstraintValidator<T>(constraint);
  
  ValidationResult validate(T target);
}

/**
 * A simple [Validator]'s implemetation for one [Constraiont].
 */
class ConstraintValidator<T> implements Validator<T> {
  
  final Constraint<T> _constraint;
  
  ConstraintValidator(this._constraint) {
    Expect.isNotNull(_constraint, "constraint must not be nul.");
  }
  
  ValidationResult validate(T target) {
    var result = buildNewResult();
    _constraint.isFulfilledBy(target, result.error);
    return result;
  }

  ValidationResult buildNewResult() => new ValidationResult();
}

/**
 * A [ValitionResult] has result of validation.
 */
class ValidationResult<T> {
  
  final List<ConstraintViolation> _violations = [];
  
  void thenError(Constraint constrant, OnViolation hander) {
    _violations.where((e) => identical(e.constraint, constrant)).forEach(hander);
  }
  
  List<ConstraintViolation> get violations => new List.from(_violations);
  
  void error(ConstraintViolation violation) {
    _violations.add(violation);
  }
  
  bool get isValid => _violations.isEmpty;
  
  void thenInvalid(void handler(List<ConstraintViolation> violations)) {
    if (!isValid) {
      handler(violations);
    }
  }
  
  void rejectError() {
    thenInvalid((violations) {
      throw new ConstraintViolationException(violations);
    });
  }
}