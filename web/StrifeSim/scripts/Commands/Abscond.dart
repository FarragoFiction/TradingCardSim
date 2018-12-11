import "Command.dart";
import 'package:CommonLib/Colours.dart';
import 'package:CommonLib/Random.dart';
import 'package:CommonLib/Utility.dart';
import "package:DollLibCorrect/DollRenderer.dart";
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