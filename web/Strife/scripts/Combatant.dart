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
    int buffer = 50;

    Combatant(this.doll);

    Future<CanvasElement> draw(double rotation) async
    {

        //redraw on existing canvas if need be.
        if(canvas == null) canvas = new CanvasElement(width: doll.width+buffer, height: doll.height+buffer);

        //only redraw self if something has changed.
        if(dirty) {
            await Renderer.drawDoll(canvas, doll);
            dirty = false;
        }

        if(rotation == 0) {
            return canvas; //just the cached one
        }else {
            return await drawWithRotation(canvas, rotation,false);
        }

    }

    Future<CanvasElement> drawWithRotation(CanvasElement c, double rotation, bool turnways) async{
        print('drawing with rotation $rotation');
        CanvasElement ret = new CanvasElement(width: doll.width+buffer, height: doll.height+buffer);
        ret.context2D.translate(ret.width/2, ret.height/2);
        ret.context2D.rotate(rotation);
        if(turnways) ret.context2D.scale(-1,1);
        ret.context2D.drawImage(canvas, -ret.width/2, -ret.height/2);
        return ret;
    }



    Future<CanvasElement> drawTurnways(double rotation) async {
        if(turnWaysCanvas == null) turnWaysCanvas = new CanvasElement(width: doll.width+buffer, height: doll.height+buffer);
        if(canvas == null) await draw(0.0);
        turnWaysCanvas.context2D.translate(canvas.width, 0);
        turnWaysCanvas.context2D.scale(-1, 1);
        turnWaysCanvas.context2D.drawImage(canvas,0, 0);

        if(rotation == 0) {
            return turnWaysCanvas; //just the cached one
        }else {
            //twitch opposite of regular sprite.
            return await drawWithRotation(turnWaysCanvas, -1* rotation, true);
        }
    }
}