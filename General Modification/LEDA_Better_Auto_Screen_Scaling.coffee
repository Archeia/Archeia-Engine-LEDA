# ===================================================================
#
#   Yami and Archeia Engine -- LEDA -- Better Auto Screen Scaling
#   Fixes the issue with VNM not scaling properly.
#   
# ===================================================================

stockHeight = [1080, 960, 720, 640, 576, 480, 360, 240]

resizeScreen = () ->
    gameResolution = 
        width: $PARAMS.resolution.width
        height: $PARAMS.resolution.height
    screenResolution = 
        width: window.screen.availWidth
        height: window.screen.availHeight
    if $PARAMS.preview or GameManager.inLivePreview then return
    if !nw? then return
    isFullscreen = nw.Window.get().isFullscreen
    ratio = gameResolution.width / gameResolution.height
    
    if isFullscreen then return
    for height in stockHeight
        if gameResolution.height < height then continue
        if screenResolution.height < height then continue
        width = height * ratio
        if screenResolution.width < width then continue
        diff = 
            width: window.innerWidth - width
            height: window.innerHeight - height
        window.resizeBy(-diff.width, -diff.height)
        return
    
gs.YEM = {} if !gs.YEM?
gs.YEM.resizeScreen = resizeScreen
gs.YEM.resizeScreen()