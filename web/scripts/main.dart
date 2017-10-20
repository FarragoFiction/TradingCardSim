
import "DollLib/DollRenderer.dart";
import 'dart:async';
import "TradingCard.dart";

import 'dart:html';

Element div = querySelector("#output");
Random rand = new Random();

void main() {

  drawDeck();
}

Future<bool> drawDeck() async {
  await drawCard();
  await drawCard();
  await drawCard();
  await drawCard();
}


Doll makeDoll()  {
  Doll doll;
  double randNum = rand.nextDouble();

  if(randNum > 0.75) {
    doll = new HomestuckDoll();
  }else if (randNum > 0.5) {
    doll = new HomestuckTrollDoll();
  } else if (randNum > 0.25) {
    doll = new ConsortDoll();
  }else {
    doll = new DenizenDoll();
  }
  return doll;
}



Future<bool>  drawCard() async{
    TradingCard card = new TradingCard(makeDoll());
    CanvasElement finishedProduct = await card.draw();
    div.append(finishedProduct);
}

