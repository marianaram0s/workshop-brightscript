sub init()
    m.spinner = m.top.findNode("spinner")
    m.spinner.poster.uri = getLoadingIndicatorInfos().SPINNER_URI
    m.spinner.poster.width = getLoadingIndicatorInfos().SPINNER_WIDTH
    m.spinner.poster.height = getLoadingIndicatorInfos().SPINNER_HEIGHT
end sub

sub show()
    m.spinner.visible = true
    m.spinner.control = "start"
end sub

sub hide()
    m.spinner.visible = false
    m.spinner.control = "stop"
end sub