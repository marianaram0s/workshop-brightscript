function init()
    setObservers()
    findNodesByXML()
    setButtonsOptions()
end function

sub findNodesByXML()
    m.buttons = m.top.FindNode("buttons")
    m.poster = m.top.FindNode("poster") 
    m.description = m.top.FindNode("descriptionLabel")
    m.timeLabel = m.top.FindNode("timeLabel")
    m.titleLabel = m.top.FindNode("titleLabel")
    m.releaseLabel = m.top.FindNode("releaseLabel")
end sub

sub setButtonsOptions()
    optionsList = []
    for each button in getDetailsScreenButtonOptions()
        optionsList.Push({title : button})
    end for
    
    m.buttons.content = convertContentListToSimpleNode(optionsList)
end sub

sub setObservers()
    m.top.ObserveField("visible", "OnVisibleChange")
    m.top.ObserveField("itemFocused", "OnItemFocusedChanged")
end sub

sub onVisibleChange()
    if m.top.visible = true
        m.buttons.SetFocus(true)
        m.top.itemFocused = m.top.jumpToItem
    end if
end sub

sub setDetailsContent(content as Object)
    m.description.text = content.description 
    m.poster.uri = content.hdPosterUrl 
    m.timeLabel.text = GetTime(content.length)
    m.titleLabel.text = content.title
    m.releaseLabel.text = content.releaseDate
end sub

sub onJumpToItem()
    content = m.top.content
    if isValid(content) and m.top.jumpToItem >= 0 and content.GetChildCount() > m.top.jumpToItem
        m.top.itemFocused = m.top.jumpToItem
    end if
end sub

sub onItemFocusedChanged(event as Object)
    focusedItem = event.GetData() 
    content = m.top.content.GetChild(focusedItem)
    SetDetailsContent(content) 
end sub

function onkeyEvent(key as String, press as Boolean) as Boolean
    result = false
    if press
        currentItem = m.top.itemFocused
        if key = "left"
            m.top.jumpToItem = currentItem - 1 
            result = true
        else if key = "right" 
            m.top.jumpToItem = currentItem + 1 
            result = true
        end if
    end if
    return result
end function