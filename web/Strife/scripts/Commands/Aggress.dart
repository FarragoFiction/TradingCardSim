import '../../../scripts/DollLib/src/includes/predicates.dart';
import "Command.dart";
import "../../../scripts/DollLib/DollRenderer.dart";

class Aggress extends Command {
    Aggress(Lambda methodToCall) : super("aggress",methodToCall) {
        textColor = new Colour.fromStyleString("#38f43d");
        Random rand = new Random();
        rand.nextInt();
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Agress!", "Auto-Parry"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Agress!", "Abjure"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Agress!", "Abstain"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Agress!", "Dodge"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Agress!", "Auto-Harley"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Agress!", "Auto-Perrier"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Agress!", "Ogloparry"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Agress!", "Auto-Pirate"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Agress!", "Lol."));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Agress!", "Blotto Parry"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Agress!", "Welp."));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Agress!", "Huh."));
        results.add(new AttackDefensePair("Agress (Passively) !", "Oh, honey, be careful!"));
        results.add(new AttackDefensePair("Agress (Passively) !", "Good Job!"));
        results.add(new AttackDefensePair("Agress (Passively) !", "Bless your heart."));
        results.add(new AttackDefensePair("Agress (Passively) !", "Good job, sweet heart!"));
    }

}