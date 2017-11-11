import '../../../scripts/DollLib/src/includes/predicates.dart';
import "Command.dart";
import "../../../scripts/DollLib/DollRenderer.dart";

class ConsortAttackCommands extends Command {
    ConsortAttackCommands(Lambda methodToCall) : super("aggrieve",methodToCall) {
        textColor = new Colour.fromStyleString("#ff0000");
        List<String> actions = <String> ["Nak!","Thip!","*tremble*", "Glub!", "Quest!", "Wizard", "Familiar", "Nak Nak!"];
        Random rand = new Random();
        rand.nextInt();
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "You tried."));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "You tried."));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "Fuck no!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "Abjure"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "You're not my REAL dad!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "You tried."));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "You're not my REAL dad!"));
    }

}