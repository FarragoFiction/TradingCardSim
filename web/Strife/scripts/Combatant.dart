import "../../scripts/DollLib/DollRenderer.dart";
import 'dart:async';
import 'dart:html';
/*
    has doll and stats like attack/health. and potential commands. and responses to commands.
    commands should have synonyms that start with a so it's different every time.

 */
class Combatant {
    Doll doll;
    CanvasElement canvas;
    CanvasElement turnWaysCanvas;
    bool dirty = true;

    Combatant(this.doll);

    Future<CanvasElement> draw() async
    {

        //redraw on existing canvas if need be.
        if(canvas == null) canvas = new CanvasElement(width: doll.width, height: doll.height);

        //only redraw self if something has changed.
        if(dirty) {
            await Renderer.drawDoll(canvas, doll);
            dirty = false;
        }

        return canvas;
    }

    Future<CanvasElement> drawTurnways() async {
        if(turnWaysCanvas == null) turnWaysCanvas = new CanvasElement(width: doll.width, height: doll.height);
        if(canvas == null) await draw();
        turnWaysCanvas.context2D.translate(canvas.width, 0);
        turnWaysCanvas.context2D.scale(-1, 1);
        turnWaysCanvas.context2D.drawImage(canvas,0, 0);
        return turnWaysCanvas;
    }
}