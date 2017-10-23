
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
  }else if (randNum > 0.10) {
    doll = new DenizenDoll();
  }else {
      if(randNum % 2 == 0) {
          doll = new EggDoll();
      }else {
          doll = new TrollEggDoll();
      }
  }
  return doll;
}



Future<bool>  drawCard() async{
    Element innerDiv  = new DivElement();
    innerDiv.className = "cardWithForm";
    double randNum = rand.nextDouble();
    TradingCard card;
    if(randNum > .2) {
        card = new TradingCard(makeDoll());
    }else if(randNum > .1) {
        card = new CoinCard(makeDoll());
    }else {
        card = new RingCard(makeDoll());
    }
    CanvasElement finishedProduct = await card.draw();
    finishedProduct.className = "cardCanvas";
    innerDiv.append(finishedProduct);
    innerDiv.append(card.makeForm());
    div.append(innerDiv);
}

