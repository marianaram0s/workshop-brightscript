sub init()
    Runner = TestRunner()
    Runner.SetFunctions([
        setup
        shouldAddNewScreeenOnStackAndTurnVisible
    ])
end sub

'@BeforeAll
sub setup()
    initScreenStack()
end sub

'@Test
sub shouldAddNewScreeenOnStackAndTurnVisible()
    mainScreen = CreateObject("roSGScreen")
    mainScreen.CreateScene("MainSceneMock")
    
    newNode = CreateObject("roSGNode", "GridScreen")
    
    showScreen(newNode)
    UTF_assertTrue(getScreenStack().Peek().IsSameNode(newNode))
end sub