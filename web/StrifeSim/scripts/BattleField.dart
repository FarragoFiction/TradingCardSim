
/*
    has two combatants. knows how to render attacks.

 */
import 'dart:html';
import "StrifeLib.dart";
import 'dart:async';
import "dart:math" as Math;
import "../../scripts/DollLib/DollRenderer.dart";
import '../../scripts/DollLib/src/includes/predicates.dart';

class BattleField {
    bool attackGoing = false;
    DivElement holder;
    bool miles = false;
    CanvasElement canvas;
    Fraymotif fraymotifInEffect;
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
    Combatant currentEnemy;
    int width = 1000;
    int height = 400;
    List<Combatant> enemies = new List<Combatant>();
    List<Command> commands = new List<Command>();
    List<Command> enemyCommands = new List<Command>();
    Lambda winCallback;
    RandomFuckingObject redMiles;

    BattleField(this.player, this.enemies, this.backGroundMusic, this.fxAudio, this.winCallback) {
        this.currentEnemy = this.enemies[0];
        redMiles = new RandomFuckingObject(999, 0, 0);
        rand = new Random();
        rand.nextInt(255);
        height = Math.max(height, player.doll.height);
        height = Math.max(height, currentEnemy.doll.height);
        player.y = height - player.doll.height;
        currentEnemy.y= height - currentEnemy.doll.height;
        player.x = 500;
        currentEnemy.x = 50;
        setUpPlayerCommands();
        setUpEnemyCommands();
    }

    void setUpPlayerCommands() {
        List<Command> attacks = <Command>[new Aggrieve(attack),new Aggress(jumpAttack)];
        List<Command> defense = <Command> [new Abjure(defend),new Abstain(defend)];
        List<Command> specials = <Command> [new Abuse(special),new Accuse(special)];
        commands.add(rand.pickFrom(attacks));
        commands.add(rand.pickFrom(defense));
        commands.add(rand.pickFrom(specials));
        commands.add(new Abscond(abscond));
    }

    void setUpEnemyCommands() {
        enemyCommands.clear();
        if(currentEnemy.doll is DadDoll) {
            enemyCommands.add(new DadAttackCommands(lameAttack));
            enemyCommands.add(new DadDefenseCommands(lameDefense));
        }if(currentEnemy.doll is BroDoll) {
            enemyCommands.add(new BroAttackCommands(lameAttack));
            enemyCommands.add(new DadDefenseCommands(lameDefense));
        }if(currentEnemy.doll is MomDoll) {
            enemyCommands.add(new MomAttackCommands(lameAttack));
            enemyCommands.add(new DadDefenseCommands(lameDefense));
        }else if(currentEnemy.doll is ConsortDoll) {
            enemyCommands.add(new ConsortAttackCommands(enemyFlipAttack));
            enemyCommands.add(new DadDefenseCommands(lameDefense));
        }else if(currentEnemy.doll is QueenDoll) {
            enemyCommands.add(new QueenAttackCommands(milesAttack));
            enemyCommands.add(new DadDefenseCommands(lameDefense));
        }else {
            enemyCommands.add(new Aggrieve(lameAttack));
            enemyCommands.add(new DadDefenseCommands(lameDefense));
        }

    }

