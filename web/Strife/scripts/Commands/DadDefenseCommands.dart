import '../../../scripts/DollLib/src/includes/predicates.dart';
import "Command.dart";
import "../../../scripts/DollLib/DollRenderer.dart";

class DadDefenseCommands extends Command {
    DadDefenseCommands(Lambda methodToCall) : super("aggrieve",methodToCall) {
        textColor = new Colour.fromStyleString("#555555");
        Random rand = new Random();
        rand.nextInt();
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Parry!", "You're not my REAL dad!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Parry!", "Hell no!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Parry!", "Abstain"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Parry!", "Dodge"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Parry!", "Abjure"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Parry!", "Auto-Perrier"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Parry!", "Ogloparry"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Parry!", "Auto-Pirate"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Parry!", "Fuck no!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Parry!", "You tried."));
    }

}