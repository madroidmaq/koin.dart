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

import 'package:koin/src/core/definition/bean_definition.dart';
import 'package:koin/src/core/instance/definition_instance.dart';

/**
 * Factory Instance Holder
 *
 * @author Arnaud Giuliani
 */
class FactoryDefinitionInstance<T> extends DefinitionInstance<T> {
  FactoryDefinitionInstance(BeanDefinition<T> beanDefinition)
      : super(beanDefinition);

  @override
  void close() {
    Function onClose = beanDefinition.getOnClose;
    if (onClose != null) {
      onClose();
    }
  }

  @override
  T get(InstanceContext context) {
    return create(context);
  }

  @override
  bool isCreated(InstanceContext context) => false;

  @override
  void release(InstanceContext context) {}
}