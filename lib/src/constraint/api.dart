part of constraint;

/**
 * A function for handling [ConstraintViolation]s.
 */
typedef OnViolation<T>(ConstraintViolation<T> violation);

/**
 * A [Constraint] should be fulfilled by [Commitment] of [T]
 */
abstract class Constraint<T> {
  
  factory Constraint(Specification<T> spec) =>
    new SpecificationConstraint(spec);
  
  factory Constraint.expressin(IsSatisfiedBy expression) =>
    new ConditionalConstraint(expression);
  
  void isFulfilledBy(T commitment, OnViolation onViolation);
}

/**
 * A value object indicates a [ConstraintViolation] by [Constraint] of [T].
 */
class ConstraintViolation<T> {
  
  final Constraint<T> constraint;
  final T invalidValue;
  
  ConstraintViolation(this.constraint, this.invalidValue) {
    Expect.isNotNull(constraint, "constraint must not be null.");
    // cause might be null if a specification of constraint is whatever null or not.
  }
}

/**
 * A [Exception] wrapped [ConstraintViolation]
 */
class ConstraintViolationException<T> implements Exception {
  final List<ConstraintViolation<T>> violations;
  
  ConstraintViolationException(this.violations);
  
  toString() {
    //TODO toString must be implemented.
    return super.toString();
  }
}