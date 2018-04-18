# ===================================================================
#
#   Image Choice Box by Archeia
#   Uses ui.Image rather than ui.Selectable for Choice Boxes
#   that require to be moved using "Auto"
#
# ===================================================================

choiceBox = ui.UiFactory.customTypes["ui.ChoiceBox"]
choiceBox.controls[1].params.template.controls = [
    {
        "type": "ui.Image",
        "frame": [0, 0],
        "inheritProperties": true,
        "actions": [
            {"name": "emitEvent", "params": { "name": "selectionAccept", "source": ($ -> o.parent.parent.parent.parent), "data": ($ -> $dataFields.scene.choices[o.parent.index]) }}
        ],
        "image": "Choice_Idle",
        "zIndex": 4999
    },
    {
        "type": "ui.Image",
        "image": "Choice_Active",
        "opacity": 0,
        "blendMode": "normal",
        "frame": [0, 0],
        "zIndex": 4999,
        "formulas": [
            $ -> o.visible = no if !o.parent.ui.enabled
        ],
        "animations": [ 
            {
                "event": "onMouseHover",
                "flow": [
                    { 
                    "type": "blendTo", 
                    "opacity": 255, 
                    "duration": 10, 
                    "easing": "quad_inout", 
                    "wait": true,
                    }
                ]
            },
            {
                "event": "onMouseLeave",
                "clear": false,
                "flow": [
                    { "type": "blendTo", 
                    "opacity": 0, 
                    "duration": 10, 
                    "easing": "quad_inout",
                    }
                ]
            },
        ]
    },
    {
        "type": "ui.Text",
        "inheritProperties": true,
        "formatting": true,
        "wordWrap": false,
        "sizeToFit": true,
        "styles": ["choiceUIText"],
        "alignmentX": 1,
        "alignmentY": 1,
        "frame": [0, 0],
        "formulas": [$ -> o.text = lcs($dataFields.scene.choices[o.parent.index]?.text)],
        "zIndex": 5100
    }
]
