
import "DollLib/DollRenderer.dart";
import 'dart:async';
import "TradingCard.dart";
import "navbar.dart";

import 'dart:html';

Element div = querySelector("#contents");
Random rand = new Random();

void main() {
    loadNavbar();
  ButtonElement button = new ButtonElement();
  button.setInnerHtml("Draw Card");
  button.onClick.listen((Event e) {
    drawCard();
  });
  div.append(button);
  drawDeck();
}

Future<bool> drawDeck() async {
  for(int i = 0; i<8; i++) {
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
    innerDiv.className = "cardWithForm";
    TradingCard card = new TradingCard(makeDoll());
    CanvasElement finishedProduct = await card.draw();
    finishedProduct.className = "cardCanvas";
    innerDiv.append(finishedProduct);
    innerDiv.append(card.makeForm());
    div.append(innerDiv);
}

