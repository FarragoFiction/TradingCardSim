import 'dart:html';
import "../../../scripts/DollLib/src/includes/predicates.dart";
import "../../../scripts/DollLib/DollRenderer.dart";

class Command {
    ImageElement image;

    Colour textColor = new Colour(0,0,0);
    String folder = "../images/Commands/";
    //maybe display that gif thing of PL's?
    List<AttackDefensePair> results = new List<AttackDefensePair>();

    List <String> modifier = <String>["Passive","Ironic","Flamboyant","Acrobatic","Flaming","Double","Sneak","Manly","Shifty","Suspicious","Sweet","Nice","Fortunate","Swift","Ninja","Bumbling","Sleep","Fluffy"];
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