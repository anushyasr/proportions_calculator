import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

void removeFocus(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    currentFocus.focusedChild.unfocus();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        removeFocus(context);
      },
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.redAccent,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'Proportions Calculator'),
      ),
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
  double _margin = 10.0;

  double _result = 0;

  var _aText = TextEditingController();
  var _bText = TextEditingController();
  var _cText = TextEditingController();
  var _dText = TextEditingController();

  double _a = 0;
  double _b = 0;
  double _c = 0;
  double _d = 0;

  void handleAChange(String value) {
    setState(() {
      this._a = double.parse(value != '' ? value : 0.0);
    });
  }

  void handleBChange(String value) {
    setState(() {
      this._b = double.parse(value != '' ? value : 0.0);
    });
  }

  void handleCChange(String value) {
    setState(() {
      this._c = double.parse(value != '' ? value : 0.0);
    });
  }

  void handleDChange(String value) {
    setState(() {
      this._d = double.parse(value != '' ? value : 0.0);
    });
  }

  void calculate() {
    removeFocus(context);
    setState(() {
      if (_a == 0) {
        this._result = _b * _c / _d;
      } else if (_b == 0) {
        this._result = _a * _d / _c;
      } else if (_c == 0) {
        this._result = _a * _d / _b;
      } else {
        this._result = _b * _c / _a;
      }
    });
  }

  void reset() {
    removeFocus(context);
    setState(() {
      this._aText.clear();
      this._bText.clear();
      this._cText.clear();
      this._dText.clear();
      this._result = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        margin: EdgeInsets.all(_margin),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
              margin: EdgeInsets.symmetric(vertical: 30.0),
              child: Text('A : B = C : D',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ))),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 150.0,
                  margin: EdgeInsets.symmetric(horizontal: _margin),
                  child: TextField(
                    controller: _aText,
                    decoration: InputDecoration(
                        labelText: 'A',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        )),
                    onChanged: this.handleAChange,
                  ),
                ),
                Container(
                  width: 150.0,
                  margin: EdgeInsets.symmetric(horizontal: _margin),
                  child: TextField(
                    controller: _bText,
                    decoration: InputDecoration(
                        labelText: 'B',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        )),
                    onChanged: this.handleBChange,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 150.0,
                  margin: EdgeInsets.symmetric(horizontal: _margin),
                  child: TextField(
                    controller: _cText,
                    decoration: InputDecoration(
                        labelText: 'C',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        )),
                    onChanged: this.handleCChange,
                  ),
                ),
                Container(
                  width: 150.0,
                  margin: EdgeInsets.symmetric(horizontal: _margin),
                  child: TextField(
                    controller: _dText,
                    decoration: InputDecoration(
                        labelText: 'D',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        )),
                    onChanged: this.handleDChange,
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 150.0,
                  margin: EdgeInsets.symmetric(horizontal: _margin),
                  child: RaisedButton(
                    child: Text(
                      'Calculate',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: calculate,
                    padding: EdgeInsets.symmetric(
                      vertical: 15.0,
                    ),
                    color: Colors.redAccent,
                  ),
                ),
                Container(
                  width: 150.0,
                  margin: EdgeInsets.symmetric(horizontal: _margin),
                  child: RaisedButton(
                    child: Text(
                      'Reset',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: reset,
                    padding: EdgeInsets.symmetric(
                      vertical: 15.0,
                    ),
                    color: Colors.teal,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            child: Text('Result',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                )),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 0.0),
            child: Text('$_result',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.deepOrange,
                )),
          ),
        ]),
      ),
    );
  }
}
