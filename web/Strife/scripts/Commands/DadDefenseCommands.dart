import '../../../scripts/DollLib/src/includes/predicates.dart';
import "Command.dart";
import "../../../scripts/DollLib/DollRenderer.dart";

class DadDefenseCommands extends Command {
    DadDefenseCommands(Lambda methodToCall) : super("aggrieve",methodToCall) {
        textColor = new Colour.fromStyleString("#555555");
        Random rand = new Random();
        rand.nextInt();
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Parry!", ""));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Parry!", ""));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Parry!", ""));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Parry!", ""));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Parry!", ""));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Parry!", ""));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Parry!", ""));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Parry!", ""));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Parry!", ""));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Parry!", ""));
    }

}