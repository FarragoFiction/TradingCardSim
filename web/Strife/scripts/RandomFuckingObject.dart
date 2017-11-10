import "../../scripts/DollLib/DollRenderer.dart";
import 'dart:async';
import 'dart:html';
class RandomFuckingObject {

    CanvasElement canvas;
    static int maxItemNumber = 40;//40
    String _imgFolder = "images/Homestuck/Fraymotifs";

    int imgNumber;
    //changes as the fraymotif goes on.
    int _x = 0;
    int _y = 0;
    //where are you in this random fucking grid? shouldn't change
    int offsetX = 0;
    int offsetY = 0;
    double _scaleX = 1.0;
    double _scaleY = 1.0;
    double rotation = 0.0;

    RandomFuckingObject(this.imgNumber, this.offsetX, this.offsetY);

    int get x => _x + offsetX;
    int get y => _y + offsetY;

    void set x(int xval) {
        _x = xval;
    }

    void set y(int yval) {
        _y = yval;
    }

    String get imageLocation {
        return "${_imgFolder}/${imgNumber}.png";
    }

    void setScale(double x, double y) {
        _scaleX = x;
        _scaleY = y;
    }

    Future<CanvasElement> draw(int w, int h) async {
        if(canvas == null) {
            ImageElement image = await Loader.getResource((imageLocation));
            canvas = new CanvasElement(width: image.width, height: image.height);
            canvas.context2D.drawImage(image, 0, 0);
        }
        return drawForReal(canvas,w,h);
    }


    //TODO: have all sorts of random shit that can be drawn here.
    //keep array of images that could be drawn in random spots.
    //they have same rotation and etc as fraymotif, and are drawn relative to it, so crazy shit is happenign even without it.
    //save their canvas here too.
    //wizards and grist and generic objects and shit.
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