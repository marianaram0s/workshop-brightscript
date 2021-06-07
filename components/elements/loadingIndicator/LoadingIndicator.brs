sub init()
    findNodesByXML()
    setupSpinner()
    setupLoadingLabel()
end sub

sub show()
    if isLowEndDevice()
        showLoadingLabel()
    else
        showSpinner()
    end if
end sub

sub hide()
    if isLowEndDevice()
        hideLoadingLabel()
    else
        hideSpinner()
    end if
end sub

sub findNodesByXML()
    m.spinner = m.top.findNode("spinner")
    m.loadingLabel = m.top.findNode("loadingLabel")
    m.loadingBackground = m.top.findNode("loadingBackground") 
end sub

sub showSpinner()
    m.spinner.visible = true
    m.spinner.control = "start"
end sub

sub hideSpinner()
    m.spinner.visible = false
    m.spinner.control = "stop"
end sub

sub showLoadingLabel()
    m.loadingLabel.visible = true
    m.loadingBackground.visible = true
end sub

sub hideLoadingLabel()
    m.loadingLabel.visible = false
    m.loadingBackground.visible = false
end sub

sub setupSpinner()
    m.spinner.poster.uri = getLoadingIndicatorInfos().SPINNER_URI
    m.spinner.poster.width = getLoadingIndicatorInfos().SPINNER_WIDTH
    m.spinner.poster.height = getLoadingIndicatorInfos().SPINNER_HEIGHT
end sub

sub setupLoadingLabel()
    m.loadingBackground.uri = getLoadingIndicatorInfos().LOADING_BACKGROUND_URI
    m.loadingBackground.width = getLoadingIndicatorInfos().LOADING_BACKGROUND_WIDTH
    m.loadingBackground.height = getLoadingIndicatorInfos().LOADING_BACKGROUND_HEIGHT
end sub