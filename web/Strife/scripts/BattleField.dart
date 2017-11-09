
/*
    has two combatants. knows how to render attacks.

 */
import 'dart:html';
import "StrifeLib.dart";
import 'dart:async';
import "dart:math" as Math;
import "../../scripts/DollLib/DollRenderer.dart";

class BattleField {
    DivElement holder;
    CanvasElement canvas;
    //should be in pairs based on the command. Irnoic Negligence is defended with Abstain.
    String currentText = "";
    AttackDefensePair currentAttack;
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
        commands.add(new Aggrieve(attack));
    }

    Future<Null> attack(Command c) {
        idle = false;
        currentAttack = rand.pickFrom(c.results);
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
        int fontSize = 48;
        canvas.context2D.textAlign="center";
        canvas.context2D.font = "${fontSize}px Strife";
        canvas.context2D.fillText(currentText,500,fontSize);

    }


    Future<Null> idleAnimation(int frame) async {
        currentText = "";
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
        currentText = currentAttack.attack;
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
        int numberFrames = 8;
        currentText = "HIT!";
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
        int numberFrames = 8;
        currentText = currentAttack.defense;
        double angle = frame * 5/numberFrames;
        double rotation = angle * Math.PI / 180.0;

        player2.rotation = rotation;
        player2.setScale(1.05, 1.05);
        player2.y += -2;
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