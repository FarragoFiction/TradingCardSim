import "TradingCard.dart";
import "package:DollLibCorrect/DollRenderer.dart";

import "CoinCard.dart";
import 'dart:async';
import 'dart:html';
class RingCard extends CoinCard {
    RingCard(Doll doll) : super(doll) {
        List<String> folds = <String>["NO","ONE","TWO","THREE","FOUR","FIVE","SIX","SEVEN","EIGHT","NINE","TEN","ELEVEN","TWELVE","???"];
        String fold = rand.pickFrom(folds);
        type = "RING of ORBS ${fold}FOLD";
        typeLayer.text = type;
        nameLayer.text = "${randomName()}'s Ring";
        tint = new Colour.fromStyleString("#d0bf03");
        statLayer.text = "${folds.indexOf(fold)}";
    }


    @override
    Future<CanvasElement>  drawMonster(Doll doll) async {
        CanvasElement monsterElement = new CanvasElement(width: (256).round(), height: (208).round());
        CanvasElement dollCanvas = new CanvasElement(width: doll.width, height: doll.height);
        await DollRenderer.drawDollEmbossed(dollCanvas, doll);
        Renderer.swapColors(dollCanvas, new Colour.fromStyleString("#ffea00"));

        dollCanvas = Renderer.cropToVisible(dollCanvas);

        Renderer.drawToFitCentered(monsterElement, dollCanvas);
        return monsterElement;
    }


}