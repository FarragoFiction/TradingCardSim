import '../../../scripts/DollLib/src/includes/predicates.dart';
import "Command.dart";
import "../../../scripts/DollLib/DollRenderer.dart";

class Abjure extends Command {
    Abjure(Lambda methodToCall) : super("abjure",methodToCall) {
        textColor = new Colour.fromStyleString("#38d5f4");
        Random rand = new Random();
        rand.nextInt();
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Abjure!", "${rand.pickFrom(modifier)} Abjure!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Abjure!", "${rand.pickFrom(modifier)} Abjure!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Abjure!", "${rand.pickFrom(modifier)} Abjure!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Abjure!", "${rand.pickFrom(modifier)} Abjure!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Abjure!", "${rand.pickFrom(modifier)} Abjure!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Abjure!", "${rand.pickFrom(modifier)} Abjure!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Abjure!", "${rand.pickFrom(modifier)} Abjure!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Abjure!", "${rand.pickFrom(modifier)} Abjure!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Abjure!", "${rand.pickFrom(modifier)} Abjure!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Abjure!", "${rand.pickFrom(modifier)} Abjure!"));
    }

}