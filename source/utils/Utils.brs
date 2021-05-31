'--------
'CreateNodeAndInit()
'
'@param(s)
'   {string} nodeName - Node name to create
'   {Dynamic} fields (optional)- fields for node to set
'
'Returns created node
'--------
Function CreateNodeAndInit(nodeName as string, fields = invalid as dynamic)
    node = CreateObject("roSGNode", nodeName)
    if (isNotEmptyObject(fields))
        node.setFields(fields)
    end if
    return node
End Function

'--------
'isValid()
'
'@param(s)
'   {dynamic} obj - object to check for validity
'
'Returns true if given @obj is not invalid
'--------
Function isValid(obj as dynamic) as boolean
    if(type(obj) = "<uninitialized>")
        print("Using an <uninitialized> variable!")
    end if
    return type(obj) <> "<uninitialized>" and obj <> invalid
End Function

'--------
'isInvalid()
'
'@param(s)
'   {dynamic} obj - object to check for invalidity
'
'Returns true if given @obj is invalid
'--------
Function isInvalid(obj as Dynamic) as Boolean
    return not isValid(obj)
End Function

'--------
'isObject()
'
'@param(s)
'   {dynamic} obj - object to check is given var is assoc array
'
'Returns true if given @obj is invalid
'--------
Function isObject(obj as Dynamic) as Boolean
    return isValid(obj) and GetInterface(obj, "ifAssociativeArray") <> invalid
End Function

'--------
'isNotEmptyObject()
'
'@param(s)
'   {Dynamic} obj - object to check for validity
'
'Returns true if given @obj is empty object(assocarray)
'--------
Function isEmptyObject(obj As Dynamic) As Boolean
    return not isNotEmptyObject(obj)
End Function

'--------
'isNotEmptyObject()
'
'@param(s)
'   {Dynamic} obj - object to check for validity
'
'Returns true if given @obj is not empty object(assocarray)
'--------
Function isNotEmptyObject(obj as Dynamic) As Boolean
    return isObject(obj) and obj.Count() > 0
End Function

'--------
'IsString()
'
'@param(s)
'   {Dynamic} obj - object to check for validity
'
'Returns true if given @obj is String type
'--------
Function IsString(obj As Dynamic) As Boolean
    return IsValid(obj) and GetInterface(obj, "ifString") <> invalid
End Function

'--------
'IsNotEmptyString()
'
'@param(s)
'   {Dynamic} obj - object to check for validity
'
'Returns true if given @obj is String and its length >0
'--------
Function IsNotEmptyString(obj As Dynamic) As Boolean
    return IsString(obj) and Len(obj) > 0
End Function

'--------
'IsEmptyString()
'
'@param(s)
'   {Dynamic} obj - object to check for validity
'
'Returns true if given @obj is String and its length = 0
'--------
Function IsEmptyString(obj As Dynamic) As Boolean
    return IsString(obj) and Len(obj) = 0
End Function

'--------
'IsFunction()
'
'@param(s)
'   {Dynamic} obj - object to check for validity
'
'Returns true if given @obj is function
'--------
Function IsFunction(obj As Dynamic) As Boolean
    tf = type(obj)
    return tf="Function" or tf="roFunction"
End Function

'--------
'IsInteger()
'
'@param(s)
'   {Dynamic} obj - object to check for validity
'
'Returns true if given @obj is integer
'--------
Function IsInteger(obj As Dynamic) As Boolean
    return IsValid(obj) and GetInterface(obj, "ifInt") <> invalid
End Function

'--------
'IsFloat()
'
'@param(s)
'   {Dynamic} obj - object to check for validity
'
'Returns true if given @obj is float
'--------
Function IsFloat(obj As Dynamic) As Boolean
    return IsValid(obj) and  GetInterface(obj, "ifFloat") <> invalid
End Function

'--------
'IsLong()
'
'@param(s)
'   {Dynamic} obj - object to check for validity
'
'Returns true if given @obj is long
'--------
Function IsLong(obj As Dynamic) As Boolean
    return IsValid(obj) and  GetInterface(obj, "ifLongInt") <> invalid
End Function

'--------
'IsDouble()
'
'@param(s)
'   {Dynamic} obj - object to check for validity
'
'Returns true if given @obj is double
'--------
Function IsDouble(obj As Dynamic) As Boolean
    return IsValid(obj) and  GetInterface(obj, "ifDouble") <> invalid
End Function

'--------
'IsNumber()
'
'@param(s)
'   {Dynamic} obj - object to check for validity
'
'Returns true if given @obj is number
'--------
Function IsNumber(obj As Dynamic) As Boolean
    return IsFloat(obj) or IsInteger(obj) or IsLong(obj) or IsDouble(obj)
End Function

'--------
'IsArray()
'
'@param(s)
'   {Dynamic} obj - object to check for validity
'
'Returns true if given @obj is array
'--------
Function IsArray(obj As Dynamic) As Boolean
    return IsValid(obj) and GetInterface(obj, "ifArray") <> invalid
End Function

'--------
'IsNotEmptyArray()
'
'@param(s)
'   {Dynamic} obj - object to check for validity
'
'Returns true if given @obj is array and its size greater than zero
'--------
Function IsNotEmptyArray(obj As Dynamic) As Boolean
    return IsArray(obj) and obj.Count() > 0
End Function


'--------
'isBoolean()
'
'@param(s)
'   {Dynamic} obj - object to check for validity
'
'Returns true if given @obj has boolean type
'--------
Function isBoolean(obj As Dynamic) As Boolean
    return IsValid(obj) and GetInterface(obj, "ifBoolean" ) <> invalid
End Function

'--------
'toBoolean()
'
'@param(s)
'   {Dynamic} obj - object to convert into boolean
'
'Returns true if given @obj has next values: [1-infinity, true, "true"]. Otherwise will return false
'--------
Function toBoolean(parameter as dynamic) as boolean
    if IsInvalid(parameter) then
        return false
    else if isNotEmptyString(parameter) then
        return LCase(parameter) = "true"
    else if IsNumber(parameter)then
        return parameter > 0
    else if isBoolean(parameter) then
        return parameter
    else
        return false
    end if
end function

'If argument is valid and true, return trueValue, else return falseValue
function ifThenElse(arg, trueValue, falseValue)
    if isValid(arg) and isBoolean(arg)
        if arg
            return trueValue
        else
            return falseValue
        end if
    end if
    
    return invalid
end function

'convert seconds to mm:ss format
' getTime(138) returns 2:18
function getTime(length as Integer) as String
    minutes = (length \ 60).ToStr()
    seconds = length MOD 60
    if seconds < 10
       seconds = "0" + seconds.ToStr()
    else
       seconds = seconds.ToStr()
    end if
    return minutes + ":" + seconds
end function

' Helper function convert AA to Node
function ContentListToSimpleNode(contentList as Object, nodeType = "ContentNode" as String) as Object
    result = CreateObject("roSGNode", nodeType) ' create node instance based on specified nodeType
    if result <> invalid
        ' go through contentList and create node instance for each item of list
        for each itemAA in contentList
            item = CreateObject("roSGNode", nodeType)
            item.SetFields(itemAA)
            result.AppendChild(item) 
        end for
    end if
    return result
end function