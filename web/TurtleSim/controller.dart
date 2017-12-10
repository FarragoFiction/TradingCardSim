
import "package:DollLibCorrect/DollRenderer.dart";
import 'dart:async';

import 'dart:html';

Element div = querySelector("#contents");
Random rand = new Random();
int fucks = 1;
ButtonElement machineThatSaysFuck;

void main() {
    drawDolls();
}

Future<bool> drawDolls() async {
    await drawDoll();
}


Doll makeDoll()  {
    ConsortDoll d =  new ConsortDoll();
    d.body.imgNumber = 2;
    return d;
}



Future<bool>  drawDoll() async{
    Element innerDiv   = new DivElement();
    Doll doll = makeDoll();
    CanvasElement finishedProduct = new CanvasElement(width: doll.width, height: doll.height);
    innerDiv.className = "cardWithForm";
    await Renderer.drawDoll(finishedProduct, doll);
    finishedProduct.className = "cardCanvas";
    innerDiv.append(finishedProduct);
    div.append(innerDiv);
    finishedProduct.onClick.listen((e) => fuck());
    machineThatSaysFuck = new ButtonElement();
    machineThatSaysFuck.setInnerHtml("Buy a Machine that Says Fuck For you?");
    machineThatSaysFuck.onClick.listen((e) => autoFuckerSayerThing());
}

void autoFuckerSayerThing() {
    fuck();
    new Timer(new Duration(milliseconds: 1000), () => autoFuckerSayerThing());
}

void fuck() {
    //TODO random css applies to it (size, color, etc)
    List<String> fuckList = <String>["fuck","FUCK","fUcK","FuCk","fUCK","Fuck"];
    List<String> fontList = <String>["Times New Roman","Lucida Console","Courier New","Verdana","Arial","Strife","Georgia","Comic Sans MS","Impact","Trebuchet MS","Tahoma","Lucida Sans Unicode"];


    SpanElement text = new SpanElement();
    text.setInnerHtml(" ${rand.pickFrom(fuckList)}");
    text.style.color = new Colour(rand.nextInt(255), rand.nextInt(255),rand.nextInt(255)).toStyleString();
    text.style.fontSize = "${rand.nextInt(72)+10}px";
    text.style.fontFamily = "${rand.pickFrom(fontList)}";
    if(rand.nextDouble() > .6) text.style.fontStyle = "italic";
    div.append(text);
    fucks ++;
    if(fucks==10) {
        div.append(machineThatSaysFuck);
        querySelector('body').style.backgroundImage =  "url(../images/Memes/autoFucker.jpg)"; //.style.backgroundColor
        div.style.backgroundColor = "white";

    }
}
