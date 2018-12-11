import "Command.dart";
import 'package:CommonLib/Colours.dart';
import 'package:CommonLib/Random.dart';
import 'package:CommonLib/Utility.dart';
import "package:DollLibCorrect/DollRenderer.dart";
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