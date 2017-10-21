
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

    CanvasElement canvas;
    Colour tint;
    Doll doll;
    int width = 322;
    int height = 450;
    Random rand;
    String name;
    String type;
    String description;
    String shittyPoem;

    int health = 1;
    int power = 1;
    int mana = 1;

    TextLayer nameLayer;
    TextLayer typeLayer;
    TextLayer descriptionLayer;
    TextLayer shittyPoemLayer;
    TextLayer statLayer;

    List<String> randomFirstWords = <String>["Lord","Elf","Muse","Priest","Dame","Guard","Sage","Smith","Scribe","Grace","Waste","Monk","Beast","Knight","Seer","Bard","Heir","Maid","Rogue","Page","Thief","Sylph","Witch","Prince","Mage","Bane","Scout","Guide","Nymph","Fool","Wright","Clown","King","Queen","Jack","Pawn","Nurse"];
    List<String> randomSecondWords = <String>["Blood","Mind","Rage","Void","Time","Heart","Breath","Light","Space","Hope","Life","Doom","Dream","Rain","Might","Sand","Mist","Null","Flow","Rhyme","Stars","Sky","Fate","Heat","Frost","Snow","Law","Flame","Flood","Quake","Ice","Mud","Calm","Peace","Zap","Soft","Hard","Home"];

    List<String> verbs = <String>["tap","use","discard","draw","imbibe","create","devour","vore","scatter","shred","place","select","choose","levitate","burn","throw away","place","dominate","humiliate","oggle","auto-parry","be","wear","flip","fondly regard","retrieve","throw","slay","defeat","become","grab","order","steal","smell","sample","taste","caress","fondle","placate","handle","pirouette","entrench","crumple","shatter","drop","farm","sign","pile","smash","resist","sip","understand","contemplate"];
    List<String> nouns =<String> ["card","monster","item","deed","feat","artifact","weapon","armor","shield","ring","mana","deck","creature","sword","legendary artifact","legendary weapon","god","meme","red mile", "ring of orbs no-fold","arm","mechanical bull","mystery","token","shrubery","Blue Lady","gem","egg","coin","talisman"];
    List<String> effects = <String>["ironic","ripe","angsting","shitty","disappointing","amazing","perfect","confused","poisoned","dead","alive", "audited", "insane","unconditionally immortal", "immortal", "on fire","boring","missing","lost","litigated","deceitful","irrelevant","a lost cause","annoying","smelly","chaotic","trembling","afraid","beserk","vomiting","depressed","disappointing","in a fandom","unloved","apathetic","addicted","uncomfortable","boggling", "goddamn mushroom"];


    TradingCard(Doll this.doll, {this.power: -1, this.health: -1, this.mana: -1, this.name:null, this.type:null, this.description:null, this.shittyPoem: null}) {
        rand = new Random();
        randomizeStats();
        tint = new Colour(rand.nextInt(255), rand.nextInt(255),rand.nextInt(255));
        if(name == null) name = randomName();
        if(description == null) description = randomDescription();
        if(shittyPoem == null) shittyPoem = randomPoem();
        nameLayer = new TextLayer("Name",name,35.0,28.0, fontSize: 18);
        typeLayer = new TextLayer("Type",type,35.0,260.0, fontSize: 18);
        statLayer = new TextLayer("Stats",stats,250.0,418.0, fontSize: 18);
        descriptionLayer = new TextLayer("Description",description,46.0,280.0, fontSize: 18, maxWidth: 180);
        shittyPoemLayer = new TextLayer("Flavor Text",shittyPoem,46.0,350.0, emphasis: "italic", fontSize: 16, maxWidth: 180);
        //TODO have text layers know how to render their own form values (in DollMaker, add DollTools to lib)
    }

    String get stats => "${power}/${health}/${mana}";

    void randomizeStats() {
        if(power < 0) power = rand.nextInt(9);
        if(health < 0) health = rand.nextInt(9);
        if(mana < 0) mana = rand.nextInt(9);

    }

    List<TextLayer> get textLayers => <TextLayer>[nameLayer, typeLayer, descriptionLayer,shittyPoemLayer,statLayer];

    String randomDescription() {
        String verb = rand.pickFrom(verbs);
        String noun  = rand.pickFrom(nouns);
        String effect = rand.pickFrom(effects);
        List<String> possibilities = <String>["For every $noun in play, $verb a card.","$verb any number of your ${noun}s. For each $noun you $verb, $verb one from your opponent's deck as well. ","Set the enemy $noun on fire. And your $noun, too. Fuck this game.","$verb the $name, discarding it in order to make the ${noun} ${effect}.","$verb two ${noun}s from your deck. Attach them to the $name.","Pick one enemy ${noun}, $verb it.  Your $name is now ${effect}","Double the ${name}'s power for the next two turns."];
        return toBeginningOfSentenceCase(rand.pickFrom(possibilities));
    }

    String randomPoem() {
        String noun  = rand.pickFrom(nouns);
        String verb  = rand.pickFrom(verbs);
        String effect = rand.pickFrom(effects);
        List<String> possibilities = <String>["'Oh, that this too too solid $noun would melt, thaw and resolve itself into a dew!' -Charles Dutton","The prophecy of $noun foretold the world becoming $effect.","I think I shall never see, something as $effect as a tree.","Is there any human who can resist a truly $effect $noun?","You can almost forget your childhood, when the ${noun}s were not yet $effect.","Is it any wonder the ${noun}s are ever ${effect}?","Everyone knows you should not trust the ${noun}s of the Forest."];
        possibilities.addAll(<String>["Cut to the chase and $verb immediately.","'On with the $noun of bang a dang diggy diggy up jump the $effect.' -Troll Kid Rock","This is exactly why ${noun}s should not be allowed to dual-wield flintlock pistols. ", "When you are extra angry at crime, you should call jail 'the $noun'.", "Today is the day you finally blow up the $noun.", "Punch $noun in the snout to establish $effect dominance. ", "You cannot do it. You cannot make the $noun ${effect}.", "Have you tried falling in a more $effect manner?", "Two roads diverge in a $effect wood."]);
        //"[You/I] got a A full of B, a C full of D, and an E full of F."
        possibilities.add("Everybody outta the way, I got a ${rand.pickFrom(nouns)} full of ${rand.pickFrom(nouns)}, a ${rand.pickFrom(nouns)} full of ${rand.pickFrom(nouns)} and a ${rand.pickFrom(nouns)} full of ${rand.pickFrom(nouns)}. ");
        possibilities.add("I am the $noun. It is me.");
        possibilities.add("When it comes to $verb, I am simple the best there is.");
        possibilities.add("It's sharp and it's $effect and it's a $noun.");
        possibilities.add("It is an immutable fact I am stating, that that $noun is $verb.");
        possibilities.add("It's hard being $effect. It's hard and nobody understands.");
        possibilities.add("$noun is fake as shit. And shit just got real.");
        possibilities.add("This is an absolutely preposterous amount of $noun.");
        possibilities.add("Wear the $noun. Be the  ${rand.pickFrom(nouns)}. ");
        possibilities.add("You cannot hope to beat ${rand.pickFrom(nouns)} in a ${noun} off. They are simply the best there is. ");
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

    Element makeTintSelector() {
        Element ret = new DivElement();
        ret.setInnerHtml("Card Tint: ");
        InputElement colorPicker = new InputElement();
        colorPicker.type = "color";
        colorPicker.value = tint.toStyleString();
        colorPicker.onChange.listen((Event e) {
            tint = new Colour.fromStyleString(colorPicker.value);
            draw();
        });

        ret.append(colorPicker);
        return ret;
    }

    Element makeDollLoader() {
        Element ret = new DivElement();
        ret.setInnerHtml("Doll URL: ");
        TextAreaElement dollArea = new TextAreaElement();
        dollArea.value = doll.toDataBytesX();
        ButtonElement dollButton = new ButtonElement();
        dollButton.setInnerHtml("Load Doll");
        ret.append(dollArea);
        ret.append(dollButton);

        dollButton.onClick.listen((Event e) {
            doll = Doll.loadSpecificDoll(dollArea.value);
            draw();
        });
        return ret;
    }

    Element makeTextLoader() {
        Element ret = new DivElement();
        for(TextLayer tl in textLayers) {
            ret.append(tl.element);
        }
        ButtonElement button = new ButtonElement();
        button.setInnerHtml("Load Text");

        button.onClick.listen((Event e) {
            print("redrawing after loading text.");
            draw();
        });

        ret.append(button);
        return ret;
    }

    Element makeSaveButton() {
        Element ret = new DivElement();
        ret.className = "paddingTop";
        AnchorElement saveButton = new AnchorElement();
        saveButton.href = canvas.toDataUrl();
        saveButton.target = "_blank";
        saveButton.setInnerHtml("Download PNG?");

        ret.append(saveButton);
        return ret;
    }

    //draws a text area for each text element, one for the doll, and a color picker for tint.
    Element makeForm() {
        Element ret = new DivElement();
        ret.className = "cardForm";

        ret.append(makeDollLoader());
        ret.append(makeTintSelector());
        ret.append(makeTextLoader());
        ret.append(makeSaveButton());

        return ret;
    }

    Future<CanvasElement> draw() async
    {

        //redraw on existing canvas if need be.
        if(canvas == null) canvas = new CanvasElement(width: width, height: height);

        CanvasElement monsterElement = await drawMonster(doll);

        CanvasElement cardElement = await drawCardTemplate(tint);

        //Renderer.drawBG(monsterElement, ReferenceColours.RED, ReferenceColours.RED);
        CanvasElement symbolElement = await drawSymbol();

        canvas.context2D.clearRect(0,0,width,height);

        Renderer.drawBGRadialWithWidth(canvas,10,300,600,tint,new Colour(255,255,255));
        canvas.context2D.drawImage(cardElement, 0, 0);
        canvas.context2D.drawImage(monsterElement,34, 34);

        canvas.context2D.drawImage(symbolElement, 185, -83);

        CanvasRenderingContext2D ctx = canvas.context2D;

        for(TextLayer textLayer in textLayers) {
            ctx.fillStyle = textLayer.fillStyle;
            ctx.font = textLayer.font;
            //ctx.fillText(textLayer.text, textLayer.topLeftX, textLayer.topLeftY);
            Renderer.wrap_text(ctx,textLayer.text,textLayer.topLeftX,textLayer.topLeftY,textLayer.fontSize,textLayer.maxWidth,"left");
        }

        return canvas;
    }

    Future<CanvasElement> drawSymbol() async {
        CanvasElement cardElement = new CanvasElement(width: width, height: height);

        for(SpriteLayer layer in doll.layers) {
            if(layer.imgNameBase.contains("Symbol")) {
                await Renderer.drawWhateverFuture(cardElement, "images/element.png");
                await Renderer.drawWhateverFuture(cardElement, layer.imgLocation);
                Renderer.swapPalette(cardElement, doll.paletteSource, doll.palette);
            }
        }
        CanvasElement ret = new CanvasElement(width: width, height: height);

        ret.context2D.scale(0.5, 0.5);
        ret.context2D.drawImage(cardElement,0,0);

        return ret;
    }

    Future<CanvasElement>  drawMonster(Doll doll) async {
        CanvasElement monsterElement = new CanvasElement(width: (256).round(), height: (208).round());
        CanvasElement dollCanvas = new CanvasElement(width: doll.width, height: doll.height);
        await Renderer.drawDoll(dollCanvas, doll);

        dollCanvas = Renderer.cropToVisible(dollCanvas);

        Renderer.drawToFitCentered(monsterElement, dollCanvas);
        return monsterElement;
    }

    Future<CanvasElement> drawCardTemplate(Colour color) async{
        CanvasElement cardElement = new CanvasElement(width: width, height: height);
        await Renderer.drawWhateverFuture(cardElement, "images/blank.png");
        Renderer.swapColors(cardElement, color);
        return cardElement;

    }

}