function getLoadingIndicatorInfos()
    return {
        SPINNER_WIDTH : 42
        SPINNER_HEIGHT : 42
        SPINNER_URI : "pkg:/images/spinner-icon.png"
    }
end function

function getRequestsParams()
    return {
        DEFAULT_CERTIFICATE : "common:/certs/ca-bundle.crt"
        CONTENT_FEED_URL : "https://jonathanbduval.com/roku/feeds/roku-developers-feed-v1.json"
    }
end function

function getDetailsScreenButtonOptions()
    return [
        "Voltar"
    ]
end function