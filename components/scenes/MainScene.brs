sub init()
    m.loadingIndicator = m.top.findNode("loadingIndicator")
    initScreenStack()
    showGridScreen()
    runContentTask()
end sub

function OnkeyEvent(key as String, press as Boolean) as Boolean
    result = false
    if press
        if key = "back"
            numberOfScreens = m.screenStack.Count()
            if numberOfScreens > 1
                CloseScreen(invalid)
                result = true
            end if
        end if
    end if
    return result
end function