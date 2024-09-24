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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget kalbutton(String btntxt, Color btncolor, Color txtColor) {
    return Container(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(12.0),
            minimumSize: Size(75.0,75.0),
            shape: CircleBorder(),
            backgroundColor: btncolor),
        onPressed: () {
          kalkulator(btntxt);
        },
        child: Text(
          '$btntxt',
          style: TextStyle(
            fontSize: 35,
            color: txtColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                reverse: true,
                child: Row(
                  children: [
                    Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 280.0),
                          child: Text(
                            '$text',
                            textAlign: TextAlign.right,
                            style: TextStyle(color: Colors.white, fontSize: 80),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  kalbutton("AC", Colors.grey, Colors.black),
                  kalbutton("+/-", Colors.grey, Colors.black),
                  kalbutton('%', Colors.grey, Colors.black),
                  kalbutton('÷', Colors.amber[700]!, Colors.white),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  kalbutton("7", Colors.grey[900]!, Colors.white),
                  kalbutton("8", Colors.grey[900]!, Colors.white),
                  kalbutton('9', Colors.grey[900]!, Colors.white),
                  kalbutton('x', Colors.amber[700]!, Colors.white),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  kalbutton("4", Colors.grey[900]!, Colors.white),
                  kalbutton("5", Colors.grey[900]!, Colors.white),
                  kalbutton('6', Colors.grey[900]!, Colors.white),
                  kalbutton('-', Colors.amber[700]!, Colors.white),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  kalbutton("1", Colors.grey[900]!, Colors.white),
                  kalbutton("2", Colors.grey[900]!, Colors.white),
                  kalbutton('3', Colors.grey[900]!, Colors.white),
                  kalbutton('+', Colors.amber[700]!, Colors.white),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      kalkulator('0');
                    },
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      padding: EdgeInsets.fromLTRB(30, 7, 105, 7),
                      backgroundColor: Colors.grey[900],
                    ),
                    child: Text(
                      '0',
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  kalbutton('.', Colors.grey[900]!, Colors.white),
                  kalbutton('=', Colors.amber[700]!, Colors.white),
                ],
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ));
  }

  dynamic text = '0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';
  void kalkulator(btnText) {
    // Matn uzunligini tekshirish (Masalan: 15 belgidan oshsa)
    if (result.length >= 9 &&
        btnText != 'AC' &&
        btnText != '=' &&
        btnText != '+' &&
        btnText != '-' &&
        btnText != 'x' &&
        btnText != '÷' &&
        btnText != '%') {
      return; // Agar belgilar uzunligi 15 dan oshsa, boshqa belgi kiritishni to'xtatadi.
    }
    if (btnText == 'AC') {
      text = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    } else if (btnText == '=') {
      numTwo =
          double.parse(result); // numTwo ni faqat tenglik bosilganda yangilash
      if (opr == '+') {
        finalResult = add();
      } else if (opr == '-') {
        finalResult = sub();
      } else if (opr == 'x') {
        finalResult = mul();
      } else if (opr == '÷') {
        finalResult = div();
      }
      opr = ''; // Yangilashni to'g'rilab qo'yamiz
      preOpr = ''; // preOprni tozalaymiz
      result = finalResult;
    } else if (btnText == '+' ||
        btnText == '-' ||
        btnText == 'x' ||
        btnText == '÷') {
      if (opr.isEmpty) {
        numOne = double.parse(result); // Birinchi raqam
      } else {
        numTwo = double.parse(result); // Ikkinchi raqam
        if (opr == '+') {
          finalResult = add();
        } else if (opr == '-') {
          finalResult = sub();
        } else if (opr == 'x') {
          finalResult = mul();
        } else if (opr == '÷') {
          finalResult = div();
        }
        numOne = double.parse(
            finalResult); // Natijani birinchi raqam sifatida saqlaymiz
      }
      preOpr = opr; // Avvalgi operatorni saqlaymiz
      opr = btnText; // Yangi operatorni saqlaymiz
      result = ''; // Natijani tozalaymiz
    } else if (btnText == '%') {
      result = (numOne / 100).toString();
      finalResult = doesContainDecimal(result);
    } else if (btnText == '.') {
      if (!result.toString().contains('.')) {
        result = result.toString() + '.';
      }
      finalResult = result;
    } else if (btnText == '+/-') {
      result.toString().startsWith('-')
          ? result = result.toString().substring(1)
          : result = '-' + result.toString();
      finalResult = result;
    } else {
      result = result + btnText; // Raqamlar kiritilayotganda yangilash
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }
}
