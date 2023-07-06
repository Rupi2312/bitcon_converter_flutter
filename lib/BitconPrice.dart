import 'NetworkHelper.dart';

class BitconPrice{


  Future<dynamic> getCurrencyConverted(var Currency, var Crypto) async{



    var addition=Crypto+ Currency;
    NetworkHelper networkHelper= NetworkHelper('https://apiv2.bitcoinaverage.com/indices/global/ticker/${addition}');
print(addition);
    var currencyData= await networkHelper.getData();
    return currencyData;
  }



}