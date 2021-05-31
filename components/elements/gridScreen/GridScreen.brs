sub init()
    m.rowList = m.top.FindNode("rowList")
    m.rowList.SetFocus(true)
    m.descriptionLabel = m.top.findNode("descriptionLabel")
    m.titleLabel = m.top.FindNode("titleLabel")
    m.rowList.ObserveField("rowItemFocused", "onItemFocused")
end sub

sub onItemFocused()
    focusedIndex = m.rowList.rowItemFocused
    row = m.rowList.content.GetChild(focusedIndex[0])
    item = row.GetChild(focusedIndex[1])
    
    m.descriptionLabel.text = item.description
    m.titleLabel.text = item.title
    
    if isValid(item.length) then m.titleLabel.text += " | " + getTime(item.length)
end sub

sub OnVisibleChange() ' invoked when GridScreen change visibility
    if m.top.visible = true
        m.rowList.SetFocus(true) ' set focus to rowList if GridScreen visible
    end if
end sub
