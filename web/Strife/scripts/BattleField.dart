
/*
    has two combatants. knows how to render attacks.

 */
import 'dart:html';
import "Combatant.dart";
import 'dart:async';
import "dart:math" as Math;
import "../../scripts/DollLib/DollRenderer.dart";
import "Command.dart";

class BattleField {
    DivElement holder;
    CanvasElement canvas;
    String currentEffect = "Test";
    bool idle = true;
    int frameRate = 100;
    AudioElement backGroundMusic;
    Combatant player1;
    Combatant player2;
    int width = 1000;
    int height = 400;
    List<Command> commands = new List<Command>();

    BattleField(this.player1, this.player2, this.backGroundMusic) {
        height = Math.max(height, player1.doll.height);
        height = Math.max(height, player2.doll.height);
        commands.add(new Command("aggrieve","Hello","World", attack));
    }

    Future<Null> attack(Command c) {
        window.alert("you attacked! Probably.");
        idle = false;
    }


    double frameToRotation(int frame) {
        double angle = 5.0 - 2* (frame % 3);
        double ret = angle * Math.PI / 180.0;
        return ret;
    }

    Future<Element> firstDraw() async {
        await draw(0);
        holder  = new DivElement();

        for(Command c in commands) {
            holder.append(c.image);
        }

        holder.append(canvas);
        return holder;
    }

    Future<Null> draw(int frame) async
    {

       // print("rendering frame $frame");
        double rotation = frameToRotation(frame);
        //redraw on existing canvas if need be.
        if(canvas == null) canvas = new CanvasElement(width: width, height: height);
        Renderer.clearCanvas(canvas);

        CanvasElement player1Canvas = await player1.drawTurnways(rotation);
        CanvasElement player2Canvas = await player2.draw(rotation);

        int player1Y = height - player1.doll.height;
        int player2Y = height - player2.doll.height;
        canvas.context2D.drawImage(player1Canvas, 500, player1Y);
        canvas.context2D.drawImage(player2Canvas,50, player2Y);

    }


    Future<Null> animate(int frame) async {
        draw(frame);
        frame ++;
        if(idle) new Timer(new Duration(milliseconds: frameRate), () => animate(frame));
    }


}