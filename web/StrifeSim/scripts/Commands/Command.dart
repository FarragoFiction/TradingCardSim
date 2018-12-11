import 'dart:html';
import "package:DollLibCorrect/DollRenderer.dart";
import 'package:CommonLib/Colours.dart';
import 'package:CommonLib/Random.dart';
import 'package:CommonLib/Utility.dart';
class Command {
    ImageElement image;

    Colour textColor = new Colour(0,0,0);
    String folder = "../images/Commands/";
    //maybe display that gif thing of PL's?
    List<AttackDefensePair> results = new List<AttackDefensePair>();

    List <String> modifier = <String>["Passive","Ironic","Flamboyant","Acrobatic","Flaming","Double","Sneak","Manly","Shifty","Suspicious","Sweet","Nice","Fortunate","Swift","Ninja","Bumbling","Sleep","Fluffy","Angery","Sincere","Nostalgic","Poignant","Festering","Tasty","Post-Ironic","Pre-Ironic","Totally Sincere","Ironically Sincere","Partially Sincere","Serious","Miraculous","Crabby","Well Reasoned","Pre-planned","Twirling","Totally Fake","Well intentioned"];
    Lambda methodToCall;

    Command(String imgPath,this.methodToCall) {
        image = new ImageElement();
        image.src = "${folder}${imgPath}.png";
        image.onClick.listen((e) => methodToCall(this));
    }
}

class AttackDefensePair {
    String attack;
    String defense;
    AttackDefensePair(this.attack, this.defense);
}