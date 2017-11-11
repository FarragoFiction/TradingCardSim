
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
int musicIndex = 0;
List<String> backGroundMusicSnippets = <String>["Showdads_Strifing_Part_1.ogg","Showdads_Strifing_Part_2.ogg","Showdads_Strifing_Part_3.ogg","Showdads_Strifing_Part_4.ogg","Showdads_Strifing_Part_5.ogg"];
void main() {
    loadNavbar();

    if(getParameterByName("easter",null)  == "egg"){
        egg = true;
        window.alert("Yo Dawg, I herd you liek easter eggs???");
    }else if(getParameterByName("easter",null)  == "troll")  {
        troll = true;
        window.alert("Huh. That's a weird sort of Lusus.");

    }

    init();
}

//wait, EGGS!?  In MY strife? It's more likely than you think.
Combatant getPlayer1() {
    if(egg) {
        return new Combatant(new EggDoll(),100,33);
    }else if(troll) {
        return new Combatant(new HomestuckTrollDoll(),100,33);
    }{
        return new Combatant(new HomestuckDoll(),100,33);
    }
}

List<Combatant> getEnemies() {
    return <Combatant>[new Combatant(new DadDoll(),100,33),new Combatant(new ConsortDoll(),100,33),new Combatant(new DenizenDoll(),100,33),new Combatant(new QueenDoll(),100,33)];
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
            }
        });

    });
    battleField = new BattleField(getPlayer1(), getEnemies(), bgMusic, fxMusic);
    Element holder = await battleField.firstDraw();
    bgMusic.play();
    holder.className = "cardCanvas";

    div.append(holder);
    battleField.idleAnimation(1);
}


