import 'dart:html';
import "../../scripts/DollLib/src/includes/predicates.dart";

class Command {
    ImageElement image;

    String folder = "../images/Commands/";
    //maybe display that gif thing of PL's?
    String effect;
    String counterEffect;
    Lambda methodToCall;

    Command(String imgPath, this.effect, this.counterEffect, this.methodToCall) {
        image = new ImageElement();
        image.src = "${folder}${imgPath}.png";
        image.onClick.listen((e) => methodToCall(this));
    }
}