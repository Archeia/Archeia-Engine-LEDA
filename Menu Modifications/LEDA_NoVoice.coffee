# ===================================================================
#
#   Remove Voice Settings by Archeia
#   What this script does is remove all traces of "Voices" from the 
#   Menu Setting's Audio and Message Menus.
#
#   This modifies Layout_SettingsAudio and Layout_SettingsMessage
#   
# ===================================================================

# Remove Traces of Voice Settings in Layout_SettingsAudio
# ===================================================================
# Delete voiceVolume text
ui.UiFactory.layouts.settingsAudio.controls[3].params.template.controls[1].controls.splice(2, 1)
# ui.Text and StackLayout for Voice Settings
ui.UiFactory.layouts.settingsAudio.controls[3].params.template.controls.splice(2 ,2)

# Remove Traces of Voice Settings in Layout_SettingsMessage
ui.UiFactory.layouts.settingsMessage.controls[3].params.template.controls[0].controls.splice(3, 1)
ui.UiFactory.layouts.settingsMessage.controls[3].params.template.controls[0].controls.splice(4, 1)

# Rearrange options in Menu
ui.UiFactory.layouts.settingsMessage.controls[3].params.template.controls[1].controls[0].controls[1].controls = [
    {
        "type": "ui.StackLayout",
        "sizeToFit": true,
        "controls": [
            { 
                "type": "ui.OptionButton", 
                "params": { 
                    "label": { "lcId": "C138CE3C9564C54707492AA264690B5BBB90", "defaultText": "Videos" }, 
                    "write": $ (v) -> $dataFields.settings.allowVideoSkip = v
                    "read": $ -> $dataFields.settings.allowVideoSkip
                }
            },
            { 
                "type": "ui.OptionButton", 
                "params": { 
                    "label": { "lcId": "469C50C92465724C9F48BD86BB799E781F3C", "defaultText": "Unread" }, 
                    "write": $ (v) -> $dataFields.settings.allowSkipUnreadMessages = v
                    "read": $ -> $dataFields.settings.allowSkipUnreadMessages
                } 
            }
        ]
    },
]

# Remove Unread from Skip Option second row to avoid duplication
ui.UiFactory.layouts.settingsMessage.controls[3].params.template.controls[1].controls[0].controls[2].controls.splice(0,1)

