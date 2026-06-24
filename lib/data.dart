import 'package:flutter/material.dart';

import 'behavioral/observer/implementation.dart' as observer;
import 'behavioral/strategy/implementation.dart' as strategy;
import 'behavioral/chain_of_responsibility/implementation.dart' as chain;

import 'creational/singleton/implementation.dart' as singleton;
import 'creational/factory/implementation.dart' as ffactory;
import 'creational/builder/implementation.dart' as builder;

import 'structural/adapter/implementation.dart' as adapter;
import 'structural/decorator/implementation.dart' as decorator;
import 'structural/facade/implementation.dart' as facade;




class PatternExample {
  final String name;
  final Widget Function() page;

  PatternExample({
    required this.name,
    required this.page,
  });
}




class PatternSubCategory {
  final String name;
  final List<PatternExample> items;

  PatternSubCategory({
    required this.name,
    required this.items,
  });
}




class PatternCategory {
  final String name;
  final List<PatternSubCategory> subCategories;

  PatternCategory({
    required this.name,
    required this.subCategories,
  });
}







final List<PatternCategory> categories = [
  PatternCategory(
    name: "Creational",
    subCategories: [
      PatternSubCategory(
        name: "Singleton",
        items: [

        ],
      ),
      PatternSubCategory(
        name: "Factory",
        items: [

        ],
      ),
      PatternSubCategory(
        name: "Builder",
        items: [

        ],
      ),
    ],
  ),

  PatternCategory(
    name: "Behavioral",
    subCategories: [
      PatternSubCategory(
        name: "Observer",
        items: [
          PatternExample(
            name: "Password Strength Checker",
            page: () => observer.Screen(
              category: 'Behavioral',
              subCategory: 'Observer',
            ),
          ),
        ],
      ),
      PatternSubCategory(
        name: "Strategy",
        items: [

        ],
      ),
      PatternSubCategory(
        name: "Chain of Responsibility",
        items: [
          PatternExample(
            name: "A request",
            page: () => chain.Screen(
              category: 'Behavioral',
              subCategory: 'Chain',
            ),
          ),
        ],
      ),
    ],
  ),

  PatternCategory(
    name: "Structural",
    subCategories: [
      PatternSubCategory(
        name: "Adapter",
        items: [

        ],
      ),
      PatternSubCategory(
        name: "Decorator",
        items: [

        ],
      ),
      PatternSubCategory(
        name: "Facade",
        items: [

        ],
      ),
    ],
  ),
];