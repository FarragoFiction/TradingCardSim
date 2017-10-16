
import "DollLib/DollRenderer.dart";
import 'dart:async';

import 'dart:html';
int width = 322;
int height = 450;
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
  await drawCard();
  await drawCard();
  await drawCard();
  await drawCard();
}

void drawTextBoxForRD(RenderedDoll rd) {

}

Future<CanvasElement>  drawMonster(Doll doll) async {
  double monsterScale = 1.0;
  CanvasElement monsterElement = new CanvasElement(width: (256*monsterScale).round(), height: (206*monsterScale).round());
  Renderer.drawBG(monsterElement, ReferenceColours.BLACK, ReferenceColours.WHITE);
  await Renderer.drawDoll(monsterElement, doll);
  return monsterElement;
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

Future<CanvasElement> drawCardTemplate(Colour color) async{
  CanvasElement cardElement = new CanvasElement(width: width, height: height);
  await Renderer.drawWhatever(cardElement, "images/blank.png");
  Renderer.swapColors(cardElement, color);
  return cardElement;

}

Future<bool>  drawCard() async{
    Colour color = new Colour(rand.nextInt(255), rand.nextInt(255),rand.nextInt(255));
    CanvasElement cardElement = await drawCardTemplate(color);
    Doll doll =  makeDoll();
    RenderedDoll rd = new RenderedDoll(cardElement, doll);

    drawTextBoxForRD(rd);
    CanvasElement monsterElement = await drawMonster(doll);



  CanvasElement finishedProduct = new CanvasElement(width: width, height: height);
  Renderer.drawBG(finishedProduct, color, new Colour(255,255,255));
  //TODO figure out where to draw monster based on monster size.
  /*
    take widht of monster box, divide by 2
    width of doll /2
    x = box/2 - doll/2
    y = box_height/2 - doll_height/2
   */
  int x = (doll.width/2 - monsterElement.width/2).round();
  int y = (3*monsterElement.height/4 - 2*monsterElement.height/4).round();
  finishedProduct.context2D.drawImage(monsterElement, x, y);
  finishedProduct.context2D.drawImage(cardElement, 0, 0);


  div.append(finishedProduct);
}



class RenderedDoll
{
  CanvasElement canvas;
  Doll doll;

  RenderedDoll(this.canvas, this.doll);

}
