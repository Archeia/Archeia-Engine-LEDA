# ===================================================================
#
#   Custom Message Box by Archeia
#   Modifies the Message Box default to fit the Vertical Screen 
#   Sample. It also adds the following new feature(s):
#
#   - Change Message Box Graphic if there is no character speaking.
#   The character's name must be blank for this to trigger.
#
# ===================================================================

ui.UiFactory.customTypes["ui.MessageBox"] = {
    "type": "ui.FreeLayout",
    "controls": [
        {
            # --------------------------------------------------------                
            # This code displays an image for the message box
            # --------------------------------------------------------
            "type": "ui.Image",
            # --------------------------------------------------------                
            # Filename of the message box graphic.
            # --------------------------------------------------------    
            "image": "UI_MSGBox_WithName",
            "zIndex": 5000,
            "updateBehavior": "continuous",
            "formulas": [
            # --------------------------------------------------------                
            # Filename of the message box graphic when no name
            # --------------------------------------------------------  
                ($ -> 
                    if !$dataFields.scene.currentCharacter? or !$dataFields.scene.currentCharacter.name? or lcs($dataFields.scene.currentCharacter.name) == ""
                        o.image = "UI_MSGBox")
            # --------------------------------------------------------                
            # Filename of the message box graphic when there is a name
            # --------------------------------------------------------  
                ($ -> 
                    if $dataFields.scene.currentCharacter? and $dataFields.scene.currentCharacter.name? and lcs($dataFields.scene.currentCharacter.name) != ""
                        o.image = "UI_MSGBox_WithName")
            ]
            # --------------------------------------------------------    
            # Affects the positioning of the message box.
            # X, Y, Width
            # --------------------------------------------------------    
            "frame": [0, 740, 520]
            "zIndex": 5000
        },
            # --------------------------------------------------------            
            # This code displays the current character's name
            # --------------------------------------------------------
        {
            "type": "ui.Text",
            "updateBehavior": "continuous",
            "text": "",
            "style": "messageBoxNameText",  
            "formulas": [
                $ -> o.text = $dataFields.scene.currentCharacter.name
                $ -> if @onTextChange $dataFields.scene.currentCharacter.name then o.font.color.setFromObject $dataFields.scene.currentCharacter.textColor or Color.WHITE
            ],
            "zIndex": 5005,
            "sizeToFit": true,
            # --------------------------------------------------------    
            # Affects the positioning of the Name display.
            # X, Y, Width, Height
            # --------------------------------------------------------   
            "frame": [21, "100% - 212", 128, 30]
        },
            # --------------------------------------------------------        
            # Call Message Box Options Menu
            # --------------------------------------------------------    
            {
                "type": "ui.VSMsgMenuLayout",
                "params": { "messageBox": ($ -> $messageBox) },
                "order": 81000,
                "frame": [66, 936, 397, 16]
            },
            # --------------------------------------------------------    
            # This code displays the message box options
            # --------------------------------------------------------
            # {
            #     "type": "ui.MessageBoxMenu",
            #     "params": { "messageBox": ($ -> $messageBox) },
            #     "order": 81000,
            #     "frame": [0, 0]
            # }
    ]        
}  # End of Message Box Customization

# ===================================================================
#
#   Modify Message Display for ADV and Create Custom Message Area
#
# ===================================================================

ui.UiFactory.customTypes["ui.GameMessage"] = {
    "type": "ui.FreeLayout",
    "sizeToFit": true,
    "controls": [
        {
            # --------------------------------------------------------   
            # This code displays the message
            # --------------------------------------------------------
            "type": "ui.Message",
            "zIndex": 10000,
            "id": -> p.id + "_message",
            # --------------------------------------------------------   
            # Affects the positioning of the Message
            # X, Y, Width, Height
            # --------------------------------------------------------   
            "frame": [-290, 60, 480, 110],
            "style": "advMessageText"
        },
        {
            # -------------------------------------------------------
            # This code displays the message indicator (message caret by default)
            # --------------------------------------------------------
            "type": "ui.Image",
            "formulas": [
                # -------------------------------------------------------
                # Affects the positioning of the message indicator
                # -------------------------------------------------------
                $ -> o.dstRect.x = o.parent.controls[0].message.caretPosition.x - 300
                $ -> o.dstRect.y = o.parent.controls[0].message.caretPosition.y + 40
                $ -> o.visible = o.parent.controls[0].visible and (o.parent.controls[0].message.isRunning or o.parent.controls[0].message.isWaiting)
            ],
            "animations": [
                {
                    "event": "onAlways",
                    "flow": [
                        { "type": "playAnimation", "repeat": false, "animationId": 0 }
                    ]
                }
            ],
            # -------------------------------------------------------
            # This code chages the image used for indicator.
            # -------------------------------------------------------
            "image": "message_caret",
            "zIndex": 10000,
            "frame": [0, 0]
        }
    ]
} # End ADV Message Display

ui.UiFactory.customTypes["ui.CustomGameMessage"] = {
    "type": "ui.FreeLayout",
    "controls": [
        {
            "type": "ui.Message",
            "zIndex": 10000,
            "id": -> p.id + "_message",
            "style": "customMessageText",
            "frame": [0, 0, "100%", "100%"]
        },
        {
            "type": "ui.Image",
            "formulas": [
                $ -> o.dstRect.x = o.parent.controls[0].message.caretPosition.x
                $ -> o.dstRect.y = o.parent.controls[0].message.caretPosition.y - 20
                $ -> o.visible = o.parent.controls[0].visible and (o.parent.controls[0].message.isRunning or o.parent.controls[0].message.isWaiting)
            ],
            "animations": [
                {
                    "event": "onAlways",
                    "flow": [
                        { "type": "playAnimation", "repeat": false, "animationId": "40133382KC7B4A4C97S81F0E7D539A513261" }
                    ]
                }
            ],
            "image": "message_caret",
            "zIndex": 10000,
            "frame": [0, 0, 0, 0]
        }
    ]
} # End Custom Message Display


# ===================================================================
#
#   NVL Mode Options
#   Currently untouched.
#
# ===================================================================

ui.UiFactory.customTypes["ui.GameMessageNVL"] = {
    "type": "ui.FreeLayout",
    "sizeToFit": true,
    "controls": [
        {
            "type": "ui.Message",
            "zIndex": 10000,
            "id": -> p.id + "_message",
            "style": "nvlMessageText",
            "frame": [Graphics.width / 100 * 12.5 + 8, 8, Graphics.width / 100 * 75 - 16, Graphics.height - 16]
        }
    ]
}

ui.UiFactory.customTypes["ui.MessageBoxNVL"] = {
    "type": "ui.FreeLayout",
    "sizeToFit": true,
    "controls": [
        {
            "type": "ui.MessageBoxMenu",
            "params": { "messageBox": ($ -> $nvlMessageBox) },
            "order": 81000,
            "frame": [0, Graphics.height - 270]
        },
        {
            "type": "ui.Window",
            "params": { "backgroundOpacity": 128
            },
            "frame": [Graphics.width / 100 * 12.5, 0, Graphics.width / 100 * 75, Graphics.height]
            "zIndex": 4999
        }
    ]
}

# ===================================================================
#
#   Menu Only Option
#   Currently untouched.
#
# ===================================================================

ui.UiFactory.customTypes["ui.MessageMenu"] = {
    "type": "ui.FreeLayout",
    "sizeToFit": true,
    "controls": [
        {
            "type": "ui.MessageBoxMenu",
            "params": { "messageBox": ($ -> $messageMenu) },
            "order": 81000,
            "frame": [0, Graphics.height - 270]
        }
    ]
}


