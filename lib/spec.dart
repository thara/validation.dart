//Copyright (C) 2013 Tomochika Hara. All Rights Reserved.
// Author: to_hara

library spec;

import 'package:meta/meta.dart';
import 'package:args/args.dart';

part 'src/spec/api.dart';
part 'src/spec/operators.dart';

/**
 * Create new specification of conditional [expression].
 */
//TODO This function is not type safe. 
//     I should keep to want to add generics to static functions in Dart.
Specification toSpec(IsSatisfiedBy expression) =>
  new _ConditionalSpecification(expression);

