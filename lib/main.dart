import 'package:design_patterns/data.dart';
import 'package:flutter/material.dart';




void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Design Patterns',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const PatternsPage(),
    );
  }
}










class PatternsPage extends StatelessWidget {
  const PatternsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Design Patterns"),
      ),

      body: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 16),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];

            return ExpansionTile(
              title: Text(
                category.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),

              children: category.subCategories.map((sub) {
                return Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: ExpansionTile(
                    title: Text(sub.name),

                    children: sub.items.map((item) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 24),
                        child: ListTile(
                          contentPadding: const EdgeInsets.only(left: 32, right: 16),
                          title: Text(item.name,style: TextStyle(fontSize: 14),),
                         // trailing: const Icon(Icons.arrow_forward_ios, size: 14,color: Colors.blue,),
                          leading: Icon(Icons.circle,size: 8,),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => item.page(),
                              ),
                            );
                          },
                        ),
                      );
                    }).toList(),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}