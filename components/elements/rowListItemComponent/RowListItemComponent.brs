sub init()
    m.top.ObserveField("itemContent", "onContentSet")
end sub

sub onContentSet()
    content = m.top.itemContent
    
    if isValid(content) then m.top.FindNode("poster").uri = content.hdPosterUrl
end sub
