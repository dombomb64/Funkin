package funkin.graphics;

import flixel.animation.FlxAnimationController;
import funkin.graphics.FunkinSprite;

class FunkinAnimationController extends FlxAnimationController
{
  public function new(sprite:FunkinSprite)
  {
    super(sprite);

    onFinish.add(onAnimationFinished);
  }

  public function onAnimationFinished(animationName:String):Void
  {
    var currentAnimation:String = name;
    if (currentAnimation == null) return;

    // Strip "-hold" from the end.
    if (currentAnimation.endsWith(Constants.ANIMATION_HOLD_SUFFIX)) currentAnimation = currentAnimation.substring(0,
      currentAnimation.length - Constants.ANIMATION_HOLD_SUFFIX.length);

    var endAnimation:String = currentAnimation + Constants.ANIMATION_END_SUFFIX;
    if (hasAnimation(endAnimation))
    {
      // Play the '-end' animation, if one exists.
      // trace('${characterId}: playing ${endAnimation}');
      play(endAnimation);
    }
    else
    {
      // Play the expected animation.
      // dance(true);
    }
  }

  public function hasAnimation(id:String):Bool
  {
    return getByName(id) != null;
  }
}
