//Copyright (C) 2013 Tomochika Hara. All Rights Reserved.
// Author: to_hara

library spec;

import 'package:meta/meta.dart';

part 'src/spec/api.dart';
part 'src/spec/operators.dart';
part 'src/spec/util.dart';

/**
 * Create new specification of conditional [expression].
 */
// This function is not type safe. 
// I should keep to want to add generics to static functions in Dart.
Specification toSpec(IsSatisfiedBy expression) =>
  new _ConditionalSpecification(expression);

