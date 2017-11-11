import '../../../scripts/DollLib/src/includes/predicates.dart';
import "Command.dart";
import "../../../scripts/DollLib/DollRenderer.dart";

class ConsortAttackCommands extends Command {
    ConsortAttackCommands(Lambda methodToCall) : super("aggrieve",methodToCall) {
        modifier.add("Secret");
        textColor = new Colour.fromStyleString("#ff0000");
        List<String> actions = <String> ["Nak!","Thip!","*tremble*", "Glub!", "Quest!", "Wizard", "Familiar", "Nak Nak!"];
        Random rand = new Random();
        rand.nextInt();
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "What."));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "What."));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "What."));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "How cute!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "How cute!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "How cute!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "How cute!"));
    }

}