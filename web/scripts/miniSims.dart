
import "DollLib/DollRenderer.dart";
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
    drawDoll(querySelector("#first"));
    drawDoll(querySelector("#second"));
    drawDoll(querySelector("#third"));
    drawDoll(querySelector("#fourth"));
}


Doll makeDoll()  {
  return Doll.makeRandomDoll();
}



Future<bool>  drawDoll(Element innerDiv) async{
    Doll doll = makeDoll();
    CanvasElement finishedProduct = new CanvasElement(width: doll.width, height: doll.height);
    innerDiv.className = "cardWithForm";
    Renderer.drawDoll(finishedProduct, doll);
    finishedProduct.className = "cardCanvas";
    innerDiv.append(finishedProduct);
    div.append(innerDiv);
}

