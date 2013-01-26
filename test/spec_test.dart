library spec_test;

import 'package:unittest/unittest.dart';
import 'package:dart_validation/spec.dart';

main () => run();

run() {
  
  group("AND operation", () {
        
    var spec1 = toSpec((str) => str != null);
    var spec2 = toSpec((str) => str.startsWith("abc"));
    
    test("conjuction 2", () {
      // Exercise
      var sut = spec1 & spec2;
      
      // Veryfy
      expect(sut.isSatisfiedBy(null), isFalse);
      expect(sut.isSatisfiedBy(""), isFalse);
      expect(sut.isSatisfiedBy("abcde"), isTrue);
    });
    
    test("conjuction 3", () {
      // Exercise
      var sut = spec1 & spec2 & toSpec((str) => str.length == 6);
      
      // Veryfy
      expect(sut.isSatisfiedBy(null), isFalse);
      expect(sut.isSatisfiedBy(""), isFalse);
      expect(sut.isSatisfiedBy("abcde"), isFalse);
      expect(sut.isSatisfiedBy("abcdef"), isTrue);
    });
  });
  
  group("OR operation", () {
    
    var spec1 = toSpec((str) => str.length == 4);
    var spec2 = toSpec((str) => str.startsWith("zx"));
    
    test("disjuction 2", () {
      // Exercise
      var sut = spec1 | spec2;
      
      // Veryfy
      expect(sut.isSatisfiedBy(""), isFalse);
      expect(sut.isSatisfiedBy("abcde"), isFalse);
      expect(sut.isSatisfiedBy("abcd"), isTrue);
      expect(sut.isSatisfiedBy("zxyyyyy"), isTrue);
    });
    
    test("disjuction 3", () {
      // Exercise
      var sut = spec1 | spec2 | toSpec((str) => str.contains("foo"));
      
      // Veryfy
      expect(sut.isSatisfiedBy(""), isFalse);
      expect(sut.isSatisfiedBy("abcde"), isFalse);
      expect(sut.isSatisfiedBy("abcd"), isTrue);
      expect(sut.isSatisfiedBy("zxyyyyy"), isTrue);
      expect(sut.isSatisfiedBy("xxxfooxxxxxxx"), isTrue);
    });
    

  });
  
  group("NOT operation", () {
    
    var spec1 = toSpec((str) => str != null);
    
    test("negation", () {
      // Exercise
      var sut = spec1.not();
      
      // Veryfy
      expect(spec1.isSatisfiedBy(null), isFalse);
      expect(sut.isSatisfiedBy(null), isTrue);
    });
  });
}