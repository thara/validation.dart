part of constraint;

/**
 * A [Constraiont] has a expression how to fulfilled by commitment.
 */
class ConditionalConstraint<T> implements Constraint<T> {
  
  final IsSatisfiedBy<T> _expression;
  
  ConditionalConstraint(this._expression) {
    Expect.isNotNull(_expression, "expression must not be null.");
  }
  
  void isFulfilledBy(T commitment, OnViolation onViolation) {
    if (!_expression(commitment)) {
      onViolation(new ConstraintViolation(this, commitment));
    }    
  }
}

/**
 * A [Constraint] has a specification how to fulfilled by commitment.
 */
class SpecificationConstraint<T> implements Constraint<T> {
  
  final Specification<T> _spec;
  
  SpecificationConstraint(this._spec) {
    Expect.isNotNull(_spec, "spec must not be null.");
  }
  
  void isFulfilledBy(T commitment, OnViolation onViolation) {
    if (!_spec.isSatisfiedBy(commitment)) {
      onViolation(new ConstraintViolation(this, commitment));
    }    
  }
}

