sub init()
    getElementSpinner()
end sub

sub labelLoader()
    m.loader = m.top.findNode("label-spinner")
    m.loader.font.size=40
    m.loader.color="0xFFFFFF"
end sub

sub spinnerLoader()
    m.loader = m.top.findNode("spinner")
    m.loader.poster.uri = getLoadingIndicatorInfos().SPINNER_URI
    m.loader.poster.width = getLoadingIndicatorInfos().SPINNER_WIDTH
    m.loader.poster.height = getLoadingIndicatorInfos().SPINNER_HEIGHT
end sub

sub getElementSpinner()
    devicesLowEnd = ["3700X", "3710X", "2700X", "2710X", "2720X", "5000X"]
    deviceModel = CreateObject("roDeviceInfo").getModel()
    if not contains(devicesLowEnd, deviceModel)
        labelLoader()
    else
        spinnerLoader()
    end if
end sub

sub show()
    m.loader.visible = true
    m.loader.control = "start"
end sub

sub hide()
    m.loader.visible = false
    m.loader.control = "stop"
end sub
