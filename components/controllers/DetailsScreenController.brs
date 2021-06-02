sub ShowDetailsScreen(content as Object, selectedItem as Integer)
    detailsScreen = CreateObject("roSGNode", "DetailsScreen")
    detailsScreen.content = content
    detailsScreen.jumpToItem = selectedItem 
    detailsScreen.ObserveField("visible", "OnDetailsScreenVisibilityChanged")
    detailsScreen.ObserveField("buttonSelected", "OnButtonSelected")
    ShowScreen(detailsScreen)
end sub

sub OnButtonSelected(event)
    if getDetailsScreenButtonOptions()[event.getData()] = "Voltar" then closeScreen(invalid)
end sub

sub OnDetailsScreenVisibilityChanged(event as Object)
    visible = event.GetData()
    detailsScreen = event.GetRoSGNode()
    if visible = false then m.GridScreen.jumpToRowItem = [m.selectedIndex[0], detailsScreen.itemFocused]
end sub