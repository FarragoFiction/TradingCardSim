import '../../../scripts/DollLib/src/includes/predicates.dart';
import "Command.dart";
import "../../../scripts/DollLib/DollRenderer.dart";

class Aggrieve extends Command {
    Aggrieve(Lambda methodToCall) : super("aggrieve",methodToCall) {
        textColor = new Colour.fromStyleString("#38f43d");
        List<String> actions = <String> ["Oppress","Aflict","Assail", "Threat", "Youth Roll", "Roll", "Flip-Roll","Summersault", "Words"];
        Random rand = new Random();
        rand.nextInt();
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "Auto-Parry"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "Abjure"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "Abstain"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Threat!", "Not Listening!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "Auto-Harley"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "Auto-Perrier"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Aggrieve!", "Ogloparry"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Aggrieve!", "Auto-Pirate"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Aggrieve!", "Fuck no!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Aggrieve!", "You tried."));
    }

}