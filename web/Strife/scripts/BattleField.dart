
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
    Random rand;
    int frameRate = 50;
    AudioElement backGroundMusic;
    Combatant player1;
    Combatant player2;
    int width = 1000;
    int height = 400;
    List<Command> commands = new List<Command>();

    BattleField(this.player1, this.player2, this.backGroundMusic) {
        rand = new Random();
        rand.nextInt(255);
        height = Math.max(height, player1.doll.height);
        height = Math.max(height, player2.doll.height);
        player1.y = height - player1.doll.height;
        player2.y= height - player2.doll.height;
        player1.x = 500;
        player2.x = 50;
        commands.add(new Command("aggrieve","Hello","World", attack));
    }

    Future<Null> attack(Command c) {
        idle = false;
        atackP1Animation(0);
    }



    Future<Element> firstDraw() async {
        await draw();
        holder  = new DivElement();

        for(Command c in commands) {
            holder.append(c.image);
        }

        holder.append(canvas);
        return holder;
    }

    Future<Null> draw() async
    {

       // print("rendering frame $frame");
        //redraw on existing canvas if need be.
        if(canvas == null) canvas = new CanvasElement(width: width, height: height);
        Renderer.clearCanvas(canvas);

        player1.turnWays = true;
        CanvasElement player1Canvas = await player1.draw();
        CanvasElement player2Canvas = await player2.draw();

        canvas.context2D.drawImage(player2Canvas,player2.x, player2.y);
        canvas.context2D.drawImage(player1Canvas, player1.x, player1.y);

    }


    Future<Null> idleAnimation(int frame) async {
        double angle = 5.0 - 2* (frame % 3);
        double rotation = angle * Math.PI / 180.0;
        player1.rotation = -1*rotation;
        player2.rotation = rotation;
        player1.y = height - player1.doll.height;
        player2.y= height - player2.doll.height;
        player1.x = 500;
        player2.x = 50;
        player1.setScale(1.0, 1.0);
        player2.setScale(1.0, 1.0);
        draw();
        frame ++;
        if(idle) new Timer(new Duration(milliseconds: frameRate), () => idleAnimation(frame));
    }

    //guy on right attacks guy on left.
    Future<Null> atackP1Animation(int frame) async {
        int numberFrames = 10;
        double angle = frame * 360.0/numberFrames;
        double rotation = angle * Math.PI / 180.0;
        player1.rotation = -1*rotation;
        player1.x += -40;
        draw();
        frame ++;
        if(frame < numberFrames*1.5) {
            new Timer(new Duration(milliseconds: frameRate), () => atackP1Animation(frame));
        }else {
            if(rand.nextBool()) {
                new Timer(new Duration(milliseconds: frameRate), () => damageP2Animation(0));
            }else {
                new Timer(new Duration(milliseconds: frameRate), () => defendP2Animation(0));
            }
        }
    }

    Future<Null> damageP2Animation(int frame) async {
        int numberFrames = 4;
        double angle = frame * 10/numberFrames;
        double rotation = angle * Math.PI / 180.0;

        player2.rotation = -1*rotation;
        player2.y += -1;
        draw();
        frame ++;
        if(frame < numberFrames) {
            new Timer(new Duration(milliseconds: frameRate), () => damageP2Animation(frame));
        }else {
            idle = true;
            new Timer(new Duration(milliseconds: frameRate), () => idleAnimation(0));

        }
    }


    Future<Null> defendP2Animation(int frame) async {
        print("defend");
        int numberFrames = 4;
        double angle = frame * 10/numberFrames;
        double rotation = angle * Math.PI / 180.0;

        player2.rotation = rotation;
        player2.setScale(1.05, 1.05);
        player2.y += -10;
        draw();
        frame ++;
        if(frame < numberFrames) {
            new Timer(new Duration(milliseconds: frameRate), () => defendP2Animation(frame));
        }else {
            idle = true;
            new Timer(new Duration(milliseconds: frameRate), () => idleAnimation(0));

        }
    }


}