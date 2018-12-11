
import 'package:CommonLib/Random.dart';
import "package:DollLibCorrect/DollRenderer.dart";
import 'dart:async';
import "TradingCard.dart";
import "CoinCard.dart";
import "RingCard.dart";
import "navbar.dart";

import 'dart:html';

Element div = querySelector("#contents");
Random rand = new Random();

Future<Null> main() async{
    loadNavbar();
    storeCard("N4Igzg9grgTgxgUxALhAGQQQxgOwJY4DmABJgEbQAuxAsgXgMp4C2YIANCDps0qgOIRilIQHkYCQhBwcQlBAA9KKEMQgB3HAgndeMYgBMEcPEbDChAB0xwA1sQQA3bQE9KACwIkol0jgPEzBDOFsTiktIAdMQAmtCkcIiW1B54YNFxUAlJ1E6uqUTEBMKe5mCelJQuxIQ8CJGyZDa2hDDQ-gBydSoAkmAAKqUMFVUAojjQhO4AUgBKkZZEspQweISE2gDC7pg4iCoADJEArLJgiFoDEACqOAA2EHYqANoAurISYFB3lGAMlJhfi9gAAdLh1MHIMH8DqiBg9Bhg9hgxyYO5QBCQsEARjBAF93pwVmsNjB-oCwBgwGBtC9CXJVuttOTfvwJIDaahnqDwbwsSAYXCEUiUWiMfzcSACctGaSWWBRgBHKBoulSoA");
    await Doll.loadFileData();

  drawDolls();
}

Future<bool> drawDolls() async {
    await drawDoll();
    await drawDoll();
    await drawDoll();
    await drawDoll();
}

void storeCard(String card) {
    String key = "LIFESIMFOUNDCARDS";
    if(window.localStorage.containsKey(key)) {
        String existing = window.localStorage[key];
        List<String> parts = existing.split(",");
        if(!parts.contains(card)) window.localStorage[key] = "$existing,$card";
    }else {
        window.localStorage[key] = card;
    }
}

Doll makeDoll()  {
  return Doll.makeRandomDoll();
}



Future<bool>  drawDoll() async{
    Element innerDiv   = new DivElement();
    Doll doll = makeDoll();
    CanvasElement finishedProduct = new CanvasElement(width: doll.width, height: doll.height);
    innerDiv.className = "cardWithForm";
    await DollRenderer.drawDoll(finishedProduct, doll);
    finishedProduct.className = "cardCanvas";
    innerDiv.append(finishedProduct);
    div.append(innerDiv);
}

