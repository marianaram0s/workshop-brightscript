function getUtilsTests()
    return [
        shouldReturnTrueValueIfArgumentIsBooleanAndTrue
        shouldReturnFalseValueIfArgumentIsBooleanAndFalse
        shouldReturnInvalidIfArgumentIsNotBoolean
        shouldReturnInvalidIfArgumentIsInvalid
   ]
end function

'@Test
sub shouldReturnTrueValueIfArgumentIsBooleanAndTrue()
    argument = type("argument") = "String"
    trueValue = "String"
    falseValue = "Integer"
    
    UTF_assertEqual(ifThenElse(argument, trueValue, falseValue), trueValue)
end sub

'@Test
sub shouldReturnFalseValueIfArgumentIsBooleanAndFalse()
    argument = type(33) = "String"
    trueValue = "String"
    falseValue = "Integer"
    
    UTF_assertEqual(ifThenElse(argument, trueValue, falseValue), falseValue)
end sub

'@Test
sub shouldReturnInvalidIfArgumentIsNotBoolean()
    argument = "argument"
    trueValue = "String"
    falseValue = "Integer"
    
    UTF_assertInvalid(ifThenElse(argument, trueValue, falseValue))
end sub

'@Test
sub shouldReturnInvalidIfArgumentIsInvalid()
    argument = invalid
    trueValue = "String"
    falseValue = "Integer"
    
    UTF_assertInvalid(ifThenElse(argument, trueValue, falseValue))
end sub