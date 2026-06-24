import 'package:design_patterns/behavioral/observer/pattern.dart';
import 'package:flutter/material.dart';


class Screen extends StatelessWidget {
  final String category;
  final String subCategory;
  const Screen({super.key,required this.category,required this.subCategory});

  @override
  Widget build(BuildContext context) {
    return  PasswordStrengthPage(category: category,subCategory: subCategory);
  }
}








/// =====================================
///                 State
/// =====================================

class PasswordState {
  final String password;
  final double strength;
  final String label;

  const PasswordState({
    required this.password,
    required this.strength,
    required this.label,
  });
}

/// =====================================
///              Controller
/// =====================================

class PasswordController {

  final Observable<PasswordState> state =
  Observable(
    const PasswordState(
      password: '',
      strength: 0,
      label: 'Empty',
    ),
  );

  void updatePassword(String password) {
    double strength = 0;
    String label = 'Weak';

    if (password.isEmpty) {
      strength = 0;
      label = 'Empty';
    } else if (password.length < 6) {
      strength = 0.25;
      label = 'Weak';
    } else if (password.length < 10) {
      strength = 0.6;
      label = 'Medium';
    } else {
      final hasUpper =
      password.contains(RegExp(r'[A-Z]'));

      final hasNumber =
      password.contains(RegExp(r'[0-9]'));

      final hasSpecial =
      password.contains(
        RegExp(r'[!@#$%^&*(),.?":{}|<>]'),
      );

      final score = [
        hasUpper,
        hasNumber,
        hasSpecial,
      ].where((e) => e).length;

      if (score == 0) {
        strength = 0.7;
        label = 'Medium';
      } else if (score == 1) {
        strength = 0.8;
        label = 'Good';
      } else {
        strength = 1.0;
        label = 'Strong';
      }
    }

    state.setValue(
      PasswordState(
        password: password,
        strength: strength,
        label: label,
      ),
    );
  }
}





/// =====================================
/// UI
/// =====================================


class ObservableBuilder<T> extends StatefulWidget {
  final Observable<T> observable;

  final Widget Function(
      BuildContext context,
      T value,
      ) builder;

  const ObservableBuilder({
    super.key,
    required this.observable,
    required this.builder,
  });

  @override
  State<ObservableBuilder<T>> createState() =>
      _ObservableBuilderState<T>();
}

class _ObservableBuilderState<T> extends State<ObservableBuilder<T>> {
  late T value;

  @override
  void initState() {
    super.initState();

    value = widget.observable.value;

    widget.observable.subscribe(_listener);
  }

  void _listener(T newValue) {
    if (mounted) {
      setState(() {
        value = newValue;
      });
    }
  }

  @override
  void dispose() {
    widget.observable.unsubscribe(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context,
      value,
    );
  }
}






class PasswordStrengthPage extends StatelessWidget {

  final String category;
  final String subCategory;
  const PasswordStrengthPage({super.key,required this.category,required this.subCategory});

  @override
  Widget build(BuildContext context) {
    final controller = PasswordController();

    return Scaffold(
      appBar: AppBar(
        title:  Text('$category / $subCategory',style: TextStyle(fontSize: 15),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ObservableBuilder<PasswordState>(
          observable: controller.state,
          builder: (context, state) {
            return Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                TextField(
                  obscureText: true,
                  onChanged:
                  controller.updatePassword,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),

                const SizedBox(height: 24),

                LinearProgressIndicator(
                  value: state.strength,
                  minHeight: 12,
                ),

                const SizedBox(height: 12),

                Text(
                  'Strength: ${state.label}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  'Length: ${state.password.length}',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}