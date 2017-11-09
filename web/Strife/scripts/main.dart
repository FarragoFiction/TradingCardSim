
import "../../scripts/DollLib/DollRenderer.dart";
import 'dart:async';
import "../../scripts/navbar.dart";
import 'BattleField.dart';
import 'Combatant.dart';

import 'dart:html';

BattleField battleField;
int frame = 0;
Element div = querySelector("#contents");
void main() {
    loadNavbar();
    init();
}

Future<Null> init() async{
    AudioElement bgMusic = querySelector("#audio");
    print("bgMusic is $bgMusic");
    battleField = new BattleField(new Combatant(new HomestuckDoll()), new Combatant(new DadDoll()), bgMusic);
    Element holder = await battleField.firstDraw();
    bgMusic.play();
    holder.className = "cardCanvas";
    div.append(holder);
    battleField.animate(1);
}


