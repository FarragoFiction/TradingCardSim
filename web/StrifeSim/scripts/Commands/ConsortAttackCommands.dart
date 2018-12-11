import "Command.dart";
import "package:DollLibCorrect/DollRenderer.dart";
import 'package:CommonLib/Colours.dart';
import 'package:CommonLib/Random.dart';
import 'package:CommonLib/Utility.dart';
class ConsortAttackCommands extends Command {
    ConsortAttackCommands(Lambda methodToCall) : super("aggrieve",methodToCall) {
        modifier.add("Secret");
        textColor = new Colour.fromStyleString("#ff0000");
        List<String> actions = <String> ["Nak!","Thip!","*tremble*", "Glub!", "Quest!", "Wizard", "Familiar", "Nak Nak!"];
        Random rand = new Random();
        rand.nextInt();
        results.add(new AttackDefensePair("Flip The Fuck Out!", "Oh god. Stop that!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "What."));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "What."));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "What."));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "How cute!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "How cute!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "How cute!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "How cute!"));
    }

}