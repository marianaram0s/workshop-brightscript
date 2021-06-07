function getLoadingIndicatorInfos()
    return {
        SPINNER_WIDTH : 42
        SPINNER_HEIGHT : 42
        SPINNER_URI : "pkg:/images/spinner-icon.png"
        LOADING_BACKGROUND_URI : "pkg:/images/loadingBackground.png"
        LOADING_BACKGROUND_WIDTH : "173"
        LOADING_BACKGROUND_HEIGHT : "42"
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
        "Ver detalhes"
        "Voltar"
    ]
end function

function getLowEndDevicesModels()
    return ["3700X", "3710X", "2700X", "2710X", "2720X", "5000X"]
end function