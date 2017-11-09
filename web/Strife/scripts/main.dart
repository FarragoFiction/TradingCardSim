
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

Future<Null> init() async{
    AudioElement bgMusic = querySelector("#audio");
    print("bgMusic is $bgMusic");
    battleField = new BattleField(getPlayer1(), getPlayer2(), bgMusic);
    Element holder = await battleField.firstDraw();
    bgMusic.play();
    holder.className = "cardCanvas";
    div.append(holder);
    battleField.idleAnimation(1);
}

