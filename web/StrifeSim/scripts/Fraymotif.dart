import "../../scripts/DollLib/DollRenderer.dart";
import 'dart:async';
import 'dart:html';
import 'Combatant.dart';
import "RandomFuckingObject.dart";
import "dart:math" as Math;
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
    List<RandomFuckingObject> randomFuckingObjects = new List<RandomFuckingObject>();
    CanvasElement canvas;
    int initialSeed = 0;
    String name;
    Random rand;
    int x = 0;
    int y = 0;
    double _scaleX = 1.0;
    double _scaleY = 1.0;
    double rotation = 0.0;
    List<FraymotifEffect> effects = new List<FraymotifEffect>();
    List<FraymotifLayer> randomObjectLayers = new List<FraymotifLayer>();

    Fraymotif(this.name, this.imgName, this.musicalThemeName, this.initialSeed) {
        resetRandom();
        randomEffects();
    }

    void apply(Combatant c, int w,  int h) {
        for(FraymotifEffect f in effects) {
            f.apply(this, c, w, h);
        }
    }

    void randomEffects() {

        WeightedList<FraymotifEffect>possibilities =  new WeightedList<FraymotifEffect>();
        possibilities.add(new BackwardsSpin(),0.5);
        possibilities.add(new HalfSpin(),0.1);
        possibilities.add(new Shrink(),0.1);
        possibilities.add(new Spin(),0.1);
        possibilities.add(new Warp(),1.0);
        possibilities.add(new Jitter(),1.0);
        possibilities.add(new Bounce(),1.0);
        possibilities.add(new MoveLeft(),1.0);
        possibilities.add(new Fall(),0.1);
        possibilities.add(new Rise(),1.0);
        possibilities.add(new MoveRight(),0.1);

        int number = rand.nextInt(2)+2;
        for(int i = 0; i<number; i++) {
            effects.add(rand.pickFrom(possibilities));

        }
    }

    void initRandomFuckingObjects(int w, int h) {
        //instead of drawing #objects each time, just three layers.
        randomObjectLayers.add(new FraymotifLayer(new CanvasElement(width: w, height:h)));
        randomObjectLayers.add(new FraymotifLayer(new CanvasElement(width: w, height:h)));
        randomObjectLayers.add(new FraymotifLayer(new CanvasElement(width: w, height:h)));

        List<int> chosenObjects = <int>[rand.nextInt(RandomFuckingObject.maxItemNumber),rand.nextInt(RandomFuckingObject.maxItemNumber),rand.nextInt(RandomFuckingObject.maxItemNumber)];
        int distanceBetweenItems = 133;
        for(int i = 0; i < w-distanceBetweenItems; i += distanceBetweenItems) {
            for(int j = 0; j < h-distanceBetweenItems; j += distanceBetweenItems) {
                int iOffset = i + rand.nextInt(distanceBetweenItems);
                int jOffset = j + rand.nextInt(distanceBetweenItems);
                print("adding item at ${iOffset} ${jOffset}");
                randomFuckingObjects.add(new RandomFuckingObject(rand.pickFrom(chosenObjects),iOffset,jOffset, rand.pickFrom(randomObjectLayers).canvas));
            }
        }
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


    Future<CanvasElement> draw(int w, int h) async {
        if(canvas == null) {
            ImageElement image = await Loader.getResource((imageLocation));
            canvas = new CanvasElement(width: image.width, height: image.height);
            canvas.context2D.drawImage(image, 0, 0);
            initRandomFuckingObjects(w, h);
        }
        return await drawForReal(canvas,w,h);
    }


    //TODO: have all sorts of random shit that can be drawn here.
    //keep array of images that could be drawn in random spots.
    //they have same rotation and etc as fraymotif, and are drawn relative to it, so crazy shit is happenign even without it.
    //save their canvas here too.
    //wizards and grist and generic objects and shit.
    Future<CanvasElement> drawForReal(CanvasElement c, int w, int h) async{
        //print('drawing with rotation $rotation');
        CanvasElement ret = new CanvasElement(width:c.width, height: c.height);
        ret.context2D.translate(ret.width/2, ret.height/2);
        ret.context2D.rotate(rotation);
        ret.context2D.scale(_scaleX, _scaleY);
        ret.context2D.drawImage(canvas, -ret.width/2, -ret.height/2);
        return ret;
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
        setScale(1.0, 1.0);
        rotation = 0.0;
        for(FraymotifLayer r in randomObjectLayers) {
            r.x = 0;
            r.y = 0;
            r.rotation = 0.0;
            r.setScale(1.0, 1.0);
        }
        /* don't do individually anymore
        for(RandomFuckingObject r in randomFuckingObjects) {
            r.x = 0;
            r.y = 0;
            r.rotation = 0.0;
            r.setScale(1.0, 1.0);
        }*/
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

    void apply(Fraymotif f, Combatant c, int w, int h);


    void keepInBounds(Fraymotif f,int w,int h) {
        if(f.canvas != null) {
            if (f.x + f.canvas.width > w) f.x = w-f.canvas.width;
            if (f.y + f.canvas.height > h) f.y = h-f.canvas.height;
            if(f.x < 0) f.x = 0;
            if(f.y < 0) f.y = 0;
        }else {
            if (f.x + 100 > w) f.x = w-100;
            if (f.y + 100 > h) f.y = h-100;
            if(f.x < 0) f.x = 0;
            if(f.y < 0) f.y = 0;
        }

    }

    void reset() {

    }

    void syncEnemy(Combatant c, Fraymotif f, int width, int height) {
        if(!c.defending) {
            c.x = f.x;
            c.y = f.y;
            c.rotation = f.rotation;
            //it's private but i'm in same file so it's fine (it's private to file not class apparently)
            c.setScale(f._scaleX, f._scaleY);
        }
        //print("syncing enemy");
        for(FraymotifLayer r in f.randomObjectLayers) {
            r.rotation = f.rotation;
            //r.x = f.x + r.offsetX;
            r.y = f.y + f.rand.nextInt(20) + 20;
            if(r.y > height) {
                r.y = 0; //zap back up
            }
            //r.setScale(f._scaleX, f._scaleY);
        }
        /* it's too slow to work on all objects.
        for(RandomFuckingObject r in f.randomFuckingObjects) {
            r.rotation = f.rotation;
            //r.x = f.x + r.offsetX;
            r.y = f.y + f.rand.nextInt(20) + 20;
            if(r.y > height) {
                r.y = 0; //zap back up
            }
            //r.setScale(f._scaleX, f._scaleY);
        }*/
    }

}


class Bounce extends FraymotifEffect {
    double direction;
    double magnitude = 10.0;

    @override
    void reset() {
        direction = null;
        magnitude = 10.0;
    }

    @override
    void apply(Fraymotif f, Combatant c, int w, int h) {
        if(direction == null) direction = (360* f.rand.nextDouble())*  (Math.PI / 180);
        int savedX = f.x;
        int savedY = f.y;
        keepInBounds(f, w, h);
        if(savedX != f.x || savedY != f.y) {
            //then i'm at an edge
            direction = -1 * direction;
        }
        double x =   this.magnitude * Math.cos(this.direction);
        double y =  this.magnitude * Math.sin(this.direction);
        f.x += x.floor();
        f.y += y.floor();
        syncEnemy(c, f,w,h);
    }
}



class Jitter extends FraymotifEffect {
    @override
    void apply(Fraymotif f, Combatant c, int w, int h) {
        int changeX = f.rand.nextInt(10);
        int changeY = f.rand.nextInt(10);
        int newX = 0;
        int newY = 0;
        if(f.rand.nextBool()) {
            newX = f.x + changeX;
        }else {
            newX = f.x - changeX;
        }

        if(f.rand.nextBool()) {
            newY = f.y + changeY;
        }else {
            newY = f.y - changeY;
        }
        f.x = newX;
        f.y = newY;
        keepInBounds(f,w,h);

        syncEnemy(c, f,w,h);
    }
}



class Warp extends FraymotifEffect {
    @override
    void apply(Fraymotif f, Combatant c, int w, int h) {
        int changeX = f.rand.nextInt(100);
        int changeY = f.rand.nextInt(100);
        int newX = 0;
        int newY = 0;
        if(f.rand.nextBool()) {
            newX = f.x + changeX;
        }else {
            newX = f.x - changeX;
        }

        if(f.rand.nextBool()) {
            newY = f.y + changeY;
        }else {
            newY = f.y - changeY;
        }
        f.x = newX;
        f.y = newY;
        keepInBounds(f,w,h);

        syncEnemy(c, f,w,h);
    }
}

class MoveRight extends FraymotifEffect {

    int speed = 0;

    @override
    void reset() {
        speed = 0;
    }

  @override
  void apply(Fraymotif f, Combatant c, int w, int h) {
      if(speed ==0) speed = f.rand.nextInt(50);
      f.x += 1* speed;
    keepInBounds(f, w, h);
    syncEnemy(c, f,w,h);
  }
}


class Spin extends FraymotifEffect {
    double angle = 0.0;
    int speed = 0;

    @override
    void reset() {
        angle = 0.0;
        speed = 0;
    }
    @override
    void apply(Fraymotif f, Combatant c, int w, int h) {
        if(speed == 0) speed = f.rand.nextInt(50);
        angle += 1.0* speed;
        double rotation = angle * Math.PI / 180.0;
        f.rotation  = rotation;
        syncEnemy(c, f,w,h);
    }
}

class BackwardsSpin extends FraymotifEffect {
    double angle = 0.0;
    int speed = 0;

    @override
    void reset() {
        angle = 0.0;
        speed = 0;
    }
    @override
    void apply(Fraymotif f, Combatant c, int w, int h) {
        if(speed == 0) speed = f.rand.nextInt(50);
        angle += -1*1.0* speed;
        double rotation = angle * Math.PI / 180.0;
        f.rotation  = rotation;
        syncEnemy(c, f,w,h);
    }
}

class HalfSpin extends FraymotifEffect {
    double angle = 0.0;
    int frame = 0;
    int maxAngle = 0;

    @override
    void reset() {
        angle = 0.0;
        frame = 0;
        maxAngle = 0;
    }
    @override
    void apply(Fraymotif f, Combatant c, int w, int h) {
        if(maxAngle == 0) maxAngle = f.rand.nextInt(90);
        frame += 1;

        double angle = 1.0*(maxAngle % frame);
        double rotation = angle * Math.PI / 180.0;
        f.rotation  = rotation;
        syncEnemy(c, f,w,h);
    }
}

class Swell extends FraymotifEffect {
    @override
    void apply(Fraymotif f, Combatant c, int w, int h) {
        f._scaleX += 0.1;
        f._scaleY += 0.1;
        keepInBounds(f, w, h);
        syncEnemy(c, f,w,h);
    }
}


class Shrink extends FraymotifEffect {
    @override
    void apply(Fraymotif f, Combatant c, int w, int h) {
        f._scaleX += -0.01;
        f._scaleY += -0.01;
        keepInBounds(f, w, h);
        syncEnemy(c, f,w,h);
    }
}

class Rise extends FraymotifEffect {

    int speed = 0;

    @override
    void reset() {
        speed = 0;
    }
    @override
    void apply(Fraymotif f, Combatant c, int w, int h) {
        if(speed ==0) speed = f.rand.nextInt(50);
        f.y += -1* speed;
        keepInBounds(f, w, h);
        syncEnemy(c, f,w,h);
    }
}

class Fall extends FraymotifEffect {

    int speed = 0;

    @override
    void reset() {
        speed = 0;
    }
    @override
    void apply(Fraymotif f, Combatant c, int w, int h) {
        if(speed ==0) speed = f.rand.nextInt(50);
        f.y += 1* speed;
        keepInBounds(f, w, h);
        syncEnemy(c, f,w,h);
    }
}

class MoveLeft extends FraymotifEffect {

    int speed = 0;

    @override
    void reset() {
        speed = 0;
    }
    @override
    void apply(Fraymotif f, Combatant c, int w, int h) {
        if(speed ==0) speed = f.rand.nextInt(50);
        f.x += -1* speed;
        keepInBounds(f, w, h);
        syncEnemy(c, f,w,h);
    }
}

class FraymotifLayer {
    CanvasElement canvas;
    int x = 0;
    int y = 0;
    //where are you in this random fucking grid? shouldn't change
    int offsetX = 0;
    int offsetY = 0;
    double _scaleX = 1.0;
    double _scaleY = 1.0;
    double rotation = 0.0;

    FraymotifLayer(this.canvas);

    void flip() {
        _scaleX = -1 * _scaleX;
    }

    void setScale(double x, double y) {
        _scaleX = x;
        _scaleY = y;
    }

    Future<CanvasElement> drawForReal(CanvasElement c, int w, int h) async{
        //print('drawing with rotation $rotation');
        CanvasElement ret = new CanvasElement(width:w, height: h);
        ret.context2D.translate(ret.width/2, ret.height/2);
        ret.context2D.rotate(rotation);
        ret.context2D.scale(_scaleX, _scaleY);
        ret.context2D.drawImage(canvas, -ret.width/2, -ret.height/2);
        return ret;
    }

}