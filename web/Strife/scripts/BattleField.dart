
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
    AudioElement fxAudio;
    Combatant player;
    Combatant enemy;
    int width = 1000;
    int height = 400;
    List<Command> commands = new List<Command>();
    List<Command> enemyCommands = new List<Command>();

    BattleField(this.player, this.enemy, this.backGroundMusic, this.fxAudio) {
        rand = new Random();
        rand.nextInt(255);
        height = Math.max(height, player.doll.height);
        height = Math.max(height, enemy.doll.height);
        player.y = height - player.doll.height;
        enemy.y= height - enemy.doll.height;
        player.x = 500;
        enemy.x = 50;
        //TODO randomly pick one of two attack, defense, etc. commands.
        commands.add(new Aggrieve(attack));
        commands.add(new Aggress(jumpAttack));
        commands.add(new Abjure(defend));
        commands.add(new Abstain(defend));
        commands.add(new Abscond(abscond));
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
        player.y = height - player.doll.height;
        enemy.y= height - enemy.doll.height;
        player.x = 500;
        enemy.x = 50;
        player.setScale(1.0, 1.0);
        enemy.setScale(1.0, 1.0);
        player.rotation = 0.0;
        enemy.rotation = 0.0;
    }

    Future<Null> attack(Command c) {
        idle = false;
        player.defending = false;
        textColor = c.textColor;
        currentAttack = rand.pickFrom(c.results);
        playerRollAttackAnimation(0);
    }

    Future<Null> defend(Command c) {
        idle = false;
        player.defending = true;
        textColor = c.textColor;
        currentAttack = rand.pickFrom(c.results);
        defendPlayerAnimation(0);
    }


    Future<Null> abscond(Command c) {
        idle = false;
        player.defending = true;
        textColor = c.textColor;
        currentAttack = rand.pickFrom(c.results);
        abscondPlayerAnimation(0);
    }

    Future<Null> lameAttack(Command c) {
        idle = false;
        textColor = c.textColor;
        enemy.defending = false;
        currentAttack = rand.pickFrom(c.results);
        enemyAttackAnimation(0);
    }

    Future<Null> lameDefense(Command c) {
        idle = false;
        textColor = c.textColor;
        currentAttack = rand.pickFrom(c.results);
        enemy.defending = true;
        enemyDefendAnimation(0);
    }

    Future<Null> jumpAttack(Command c) {
        idle = false;
        player.defending = false;
        textColor = c.textColor;
        currentAttack = rand.pickFrom(c.results);
        playerJumpAttackAnimation(0);
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

        player.turnWays = true;
        CanvasElement player1Canvas = await player.draw();
        CanvasElement player2Canvas = await enemy.draw();

        canvas.context2D.drawImage(player2Canvas,enemy.x, enemy.y);
        canvas.context2D.drawImage(player1Canvas, player.x, player.y);
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

        player.rotation = -1*rotation;
        enemy.rotation = rotation;

        draw();
        frame ++;
        if(idle) new Timer(new Duration(milliseconds: frameRate), () => idleAnimation(frame));
    }

    //guy on right attacks guy on left.
    Future<Null> playerRollAttackAnimation(int frame) async {
        currentText = currentAttack.attack;
        int numberFrames = 10;
        double angle = frame * 360.0/numberFrames;
        double rotation = angle * Math.PI / 180.0;
        player.rotation = -1*rotation;
        player.x += -40;
        draw();
        frame ++;
        if(frame < numberFrames*1.5) {
            new Timer(new Duration(milliseconds: frameRate), () => playerRollAttackAnimation(frame));
        }else {
            if(enemy.defending) {
                new Timer(new Duration(milliseconds: frameRate), () => enemyDefendAnimation(0));
            }else {
                new Timer(new Duration(milliseconds: frameRate), () => damageEnemy(0));
            }
        }
    }


    //guy on right attacks guy on left.
    Future<Null> enemyAttackAnimation(int frame) async {
        currentText = currentAttack.attack;
        int numberFrames = 5;
        double angle = 5.0 - 2* (frame % 3);
        double rotation = angle * Math.PI / 180.0;
        enemy.rotation = rotation;
        enemy.x += 80;

        draw();
        frame ++;
        if(frame < numberFrames*1.5) {
            new Timer(new Duration(milliseconds: frameRate), () => enemyAttackAnimation(frame));
        }else {
            if(!player.defending) {
                new Timer(new Duration(milliseconds: frameRate), () => damagePlayer(0));
            }else {
                new Timer(new Duration(milliseconds: frameRate), () => defendPlayerAnimation(0));
            }
        }
    }



    //guy on right attacks guy on left.
    Future<Null> playerJumpAttackAnimation(int frame) async {
        currentText = currentAttack.attack;
        int numberFrames = 10;
        double angle = frame * 360.0/numberFrames;
        double rotation = angle * Math.PI / 180.0;
        player.rotation = -1*rotation;
        player.x += -40;
        if(player.y <= 0) {
            player.y += 40;
        }else {
            player.y += -40;
        }

        draw();
        frame ++;
        if(frame < numberFrames*1.5) {
            new Timer(new Duration(milliseconds: frameRate), () => playerJumpAttackAnimation(frame));
        }else {
            if(!enemy.defending) {
                new Timer(new Duration(milliseconds: frameRate), () => damageEnemy(0));
            }else {
                new Timer(new Duration(milliseconds: frameRate), () => enemyDefendAnimation(0));
            }
        }
    }

    Future<Null> damageEnemy(int frame) async {
        int numberFrames = 8;
        currentText = "HIT!";
        double angle = frame * 10/numberFrames;
        double rotation = angle * Math.PI / 180.0;
        fxAudio.play();
        enemy.rotation = -1*rotation;
        enemy.y += -1;
        draw();
        frame ++;
        if(frame < numberFrames) {
            new Timer(new Duration(milliseconds: frameRate), () => damageEnemy(frame));
        }else {
            idle = true;
            new Timer(new Duration(milliseconds: frameRate), () => nextTurn());

        }
    }


    Future<Null> enemyDefendAnimation(int frame) async {
        print("defend");
        int numberFrames = 8;
        currentText = currentAttack.defense;
        double angle = frame * 5/numberFrames;
        double rotation = angle * Math.PI / 180.0;

        enemy.rotation = rotation;
        enemy.setScale(1.05, 1.05);
        enemy.y += -2;
        draw();
        frame ++;
        if(frame < numberFrames) {
            new Timer(new Duration(milliseconds: frameRate), () => enemyDefendAnimation(frame));
        }else {
            idle = true;
            new Timer(new Duration(milliseconds: frameRate), () => nextTurn());

        }
    }


    Future<Null> damagePlayer(int frame) async {
        int numberFrames = 8;
        currentText = "HIT!";
        double angle = frame * 10/numberFrames;
        double rotation = angle * Math.PI / 180.0;
        fxAudio.play();


        player.rotation = -1*rotation;
        player.y += -1;
        draw();
        frame ++;
        if(frame < numberFrames) {
            new Timer(new Duration(milliseconds: frameRate), () => damagePlayer(frame));
        }else {
            idle = true;
            new Timer(new Duration(milliseconds: frameRate), () => nextTurn());

        }
    }


    Future<Null> defendPlayerAnimation(int frame) async {
        print("defend");
        int numberFrames = 8;
        currentText = currentAttack.defense;
        double angle = frame * 5/numberFrames;
        double rotation = angle * Math.PI / 180.0;

        player.rotation = rotation;
        player.setScale(1.05, 1.05);
        player.y += -2;
        draw();
        frame ++;
        if(frame < numberFrames) {
            new Timer(new Duration(milliseconds: frameRate), () => defendPlayerAnimation(frame));
        }else {
            idle = true;
            new Timer(new Duration(milliseconds: frameRate), () => nextTurn());

        }
    }

    Future<Null> abscondPlayerAnimation(int frame) async {
        int numberFrames = 8;
        currentText = currentAttack.defense;
        double angle = frame * 5/numberFrames;
        double rotation = angle * Math.PI / 180.0;

        player.rotation = rotation;
        player.setScale(1.05, 1.05);
        player.y += 20; //just leave. can't be hurt.
        draw();
        frame ++;
        if(frame < numberFrames) {
            new Timer(new Duration(milliseconds: frameRate), () => defendPlayerAnimation(frame));
        }else {
            idle = true;
            new Timer(new Duration(milliseconds: frameRate), () => nextTurn());

        }
    }


}