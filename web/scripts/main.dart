
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
    storeCard("N4Igzg9grgTgxgUxALhAWQIYGsEAIAiEANkbgCowYAmAlgHYDmuAwhjFWCADQh0YC2SVAAUiGAJ4s2HbiAAuCAB5yUIXBADudBDAR9BMXAAcx4sLgy44ACxpEquuubjTcDAXgx0quaxnOWuhgkkgxBcrhyNIIAdLIARhhwWGHQ3gByHqoAytYQDFB0AOIQ2VD8-BB0AKKKJhC0GDFGjLJyMDQMDDrMfnSIqgAMMQCssmCI2mBkEACqdEQQyaoA2gC6srpgUERyYNlyGHurwAA6vB7nyOcAkmgAgkU36fdkNwDy6edc5wBuwVAEFdzgBGc4AXw2PHanW6MAORzAABkEGAwDpVlD5B0ujoEXsiuEMagVmcLoJgSBHtVvn8AUCUKCRhCsTDcfDDntqgBHKDBTEgcFAA");
  ButtonElement button = new ButtonElement();
  button.setInnerHtml("Draw Card");
  button.onClick.listen((Event e) {
    drawCard();
  });
  div.append(button);
  drawDeck();
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

Future<bool> drawDeck() async {
  for(int i = 0; i<4; i++) {
    await drawCard();
  }

}


Doll makeDoll()  {
  Doll doll;
  WeightedList<Doll> dolls = new WeightedList<Doll>();
  dolls.add(new HomestuckDoll(),3);
  dolls.add(new HomestuckTrollDoll(),3);
  dolls.add(new HomestuckBabyDoll(),1);
  dolls.add(new HomestuckGrubDoll(),1);
  dolls.add(new ConsortDoll(),0.5);
  dolls.add(new DenizenDoll(),0.5);
  dolls.add(new QueenDoll(),0.5);
  dolls.add(new EggDoll(),0.25);
  dolls.add(new TrollEggDoll(), 0.25);
  dolls.add(new DadDoll(),0.4);
  dolls.add(new MomDoll(),0.4);

  doll = rand.pickFrom(dolls);
  //doll = new BroDoll();
  return doll;
}



Future<bool>  drawCard() async{
    Element innerDiv  = new DivElement();
    innerDiv.className = "cardWithForm";
    double randNum = rand.nextDouble();
    TradingCard card;
    if(randNum > .1) {
        card = new TradingCard(makeDoll());
    }else if(randNum > .05) {
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

