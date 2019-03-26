// ===================================================================
// 
//  Archeia Engine  LEDA -- Change Keys
// 
//  Version 1.0.2 - 3/26/2019
// 
//  Change keyboard input for specific Visual Novel Maker games.
//  This plugin overwrites a lot of input functions.
//
//  ===================================================================
var Imported = Imported || {};
Imported.AEL_KEY = true;

var Archeia = Archeia || {};
Archeia.AEL_KEY = Archeia.AEL_KEY || {};
Archeia.AEL_KEY.version = 1.02;

//=============================================================================
// Parameter Variables
//=============================================================================

// Keys set in this section will proceed the game
Archeia.AEL_KEY.InputOK = Input.KEY_SPACE;
Archeia.AEL_KEY.InputOK_ALT = Input.C;

// This key exists for hiding the messagebox
Archeia.AEL_KEY.inputHIDE = Input.KEY_BACK_SPACE;

//=============================================================================
// Component_GameSceneBehavior
//=============================================================================

// Checks for the shortcut to hide/show the game UI. By default, this is the 
// space-key. You can override this method to change the shortcut.
// ----------------------------------------------------------------------- //
vn.Component_GameSceneBehavior.prototype.updateUIVisibilityShortcut = function() {
    if (!this.uiVisible && (Input.trigger(Archeia.AEL_KEY.InputOK) || Input.trigger(Archeia.AEL_KEY.InputOK_ALT) || Input.Mouse.buttonDown)) {
        this.changeUIVisibility(!this.uiVisible);
    }
    if (Input.trigger(Archeia.AEL_KEY.inputHIDE)) {
        return this.changeUIVisibility(!this.uiVisible);
    }
};

//=============================================================================
// Component_MessageTextRenderer
//=============================================================================
// Adds event-handlers for mouse/touch events
// ----------------------------------------------------------------------- //
gs.Component_MessageTextRenderer.prototype.setupEventHandlers = function() {
    gs.GlobalEventManager.offByOwner("mouseUp", this.object);
    gs.GlobalEventManager.offByOwner("keyUp", this.object);
    gs.GlobalEventManager.on("mouseUp", ((function(_this) {
        return function(e) {
            if (_this.object.findComponentByName("animation") || (GameManager.settings.autoMessage.enabled && !GameManager.settings.autoMessage.stopOnAction)) {
                return;
            }
            if (Input.Mouse.buttons[Input.Mouse.LEFT] !== 2) {
                return;
            }
            if (_this.isWaiting && !(_this.waitCounter > 0 || _this.waitForKey)) {
                e.breakChain = true;
                _this["continue"]();
            } else {
                e.breakChain = _this.isRunning;
                _this.drawImmediately = !_this.waitForKey;
                _this.waitCounter = 0;
                _this.waitForKey = false;
                _this.isWaiting = false;
            }
            if (_this.waitForKey) {
                if (Input.Mouse.buttons[Input.Mouse.LEFT] === 2) {
                    e.breakChain = true;
                    Input.clear();
                    _this.waitForKey = false;
                    return _this.isWaiting = false;
                }
            }
        };
    })(this)), null, this.object);
    return gs.GlobalEventManager.on("keyUp", ((function(_this) {
        return function(e) {
            if ((Input.keys[Archeia.AEL_KEY.inputOK] || Input.keys[Archeia.AEL_KEY.InputOK_ALT]) && (!_this.isWaiting || (_this.waitCounter > 0 || _this.waitForKey))) {
                _this.drawImmediately = !_this.waitForKey;
                _this.waitCounter = 0;
                _this.waitForKey = false;
                _this.isWaiting = false;
            }
            if (_this.isWaiting && !_this.waitForKey && !_this.waitCounter && (Input.keys[Archeia.AEL_KEY.InputOK] || Input.keys[Archeia.AEL_KEY.InputOK_ALT])) {
                _this["continue"]();
            }
            if (_this.waitForKey) {
                if (Input.keys[Archeia.AEL_KEY.InputOK] || Input.keys[Archeia.AEL_KEY.InputOK_ALT]) {
                    Input.clear();
                    _this.waitForKey = false;
                    return _this.isWaiting = false;
                }
            }
        };
    })(this)), null, this.object);
};

//=============================================================================
// Component_MessageBehavior
//=============================================================================
// Checks if a mouse-button or key was pressed to continue with the message-rendering.
// ----------------------------------------------------------------------- //

vn.Component_MessageBehavior.prototype.actionTrigger = function() {
    return (gs.ObjectManager.current.input && this.object.visible && this.object.dstRect.contains(Input.Mouse.x - this.object.origin.x, Input.Mouse.y - this.object.origin.y) && Input.Mouse.buttons[Input.Mouse.LEFT] === 2) || Input.trigger(Archeia.AEL_KEY.InputOK) || Input.trigger(Archeia.AEL_KEY.InputOK_ALT);
};