import 'package:http/http.dart' as http;
import 'dart:convert';
//const api='A8DF112D-1C28-4CE4-ABA6-8E42870D1ACA';


const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future getData(String selectedCurrency) async{
    var reqUrl='https://rest.coinapi.io/v1/exchangerate/BTC/$selectedCurrency?apikey=A8DF112D-1C28-4CE4-ABA6-8E42870D1ACA';

    http.Response response= await http.get(reqUrl);
    print(response.body);

    //selectedCurrency=jsonDecode(data)['asset_id_quote'];
    if(response.statusCode==200){
      var data=response.body;
      var currencyRate=jsonDecode(data)['rate'];
      return currencyRate.toStringAsFixed(0);
    }else{
      print(response.statusCode);
      throw 'Problem with the get request';
    }



  }
}
