sub ShowDetailsScreen(content as Object, selectedItem as Integer)
    m.detailsScreen = CreateObject("roSGNode", "DetailsScreen")
    m.detailsScreen.content = content
    m.detailsScreen.jumpToItem = selectedItem 
    m.detailsScreen.ObserveField("visible", "OnDetailsScreenVisibilityChanged")
    m.detailsScreen.ObserveField("buttonSelected", "OnButtonSelected")
    ShowScreen(m.detailsScreen)
end sub

sub OnDetailsScreenVisibilityChanged(event as Object)
    visible = event.GetData()
    detailsScreen = event.GetRoSGNode()
    if visible = false then m.GridScreen.jumpToRowItem = [m.selectedIndex[0], detailsScreen.itemFocused]
end sub

sub OnButtonSelected(event)
    if getDetailsScreenButtonOptions()[event.getData()] = "Ver detalhes" then showMore()
    if getDetailsScreenButtonOptions()[event.getData()] = "Voltar" then closeScreen(invalid)
end sub

sub showMore()
    m.detailsscreen.showMore = true
end sub