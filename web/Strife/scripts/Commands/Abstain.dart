import '../../../scripts/DollLib/src/includes/predicates.dart';
import "Command.dart";
import "../../../scripts/DollLib/DollRenderer.dart";

class Abstain extends Command {
    Abstain(Lambda methodToCall) : super("abstain",methodToCall) {
        textColor = new Colour.fromStyleString("#38d5f4");
        Random rand = new Random();
        rand.nextInt();
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Abstain!", "${rand.pickFrom(modifier)} Abstain!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Abstain!", "${rand.pickFrom(modifier)} Abstain!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Abstain!", "${rand.pickFrom(modifier)} Abstain!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Abstain!", "${rand.pickFrom(modifier)} Abstain!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Abstain!", "${rand.pickFrom(modifier)} Abstain!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Abstain!", "${rand.pickFrom(modifier)} Abstain!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Abstain!", "${rand.pickFrom(modifier)} Abstain!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Abstain!", "${rand.pickFrom(modifier)} Abstain!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Abstain!", "${rand.pickFrom(modifier)} Abstain!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Abstain!", "${rand.pickFrom(modifier)} Abstain!"));
    }

}