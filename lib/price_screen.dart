import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'BitconPrice.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

const List<String> list = <String>['USD', '', 'Three', 'Four'];

int _selectedIndex = 0;
String dropdownValue = currenciesList.first;

class _PriceScreenState extends State<PriceScreen> {
  late String bitcoindata = "?";

  // Widget getPicker() {
  //
  //   if(Platform.isIOS)
  //     {return iosPicker();}
  //
  //   else
  //     { return androidPicker();}
  //
  // }

  CupertinoPicker iosPicker() {
    return CupertinoPicker(
      magnification: 1.22,
      squeeze: 1.2,
      useMagnifier: true,
      itemExtent: 32,
      // This sets the initial item.
      scrollController: FixedExtentScrollController(
        initialItem: 0,
      ),
      // This is called when selected item is changed.
      onSelectedItemChanged: (int selectedItem) async {
        setState(() {
          _selectedIndex = selectedItem;
        });

        BitconPrice bitconPrice = new BitconPrice();

        var Bitcon = await bitconPrice.getCurrencyConverted(
            currenciesList[selectedItem], 'BTC');

        updateUI(Bitcon);
      },
      children: List<Widget>.generate(currenciesList.length, (int index) {
        return Center(child: Text(currenciesList[index]));
      }),
    );
  }

  DropdownButton androidPicker() {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) async {
// This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
        BitconPrice bitconPrice = new BitconPrice();

        var Bitcon = await bitconPrice.getCurrencyConverted(value, 'BTC');

        print(value!);
        updateUI(Bitcon);
      },
      items: currenciesList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  void updateUI(dynamic BitconPrice) {
    print("updating UI");

    if (BitconPrice != null) {
      setState(() {
        double val = BitconPrice['last'];

        bitcoindata = val.toString();
      });
    } else {
      print("bitcoin price null");
    }
  }
//

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC =  $bitcoindata  USD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: iosPicker(),
          ),
        ],
      ),
    );
  }
}

//
