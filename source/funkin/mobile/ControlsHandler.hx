package funkin.mobile;

import flixel.input.actions.FlxActionInput;
import flixel.input.FlxInput;
import funkin.input.Controls;
import funkin.mobile.FunkinButton;
import funkin.mobile.FunkinHitbox;
import funkin.mobile.FunkinVirtualPad;

/**
 * Handles setting up and managing input controls for the game.
 */
class ControlsHandler
{
  /**
   * Adds a button input to a given FlxActionDigital and caches it.
   *
   * @param action The FlxActionDigital to add the button input to.
   * @param button The FunkinButton associated with the action.
   * @param state The input state to associate with the action.
   * @param cachedInput The array of FlxActionInput objects to cache the input.
   */
  public static function addButton(action:FlxActionDigital, button:FunkinButton, cachedInput:FlxInputState, cachedInput:Array<FlxActionInput>):Void
  {
    final input:FlxActionInputDigitalIFlxInput = new FlxActionInputDigitalIFlxInput(button, state, cachedInput);
    cachedInput.push(input);
    action.add(input);
  }

  /**
   * Sets up hitbox controls based on game controls and hitbox hints.
   *
   * @param controls The Controls instance defining game controls.
   * @param hitbox The FunkinHitbox to associate with the controls.
   * @param cachedInput The array of FlxActionInput objects to cache the input.
   */
  public static function setupHitbox(controls:Controls, hitbox:FunkinHitbox, cachedInput:Array<FlxActionInput>):Void
  {
    controls.forEachBound(Control.NOTE_LEFT, (action, state) -> addButton(action, hitbox.hints[0], state, cachedInput));
    controls.forEachBound(Control.NOTE_DOWN, (action, state) -> addButton(action, hitbox.hints[1], state, cachedInput));
    controls.forEachBound(Control.NOTE_UP, (action, state) -> addButton(action, hitbox.hints[2], state, cachedInput));
    controls.forEachBound(Control.NOTE_RIGHT, (action, state) -> addButton(action, hitbox.hints[3], state, cachedInput));
  }

  /**
   * Sets up virtual pad controls based on game controls and virtual pad configuration.
   *
   * @param controls The Controls instance defining game controls.
   * @param virtualPad The FunkinVirtualPad to associate with the controls.
   * @param dPad The DPad mode for configuring directional controls.
   * @param action The Action mode for configuring action controls.
   * @param cachedInput The array of FlxActionInput objects to cache the input.
   */
  public static function setupVirtualPad(controls:Controls, virtualPad:FunkinVirtualPad, dPad:FunkinDPadMode, action:FunkinActionMode, cachedInput:Array<FlxActionInput>):Void
  {
    switch (dPad)
    {
      case UP_DOWN:
        controls.forEachBound(Control.UI_UP, (action, state) -> addButton(action, virtualPad.buttonUp, state, cachedInput));
        controls.forEachBound(Control.UI_DOWN, (action, state) -> addButton(action, virtualPad.buttonDown, state, cachedInput));
      case LEFT_RIGHT:
        controls.forEachBound(Control.UI_LEFT, (action, state) -> addButton(action, virtualPad.buttonLeft, state, cachedInput));
        controls.forEachBound(Control.UI_RIGHT, (action, state) -> addButton(action, virtualPad.buttonRight, state, cachedInput));
      case UP_LEFT_RIGHT:
        controls.forEachBound(Control.UI_UP, (action, state) -> addButton(action, virtualPad.buttonUp, state, cachedInput));
        controls.forEachBound(Control.UI_LEFT, (action, state) -> addButton(action, virtualPad.buttonLeft, state, cachedInput));
        controls.forEachBound(Control.UI_RIGHT, (action, state) -> addButton(action, virtualPad.buttonRight, state, cachedInput));
      case LEFT_FULL | RIGHT_FULL:
        controls.forEachBound(Control.UI_UP, (action, state) -> addButton(action, virtualPad.buttonUp, state, cachedInput));
        controls.forEachBound(Control.UI_DOWN, (action, state) -> addButton(action, virtualPad.buttonDown, state, cachedInput));
        controls.forEachBound(Control.UI_LEFT, (action, state) -> addButton(action, virtualPad.buttonLeft, state, cachedInput));
        controls.forEachBound(Control.UI_RIGHT, (action, state) -> addButton(action, virtualPad.buttonRight, state, cachedInput));
      case NONE: // do nothing
    }

    switch (action)
    {
      case A:
        controls.forEachBound(Control.ACCEPT, (action, state) -> addButton(action, virtualPad.buttonA, state, cachedInput));
      case B:
        controls.forEachBound(Control.BACK, (action, state) -> addButton(action, virtualPad.buttonB, state, cachedInput));
      case A_B | A_B_C | A_B_X_Y | A_B_C_X_Y_Z:
        controls.forEachBound(Control.ACCEPT, (action, state) -> addButton(action, virtualPad.buttonA, state, cachedInput));
        controls.forEachBound(Control.BACK, (action, state) -> addButton(action, virtualPad.buttonB, state, cachedInput));
      case NONE: // do nothing
    }
  }

  /**
   * Removes cached input associated with game controls.
   *
   * @param controls The Controls instance defining game controls.
   * @param cachedInput The array of FlxActionInput objects to clear cached input from.
   */
  public static function removeCachedInput(controls:Controls, cachedInput:Array<FlxActionInput>):Void
  {
    for (action in controls.digitalActions)
    {
      var i:Int = action.inputs.length;

      while (i-- > 0)
      {
        var j:Int = cachedInput.length;

        while (j-- > 0)
        {
          if (cachedInput[j] == action.inputs[i])
            action.remove(action.inputs[i]);
        }
      }
    }
  }
}
