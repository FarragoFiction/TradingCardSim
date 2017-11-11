import "../../scripts/DollLib/DollRenderer.dart";
import "Fraymotif.dart";
import 'dart:async';
import 'dart:html';
import "dart:math" as Math;

/*
    has doll and stats like attack/health. and potential commands. and responses to commands.
    commands should have synonyms that start with a so it's different every time.

 */
class Combatant {
    int maxHP;
    int currentHP;
    int manaThreshold = 100;
    int currentMana = 0;
    int power;
    Doll doll;
    //get a new fraymotif every time you win.
    List<Fraymotif> fraymotifs = new List<Fraymotif>();
    CanvasElement canvas;
    CanvasElement turnWaysCanvas;
    Colour textColor;
    bool defending = false;
    bool dirty = true; // maybe need to update sprite in some way instead of just rotate/scale it?
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


    Combatant(this.doll, this.maxHP, this.power) {
        this.currentHP = this.maxHP;
        //needs to be a square so i can do full rotation.
        width = Math.max(doll.width, doll.height);
        height = width;
        fraymotifs.add(Fraymotif.randomFraymotif());
        fraymotifs.add(Fraymotif.randomFraymotif());
        print("Made fraymotif ${fraymotifs.first.name}");

    }

    bool get dead {
        return currentHP <= 0;
    }

    bool get canFraymotif {
        return currentMana >= manaThreshold;
    }

    void resetStats() {
        currentHP = maxHP;
        currentMana = 0;
    }

    void restoreHP() {
        currentHP = maxHP;
    }

    void resetMana() {
        currentMana = 0;

    }

    void removeHealth(int power) {
        if(defending) {
            currentHP += (-0.1 * power).ceil();
            currentMana += (0.9 * power).floor();
        }else {
            currentHP += -1 * power;
        }
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


        return await drawForReal(canvas);

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