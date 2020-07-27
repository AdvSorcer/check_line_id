import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = '詐騙ID查詢';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final _formKey = GlobalKey<FormState>();

  Map allData = new Map();

  @override
  void initState() {
    super.initState();
  }

  Future<Response> getHttp() async {
    try {
      Response response = await Dio().get(
          "https://od.moi.gov.tw/api/v1/rest/datastore/A01010000C-001277-053");
      if (response.statusCode == 200) {
        return response;
      }
    } catch (e) {
      print("錯誤$e");
    }
  }

  @override
  Widget build(BuildContext context) {
//    return Form(
//      key: _formKey,
//      child: Column(
//        crossAxisAlignment: CrossAxisAlignment.start,
//        children: <Widget>[
//          TextFormField(
//            decoration: const InputDecoration(
//              hintText: '輸入ID',
//            ),
//            validator: (value) {
//              if (value.isEmpty) {
//                return '清輸入再送出';
//              }
//              return null;
//            },
//          ),
//          Padding(
//            padding: const EdgeInsets.symmetric(vertical: 16.0),
//            child: RaisedButton(
//              onPressed: () {
//                if (_formKey.currentState.validate()) {
//                  getHttp();
//                }
//              },
//              child: Text('查詢'),
//            ),
//          ),
//        ],
//      ),
//    );
    return myFutureBuilder(getHttp());
  }
}

//TODO : 需要解決set State 重複問題
//TODO：了解如何解析複雜ＪＳＯＮ

FutureBuilder myFutureBuilder(Future future) {
  return FutureBuilder(
    future: future,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      Response res = snapshot.data;
      print(res.data);
      return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: 2,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
//            title: Text(res.data["success"]),
            title: Text("sss"),
          );
        },
      );
    },
  );
}
