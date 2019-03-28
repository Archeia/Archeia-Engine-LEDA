ui.UiFactory.customTypes["ui.VSMsgMenuLayout"] = {
    "type": "ui.FreeLayout",
    "controls": [
        {
            "type": "ui.ImageMap"
            "images": [{ "name": "UI_Options_Inactive.png", "folderPath": "Graphics/Pictures/ArcheiaUI" }, 
                       { "name": "UI_Options_Active.png", "folderPath": "Graphics/Pictures/ArcheiaUI" }, 
                       { "name": "UI_Options_Inactive.png", "folderPath": "Graphics/Pictures/ArcheiaUI" },
                       { "name": "UI_Options_Active.png", "folderPath": "Graphics/Pictures/ArcheiaUI" }]
            "updateBehavior": "continuous"
            "hotspots": [
                #-----------------------------------------------------------                      
                # Skip Hotspot
                #-----------------------------------------------------------                
                {
                    "rect": [0, 0, 60, 22]
                    "actions" : [{
                        "name": "executeFormulas", 
                        "params": [
                            $ -> $dataFields.tempSettings.skip = !$dataFields.tempSettings.skip
                            $ -> o.ui.selected = $dataFields.settings.allowSkip.enabled
                        ]
                    }]
                },

                #-----------------------------------------------------------                      
                # Log Hotspot
                #-----------------------------------------------------------                
                {
                    "rect": [77, 0, 57, 22]
                    "actions" : [
                        {
                           "name": "createControl", 
                           "params": { 
                               "descriptor": "ui.MessageBacklogBox"
                            }
                         },
                        {
                            "name": "executeFormulas", 
                            "params": [
                                $ -> $dataFields.tempSettings.logOpened = !$dataFields.tempSettings.logOpened
                                # $ -> o.ui.selected = $dataFields.tempSettings.logOpened
                            ]
                        },
                    ]
                },

                #-----------------------------------------------------------
                # Save Hotspot
                #-----------------------------------------------------------
                {
                    "rect": [153, 0, 65, 22]
                    "zIndex": 39000
                    "id": "saveButton",
                    "actions": [
                        {
                            "name": "executeFormulas",
                            "params":[
                                $ -> o.ui.enabled = $dataFields.tempSettings.saveMenuAccess
                            ]
                        },
                        {
                            "name": "prepareSaveGame",
                            "params": { "snapshot": true },
                        },
                        {
                            "name": "switchLayout" ,
                            "params": {
                                "name": "saveMenuLayout",
                                "savePrevious": true,
                                "snapshot": true
                        }
                    }]
                },
                #-----------------------------------------------------------      
                # Load Hotspot
                #-----------------------------------------------------------                
                {
                    "rect": [238, 0, 69, 22]
                    "actions": [{
                        "name": "switchLayout" ,
                        "params": {
                            "name": "loadMenuLayout",
                            "savePrevious": true,
                            "snapshot": true
                        }
                    }]
                },

                #-----------------------------------------------------------   
                # Title Hotspot
                #-----------------------------------------------------------                
                {
                    "rect": [326, 0, 74, 22]
                    "actions": [{
                        "name": "switchLayout",
                        "params": {
                            "name": "titleLayout"
                        }
                    }]
                },
            ]
            #-----------------------------------------------------------   
            # This ensures that when you press Skip or log the option
            # remains in selected graphic.
            #-----------------------------------------------------------   
            "formulas": [
              $ ->
                  o.visual.hotspots[0].selected = $dataFields.tempSettings.skip
                #   o.visual.hotspots[1].selected = $dataFields.tempSettings.logOpened
          ]
            #-----------------------------------------------------------   
            # Imagemap Z-Index is doubled hence the smaller number.
            #-----------------------------------------------------------    
            "zIndex": 39000
        }, # End Image Map

        
    ] # End FreeLayout
    
} #End MessageBoxMenu
