
import "../../scripts/DollLib/DollRenderer.dart";
import 'dart:async';
import "../../scripts/navbar.dart";
import 'BattleField.dart';
import 'Combatant.dart';

import 'dart:html';

BattleField battleField;
int frame = 0;
Element div = querySelector("#contents");
bool egg = true;
void main() {
    loadNavbar();
    init();
}

//wait, EGGS!?  In MY strife? It's more likely than you think.
Combatant getPlayer1() {
    if(egg) {
        return new Combatant(new EggDoll());
    }else {
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


