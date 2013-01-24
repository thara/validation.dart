part of constraint;

/**
 * A function for handling [ConstraintViolation]s.
 */
typedef OnViolation<T>(ConstraintViolation<T> violation);

/**
 * A [Constraint] should be fulfilled by [Commitment] of [T]
 */
abstract class Constraint<T> {
  
  void isFulfilledBy(Commitment<T> commitment);
}

/**
 * A [Commitment] of [T] might fulfill to any [Constraint]s.
 */
class Commitment<T> {
  
  static final OnViolation defaultOnViolation = (violation) {
    throw new ConstraintViolationException(violation);
  };
  
  final T value;
  
  OnViolation<T> _onViolation;
  
  Commitment(this.value, [OnViolation<T> onViolation]) {
    if (?onViolation) {
      _onViolation = defaultOnViolation;
    } else {
      Expect.isNotNull(onViolation, "handler on violation must not be null.");
      this._onViolation = onViolation;
    }
  }
  
  OnViolation<T> get onViolation => _onViolation;
}

/**
 * A value object indicates a [ConstraintViolation] by [Constraint] of [T].
 */
class ConstraintViolation<T> {
  
  final Constraint<T> constraint;
  final T cause;
  
  ConstraintViolation(this.constraint, this.cause) {
    Expect.isNotNull(constraint, "constraint must not be null.");
    // cause might be null if a specification of constraint is whatever null or not.
  }
}

/**
 * A [Exception] wrapped [ConstraintViolation]
 */
class ConstraintViolationException<T> implements Exception {
  final ConstraintViolation<T> violation;
  
  ConstraintViolationException(this.violation);
  
  toString() {
    //TODO toString must be implemented.
    return super.toString();
  }
}