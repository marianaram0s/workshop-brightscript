function init()
    m.top.ObserveField("visible", "onVisibleChange")
    m.top.ObserveField("itemFocused", "onItemFocusedChanged")
    m.buttons = m.top.FindNode("buttons")
    m.poster = m.top.FindNode("poster") 
    m.description = m.top.FindNode("descriptionLabel")
    m.timeLabel = m.top.FindNode("timeLabel")
    m.titleLabel = m.top.FindNode("titleLabel")
    m.releaseLabel = m.top.FindNode("releaseLabel")
    
    result = []
    for each button in ["Play"]
        result.Push({title : button})
    end for
    m.buttons.content = ContentListToSimpleNode(result)
end function

sub onVisibleChange()
    if m.top.visible = true
        m.buttons.SetFocus(true)
        m.top.itemFocused = m.top.jumpToItem
    end if
end sub

sub SetDetailsContent(content as Object)
    m.description.text = content.description 
    m.poster.uri = content.hdPosterUrl
    m.timeLabel.text = GetTime(content.length)
    m.titleLabel.text = content.title
    m.releaseLabel.text = content.releaseDate
end sub

sub OnJumpToItem()
    content = m.top.content
    if content <> invalid and m.top.jumpToItem >= 0 and content.GetChildCount() > m.top.jumpToItem
        m.top.itemFocused = m.top.jumpToItem
    end if
end sub

sub OnItemFocusedChanged(event as Object)
    focusedItem = event.GetData()
    content = m.top.content.GetChild(focusedItem)
    SetDetailsContent(content)
end sub

function OnkeyEvent(key as String, press as Boolean) as Boolean
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