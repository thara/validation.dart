part of spec;

/**
 * A [Specification] for AND operation.
 */
class _AndSpecification<T> extends Specification<T> {

  final Specification<T> _spec1;
  final Specification<T> _spec2;

  _AndSpecification(this._spec1, this._spec2);

  @override
  bool isSatisfiedBy(T target) {
    return _spec1.isSatisfiedBy(target) && _spec2.isSatisfiedBy(target);
  }
}

/**
 * A [Specification] for OR operation.
 */
class _OrSpecification<T> extends Specification<T> {

  final Specification<T> _spec1;
  final Specification<T> _spec2;

  _OrSpecification(this._spec1, this._spec2);

  @override
  bool isSatisfiedBy(T target) {
    return _spec1.isSatisfiedBy(target) || _spec2.isSatisfiedBy(target);
  }
}

/**
 * A [Specification] for NOT operation.
 */
class _NotSpecification<T> extends Specification<T> {

  final Specification<T> _spec1;

  _NotSpecification(this._spec1);

  @override
  bool isSatisfiedBy(T target) {
    return !_spec1.isSatisfiedBy(target);
  }
}

