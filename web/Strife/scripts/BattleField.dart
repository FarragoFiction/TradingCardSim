
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
    bool enemyTurn = false;
    AttackDefensePair currentAttack;
    Colour textColor = new Colour(0,0,0);
    bool idle = true;
    Random rand;
    int frameRate = 50;
    AudioElement backGroundMusic;
    Combatant player1;
    Combatant player2;
    int width = 1000;
    int height = 400;
    List<Command> commands = new List<Command>();
    List<Command> enemyCommands = new List<Command>();

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
        commands.add(new Aggress(jumpAttack));
        //TODO once i have more than just dads, different attacks
        enemyCommands.add(new DadAttackCommands(lameAttack));
        enemyCommands.add(new DadAttackCommands(lameDefense));

    }

    void nextTurn() {
        if(!enemyTurn) {
            enemyTakeTurn();
        }else {
            new Timer(new Duration(milliseconds: frameRate), () => idleAnimation(0));
        }
        enemyTurn = !enemyTurn;
    }

    void enemyTakeTurn() {
        resetSprites();
        draw();
        Command chosen = rand.pickFrom(enemyCommands);
        new Timer(new Duration(milliseconds: 10*frameRate), () {
            chosen.methodToCall(chosen);
        });
    }

    void resetSprites() {
        player1.y = height - player1.doll.height;
        player2.y= height - player2.doll.height;
        player1.x = 500;
        player2.x = 50;
        player1.setScale(1.0, 1.0);
        player2.setScale(1.0, 1.0);
        player1.rotation = 0.0;
        player2.rotation = 0.0;
    }

    Future<Null> attack(Command c) {
        idle = false;
        player1.defending = false;
        textColor = c.textColor;
        currentAttack = rand.pickFrom(c.results);
        atackP1Animation(0);
    }

    Future<Null> lameAttack(Command c) {
        idle = false;
        textColor = c.textColor;
        player2.defending = false;
        currentAttack = rand.pickFrom(c.results);
        attackP2Animation(0);
    }

    Future<Null> lameDefense(Command c) {
        idle = false;
        textColor = c.textColor;
        currentAttack = rand.pickFrom(c.results);
        player2.defending = true;
        defendP2Animation(0);
    }

    Future<Null> jumpAttack(Command c) {
        idle = false;
        player1.defending = false;
        textColor = c.textColor;
        currentAttack = rand.pickFrom(c.results);
        jumpAttackP1Animation(0);
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
        canvas.context2D.fillStyle = textColor.toStyleString();
        canvas.context2D.textAlign="center";
        canvas.context2D.font = "${fontSize}px Strife";
        canvas.context2D.fillText(currentText,500,fontSize);

    }


    Future<Null> idleAnimation(int frame) async {
       // print("idle");
        if(enemyTurn) {
            enemyTurn = false; //if i'm idling, it's the players turn.
        }
        currentText = "";
        double angle = 5.0 - 2* (frame % 3);
        double rotation = angle * Math.PI / 180.0;
        resetSprites();

        player1.rotation = -1*rotation;
        player2.rotation = rotation;

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
            if(player2.defending) {
                new Timer(new Duration(milliseconds: frameRate), () => defendP2Animation(0));
            }else {
                new Timer(new Duration(milliseconds: frameRate), () => damageP2Animation(0));
            }
        }
    }


    //guy on right attacks guy on left.
    Future<Null> attackP2Animation(int frame) async {
        currentText = currentAttack.attack;
        int numberFrames = 10;
        double angle = frame * 360.0/numberFrames;
        double rotation = angle * Math.PI / 180.0;
        player2.rotation = -1*rotation;
        player2.x += 40;
        draw();
        frame ++;
        if(frame < numberFrames*1.5) {
            new Timer(new Duration(milliseconds: frameRate), () => attackP2Animation(frame));
        }else {
            if(!player1.defending) {
                new Timer(new Duration(milliseconds: frameRate), () => damageP1Animation(0));
            }else {
                new Timer(new Duration(milliseconds: frameRate), () => defendP1Animation(0));
            }
        }
    }



    //guy on right attacks guy on left.
    Future<Null> jumpAttackP1Animation(int frame) async {
        currentText = currentAttack.attack;
        int numberFrames = 10;
        double angle = frame * 360.0/numberFrames;
        double rotation = angle * Math.PI / 180.0;
        player1.rotation = -1*rotation;
        player1.x += -40;
        if(player1.y <= 0) {
            player1.y += 40;
        }else {
            player1.y += -40;
        }

        draw();
        frame ++;
        if(frame < numberFrames*1.5) {
            new Timer(new Duration(milliseconds: frameRate), () => jumpAttackP1Animation(frame));
        }else {
            if(!player2.defending) {
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
            new Timer(new Duration(milliseconds: frameRate), () => nextTurn());

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
            new Timer(new Duration(milliseconds: frameRate), () => nextTurn());

        }
    }


    Future<Null> damageP1Animation(int frame) async {
        int numberFrames = 8;
        currentText = "HIT!";
        double angle = frame * 10/numberFrames;
        double rotation = angle * Math.PI / 180.0;

        player1.rotation = -1*rotation;
        player1.y += -1;
        draw();
        frame ++;
        if(frame < numberFrames) {
            new Timer(new Duration(milliseconds: frameRate), () => damageP1Animation(frame));
        }else {
            idle = true;
            new Timer(new Duration(milliseconds: frameRate), () => idleAnimation(0));

        }
    }


    Future<Null> defendP1Animation(int frame) async {
        print("defend");
        int numberFrames = 8;
        currentText = currentAttack.defense;
        double angle = frame * 5/numberFrames;
        double rotation = angle * Math.PI / 180.0;

        player1.rotation = rotation;
        player1.setScale(1.05, 1.05);
        player1.y += -2;
        draw();
        frame ++;
        if(frame < numberFrames) {
            new Timer(new Duration(milliseconds: frameRate), () => defendP1Animation(frame));
        }else {
            idle = true;
            new Timer(new Duration(milliseconds: frameRate), () => idleAnimation(0));

        }
    }


}