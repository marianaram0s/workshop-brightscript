sub init()
    m.loadingIndicator = m.top.findNode("loadingIndicator")
    initScreenStack()
    showGridScreen()
    runContentTask()
end sub