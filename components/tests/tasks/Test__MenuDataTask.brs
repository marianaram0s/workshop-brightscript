sub init()
    Runner = TestRunner()
    Runner.SetFunctions([
        shouldReceiveValidJsonWhenRequestApi
    ])
end sub

'@Test
sub shouldReceiveValidJsonWhenRequestApi()
    setUrlTransfer()
    
    menuData = requestMenuDataByApi()
    
    UTF_assertNotInvalid(menuData)
end sub

sub setUrlTransfer()
    m.UrlTransfer = getUrlTransferMock()
end sub