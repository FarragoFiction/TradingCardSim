
import "../../scripts/DollLib/DollRenderer.dart";
import 'dart:async';
import "../../scripts/navbar.dart";
import 'BattleField.dart';
import 'Combatant.dart';

import 'dart:html';

BattleField battleField;
int frame = 0;
Element div = querySelector("#contents");
bool egg = false;
bool troll = false;
bool cheating = false;
int musicIndex = 0;
List<String> backGroundMusicSnippets = <String>["bg.ogg"];

//List<String> backGroundMusicSnippets = <String>["Showdads_Strifing_Part_1.ogg","Showdads_Strifing_Part_2.ogg","Showdads_Strifing_Part_3.ogg","Showdads_Strifing_Part_4.ogg","Showdads_Strifing_Part_5.ogg"];
void main() {
    loadNavbar();

    if(getParameterByName("easter",null)  == "egg"){
        egg = true;
        window.alert("Yo Dawg, I herd you liek easter eggs???");
    }else if(getParameterByName("easter",null)  == "troll")  {
        troll = true;
        window.alert("Huh. That's a weird sort of Lusus.");
    }

    if(getParameterByName("cheaters",null)  == "neverWin"){
        cheating = true;
    }

    init();
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

    if(egg) {
        return new Combatant(new EggDoll(),100,33,cheating);
    }else if(troll) {
        return new Combatant(new HomestuckTrollDoll(),100,33,cheating);
    }{
        return new Combatant(new HomestuckDoll(),100,33,cheating);
    }
}

List<Combatant> getEnemies() {
    return <Combatant>[new Combatant(new DadDoll(),100,33),new Combatant(new ConsortDoll(),130,44),new Combatant(new DenizenDoll(),150,55),new Combatant(new QueenDoll(),200,66)];
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
    battleField = new BattleField(getPlayer1(), getEnemies(), bgMusic, fxMusic);
    drawCustomizationForms();

}

Future<Null> drawCustomizationForms() async {
    await drawFormForCombatant(battleField.player);
    for(Combatant c in battleField.enemies) {
        await drawFormForCombatant(c);
    }
}

Future<Null> startStife() async {
    Element holder = await battleField.firstDraw();
    battleField.backGroundMusic.play();
    holder.className = "cardCanvas";

    div.append(holder);
    battleField.idleAnimation(1);
}


