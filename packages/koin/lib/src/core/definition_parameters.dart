/*
 * Copyright 2017-2018 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'dart:core';

import 'error/exceptions.dart';

/// DefinitionParameters - Parameter holder
///
/// Usable with exploded declaration
///
// @author - Arnaud GIULIANI
//
// Ported to Dart from Kotlin by:
// @author - Pedro Bissonho

class DefinitionParameters {
  final List<Object> _values;

  /// Maximum number of parameters that [DefinitionParameters] can support.
  static final int maxParams = 5;

  /// DefinitionParameters - Parameter holder
  ///
  /// Usable with exploded declaration
  DefinitionParameters(this._values) {
    if (_values.length > maxParams) {
      throw DefinitionParameterException(
          "Can't build DefinitionParameters for more than 5 arguments");
    }
  }

  /// Get element at index 'i'.
  Object elementAt(int i) {
    Object value;
    if (_values.length > i) {
      value = _values[i];
    } else {
      throw NoParameterFoundException(
          "Can't get parameter value at position $i from $this");
    }

    if (value == null) {
      throw DefinitionParameterException("""
Can't get parameter value at position $i from $this. The Parameter is null.""");
    }

    return value;
  }

  /// Get element at 0 index.
  Object get component1 => elementAt(0);
  /// Get element at 1 index.
  Object get component2 => elementAt(1);
  /// Get element at 2 index.
  Object get component3 => elementAt(2);
  /// Get element at 3 index.
  Object get component4 => elementAt(3);
  /// Get element at 4 index.
  Object get component5 => elementAt(4);

  /// Get element at 0 index.
  Object get param1 => elementAt(0);
  /// Get element at 1 index.
  Object get param2 => elementAt(1);
  /// Get element at 2 index.
  Object get param3 => elementAt(2);
  /// Get element at 3 index.
  Object get param4 => elementAt(3);
  /// Get element at 4 index.
  Object get param5 => elementAt(4);
 

  /// Get element at given index and return as [T]
  ///
  T get<T>(int index) {
    var object = elementAt(index);
    return object as T;
  }

  ///
  /// Returns the number of contained elements
  ///
  int size() => _values.length;

  ///
  /// Tells if it has parameters
  ///
  bool isEmpty() => _values.isEmpty;

  ///
  /// Tells if it not has parameters
  ///
  bool isNotEmpty() => _values.isNotEmpty;

  ///
  /// Get first element of given type [T].
  ///
  T getWhere<T>() => _values.firstWhere((value) => value is T);
}

///
/// Builds a `DefinitionParameters` with the [parameters] list elements.
///
DefinitionParameters parametersOf(List<Object> parameters) {
  if (parameters != null) {
    return DefinitionParameters(parameters);
  }

  return emptyParametersHolder();
}

///
/// Builds a [DefinitionParameters] without elements
///
DefinitionParameters emptyParametersHolder() =>
    DefinitionParameters(<Object>[]);
