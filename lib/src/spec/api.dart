part of spec;

/**
 * A [Specification] for [T].
 */
abstract class Specification<T> {
  
  /**
   * Check if [target] is satisfied by the specification.
   */
  bool isSatisfiedBy(T target);
  
  /**
   * Returns new specification as logical conjunction : [this] AND [s].
   */
  Specification<T> operator &(Specification<T> s) =>
    new _AndSpecification(this, s);

  /**
   * Returns new specification as logical disjunction : [this] OR [s].
   */
  Specification<T> operator |(Specification<T> s) => 
    new _OrSpecification(this, s);
  
  /**
   * Returns new specification as negation : NOT [this].
   */
  Specification<T> not() => new _NotSpecification(this);
}

/**
 * Return true if [target] is satisfied by this specification.
 */
typedef bool IsSatisfiedBy<T>(T target);

/**
 * A specification for [T] by conditional [expression].
 */
class _ConditionalSpecification<T> extends Specification<T> {
  
  /** an actual conditional expression for this specification. */
  final IsSatisfiedBy<T> _expression;
  
  _ConditionalSpecification(this._expression) {
    Expect.isNotNull(_expression, "hoge");
  }
  
  @override
  bool isSatisfiedBy(T target) => _expression(target);
}
