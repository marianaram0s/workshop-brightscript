sub initScreenStack()
    m.screenStack = []
end sub

sub showScreen(node as Object)
    currentScreen = m.screenStack.Peek()
    if isValid(currentScreen) then currentScreen.visible = false
    
    m.top.AppendChild(node)
    node.visible = true
    node.SetFocus(true)
    m.screenStack.Push(node)
end sub

sub closeScreen(node as Object)
    if isValid(node) OR (isValid(m.screenStack.Peek() AND m.screenStack.Peek().IsSameNode(node)))
        currentScreen = m.screenStack.Pop()
        currentScreen.visible = false
        m.top.RemoveChild(node)

        previousScreen = m.screenStack.Peek()
        if isValid(previousScreen)
            previousScreen.visible = true
            previousScreen.SetFocus(true)
        end if
    end if
end sub

function getScreenStack()
    return m.screenStack
end function