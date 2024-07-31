import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Steam Concept',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const SteamConcept(),
    );
  }
}

class SteamConcept extends StatelessWidget {
  const SteamConcept({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    // final StreamController<List<String>> streamController =
    //     StreamController<List<String>>();
    StreamController streamController = StreamController();
    final List<String> languageList = [];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Steam Concept App"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextFormField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Language'),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final language = controller.text;
                  if (language.isNotEmpty) {
                    languageList.add(language);
                    streamController.sink.add(languageList);
                    controller.clear();
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  backgroundColor: Colors.red[400],
                  foregroundColor: Colors.white,
                ),
                child: const Text('Add'),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: StreamBuilder(
                stream: streamController.stream,
                builder: (_, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text('Please add some language in the list'),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) {
                        return Card(
                          child: ListTile(
                            title: Text(snapshot.data![index]),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
