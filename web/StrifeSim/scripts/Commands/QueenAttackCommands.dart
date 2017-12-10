import "Command.dart";
import "package:DollLibCorrect/DollRenderer.dart";
class QueenAttackCommands extends Command {

    @override
    List <String> modifier = <String>["Red","Blue","Green","Yellow","Black","White","Orange","Muave","Purple","Magenta","Violet","Crimson","Scarlet","Citrine"];


    QueenAttackCommands(Lambda methodToCall) : super("aggrieve",methodToCall) {
        textColor = new Colour.fromStyleString("#ff0000");

        List<String> actions = <String> ["Miles!","Leages!","Inches!", "Yards!", "Meters!", "Kilometers!"];
        Random rand = new Random();
        rand.nextInt();
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "You escaped them."));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "You escaped them."));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "You escaped them."));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "You escaped them."));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "You escaped them."));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "You escaped them."));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "You escaped them."));
    }

}