import 'package:koin/src/core/definition/definitions.dart';
import 'package:koin/src/core/instance/instance_context.dart';
import 'package:koin/src/core/koin_dart.dart';
import 'package:koin/src/core/scope/scope.dart';
import 'package:koin/src/dsl/koin_application_dsl.dart';
import 'package:koin/src/dsl/module_dsl.dart';
import 'package:test/test.dart';

import 'package:koin/src/core/definition/options.dart';
import 'package:koin/src/core/definition/bean_definition.dart';
import '../components.dart';
import '../test_extension/koin_application_ext.dart';

import 'package:koin/src/core/qualifier.dart';
import 'package:koin/src/core/definition_parameters.dart';

void main() {
  Koin koin;
  Scope rootScope;

  setUp(() {
    koin = koinApplication((app) {}).koin;
    rootScope = koin.scopeRegistry.rootScope;
  });

  test('equals definitions', () {
    var def1 = Definitions.createSingle(
        definition: (s, p) => ComponentA(),
        scopeDefinition: rootScope.scopeDefinition,
        options: Options());
    var def2 = Definitions.createSingle(
        definition: (s, p) => ComponentA(),
        scopeDefinition: rootScope.scopeDefinition,
        options: Options());

    expect(def1, def2);
  });

  test('scope definition', () {
    var def1 = Definitions.createSingle(
        definition: (s, p) => ComponentA(),
        scopeDefinition: rootScope.scopeDefinition,
        options: Options());

    expect(def1.scopeDefinition, rootScope.scopeDefinition);
    expect(def1.kind, Kind.Single);
  });

  test('equals definitions - but diif kind', () {
    var def1 = Definitions.createSingle(
        definition: (s, p) => ComponentA(),
        scopeDefinition: rootScope.scopeDefinition,
        options: Options());
    var def2 = Definitions.createSingle(
        definition: (s, p) => ComponentA(),
        scopeDefinition: rootScope.scopeDefinition,
        options: Options());

    expect(def1, def2);
  });

  test('definition kind', () {
    var app = koinApplication((app) {
      app.module(module()
        ..single<ComponentA>((s, p) => ComponentA())
        ..factory<ComponentB>((s, p) => ComponentB(s.get<ComponentA>())));
    });

    var defA = app.getBeanDefinition(ComponentA);
    expect(Kind.Single, defA.kind);

    var defB = app.getBeanDefinition(ComponentB);
    expect(Kind.Factory, defB.kind);
  });

  test('definition name', () {
    var name = named("A");

    var app = koinApplication((app) {
      app.module(module()
        ..single<ComponentA>((s, p) => ComponentA(), qualifier: name)
        ..factory<ComponentB>((s, p) => ComponentB(s.get<ComponentA>())));
    });

    var defA = app.getBeanDefinition(ComponentA);
    expect(name, defA.qualifier);

    var defB = app.getBeanDefinition(ComponentB);
    expect(defB.qualifier, null);
  });

  test('definition function', () {
    var app = koinApplication((app) {
      app.module(module()..single<ComponentA>((s, p) => ComponentA()));
    });

    app.getBeanDefinition(ComponentA);
    var instance = app.getInstanceFactory(ComponentA).get(InstanceContext(
        koin: app.koin, scope: rootScope, parameters: emptyParametersHolder()));

    print(instance);
    expect(instance, app.koin.get<ComponentA>());
  });

  test('testes', () {
    var app = koinApplication((app) {
      app.module(module()
        ..single<ComponentA>(
          (s, p) => ComponentA(),
        )
        ..factory<ComponentB>((s, p) => ComponentB(s.get<ComponentA>())));
    });

    app.getBeanDefinition(ComponentA);
    var instance = app.getInstanceFactory(ComponentA).get(InstanceContext(
        koin: app.koin, scope: rootScope, parameters: emptyParametersHolder()));

    var instanceb = app.koin.get<ComponentB>();

    print(instance);
    expect(instance, app.koin.get<ComponentA>());

    expect(instanceb.a, instance);
  });

  test("indexKey", () {
    Type type = ComponentA;
    var id = indexKey(type, null);

    expect(id, "ComponentA");
  });
}
