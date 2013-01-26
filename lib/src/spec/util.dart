part of spec;

/**
 * [StringSpecs] has convinience methods for creation [Specification] to [String].
 */
class StringSpecs {
  
  static final Specification<String> _isEmpty = toSpec((String str) => str.isEmpty);
  static final Specification<String> _isNotEmpty = toSpec((String str) => !str.isEmpty);
  
  Specification<String> isEmpty() => _isEmpty;
  Specification<String> isNotEmpty() => _isNotEmpty;
  
  Specification<String> length(int length) => 
    toSpec((String str) => str.length == length);
  
  Specification<String> minLength(int length) => 
      toSpec((String str) => length <= str.length);
  
  Specification<String> maxLength(int length) => 
      toSpec((String str) => str.length <= length);
}

/**
 * [IntSpecs] has convinience methods for creation [Specification] to [int].
 */
class IntSpecs {
  
  Specification<int> min(int minimum) => toSpec((int num) => minimum <= num); 
  Specification<int> max(int maximum) => toSpec((int num) => num <= maximum);
  
  Specification<int> negative() => toSpec((int num) => num.isNegative);
  Specification<int> notNegative() => toSpec((int num) => !num.isNegative);
}

//TODO more and more...