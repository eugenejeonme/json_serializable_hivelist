// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/type.dart';
import 'package:hive/hive.dart';
import 'package:source_gen/source_gen.dart' show TypeChecker;
import 'package:json_serializable/type_helper.dart';

import 'package:json_serializable/src/constants.dart';
import 'package:json_serializable/src/lambda_result.dart';
import 'package:json_serializable/src/shared_checkers.dart';
import 'package:json_serializable_type_helper_utils/json_serializable_type_helper_utils.dart';


class HiveListTypeHelper extends TypeHelper<TypeHelperContextWithConfig> {
  const HiveListTypeHelper();

  @override
  String serialize(DartType targetType, String expression,
      TypeHelperContextWithConfig context) {
    //default iterable helper will serialize all iterables fine
    return null;
  }

  @override
  String deserialize(DartType targetType, String expression,
      TypeHelperContextWithConfig context) {
    if (!(coreIterableTypeChecker.isExactlyType(targetType) ||
        hiveListTypeChecker.isExactlyType(targetType))) {
      return null;
    }
    final iterableGenericType = coreIterableGenericType(targetType);

    final itemSubVal = context.deserialize(iterableGenericType, closureArg);

    var output = '$expression as HiveList';

    // If `itemSubVal` is the same and it's not a Set, then we don't need to do
    // anything fancy
    if (closureArg == itemSubVal &&
        hiveListTypeChecker.isExactlyType(targetType)) {
      return wrapNullableIfNecessary(
          expression, '($output)', context.nullable);
    }

    output = '($output)';

    if (closureArg != itemSubVal) {
      final lambda = LambdaResult.process(itemSubVal, closureArg);
      output += '.map($lambda)';
    }

    return wrapNullableIfNecessary(expression, output, context.nullable);
  }
}

final hiveListTypeChecker = TypeChecker.fromRuntime(HiveList);
