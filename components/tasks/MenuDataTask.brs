sub init()
    m.top.functionName = "getContent"
end sub

sub getContent()
    m.URLTransfer = CreateObject("roURLTransfer")
    
end sub

function requestMenuDataByApi()
    m.URLTransfer.SetCertificatesFile(getRequestsParams().DEFAULT_CERTIFICATE)
    m.URLTransfer.SetURL(getRequestsParams().MENU_DATA_URL)
    return m.URLTransfer.GetToString()
end function