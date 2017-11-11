import '../../../scripts/DollLib/src/includes/predicates.dart';
import "Command.dart";
import "../../../scripts/DollLib/DollRenderer.dart";

class DadDefenseCommands extends Command {


    @override
    List <String> modifier = <String>["Auto","Otto","Blotto","Also","Bravo","Follow","Hollow","Mano","Pronto","Swallow","Taco","Wallow","Water","Lotto","Motto","Vibrato","Avocado","Desperado","Colorado","Incommunicado","Apollo","Bravado","Picasso","Risotto","Toronto"];

    DadDefenseCommands(Lambda methodToCall) : super("abstain",methodToCall) {
        textColor = new Colour.fromStyleString("#555555");
        Random rand = new Random();
        rand.nextInt();
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Parry!", "${rand.pickFrom(modifier)} Parry!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Parry!", "${rand.pickFrom(modifier)} Parry!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Parry!", "${rand.pickFrom(modifier)} Parry!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Parry!", "${rand.pickFrom(modifier)} Parry!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Parry!", "${rand.pickFrom(modifier)} Parry!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Parry!", "${rand.pickFrom(modifier)} Parry!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Parry!", "${rand.pickFrom(modifier)} Parry!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Parry!", "${rand.pickFrom(modifier)} Parry!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Parry!", "${rand.pickFrom(modifier)} Parry!"));
        results.add(new AttackDefensePair("${rand.pickFrom(modifier)} Parry!", "${rand.pickFrom(modifier)} Parry!"));
    }

}