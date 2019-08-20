import 'package:flutter/material.dart';
import 'package:flutter_app_2/localizations.dart';
import 'package:flutter_app_2/screens/page_edit_fueling.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:flutter_app_2/model/fuel_list_model.dart';
import 'package:flutter_app_2/persistor.dart';
import 'package:flutter_app_2/screens/page_add_data.dart';
import 'package:flutter_app_2/screens/page_history.dart';
import 'package:flutter_app_2/screens/page_stats.dart';
import 'package:flutter_app_2/screens/start.dart';

class FuelApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final persistor = Persistor();
    final model =
        FuelingListModel(onSave: (model) => persistor.save(model.fuelings));

    persistor.load().then((data) => model.import(data));

    return ScopedModel<FuelingListModel>(
      model: model,
      child: MaterialApp(
        home: FuelAppMain(),
        initialRoute: '/',
        theme: ThemeData(
            primarySwatch: Colors.green, backgroundColor: Colors.white),
        routes: {
          '/start': (context) => StartPage(),
          '/main': (context) => FuelAppMain(),
          '/edit_fueling': (context) => PageEditFueling(),
        },
        localizationsDelegates: [
          AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: [Locale("en"), Locale("pl")],
        onGenerateTitle: (BuildContext context) =>
        AppLocalizations.of(context).title,
      ),
    );
  }
}

class FuelAppMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.add)),
              Tab(icon: Icon(Icons.history)),
              Tab(icon: Icon(Icons.equalizer)),
            ],
          ),
          title: Text('Fuel app'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.local_gas_station),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StartPage()),
                );
              },
            ),
          ],
        ),
        body: TabBarView(
          children: [
            PageAddData(),
            PageHistory(),
            PageStatistics(),
          ],
        ),
      ),
    );
  }
}
