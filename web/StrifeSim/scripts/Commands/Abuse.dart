import "Command.dart";
import 'package:CommonLib/Colours.dart';
import 'package:CommonLib/Random.dart';
import 'package:CommonLib/Utility.dart';
import "package:DollLibCorrect/DollRenderer.dart";
class Abuse extends Command {

    Abuse(Lambda methodToCall) : super("abuse",methodToCall) {
        textColor = new Colour.fromStyleString("#ffb82d");
        //will trigger a fraymotif if you timed it right.
        results.add(new AttackDefensePair("You can't do that, yet!", "Auto-Parry"));
    }

}