import '../../../scripts/DollLib/src/includes/predicates.dart';
import "Command.dart";
import "../../../scripts/DollLib/DollRenderer.dart";

class DadAttackCommands extends Command {
    DadAttackCommands(Lambda methodToCall) : super("aggrieve",methodToCall) {
        textColor = new Colour.fromStyleString("#555555");
        Random rand = new Random();
        rand.nextInt();
        results.add(new AttackDefensePair("Go to Your Room!", "You're not my REAL dad!"));
        results.add(new AttackDefensePair("You're Grounded!", "Hell no!"));
        results.add(new AttackDefensePair("Guardian Rubric: Ironic Negligence", "Abstain"));
        results.add(new AttackDefensePair("Guardian Rubric: Coddlebrand", "Dodge"));
        results.add(new AttackDefensePair("Guardian Rubric: Ironic Negligence", "Abjure"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Parent!", "Auto-Perrier"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Parent!", "Ogloparry"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Parent!", "Auto-Pirate"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Parent!", "Fuck no!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Parent!", "You tried."));
    }

}