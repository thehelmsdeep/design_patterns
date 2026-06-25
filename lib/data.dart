import 'package:flutter/material.dart';
import 'behavioral/observer/implementation.dart';
import 'behavioral/chain_of_responsibility/implementation.dart';
import 'behavioral/observer/implementation_2.dart';




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
            name: "1 listener",
            page: () => PasswordStrengthPage(
              category: 'Behavioral',
              subCategory: 'Observer / 1 listener',
            ),
          ),

          PatternExample(
            name: "more listeners",
            page: () => ObserverDashboard(
              category: 'Behavioral',
              subCategory: 'Observer / more listeners ',
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
            page: () => ChainScreen(
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