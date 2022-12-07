// Eu só escrevi isso pra esse mod K
import sys.net.Address;
import LoadingState;
import openfl.utils.Assets as OpenFlAssets;
import flixel.math.FlxMath;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
#if desktop
import Discord.DiscordClient;
#end

//Caching falso (por enquanto)
class Caching extends MusicBeatState 
{
    var spr:FlxSprite; // Foto dos personagens do desenho
    var tip:String = (FlxG.random.bool(20) ?
	"Texto sus" :
	"Amogus"); // Coloquem certas frases aqui.
    var txtDisp:FlxText; // Uma display


override public function create() {
        
    #if desktop
    DiscordClient.changePresence("Loading...", null);
    #end

    spr = new FlxSprite().loadGraphic(Paths.image("loads"));
    spr.screenCenter();

    txtDisp = new FlxText(40, 40, 1180, tip, 32);
	txtDisp.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER);
	txtDisp.setBorderStyle(OUTLINE, FlxColor.BLACK, 1.5);
	txtDisp.scrollFactor.set();
	txtDisp.antialiasing = true;


    add(spr);
	add(txtDisp);

    new FlxTimer().start(1, function(tmr:FlxTimer)
	{
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
       
