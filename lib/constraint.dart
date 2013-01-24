library constraint;

import 'spec.dart';

part 'src/constraint/api.dart';

Constraint toConstraint(IsSatisfiedBy expression) =>
    new _ConditionalConstraint(expression);

class _ConditionalConstraint<T> implements Constraint<T> {
  
  final IsSatisfiedBy<T> _expression;
  
  _ConditionalConstraint(this._expression) {
    //TODO
    Expect.isNotNull(_expression);    
  }
  
  void isFulfilledBy(Commitment<T> commitment) {
    if (!_expression(commitment.value)) {
      commitment.onViolation(new ConstraintViolation(this, commitment.value));
    }
  }
}