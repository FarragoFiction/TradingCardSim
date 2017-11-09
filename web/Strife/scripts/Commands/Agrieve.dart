import '../../../scripts/DollLib/src/includes/predicates.dart';
import "Command.dart";
import "../../../scripts/DollLib/DollRenderer.dart";

class Aggrieve extends Command {
    Aggrieve(Lambda methodToCall) : super("aggrieve",methodToCall) {
        textColor = new Colour.fromStyleString("#38f43d");
        Random rand = new Random();
        rand.nextInt();
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Aggrieve!", "Auto-Parry"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Aggrieve!", "Abjure"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Aggrieve!", "Abstain"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Aggrieve!", "Dodge"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Aggrieve!", "Auto-Harley"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Aggrieve!", "Auto-Perrier"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Aggrieve!", "Ogloparry"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Aggrieve!", "Auto-Pirate"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Aggrieve!", "Fuck no!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Aggrieve!", "You tried."));
    }

}