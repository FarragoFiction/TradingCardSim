
import "package:DollLibCorrect/DollRenderer.dart";
import 'dart:async';
import "../../scripts/navbar.dart";
import 'BattleField.dart';
import 'Combatant.dart';

import 'dart:html';

BattleField battleField;
int frame = 0;
Element div = querySelector("#strife");
bool egg = false;
bool troll = false;
bool cheating = false;
bool winner = false;
int musicIndex = 0;
List<String> backGroundMusicSnippets = <String>["bg.ogg"];

//List<String> backGroundMusicSnippets = <String>["Showdads_Strifing_Part_1.ogg","Showdads_Strifing_Part_2.ogg","Showdads_Strifing_Part_3.ogg","Showdads_Strifing_Part_4.ogg","Showdads_Strifing_Part_5.ogg"];
void main() {
    storeCard("N4Igzg9grgTgxgUxALhABQDYEMCeBLAOwHMACAZQBcY8AzBMvAWxABoQCtGlVLq6Sc0GCQAiWACasQFBAA8KKECQgB3AghgIOXYWCjjxWjDhIALLGBIUIJMFVoIrphHmFjxAQhLeAkhQDkllhW0ESmJDR4YRQsEXgYGAjiJCp4FOEAwhAGiQBGMFgEyTBQ+XhwANZBRRFY8UkkWBQyjAAOFJbWjblgcBBFsblQFN6q6praGmYQGOKdzq7KagB0UrlYlUQw0EUAcpzcIADq-USJJzAVy63EUvZERBoZ5gSIigAMywCsUr1aCGAACoQACqBAwEEqigA2gBdKSaPQYDqUJpgGHAAA67AO2OQ2IAaj4ALLYljYgBuWAwUAQeOxACZsQBfeFse6PGCojoAGQBYA0MLZ0moDw03LAAHFNE1BahoVicVx6SAiaTWJTqbSVQBGFnCjniihogCiAEcoNShSBmUA");
    loadNavbar();

    if(getParameterByName("easter",null)  == "egg"){
        egg = true;
        window.alert("Yo Dawg, I herd you liek easter eggs???");
    }
    if(getParameterByName("egg",null)  == "troll")  {
        troll = true;
        window.alert("Huh. That's a weird sort of Lusus.");
    }

    if(getParameterByName("cheaters",null)  == "neverWin"){
        cheating = true;
    }

    if(getParameterByName("winner",null)  == "you"){
        winner = true;
    }

    init();
}

void storeCard(String card) {
    String key = "LIFESIMFOUNDCARDS";
    if(window.localStorage.containsKey(key)) {
        String existing = window.localStorage[key];
        List<String> parts = existing.split(",");
        if(!parts.contains(card)) window.localStorage[key] = "$existing,$card";
    }else {
        window.localStorage[key] = card;
    }
}

Future<Null> drawFormForCombatant(Combatant c) async {
        Element ret = new DivElement();
        ret.setInnerHtml("Doll URL: ");
        TextAreaElement dollArea = new TextAreaElement();
        dollArea.value = c.doll.toDataBytesX();
        ButtonElement dollButton = new ButtonElement();
        dollButton.setInnerHtml("Load Doll");
        ret.append(dollArea);
        ret.append(dollButton);

        dollButton.onClick.listen((Event e) {
            c.doll = Doll.loadSpecificDoll(dollArea.value);
            c.dirty = true;
            c.draw();
        });
        await c.draw();
        div.append(c.canvas);
        div.append(ret);
}



//wait, EGGS!?  In MY strife? It's more likely than you think.
Combatant getPlayer1() {

    if(egg && troll) {
        return new Combatant(new TrollEggDoll(),100,33,cheating);
    }else if(egg) {
        return new Combatant(new EggDoll(),100,33,cheating);
    }else if(troll) {
        return new Combatant(new HomestuckTrollDoll(),100,33,cheating);
    }{
        return new Combatant(new HomestuckDoll(),100,33,cheating);
    }
}

List<Combatant> getEnemies() {
    Random rand = new Random();
    List<Doll> possibleFirsts =  <Doll>[new DadDoll(), new MomDoll(), new BroDoll()];
    
    return <Combatant>[new Combatant(rand.pickFrom(possibleFirsts),100,33),new Combatant(new ConsortDoll(),130,44),new Combatant(new DenizenDoll(),150,55),new Combatant(new QueenDoll(false),200,66)];
}

String getNextSong() {
    musicIndex++;

    if(musicIndex >= backGroundMusicSnippets.length) {
        musicIndex = 0;
        print("Starting over");
    }
    print("music index is");
    return "../music/${backGroundMusicSnippets[musicIndex]}";
}




//TODO ((in fact, i just decided that only by beating the queen can you enter in your own players, or learn the secret to do it from the start))
Future<Null> init() async{
    AudioElement bgMusic = querySelector("#bgAudio");
    AudioElement fxMusic = querySelector("#fxAudio");
    print("bgMusic is $bgMusic");

    bgMusic.onEnded.listen((e) {
        new Timer(new Duration(milliseconds: 3000), () {
            //might be playing a fraymotif
            if(bgMusic.paused) {
                bgMusic.src = getNextSong();
                bgMusic.currentTime = 0;
                bgMusic.play();
                bgMusic.playbackRate = 1.0;
            }
        });

    });
    battleField = new BattleField(getPlayer1(), getEnemies(), bgMusic, fxMusic, onWin);
    drawCustomizationForms();

}

Future<Null> drawCustomizationForms() async {
    ButtonElement b = new ButtonElement();
    b.setInnerHtml("Start Strife!!!");
    b.onClick.listen((e)
    {
        div.setInnerHtml("");
        startStife();
    });
    div.append(b);

    await drawFormForCombatant(battleField.player);
    //gotta earn this shit.
    if (winner){
        for (Combatant c in battleField.enemies) {
            await drawFormForCombatant(c);
        }
    }
    b = new ButtonElement();
    b.setInnerHtml("Start Strife!!!");
    b.onClick.listen((e)
    {
        div.setInnerHtml("");
        startStife();
    });
    div.append(b);
}

void onWin(Combatant c) {
    battleField.backGroundMusic.pause();
    AnchorElement win = new AnchorElement();
    win.href = "index.html?winner=you";
    win.setInnerHtml("<br><br>I wonder what winning earns you?");

    AnchorElement cheat = new AnchorElement();
    cheat.href = "index.html?cheaters=neverWin";
    cheat.setInnerHtml("<br><br>I wish this game were easier.");


    AnchorElement egg = new AnchorElement();
    egg.href = "index.html?easter=egg&winner=you";
    if(winner) egg.href = "index.html?easter=egg&egg=troll&winner=you"; //extra secret egg.
    egg.setInnerHtml("<br><br>Yo dog.");


    DivElement winningLabel = new DivElement();
    winningLabel.classes.add("winner");

    if(cheating) {
        winningLabel.setInnerHtml("You finished! But didn't you pay attention? Cheaters never win.");
    }else {
        winningLabel.setInnerHtml("You win!!!");
        winningLabel.append(win);
        winningLabel.append(cheat);
        winningLabel.append(egg);
    }
    div.setInnerHtml("");
    div.append(winningLabel);
}

Future<Null> startStife() async {
    Element holder = await battleField.firstDraw();
    battleField.backGroundMusic.play();
    holder.className = "cardCanvas";

    div.append(holder);
    battleField.idleAnimation(1);
}


