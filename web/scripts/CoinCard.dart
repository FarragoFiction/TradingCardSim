import 'DollLib/src/Dolls/Doll.dart';
import "TradingCard.dart";
import "DollLib/src/includes/colour.dart";
import "DollLib/DollRenderer.dart";
import 'dart:async';
import 'dart:html';
class CoinCard extends TradingCard {
  CoinCard(Doll doll) : super(doll) {
      type = "Coin";
      nameLayer.text = "${randomName()}'s Coin";
      typeLayer.text = "Coin";
      tint = new Colour(100,100,100);
      statLayer.text = "${rand.nextInt(10)}";

  }

    @override
    void drawBGThingy() {
        Renderer.drawBG(canvas,tint,tint);
    }


  @override
  Future<CanvasElement>  drawMonster(Doll doll) async {
      CanvasElement monsterElement = new CanvasElement(width: (256).round(), height: (208).round());
      CanvasElement dollCanvas = new CanvasElement(width: doll.width, height: doll.height);
      await Renderer.drawDollEmbossed(dollCanvas, doll);
      Renderer.swapColors(dollCanvas, tint);

      dollCanvas = Renderer.cropToVisible(dollCanvas);

      Renderer.drawToFitCentered(monsterElement, dollCanvas);
      return monsterElement;
  }


}