    void nextTurn() {
        print('next turn');
        attackGoing = false;
        //print("next turn is player dead? ${player.dead} and is enemy dead? ${currentEnemy.dead}");
        if(currentEnemy.dead) {
            attackGoing = true;
            resetSprites();
            winAnimation(0);
            return;
        }else if(player.dead) {
            attackGoing = true;
            loseAnimation(0);
            return;
        }

        if(!enemyTurn) {
            attackGoing = true;
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
        currentEnemy.y= height - currentEnemy.doll.height;
        player.x = 500;
        currentEnemy.x = 50;
        player.setScale(1.0, 1.0);
        currentEnemy.setScale(1.0, 1.0);
        player.rotation = 0.0;
        currentEnemy.rotation = 0.0;
    }

    Future<Null> attack(Command c) {
        if(!attackGoing) {
            attackGoing = true;
            idle = false;
            player.defending = false;
            textColor = c.textColor;
            currentAttack = rand.pickFrom(c.results);
            playerRollAttackAnimation(0);
        }
    }

    Future<Null> special(Command c) {
        if(!attackGoing) {
            attackGoing = true;
            idle = false;
            player.defending = false;
            textColor = c.textColor;
            currentAttack = rand.pickFrom(c.results);
            //fraymotifs will do nothing if you don't do them at the right time. Think Sepulchritude.
            if (player.canFraymotif) {
                fraymotifInEffect = rand.pickFrom(player.fraymotifs);
                //print("fraymotif chosen is ${fraymotifInEffect.name}");
                changeMusic(fraymotifInEffect.musicLocation);
                fraymotifInEffect.x = player.x;
                fraymotifInEffect.y = player.y;
                fraymotifInEffect.resetRandom(); //always do the exact same things. makes it look designed.

                playerFraymotifAnimation(0);
            } else {
                player.defending = true;
                defendPlayerAnimation(0, true);
            }
        }

    }

    void changeMusic(String newMusicLocation) {
        backGroundMusic.src = newMusicLocation;
        backGroundMusic.play();
    }

    Future<Null> defend(Command c) {
        if(!attackGoing) {
            attackGoing = true;
            idle = false;
            player.defending = true;
            textColor = c.textColor;
            currentAttack = rand.pickFrom(c.results);
            defendPlayerAnimation(0, true);
        }
    }


    Future<Null> abscond(Command c) {
        if(!attackGoing) {
            attackGoing = true;
            idle = false;
            player.defending = true;
            textColor = c.textColor;
            currentAttack = rand.pickFrom(c.results);
            abscondPlayerAnimation(0);
        }
    }

    Future<Null> lameAttack(Command c) {
        attackGoing = true;
        idle = false;
        textColor = c.textColor;
        currentEnemy.defending = false;
        currentAttack = rand.pickFrom(c.results);
        enemyAttackAnimation(0);
    }

    Future<Null> milesAttack(Command c) {
        attackGoing = true;
        idle = false;
        miles = true;
        textColor = c.textColor;
        currentEnemy.defending = false;
        currentAttack = rand.pickFrom(c.results);
        enemyMilesAttackAnimation(0);
    }

    Future<Null> enemyFlipAttack(Command c) {
        attackGoing = true;
        idle = false;
        textColor = c.textColor;
        currentEnemy.defending = false;
        currentAttack = rand.pickFrom(c.results);
        enemyFlipOutAttackAnimation(0);
    }

    Future<Null> lameDefense(Command c) {
        attackGoing = true;
        idle = false;
        textColor = c.textColor;
        currentAttack = rand.pickFrom(c.results);
        currentEnemy.defending = true;
        enemyDefendAnimation(0, true);
    }

    Future<Null> jumpAttack(Command c) {
        if(!attackGoing) {
            attackGoing = true;
            idle = false;
            player.defending = false;
            textColor = c.textColor;
            currentAttack = rand.pickFrom(c.results);
            playerJumpAttackAnimation(0);
        }
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
        CanvasElement player2Canvas = await currentEnemy.draw();

        if(fraymotifInEffect != null) {
            CanvasElement fraymotifCanvas = await fraymotifInEffect.draw(canvas.width, canvas.height);
            for(RandomFuckingObject r in fraymotifInEffect.randomFuckingObjects) {
                CanvasElement objCanvas = await r.draw(canvas.width, canvas.height);
                canvas.context2D.drawImage(objCanvas,r.x, r.y);
            }
            canvas.context2D.drawImage(fraymotifCanvas,fraymotifInEffect.x, fraymotifInEffect.y);
        }


        canvas.context2D.drawImage(player2Canvas,currentEnemy.x, currentEnemy.y);
        canvas.context2D.drawImage(player2Canvas,currentEnemy.x, currentEnemy.y);
        canvas.context2D.drawImage(player1Canvas, player.x, player.y);
        int fontSize = 48;
        canvas.context2D.fillStyle = textColor.toStyleString();
        canvas.context2D.textAlign="center";
        canvas.context2D.font = "${fontSize}px Strife";
        canvas.context2D.fillText(currentText,500,fontSize);
        canvas.context2D.font = "22px Strife";
        canvas.context2D.fillText("${player.currentHP} HP, ${player.currentMana} MP ",800,2*fontSize);
        canvas.context2D.fillText("${currentEnemy.currentHP}, HP, ${currentEnemy.currentMana} MP",100,2*fontSize);
        if(miles) {
            //print("drawing miles");
            CanvasElement milesCanvas = await redMiles.draw(canvas.width, canvas.height);
            canvas.context2D.drawImage(milesCanvas, player.x, 0);
        }

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
        currentEnemy.rotation = rotation;

        draw();
        frame ++;
        if(idle) new Timer(new Duration(milliseconds: frameRate), () => idleAnimation(frame));
    }



    Future<Null> winAnimation(int frame) async {
        currentText = "You win!!!";
        int numberFrames = 40;

        if(frame %10 == 0) {
            player.flip();
        }
        player.x += 1;
        currentEnemy.y = 1000; //go off screen, asshole.
        draw();
        frame ++;
        if(frame < numberFrames) {
            new Timer(new Duration(milliseconds: frameRate), () => winAnimation(frame));
        }else {
            new Timer(new Duration(milliseconds: frameRate), () => newStrife());
        }
    }

    Future<Null> loseAnimation(int frame) async {
        int numberFrames = 40;
        currentText = "You lost??? Try again.";
        if(frame %10 == 0) {
            currentEnemy.flip();
        }
        currentEnemy.x += 1;
        draw();
        frame ++;
        if(frame < numberFrames) {
            new Timer(new Duration(milliseconds: frameRate), () => loseAnimation(frame));
        }else {
            new Timer(new Duration(milliseconds: frameRate), () => repeatStrife());
        }
    }

    void newStrife() {
        print("doing things ${enemies}");
        player.levelUp();
        player.restoreHP();
        player.addRandomFraymotif();
        int nextIndex = enemies.indexOf(currentEnemy) + 1;
        if(nextIndex >= enemies.length) {
           winCallback(player);
        }else {
            currentEnemy = enemies[nextIndex];
            enemyTurn = true; //next turn will make it be my turn.
            setUpEnemyCommands();
            nextTurn();
        }
    }

    void repeatStrife() {
        player.resetStats();
        enemyTurn = true; //next turn will make it be my turn.
        currentEnemy.resetStats();
        nextTurn();
    }

    Future<Null> playerFraymotifAnimation(int frame) async {
        currentText = fraymotifInEffect.name;
        int numberFrames = 100;
       // print("current text is $currentText");
        fraymotifInEffect.apply(currentEnemy,canvas.width, canvas.height);

        if(!currentEnemy.defending) {
            fxAudio.play();
        }

        currentEnemy.removeHealth((player.power/30).round()); //damage over time


        draw();
        frame ++;
        if(frame < numberFrames) {
            new Timer(new Duration(milliseconds: frameRate), () => playerFraymotifAnimation(frame));
        }else {
           fraymotifInEffect = null; //done
           backGroundMusic.playbackRate = 4.0; //hurry through ending
           player.currentMana += -1 * player.manaThreshold;
           new Timer(new Duration(milliseconds: frameRate), () => nextTurn());
        }
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
            if(currentEnemy.defending) {
                new Timer(new Duration(milliseconds: frameRate), () => enemyDefendAnimation(0));
            }else {
                new Timer(new Duration(milliseconds: frameRate), () => damageEnemy(0));
            }
        }
    }


