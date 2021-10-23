import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_future/data/postal_code.dart';
import 'package:riverpod_future/provider.dart';

void main() {
  runApp(const MyApp());
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
      home: ProviderScope(child: MyHomePage(title: 'Flutter Demo Home Page')),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              onChanged: (text) {
                if (text.length != 7) {
                  return;
                }
                try {
                  int.parse(text);
                  ref.read(textProvider).state = text;
                  ref.refresh(apiProvider);
                  //print(text);
                } catch (ex) {}
              },
            ),
            ref.watch(apiProvider).when(
                  data: (data) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data.data[0].en.prefecture),
                      Text(data.data[0].en.address1),
                      Text(data.data[0].en.address2),
                      Text(data.data[0].en.address3),
                      Text(data.data[0].en.address4),
                    ],
                  ),
                  error: (error, stack, data) =>
                      Text('No PostCode: ${ref.watch(textProvider).state}'),
                  loading: (data) => const CircularProgressIndicator(),
                ),
          ],
        ),
      ),
    );
  }
}
