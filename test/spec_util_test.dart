library spec_util_test;

import 'package:unittest/unittest.dart';
import 'package:dart_validation/spec.dart';

main () => run();

run() {
  
  group("StringSpecs", () {
    
    StringSpecs sut = new StringSpecs();
    
    test("isEmpty", () {
      Specification<String> isEmpty = sut.isEmpty();
      expect(isEmpty.isSatisfiedBy(""), isTrue);
      expect(isEmpty.isSatisfiedBy("A"), isFalse);
    });
    
    test("isNotEmpty", () {
      Specification<String> isNotEmpty = sut.isNotEmpty();
      expect(isNotEmpty.isSatisfiedBy(""), isFalse);
      expect(isNotEmpty.isSatisfiedBy("A"), isTrue);
    });
    
    test("length", () {
      Specification<String> length = sut.length(3);
      expect(length.isSatisfiedBy("AB"), isFalse);
      expect(length.isSatisfiedBy("ABC"), isTrue);
      expect(length.isSatisfiedBy("ABCD"), isFalse);
      
      length = sut.length(0);
      expect(length.isSatisfiedBy(""), isTrue);
      expect(length.isSatisfiedBy("A"), isFalse);
    });
    
    test("minLength", () {
      Specification<String> minLength = sut.minLength(4);
      expect(minLength.isSatisfiedBy("ABC"), isFalse);
      expect(minLength.isSatisfiedBy("ABCD"), isTrue);
      expect(minLength.isSatisfiedBy("ABCDE"), isTrue);
    });
    
    test("maxLength", () {
      Specification<String> maxLength = sut.maxLength(4);
      expect(maxLength.isSatisfiedBy("ABC"), isTrue);
      expect(maxLength.isSatisfiedBy("ABCD"), isTrue);
      expect(maxLength.isSatisfiedBy("ABCDE"), isFalse);
    });
  });
}