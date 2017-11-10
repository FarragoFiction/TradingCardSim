import "../../scripts/DollLib/DollRenderer.dart";
class Fraymotif {
    static List<String> fraymotifTypes = <String>["blood","mind","rage","void","time","heart","breath","light","space","hope","life","doom"];
    static List<String> musicsChoices = <String>["Hymn_of_Lost_Hope_Segment.ogg","Lucky_Flare_Cadence_Segment.ogg","Noirsong_Segment.ogg","PARAN01A_Segment.ogg","Supernova_Stretto_Segment.ogg","Tempo_Transference_Segment.ogg","Veloce_Clockwork_Segment.ogg"];


    String _imgFolder = "../images/Homestuck/Fraymotifs";
    String imgName;
    String _musicFolder = "../music/";
    String musicalThemeName;

    Fraymotif(this.imgName, this.musicalThemeName);

    String get imageLocation {
        return "${_imgFolder}${imgName}.png";
    }

    String get musicLocation {
        return "${_musicFolder}${musicalThemeName}.png";
    }
}


/*
TODO:   All fraymotifs do damage every frame (instead of just at end).

A fraymotif can do multiple things to itself each frame. Spin, bounce around on screen. Flip, etc.

If the enemy is NOT defending, whatever happens to the fraymotif happens to the enemy as well.

Some fraymotifs will suck the enemy to their location, others will go to the enemies location. Whatever.
 */
class FraymotifEffect {

}