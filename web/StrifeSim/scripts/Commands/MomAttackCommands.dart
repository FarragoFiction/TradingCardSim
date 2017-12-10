import "Command.dart";
import "package:DollLibCorrect/DollRenderer.dart";
class MomAttackCommands extends Command {
    MomAttackCommands(Lambda methodToCall) : super("aggrieve",methodToCall) {
        textColor = new Colour.fromStyleString("#555555");
        List<String> actions = <String> ["Teach","Example","Mentor", "Lesson", "Parable", "Boring Story", "Awkward Conversation", "Embarassment"];
        Random rand = new Random();
        rand.nextInt();
        results.add(new AttackDefensePair("Go to Your Room!", "You're not my REAL mom!"));
        results.add(new AttackDefensePair("You're Grounded!", "Hell no!"));
        results.add(new AttackDefensePair("Guardian Rubric: Ironic Negligence", "Abstain"));
        results.add(new AttackDefensePair("Guardian Rubric: Ironic Negligence", "Auto-Perrier"));
        results.add(new AttackDefensePair("Guardian Rubric: Coddlebrand", "Dodge"));
        results.add(new AttackDefensePair("Guardian Rubric: Ironic Negligence", "Abjure"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Parent!", "Auto-Perrier"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Parent!", "Ogloparry"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Parent!", "Auto-Pirate"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Parent!", "Fuck no!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Awkward Conversation!", "Fuck no!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Lesson!", "Not Listening!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "You tried."));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "You tried."));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "Fuck no!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "Abjure"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "You're not my REAL mom!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "You tried."));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} ${rand.pickFrom(actions)}!", "You're not my REAL mom!"));
    }

}