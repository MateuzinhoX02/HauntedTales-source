package;

import haxe.Exception;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import sys.FileSystem;
import sys.io.File;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.text.FlxText;

using StringTools;

class Caching extends MusicBeatState
{
    var toBeDone = 0;
    var done = 0;

    var loadTxt:FlxText;
    var spr:FlxSprite;
    var loadTxtBg:FlxSprite;

	override function create()
	{
        FlxG.mouse.visible = false;

        FlxG.worldBounds.set(0,0);

        loadTxtBg = new FlxSprite();
		add(loadTxtBg);

        loadTxt = new FlxText(0, 0, 0, "Loading...", 30);
		loadTxt.setFormat("LEMON MILK Bold", 24, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		loadTxt.x = 5;
		loadTxt.y = FlxG.height - loadTxt.height - 5;

        spr = new FlxSprite().loadGraphic(Paths.image("loads"));
        spr.screenCenter();


        loadTxtBg.makeGraphic(1, 1, 0xFF000000);
		loadTxtBg.updateHitbox();
		loadTxtBg.origin.set();
		loadTxtBg.scale.set(1280, loadTxt.height + 5);
		loadTxtBg.alpha = 0.8;
		loadTxtBg.y = loadTxt.y;

        add(spr);
        add(loadTxtBg);
        add(loadTxt);

        sys.thread.Thread.create(() -> {
            cache();
        });


        super.create();
    }

    var calledDone = false;

    override function update(elapsed) 
    {

        if (toBeDone != 0 && done != toBeDone)
        {
            loadTxt.text = "Loading... (" + done + "/" + toBeDone + ")";
        }

        super.update(elapsed);
    }


    function cache()
    {

        var images = [];
        var music = [];

        trace("caching images...");

        for (i in FileSystem.readDirectory(FileSystem.absolutePath("assets/shared/images/characters")))
        {
            if (!i.endsWith(".png"))
                continue;
            images.push(i);
        }

        for (i in FileSystem.readDirectory(FileSystem.absolutePath("assets/shared/images/kack")))
            {
                if (!i.endsWith(".png"))
                    continue;
                images.push(i);
            }
        for (i in FileSystem.readDirectory(FileSystem.absolutePath("assets/shared/images/kack")))
            {
                if (!i.endsWith(".xml"))
                    continue;
                images.push(i);
            }

        trace("caching music...");

        for (i in FileSystem.readDirectory(FileSystem.absolutePath("assets/songs")))
        {
            music.push(i);
        }

        toBeDone = Lambda.count(images) + Lambda.count(music);

        trace("LOADING: " + toBeDone + " OBJECTS.");

        for (i in images)
        {
            var replaced = i.replace(".png","");
            FlxG.bitmap.add(Paths.image("characters/" + replaced,"shared"));
            trace("cached " + replaced);
            done++;
        }

        for (i in images)
            {
                var replaced = i.replace(".png","");
                FlxG.bitmap.add(Paths.image("kack/" + replaced,"shared"));
                trace("cached " + replaced);
                done++;
            }
         for (i in images)
            {
                var replaced = i.replace(".xml","");
                FlxG.bitmap.add(Paths.image("kack/" + replaced,"shared"));
                trace("cached " + replaced);
                done++;
            }

        for (i in music)
        {
            FlxG.sound.cache(Paths.inst(i));
            FlxG.sound.cache(Paths.voices(i));
            trace("cached " + i);
            done++;
        }

        trace("Finished caching...");

        FlxG.switchState(new TitleState());
    }

}