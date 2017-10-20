
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
  //TODO why is the first card always untinted?
  for(int i = 0; i<2; i++) {
    await drawCard();
  }

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
    Element innerDiv  = new DivElement();
    TradingCard card = new TradingCard(makeDoll());
    CanvasElement finishedProduct = await card.draw();
    innerDiv.append(finishedProduct);
    innerDiv.append(card.makeForm());
    div.append(innerDiv);
}

