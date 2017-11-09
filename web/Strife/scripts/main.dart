
import "../../scripts/DollLib/DollRenderer.dart";
import 'dart:async';
import "../../scripts/navbar.dart";
import 'BattleField.dart';
import 'Combatant.dart';

import 'dart:html';

BattleField battleField;
Element div = querySelector("#contents");
void main() {
    loadNavbar();
    init();
}

Future<Null> init() async{
    battleField = new BattleField(new Combatant(new HomestuckDoll()), new Combatant(new DadDoll()));
    CanvasElement finishedProduct = await battleField.draw();
    finishedProduct.className = "cardCanvas";
    div.append(finishedProduct);
}
