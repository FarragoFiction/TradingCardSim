
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
  WeightedList<Doll> dolls = new WeightedList<Doll>();
  dolls.add(new HomestuckDoll());
  dolls.add(new HomestuckTrollDoll());
  dolls.add(new ConsortDoll());
  dolls.add(new DenizenDoll());
  dolls.add(new EggDoll(),0.5);
  dolls.add(new TrollEggDoll(), 0.5);
  dolls.add(new DadDoll());

  doll = rand.pickFrom(dolls);
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

