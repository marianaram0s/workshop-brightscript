sub showDetailsScreen(content as Object, selectedItem as Integer)
    detailsScreen = CreateObject("roSGNode", "DetailsScreen")
    detailsScreen.content = content
    detailsScreen.jumpToItem = selectedItem
    detailsScreen.ObserveField("visible", "onDetailsScreenVisibilityChanged")
    detailsScreen.ObserveField("buttonSelected", "onButtonSelected")
    ShowScreen(detailsScreen)
end sub

sub onButtonSelected(event)
    details = event.GetRoSGNode()
    content = details.content
    buttonIndex = event.getData()
    selectedItem = details.itemFocused
    if buttonIndex = 0 then showVideoScreen(content, selectedItem)
    stop
end sub

sub onDetailsScreenVisibilityChanged(event as Object)
    visible = event.GetData()
    detailsScreen = event.GetRoSGNode()
    if visible = false then m.GridScreen.jumpToRowItem = [m.selectedIndex[0], detailsScreen.itemFocused]
end sub