function getUtilsTests()
    return [
        shouldReturnTrueValueWhenArgumentIsBooleanAndTrue
        shouldReturnFalseValueWhenArgumentIsBooleanAndFalse
        shouldReturnInvalidWhenArgumentIsNotBoolean
        shouldReturnInvalidWhenArgumentIsInvalid
        shouldReturnTrueWhenArrayContainsTheValue
        shouldReturnFalseWhenArrayNotContainsTheValue
        shouldReturnFalseWhenArrayIsInvalid
        shouldReturnFalseWhenValueIsUndefined
        shouldReturnFalseWhenValueIsInvalid
   ]
end function

'@Test
sub shouldReturnTrueValueWhenArgumentIsBooleanAndTrue()
    argument = type("argument") = "String"
    trueValue = "String"
    falseValue = "Integer"
    
    UTF_assertEqual(ifThenElse(argument, trueValue, falseValue), trueValue)
end sub

'@Test
sub shouldReturnFalseValueWhenArgumentIsBooleanAndFalse()
    argument = type(33) = "String"
    trueValue = "String"
    falseValue = "Integer"
    
    UTF_assertEqual(ifThenElse(argument, trueValue, falseValue), falseValue)
end sub

'@Test
sub shouldReturnInvalidWhenArgumentIsNotBoolean()
    argument = "argument"
    trueValue = "String"
    falseValue = "Integer"
    
    UTF_assertInvalid(ifThenElse(argument, trueValue, falseValue))
end sub

'@Test
sub shouldReturnInvalidWhenArgumentIsInvalid()
    argument = invalid
    trueValue = "String"
    falseValue = "Integer"
    
    UTF_assertInvalid(ifThenElse(argument, trueValue, falseValue))
end sub

'@Test
sub shouldReturnTrueWhenArrayContainsTheValue()
    array = ["value1", "value2", "value3"]
    value = "value3"
    
    UTF_assertTrue(contains(array, value))
end sub

'@Test
sub shouldReturnFalseWhenArrayNotContainsTheValue()
    array = ["value1", "value2", "value3"]
    value = "value4"
    
    UTF_assertFalse(contains(array, value))
end sub

'@Test
sub shouldReturnFalseWhenArrayIsInvalid()
    array = invalid
    value = "value4"
    
    UTF_assertFalse(contains(array, value))
end sub

'@Test
sub shouldReturnFalseWhenValueIsUndefined()
    array = ["value1", "value2", "value3"]
    
    UTF_assertFalse(contains(array, value))
end sub

'@Test
sub shouldReturnFalseWhenValueIsInvalid()
    array = ["value1", "value2", "value3"]
    value = invalid
    
    UTF_assertFalse(contains(array, value))
end sub