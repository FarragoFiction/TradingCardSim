
import "DollLib/DollRenderer.dart";
import 'dart:async';

import 'dart:html';
int width = 322;
int height = 450;
List<RenderedDoll> renderedDolls = new List<RenderedDoll>();
Element div = querySelector("#output");

void main() {

  drawCard();
}

//TODO why is only one thing being drawn here.
Future<bool>  drawCard() async{
  CanvasElement monsterElement = new CanvasElement(width: 256, height: 206);
  CanvasElement cardElement = new CanvasElement(width: width, height: height);
  Doll doll = new HomestuckDoll();
  renderedDolls.add(new RenderedDoll(cardElement, doll));
  await Renderer.drawWhatever(cardElement, "images/blank.png");
  await Renderer.drawDoll(monsterElement, doll);


  CanvasElement finishedProduct = new CanvasElement(width: width, height: height);
  finishedProduct.context2D.drawImage(monsterElement, 0, 0);
  finishedProduct.context2D.drawImage(cardElement, 0, 0);
  div.append(finishedProduct);
  div.append(monsterElement);
  div.append(cardElement);
}



class RenderedDoll
{
  CanvasElement canvas;
  Doll doll;

  RenderedDoll(this.canvas, this.doll);

}
