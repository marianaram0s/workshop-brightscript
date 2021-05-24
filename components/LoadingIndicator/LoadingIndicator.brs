sub init()
    m.spinner = m.top.findNode("spinner")
    m.spinner.poster.uri = getLoadingIndicatorInfos().SPINNER_URI
    m.spinner.poster.width = getLoadingIndicatorInfos().SPINNER_WIDTH
    m.spinner.poster.height = getLoadingIndicatorInfos().SPINNER_HEIGHT
end sub