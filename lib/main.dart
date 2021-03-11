import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_language/lang.dart';
import 'package:flutter_language/languageConstants.dart';

Lang strings = Lang();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  strings.setLang(Lang.english);
  runApp(
    EasyLocalization(
        child: MyApp(),
        supportedLocales: [
          Locale('en', 'US'),
          Locale('es', 'SP'),
        ],
        path: 'assets'),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  FixedLanguage lang = FixedLanguage();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                TextButton(
                  onPressed: () async {
                    setState(() {
                      context.locale = Locale('en', 'US');
                    });
                  },
                  child: Text("English"),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      context.locale = Locale('es', 'SP');
                    });
                  },
                  child: Text("Spenish"),
                ),
              ],
            ),
            Text(lang.name).tr(),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
