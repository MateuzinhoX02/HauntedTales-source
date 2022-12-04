// Eu só escrevi isso pra esse mod K
import sys.net.Address;
import LoadingState;
import flixel.*;
import openfl.utils.Assets as OpenFlAssets;
import flixel.math.FlxMath;

using StringTools;

//Caching falso (por enquanto)
class Caching extends MusicBeatState 
{
    var spr:FlxSprite; // Foto dos personagens do desenho
    var tip:String = (FlxG.random.bool(20) ?
	"Texto sus" :
	"Amogus"); // Coloquem certas frases aqui.
    var txtDisp:FlxText; // Uma display
    var txtBackg:FlxSprite;

override public function create() {
        
    #if desktop
    DiscordClient.changePresence("Loading...", null);
    #end

    spr = new FlxSprite().loadGraphic(Paths.image("loads"));
    spr.screenCenter();

    txtBackg.makeGraphic(1, 1, 0xFF000000);
    txtBackg.updateHitbox();
    txtBackg.origin.set();
    txtBackg.scale.set(1280, txtDisp.height + 5);
    txtBackg.alpha = 0.8;
    txtBackg.y = txtDisp.y;

    txtDisp = new FlxText(40, 40, 1180, tip, 32);
	txtDisp.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER);
	txtDisp.setBorderStyle(OUTLINE, FlxColor.BLACK, 1.5);
	txtDisp.scrollFactor.set();
	txtDisp.antialiasing = true;


    add(spr);
    add(txtBackg);
	add(txtDisp);

    new FlxTimer().start(1, function(tmr:FlxTimer)
	{
		txtDisp.text("Done!");
		end();
	});

    super.create();
    }

    function end()
        {
            FlxG.camera.fade(FlxColor.BLACK, 1, false);
    
            new FlxTimer().start(1, function(tmr:FlxTimer)
            {
                FlxG.switchState(new TitleState());
            });
        }
}
       
