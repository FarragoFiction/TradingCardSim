
/*
    has two combatants. knows how to render attacks.

 */
import 'dart:html';
import "Combatant.dart";
import 'dart:async';
import "dart:math" as Math;


class BattleField {
    CanvasElement canvas;
    Combatant player1;
    Combatant player2;
    int width = 1000;
    int height = 400;

    BattleField(this.player1, this.player2) {
        height = Math.max(height, player1.doll.height);
        height = Math.max(height, player2.doll.height);
    }




    Future<CanvasElement> draw() async
    {

        //redraw on existing canvas if need be.
        if(canvas == null) canvas = new CanvasElement(width: width, height: height);

        CanvasElement player1Canvas = await player1.draw();
        CanvasElement player2Canvas = await player2.draw();

        canvas.context2D.drawImage(player1Canvas, 0, 0);
        //TODO no. You gotta flip it TURN ways.
        canvas.context2D.drawImage(player2Canvas,400, 0);

        return canvas;
    }


}