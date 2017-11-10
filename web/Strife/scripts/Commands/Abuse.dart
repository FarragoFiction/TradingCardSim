import '../../../scripts/DollLib/src/includes/predicates.dart';
import "Command.dart";
import "../../../scripts/DollLib/DollRenderer.dart";

class Abuse extends Command {

    Abuse(Lambda methodToCall) : super("abuse",methodToCall) {
        textColor = new Colour.fromStyleString("#ffb82d");
        //will trigger a fraymotif if you timed it right.
        results.add(new AttackDefensePair("Stop Spamming!", "Auto-Parry"));
    }

}