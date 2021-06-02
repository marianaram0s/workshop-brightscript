sub init()
    Runner = TestRunner()
    Runner.SetFunctions([
        setupTest
        shouldHideCurrentScreenAndShowTheNewScreen
        shouldShowTheNewScreen
    ])
end sub

'@BeforeEach
sub setupTest()
    initScreenStack()
end sub

'@Test
sub shouldHideCurrentScreenAndShowTheNewScreen()
    currentScreen = createObject("roSGNode", "Poster")
    setScreenStack(currentScreen)
    newScreen = createObject("roSGNode", "Rectangle")
    
    showScreen(newScreen)
    
    UTF_assertFalse(currentScreen.visible)
    UTF_assertTrue(newScreen.visible)
end sub

'@Test
sub shouldShowTheNewScreen()
    newScreen = createObject("roSGNode", "Poster")
    showScreen(newScreen)
    UTF_assertTrue(newScreen.visible)
end sub

sub setScreenStack(node)
    m.screenStack.push(node)
end sub