import 'package:flutter/material.dart';
import 'behavioral/observer/implementation.dart' as observer;
import 'behavioral/strategy/implementation.dart' as strategy;
import 'behavioral/chain_of_responsibility/implementation.dart' as chain;
import 'creational/singleton/implementation.dart' as singleton;
import 'creational/factory/implementation.dart' as appFactory;
import 'creational/builder/implementation.dart' as builder;
import 'structural/adapter/implementation.dart' as adapter;
import 'structural/decorator/implementation.dart' as decorator;
import 'structural/facade/implementation.dart' as facade;

class PatternItem {
  final String name;
  final Widget Function() page;

  PatternItem({required this.name, required this.page});
}

class PatternCategory {
  final String name;
  final List<PatternItem> items;

  PatternCategory({required this.name, required this.items});
}

final List<PatternCategory> categories = [
  PatternCategory(
    name: "Creational",
    items: [
      PatternItem(
        name: "Singleton",
        page: () =>
            singleton.Screen(category: 'Behavioral', subCategory: 'Singleton'),
      ),
      PatternItem(
        name: "Factory",
        page: () =>
            appFactory.Screen(category: 'Behavioral', subCategory: 'Factory'),
      ),
      PatternItem(
        name: "Builder",
        page: () =>
            builder.Screen(category: 'Behavioral', subCategory: 'Builder'),
      ),
    ],
  ),
  PatternCategory(
    name: "Behavioral",
    items: [
      PatternItem(
        name: "Chain of Responsibility",
        page: () => chain.Screen(
          category: 'Behavioral',
          subCategory: 'Chain of Responsibility',
        ),
      ),
      PatternItem(
        name: "Observer",
        page: () =>
            observer.Screen(category: 'Behavioral', subCategory: 'Observer'),
      ),
      PatternItem(
        name: "Strategy",
        page: () =>
            strategy.Screen(category: 'Behavioral', subCategory: 'Strategy'),
      ),
    ],
  ),

  PatternCategory(
    name: "Structural",
    items: [
      PatternItem(
        name: "Adapter",
        page: () =>
            adapter.Screen(category: 'Behavioral', subCategory: 'Adapter'),
      ),
      PatternItem(
        name: "Decorator",
        page: () =>
            decorator.Screen(category: 'Behavioral', subCategory: 'Decorator'),
      ),
      PatternItem(
        name: "Facade",
        page: () => facade.Screen(category: 'Behavioral', subCategory: 'Facade'),
      ),
    ],
  ),
];
