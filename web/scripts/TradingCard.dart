
import "DollLib/src/includes/colour.dart";
import "DollLib/DollRenderer.dart";
import 'dart:async';
import 'dart:html';


/*
 has a doll drawn in the window, a bunch of text, and IF it's a doll that has a symbol layer
 the symbol is copied in the upper right corner.

 knows how to draw itself.

 */
class TradingCard {
    Colour tint;
    Doll doll;
    List<TextLayer> textLayers;
    int width = 322;
    int height = 450;
    Random rand;

    TradingCard(Doll this.doll) {
        rand = new Random();
        tint = new Colour(rand.nextInt(255), rand.nextInt(255),rand.nextInt(255));
        //TODO set up text layers with random values.
        //TODO have text layers know how to render their own form values (in DollMaker, add DollTools to lib)

    }

    Future<CanvasElement> draw() async

    {
        CanvasElement cardElement = await drawCardTemplate(tint);
        CanvasElement monsterElement = await drawMonster(doll);

        CanvasElement finishedProduct = new CanvasElement(width: width, height: height);
        Renderer.drawBG(finishedProduct, tint, new Colour(255,255,255));

        int x = (doll.width/3 - monsterElement.width/3).round();
        int y = (3*monsterElement.height/4 - 2*monsterElement.height/4).round();
        finishedProduct.context2D.drawImage(monsterElement, x, y);
        finishedProduct.context2D.drawImage(cardElement, 0, 0);
        return finishedProduct;
    }

    Future<CanvasElement>  drawMonster(Doll doll) async {
        double monsterScale = 1.0;
        CanvasElement monsterElement = new CanvasElement(width: (256*monsterScale).round(), height: (206*monsterScale).round());
        // Renderer.drawBG(monsterElement, ReferenceColours.BLACK, ReferenceColours.WHITE);
        await Renderer.drawDoll(monsterElement, doll);
        return monsterElement;
    }

    Future<CanvasElement> drawCardTemplate(Colour color) async{
        CanvasElement cardElement = new CanvasElement(width: width, height: height);
        await Renderer.drawWhatever(cardElement, "images/blank.png");
        Renderer.swapColors(cardElement, color);
        return cardElement;

    }

}