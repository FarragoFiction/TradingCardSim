import "../../scripts/DollLib/DollRenderer.dart";
import 'dart:async';
import 'dart:html';
import "dart:math" as Math;

/*
    has doll and stats like attack/health. and potential commands. and responses to commands.
    commands should have synonyms that start with a so it's different every time.

 */
class Combatant {
    Doll doll;
    CanvasElement canvas;
    CanvasElement turnWaysCanvas;
    bool dirty = true; //TODO maybe need to update sprite in some way instead of just rotate/scale it?
    int buffer = 50;
    bool turnWays = false;
    int x = 0;
    int y = 0;
    double _scaleX = 1.0;
    double _scaleY = 1.0;
    double rotation = 0.0;
    CanvasRenderingContext2D defaultContext;
    int width = 0;
    int height = 0;


    Combatant(this.doll) {
        //needs to be a square so i can do full rotation.
        width = Math.max(doll.width, doll.height);
        height = width;

    }

    void restoreCanvas() {
        canvas.context2D.restore();
    }

    void setScale(double x, double y) {
        _scaleX = x;
        _scaleY = y;
    }

    Future<CanvasElement> draw() async
    {

        //redraw on existing canvas if need be.
        if(canvas == null) {
            canvas = new CanvasElement(width: width, height: height);
            canvas.context2D.save(); //need to know what an unmodified canvas looks like.
        }
        if(dirty) {
            dirty = false;
            await Renderer.drawDoll(canvas,doll);
        }


        return drawForReal(canvas);

    }

    Future<CanvasElement> drawForReal(CanvasElement c) async{
        //print('drawing with rotation $rotation');
        dirty = false;
        CanvasElement ret = new CanvasElement(width: width, height: height);
        ret.context2D.translate(ret.width/2, ret.height/2);
        ret.context2D.rotate(rotation);

        if(turnWays) {
            ret.context2D.scale(-1*_scaleX, _scaleY);
        }else {
            ret.context2D.scale(_scaleX, _scaleY);
        }
        ret.context2D.drawImage(canvas, -ret.width/2, -ret.height/2);
        return ret;
    }

}