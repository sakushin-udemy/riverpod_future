import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_future/provider.dart';

void main() {
  runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postalCode = ref.watch(apiProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              onChanged: (text) => onPostalCodeChanged(ref, text),
            ),
            postalCode.when(
              data: (data) => Column(
                children: [
                  Text(data.data[0].en.prefecture),
                  Text(data.data[0].en.address1),
                  Text(data.data[0].en.address2),
                  Text(data.data[0].en.address3),
                  Text(data.data[0].en.address4),
                ],
              ),
              error: error,
              loading: loading,
            )
          ],
        ),
      ),
    );
  }

  void onPostalCodeChanged(WidgetRef ref, String text) {
    if (text.length != 7) {
      return;
    }

    try {
      int.parse(text);
      ref.watch(postalCodeProvider).state = text;
      print(text);
    } catch (ex) {}
  }
}
