import 'DollLib/src/Dolls/Doll.dart';
import "TradingCard.dart";
import "DollLib/src/includes/colour.dart";
import "DollLib/DollRenderer.dart";
import 'dart:async';
import 'dart:html';
class CoinCard extends TradingCard {
  CoinCard(Doll doll) : super(doll) {
      type = "Coin";
      typeLayer.text = type;
  }

    @override
    void drawBGThingy() {
        Renderer.drawBG(canvas,new Colour(100,100,100),new Colour(100,100,100));
    }


  @override
  Future<CanvasElement>  drawMonster(Doll doll) async {
      CanvasElement monsterElement = new CanvasElement(width: (256).round(), height: (208).round());
      CanvasElement dollCanvas = new CanvasElement(width: doll.width, height: doll.height);
      await Renderer.drawDollEmbossed(dollCanvas, doll);

      dollCanvas = Renderer.cropToVisible(dollCanvas);

      Renderer.drawToFitCentered(monsterElement, dollCanvas);
      return monsterElement;
  }


}