    //guy on right attacks guy on left.
    Future<Null> enemyFlipOutAttackAnimation(int frame) async {
        currentText = currentAttack.attack;
        int numberFrames = 10;
        if(frame %3 == 0) {
            currentEnemy.flip();
        }
        currentEnemy.x += 40;

        draw();
        frame ++;
        if(frame < numberFrames*1.5) {
            new Timer(new Duration(milliseconds: frameRate), () => enemyFlipOutAttackAnimation(frame));
        }else {
            if(!player.defending) {
                new Timer(new Duration(milliseconds: frameRate), () => damagePlayer(0));
            }else {
                new Timer(new Duration(milliseconds: frameRate), () => defendPlayerAnimation(0));
            }
        }
    }

    //guy on right attacks guy on left.
    Future<Null> enemyAttackAnimation(int frame) async {
        currentText = currentAttack.attack;
        int numberFrames = 5;
        double angle = 5.0 - 2* (frame % 3);
        double rotation = angle * Math.PI / 180.0;
        currentEnemy.rotation = rotation;
        currentEnemy.x += 80;

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
    Future<Null> enemyMilesAttackAnimation(int frame) async {
        currentText = currentAttack.attack;
        int numberFrames = 15;
        if(frame %3 == 0) {
            redMiles.flip();
        }
        draw();
        frame ++;
        if(frame < numberFrames*1.5) {
            new Timer(new Duration(milliseconds: frameRate), () => enemyMilesAttackAnimation(frame));
        }else {
            miles = false;
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
            if(!currentEnemy.defending) {
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
        currentEnemy.rotation = -1*rotation;
        currentEnemy.y += -1;
        draw();
        frame ++;
        if(frame < numberFrames) {
            new Timer(new Duration(milliseconds: frameRate), () => damageEnemy(frame));
        }else {
            idle = true;
            currentEnemy.removeHealth(player.power);
            new Timer(new Duration(milliseconds: frameRate), () => nextTurn());

        }
    }


    Future<Null> enemyDefendAnimation(int frame,[bool isAttack = false]) async {
       // print("defend");
        int numberFrames = 8;
        currentText = currentAttack.defense;
        if(isAttack) currentText = currentAttack.attack;
        double angle = frame * 5/numberFrames;
        double rotation = angle * Math.PI / 180.0;
        currentEnemy.currentMana ++; //not a lot, but some.

        currentEnemy.rotation = rotation;
        currentEnemy.setScale(1.05, 1.05);
        currentEnemy.y += -2;
        draw();
        frame ++;
        if(frame < numberFrames) {
            new Timer(new Duration(milliseconds: frameRate), () => enemyDefendAnimation(frame, isAttack));
        }else {
            idle = true;
            if(!isAttack) currentEnemy.removeHealth(player.power); //if i choose to defend, then don't take damage

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
            player.removeHealth(currentEnemy.power);
            new Timer(new Duration(milliseconds: frameRate), () => nextTurn());
        }
    }


    Future<Null> defendPlayerAnimation(int frame,[bool isAttack = false]) async {
        //print("defend");
        int numberFrames = 8;
        currentText = currentAttack.defense;
        if(isAttack) currentText = currentAttack.attack;
        double angle = frame * 5/numberFrames;
        double rotation = angle * Math.PI / 180.0;
        player.currentMana ++; //not a lot, but some.
        player.rotation = rotation;
        player.setScale(1.05, 1.05);
        player.y += -2;
        draw();
        frame ++;
        if(frame < numberFrames) {
            new Timer(new Duration(milliseconds: frameRate), () => defendPlayerAnimation(frame,isAttack));
        }else {
            idle = true;
            if(!isAttack) player.removeHealth(currentEnemy.power); //if i choose to defend, then don't take damage
            new Timer(new Duration(milliseconds: frameRate), () => nextTurn());

        }
    }

    Future<Null> abscondPlayerAnimation(int frame, [bool isAttack = false]) async {
        int numberFrames = 8;
        currentText = currentAttack.defense;
        if(isAttack) currentText = currentAttack.attack;
        double angle = frame * 5/numberFrames;
        double rotation = angle * Math.PI / 180.0;

        player.rotation = rotation;
        player.setScale(1.05, 1.05);
        player.y += 20; //just leave. can't be hurt.
        draw();
        frame ++;
        if(frame < numberFrames) {
            new Timer(new Duration(milliseconds: frameRate), () => defendPlayerAnimation(frame,isAttack));
        }else {
            idle = true;
            new Timer(new Duration(milliseconds: frameRate), () => nextTurn());

        }
    }


}