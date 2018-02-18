
import "package:DollLibCorrect/DollRenderer.dart";
import 'dart:async';
import "TradingCard.dart";
import "CoinCard.dart";
import "RingCard.dart";
import "navbar.dart";

import 'dart:html';

Element div = querySelector("#contents");
Random rand = new Random();

void main() {
    loadNavbar();

  drawDolls();
}

Future<bool> drawDolls() async {
    await drawDoll();
    await drawDoll();
    await drawDoll();
    await drawDoll();
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

