import 'dart:math';
import 'package:design_patterns/behavioral/chain_of_responsibility/pattern.dart';
import 'package:flutter/material.dart';



class Screen extends StatefulWidget {
  final String category;
  final String subCategory;
  const Screen({super.key,required this.category,required this.subCategory});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {


  final List<String> steps = [
    "Validate Request",
    "Authenticate User",
    "Check Permissions",
    "Process Data",
    "Return Response",
  ];

  final Map<String, String> statuses = {};

  @override
  void initState() {
    super.initState();

    for (final step in steps) {
      statuses[step] = "pending";
    }
  }



  Future<void> runFlow() async {
    setState(() {
      statuses.clear();

      for (final step in steps) {
        statuses[step] = "pending";
      }
    });

    final chain = ValidateRequestHandler(
      AuthenticateUserHandler(
        CheckPermissionHandler(
          ProcessDataHandler(
            ReturnResponseHandler(),
          ),
        ),
      ),
    );

    final context = RequestContext(
      onUpdate: (step, status) {
        if (!mounted) return;

        setState(() {
          statuses[step] = status;
        });
      },
    );

    await chain.handle(context);
  }

  Color getColor(String step) {
    final status = statuses[step];

    switch (status) {
      case "running":
        return Color(0xff18bde8);

      case "success":
        return Color(0xff25c33e);

      case "fail":
        return Color(0xffe40931);

      default:
        return Colors.grey.shade700;
    }
  }

  IconData getIcon(String step) {
    final status = statuses[step];

    switch (status) {
      case "success":
        return Icons.check;

      case "fail":
        return Icons.close;

      case "running":
        return Icons.hourglass_top;

      default:
        return Icons.circle_outlined;
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.white,
      appBar: AppBar(
        title:  Text('${widget.category} / ${widget.subCategory}',style: TextStyle(fontSize: 15),),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: List.generate(
                  steps.length,
                      (index) {
                    final step = steps[index];

                    return Column(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(
                            milliseconds: 300,
                          ),
                          width: 220,
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.symmetric(
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color:Colors.grey.shade200,
                            //color: getColor(step),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                getIcon(step),
                                color: getColor(step),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  step,
                                  style:  TextStyle(
                                    color: getColor(step),
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (index != steps.length - 1)
                          const Icon(
                            Icons.arrow_downward,
                            color: Colors.black38,
                          ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: runFlow,
                child: const Text(
                  "Run Request",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





/// ======================================================
/// Request Context
/// ======================================================

class RequestContext {
  final void Function(String step, String status) onUpdate;

  RequestContext({
    required this.onUpdate,
  });
}







abstract class RequestHandler extends ChainHandler<RequestContext> {
  final String stepName;

  RequestHandler(
      this.stepName, [
        ChainHandler<RequestContext>? next,
      ]) : super(next);

  @override
  Future<bool> handle(RequestContext context) async {
    context.onUpdate(stepName, "running");

    await Future.delayed(
      const Duration(milliseconds: 700),
    );

    final success = await process(context);

    if (!success) {
      context.onUpdate(stepName, "fail");
      return false;
    }

    context.onUpdate(stepName, "success");

    return await nextHandle(context);
  }

  Future<bool> process(RequestContext context);
}






/// ======================================================
///  Handlers
/// ======================================================

class ValidateRequestHandler extends RequestHandler {
  ValidateRequestHandler([
    ChainHandler<RequestContext>? next,
  ]) : super(
    "Validate Request",
    next,
  );

  @override
  Future<bool> process(RequestContext context) async {
    return true;
  }
}

class AuthenticateUserHandler extends RequestHandler {
  AuthenticateUserHandler([
    ChainHandler<RequestContext>? next,
  ]) : super(
    "Authenticate User",
    next,
  );

  @override
  Future<bool> process(RequestContext context) async {
    return true;
  }
}

class CheckPermissionHandler extends RequestHandler {
  CheckPermissionHandler([
    ChainHandler<RequestContext>? next,
  ]) : super(
    "Check Permissions",
    next,
  );

  @override
  Future<bool> process(RequestContext context) async {
    return !Random().nextBool();
  }
}

class ProcessDataHandler extends RequestHandler {
  ProcessDataHandler([
    ChainHandler<RequestContext>? next,
  ]) : super(
    "Process Data",
    next,
  );

  @override
  Future<bool> process(RequestContext context) async {
    return true;
  }
}

class ReturnResponseHandler extends RequestHandler {
  ReturnResponseHandler([
    ChainHandler<RequestContext>? next,
  ]) : super(
    "Return Response",
    next,
  );

  @override
  Future<bool> process(RequestContext context) async {
    return true;
  }
}


