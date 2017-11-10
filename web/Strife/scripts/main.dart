
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
        return new Combatant(new EggDoll());
    }else if(troll) {
        return new Combatant(new HomestuckTrollDoll());
    }{
        return new Combatant(new HomestuckDoll());
    }
}

Combatant getPlayer2() {
    return new Combatant(new DadDoll());
}


//TODO ((in fact, i just decided that only by beating the queen can you enter in your own players, or learn the secret to do it from the start))
Future<Null> init() async{
    AudioElement bgMusic = querySelector("#bgAudio");
    AudioElement fxMusic = querySelector("#fxAudio");
    print("bgMusic is $bgMusic");
    battleField = new BattleField(getPlayer1(), getPlayer2(), bgMusic, fxMusic);
    Element holder = await battleField.firstDraw();
    bgMusic.play();
    holder.className = "cardCanvas";

    ButtonElement button = new ButtonElement();
    button.setInnerHtml("Change Music Test");
    div.append(button);
    button.onClick.listen((e) {
        bgMusic.src = "../music/Hymn_of_Lost_Hope_Segment.ogg";
        bgMusic.play();
    });


    button = new ButtonElement();
    button.setInnerHtml("Speed Up Music Test");
    div.append(button);
    button.onClick.listen((e) {
        bgMusic.playbackRate = 4.0;
    });

    button = new ButtonElement();
    button.setInnerHtml("Slow Down Music Test");
    div.append(button);
    button.onClick.listen((e) {
        bgMusic.playbackRate = 0.5;
    });


    div.append(holder);
    battleField.idleAnimation(1);
}


