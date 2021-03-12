import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_language/lang.dart';
import 'package:flutter_language/themeManage.dart';
import 'package:provider/provider.dart';

Lang strings = Lang();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  strings.setLang(Lang.english);
  runApp(
    ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => new ThemeNotifier(),
      child: EasyLocalization(
          child: MyApp(),
          supportedLocales: [
            Locale('en', 'US'),
            Locale('es', 'SP'),
          ],
          path: 'assets'),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, theme, _) {
        return MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          // Provide dark theme.
          theme: theme.getTheme(),
          locale: context.locale,
          title: 'Flutter Demo',

          home: MyHomePage(title: 'Flutter Demo Home Page', theme: theme),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  final notifier;
  final mode;
  String title;
  final theme;
  MyHomePage({Key key, this.title, this.mode, this.notifier, this.theme})
      : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('title'.tr()),
      ),
      body: Center(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                Container(
                  child: FlatButton(
                    onPressed: () => {
                      print('Set Light Theme'),
                      widget.theme.setLightMode(),
                    },
                    child: Text('Set Light Theme'),
                  ),
                ),
                Container(
                  child: FlatButton(
                    onPressed: () => {
                      print('Set Dark theme'),
                      widget.theme.setDarkMode(),
                    },
                    child: Text('Set Dark theme'),
                  ),
                ),
              ],
            ),
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
            Text('name'.tr()),
            Text('address'.tr()),
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
