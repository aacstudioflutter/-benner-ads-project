import 'dart:math';

import 'package:bennerads/AdmobHelper.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AdmobHelper.initialization();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late List<String> datas;
  late List<Object> dataads;

  AdmobHelper admobHelper =AdmobHelper();

  void listdatas(){
    datas=[];

    for(int i=1;i<=20;i++){
      datas.add("List Item $i");
    }
    dataads =List.from(datas);
    for(int i=1;i<=2; i++){
      var min= 1;
      var random =new Random();
      var rannumpos=min+ random.nextInt(18);
      dataads.insert(rannumpos, AdmobHelper.getBannerAd()..load());
    }


  }
  @override
  void initState() {
    // TODO: implement initState
    listdatas();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Admob test'),
        backgroundColor: Colors.black12,
      ),
      body: ListView.builder(
          itemCount: dataads.length,
          itemBuilder: (context,index){
            if(dataads[index] is String){
              return ListTile(
                title: Text(dataads[index].toString()),
                leading: Icon(Icons.add),
                trailing: Icon(Icons.settings),
                onTap:(){
                  admobHelper.createInterstitialAd();
                },
                onLongPress: (){
                  admobHelper.showInterstitialAd();
                },
              );
            }else{
              final Container adcontent = Container(
                child: AdWidget(
                  ad: dataads[index] as BannerAd,
                  key: UniqueKey(),
                ),
                height: 50,
              );
              return adcontent;
            }

          }),
      bottomNavigationBar: Container(
        child: AdWidget(
          ad:AdmobHelper.getBannerAd()..load(),
          key:  UniqueKey(),
        ),
        height: 50,
      ),
    );
  }
}