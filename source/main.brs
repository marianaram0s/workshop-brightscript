sub main(args as Dynamic)
    print "LOG - Main() - Starting Channel"
    launchMainScene()
end sub

sub launchMainScene()
    mainScreen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    
    mainScreen.setMessagePort(m.port)

    mainScene = mainScreen.CreateScene("MainScene")

    mainScreen.show()

    while(true)
        msg = wait(0, m.port)
        msgType = type(msg)
        if msgType = "roSGScreenEvent"
            if msg.isScreenClosed() 
                print "LOG - Main() - Closing App"
                return
            end if
        end if
    end while
end sub