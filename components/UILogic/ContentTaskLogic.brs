sub runContentTask()
    m.contentTask = CreateObject("roSGNode", "ContentLoaderTask")
    m.contentTask.ObserveField("content", "onContentLoaded")
    m.contentTask.control = "RUN"
    m.loadingIndicator.callFunc("show")
end sub

sub onContentLoaded()
    m.GridScreen.SetFocus(true)
    m.loadingIndicator.callFunc("hide")
    m.GridScreen.content = m.contentTask.content
end sub