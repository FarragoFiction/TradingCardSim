import "Command.dart";
import 'package:CommonLib/Colours.dart';
import 'package:CommonLib/Random.dart';
import 'package:CommonLib/Utility.dart';
import "package:DollLibCorrect/DollRenderer.dart";
class Abjure extends Command {
    List<String> actions = <String> ["Refrain","Retract", "Abstain", "Refuse", "Forswear", "Recant", "Renege", "Renounce"];
    Abjure(Lambda methodToCall) : super("abjure",methodToCall) {
        textColor = new Colour.fromStyleString("#38d5f4");
        Random rand = new Random();
        rand.nextInt();
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Abjure!", "${rand.pickFrom(modifier)} Abjure!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Abjure!", "${rand.pickFrom(modifier)} Abjure!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Abjure!", "${rand.pickFrom(modifier)} Abjure!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Abjure!", "${rand.pickFrom(modifier)} Abjure!"));
    }

}