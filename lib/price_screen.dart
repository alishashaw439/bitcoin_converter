import 'package:flutter/material.dart';

import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CupertinoPicker IOSPicker(){
    List<Text> pickerItems =[];
    for(String currency in currenciesList){
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(itemExtent:40.0 , onSelectedItemChanged:(selectedIndex){
      setState(() {
        selectedCurrency=currenciesList[selectedIndex];
        getCoin();
      });
      print(selectedIndex);
    } , children: pickerItems);
  }
  Widget getPicker(){
    if(Platform.isIOS){
      return IOSPicker();
    }
    else if(Platform.isAndroid){
      return androidDropdown();
    }
  }
  DropdownButton<String> androidDropdown(){

    List<DropdownMenuItem<String>> dropdownItems=[];
    for (String currency in currenciesList) {
      var newItem=DropdownMenuItem(
        child:Text(currency) ,
        value:currency,
      );

      dropdownItems.add(newItem);
    }

    return DropdownButton(
        value:selectedCurrency,
        items: dropdownItems,
        onChanged: (value){
          setState(() {
            selectedCurrency = value;
            getCoin();
          });
        });
  }

  String currencyRate='?';
  String selectedCurrency='USD';

  void getCoin()async{
    try{
      var dataCoin= await CoinData().getData(selectedCurrency);
      setState(() {
        currencyRate=dataCoin;
      });
    }catch(e){
      print(e);
    }
  }
  @override
  void initState(){
    super.initState();
    getCoin();
  }
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
                  '1 BTC = $currencyRate $selectedCurrency',
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
            height: 80.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getPicker(),
          ),
        ],
      ),
    );
  }
}
