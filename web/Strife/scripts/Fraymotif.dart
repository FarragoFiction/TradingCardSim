import "../../scripts/DollLib/DollRenderer.dart";
import 'dart:async';
import 'dart:html';
import 'Combatant.dart';
//fraymotifs are owned by combatants.
class Fraymotif {
    static List<String> imageNames = <String>["blood","mind","rage","void","time","heart","breath","light","space","hope","life","doom"];
    static List<String> musicsChoices = <String>["Hymn_of_Lost_Hope_Segment.ogg","Lucky_Flare_Cadence_Segment.ogg","Noirsong_Segment.ogg","PARAN01A_Segment.ogg","Supernova_Stretto_Segment.ogg","Tempo_Transference_Segment.ogg","Veloce_Clockwork_Segment.ogg"];
    //why yes, i did just grab my three favorite aspects for fraymotif words from the sim. how did you know?
    static List<String> nameChoices = <String>["Rage", "Barbaric", "Impossible", "Tantrum", "Juggalo", "Horrorcore", "Madness", "Carnival", "Mirthful", "Screaming", "Berserk", "MoThErFuCkInG", "War", "Haze", "Murder", "Furioso", "Aggressive", "ATBasher", "Violent", "Unbound", "Purple", "Unholy", "Hateful", "Fearful", "Inconceivable", "Impossible","Time", "Paradox", "Chrono", "Moment", "Foregone", "Reset", "Endless", "Temporal", "Shenanigans", "Clock", "Tick-Tock", "Spinning", "Repeat", "Rhythm", "Redshift", "Epoch", "Beatdown", "Slow", "Remix", "Clockwork", "Lock", "Eternal","Undefined", "untitled.mp4", "Void", "Disappearification", "Pumpkin", "Nothing", "Emptiness", "Invisible", "Dark", "Hole", "Solo", "Silent", "Alone", "Night", "Null", "[Censored]", "[???]", "Vacuous", "Abyss", "Noir", "Blank", "Tenebrous", "Antithesis", "404"];
    static List<String> musicalNameChoices = <String>["Fortississimo", "Leitmotif", "Liberetto", "Sarabande", "Serenade", "Anthem", "Crescendo", "Vivace", "Encore", "Vivante", "Allegretto", "Fugue", "Choir", "Nobilmente", "Hymn", "Eroico", "Chant", "Mysterioso", "Diminuendo", "Perdendo", "Staccato", "Allegro", "Caloroso", "Nocturne","Cadenza", "Cadence", "Waltz", "Concerto", "Finale", "Requiem", "Coda", "Dirge", "Battaglia", "Leggiadro", "Capriccio", "Presto", "Largo", "Accelerando", "Polytempo", "Overture", "Reprise", "Orchestra"];

    String _imgFolder = "images/Homestuck/Fraymotifs";
    String imgName;
    String _musicFolder = "../music/";
    String musicalThemeName;
    CanvasElement canvas;
    int initialSeed = 0;
    String name;
    Random rand;
    int x = 0;
    int y = 0;
    double _scaleX = 1.0;
    double _scaleY = 1.0;
    double rotation = 0.0;
    List<FraymotifEffect> effects;

    Fraymotif(this.name, this.imgName, this.musicalThemeName, this.initialSeed) {
        resetRandom();
        randomEffects();
    }

    void apply(Combatant c) {
        for(FraymotifEffect f in effects) {
            f.apply(this, c);
        }
    }

    void randomEffects() {
        effects.add(new MoveLeft());
    }

    void setScale(double x, double y) {
        _scaleX = x;
        _scaleY = y;
    }

    static Fraymotif randomFraymotif() {
        Random rand = new Random();
        int seed = rand.nextInt();
        return new Fraymotif(randomName(), randomImage(), randomSong(), seed);
    }

    static String randomName() {
        Random rand = new Random();
        int number = rand.nextInt(3)+1;
        String ret = "";
        for(int i = 0; i< number; i++) {
            ret += "${rand.pickFrom(nameChoices)} ";
        }
        ret += "${rand.pickFrom(musicalNameChoices)}";

        return ret;
    }

    Future<CanvasElement> draw() async {
        if(canvas == null) {
            ImageElement image = await Loader.getResource((imageLocation));
            canvas = new CanvasElement(width: image.width, height: image.height);
            canvas.context2D.drawImage(image, 0, 0);
        }
        return canvas;
    }

    static String randomSong() {
        Random rand = new Random();
        return rand.pickFrom(musicsChoices);
    }

    static String randomImage() {
        Random rand = new Random();
        return rand.pickFrom(imageNames);
    }


    //fraymotifs carry their own random so their motions are the same each time, but still random.
    void resetRandom() {
        rand = new Random(initialSeed);
    }

    String get imageLocation {
        return "${_imgFolder}/${imgName}.png";
    }

    String get musicLocation {
        return "${_musicFolder}${musicalThemeName}";
    }
}


/*
TODO:   All fraymotifs do damage every frame (instead of just at end).

A fraymotif can do multiple things to itself each frame. Spin, bounce around on screen. Flip, etc.

If the enemy is NOT defending, whatever happens to the fraymotif happens to the enemy as well.

Some fraymotifs will suck the enemy to their location, others will go to the enemies location. Whatever.
 */
abstract class FraymotifEffect {

    void apply(Fraymotif f, Combatant c);

}

class MoveLeft extends FraymotifEffect {
  @override
  void apply(Fraymotif f, Combatant c) {
    f.x += 10;
    if(!c.defending) c.x += 10;
  }
}