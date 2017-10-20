
import "DollLib/src/includes/colour.dart";
import "DollLib/DollRenderer.dart";
import 'dart:async';
import 'dart:html';


/*
 has a doll drawn in the window, a bunch of text, and IF it's a doll that has a symbol layer
 the symbol is copied in the upper right corner.

 knows how to draw itself.

 */
class TradingCard {
    Colour tint;
    Doll doll;
    int width = 322;
    int height = 450;
    Random rand;
    String name;
    String type;
    String description;

    TextLayer nameLayer;
    TextLayer typeLayer;
    TextLayer descriptionLayer;

    List<String> randomFirstWords = <String>["Lord","Muse","Priest","Dame","Guard","Sage","Smith","Scribe","Grace","Waste","Monk","Beast","Knight","Seer","Bard","Heir","Maid","Rogue","Page","Thief","Sylph","Witch","Prince","Mage","Bane","Scout","Guide","Nymph","Fool","Wright","Clown","King","Queen","Jack","Pawn","Nurse"];
    List<String> randomSecondWords = <String>["Blood","Mind","Rage","Void","Time","Heart","Breath","Light","Space","Hope","Life","Doom","Dream","Rain","Might","Sand","Mist","Null","Flow","Rhyme","Stars","Sky","Fate","Heat","Frost","Snow","Law","Flame","Flood","Quake","Ice","Mud","Calm","Peace","Zap","Soft","Hard","Home"];

    List<String> verbs = ["tap","use","discard","draw"];
    List<String> nouns = ["card","monster","item"];
    List<String> effects = ["confused","poisoned","dead"];


    TradingCard(Doll this.doll, {this.name:null, this.type:null, this.description:null}) {
        rand = new Random();
        tint = new Colour(rand.nextInt(255), rand.nextInt(255),rand.nextInt(255));
        //TODO set up text layers with random values.
        if(name == null) name = randomName();
        if(description == null) description = randomDescription();
        nameLayer = new TextLayer(name,35.0,28.0, fontSize: 18);
        typeLayer = new TextLayer(type,35.0,260.0, fontSize: 18);
        descriptionLayer = new TextLayer(description,46.0,280.0, fontSize: 18, maxWidth: 180);
        //TODO have text layers know how to render their own form values (in DollMaker, add DollTools to lib)
    }

    List<TextLayer> get textLayers => <TextLayer>[nameLayer, typeLayer, descriptionLayer];

    String randomDescription() {
        String verb = rand.pickFrom(verbs);
        String noun  = rand.pickFrom(nouns);
        String effect = rand.pickFrom(effects);
        List<String> possibilities = <String>["$verb the $name, discarding it in order to make the ${noun} ${effect}.","$verb two ${noun}s from your deck. Attach them to the $name.","Pick one enemy ${noun}, $verb it.  Your $name is now ${effect}"];
        return toBeginningOfSentenceCase(rand.pickFrom(possibilities));
    }

    String toBeginningOfSentenceCase(String input) {
        if (input == null || input.isEmpty) return input;
        return "${input[0].toUpperCase()}${input.substring(1)}";
    }



    String randomName() {
        type = rand.pickFrom(randomFirstWords);
        return "$type of ${rand.pickFrom(randomSecondWords)}";
    }

    Future<CanvasElement> draw() async

    {
        CanvasElement cardElement = await drawCardTemplate(tint);
        CanvasElement monsterElement = await drawMonster(doll);

        CanvasElement finishedProduct = new CanvasElement(width: width, height: height);
        Renderer.drawBG(finishedProduct, tint, new Colour(255,255,255));

        int x = (doll.width/3 - monsterElement.width/3).round();
        int y = (3*monsterElement.height/4 - 2*monsterElement.height/4).round();
        finishedProduct.context2D.drawImage(monsterElement, x, y);
        finishedProduct.context2D.drawImage(cardElement, 0, 0);

        CanvasRenderingContext2D ctx = finishedProduct.context2D;

        for(TextLayer textLayer in textLayers) {
            ctx.fillStyle = textLayer.fillStyle;
            ctx.font = textLayer.font;
            //ctx.fillText(textLayer.text, textLayer.topLeftX, textLayer.topLeftY);
            Renderer.wrap_text(ctx,textLayer.text,textLayer.topLeftX,textLayer.topLeftY,textLayer.fontSize,textLayer.maxWidth,"left");
        }

        return finishedProduct;
    }

    Future<CanvasElement>  drawMonster(Doll doll) async {
        double monsterScale = 1.0;
        CanvasElement monsterElement = new CanvasElement(width: (256*monsterScale).round(), height: (206*monsterScale).round());
        // Renderer.drawBG(monsterElement, ReferenceColours.BLACK, ReferenceColours.WHITE);
        await Renderer.drawDoll(monsterElement, doll);
        return monsterElement;
    }

    Future<CanvasElement> drawCardTemplate(Colour color) async{
        CanvasElement cardElement = new CanvasElement(width: width, height: height);
        await Renderer.drawWhatever(cardElement, "images/blank.png");
        Renderer.swapColors(cardElement, color);
        return cardElement;

    }

}