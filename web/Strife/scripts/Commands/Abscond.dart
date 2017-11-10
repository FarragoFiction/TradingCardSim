import '../../../scripts/DollLib/src/includes/predicates.dart';
import "Command.dart";
import "../../../scripts/DollLib/DollRenderer.dart";

class Abscond extends Command {
    Abscond(Lambda methodToCall) : super("abscond",methodToCall) {
        List<String> actions = <String> ["Flee","Retreat","Renounce", "Hightail", "Vamoose", "Escape"];

        textColor = new Colour.fromStyleString("#ff3779");
        Random rand = new Random();
        rand.nextInt();
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "Can't Abscond, Bro."));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "Can't Abscond, Bro."));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "Can't Abscond, Bro."));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "Can't Abscond, Bro."));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "Can't Abscond, Bro."));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "Can't Abscond, Bro."));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Abscond!", "Can't Abscond, Bro."));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Abscond!", "Can't Abscond, Bro."));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Abscond!", "Can't Abscond, Bro."));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Abscond!", "Can't Abscond, Bro."));
    }

}