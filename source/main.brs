sub main(args as Dynamic)
    print "LOG - Main() - Starting Channel"
    runUnitTests = args.RunTests = "true" and type(TestRunner) = "Function"
    launchMainScene(runUnitTests)
end sub

sub launchMainScene(runUnitTests)
    mainScreen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    
    scene = ifThenElse(runUnitTests, "TestScene", "MainScene")
    
    mainScreen.setMessagePort(m.port)
    mainScene = mainScreen.CreateScene(scene)
    mainScreen.show()
    
    if runUnitTests then setupTestRunnerAndExecuteTests()

    createEventLoop()
end sub

sub setupTestRunnerAndExecuteTests()
    Runner = TestRunner()
    
    testsBySourcePackage = []
    testsBySourcePackage.append(getUtilsTests())
            
    Runner.SetFunctions(testsBySourcePackage)
    Runner.Logger.SetVerbosity(2)
    Runner.Logger.SetEcho(false)
    Runner.Logger.SetJUnit(false)
    Runner.SetFailFast(false)
    
    Runner.Run()
end sub

sub createEventLoop()
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