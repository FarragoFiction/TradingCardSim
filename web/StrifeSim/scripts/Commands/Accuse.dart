import '../../../scripts/DollLib/src/includes/predicates.dart';
import "Command.dart";
import "../../../scripts/DollLib/DollRenderer.dart";

class Accuse extends Command {
    Accuse(Lambda methodToCall) : super("accuse",methodToCall) {
        textColor = new Colour.fromStyleString("#ffb82d");
        //will trigger a fraymotif if you timed it right.
        results.add(new AttackDefensePair("It's Not Time To Use That Yet!", "Auto-Parry"));
    }

}