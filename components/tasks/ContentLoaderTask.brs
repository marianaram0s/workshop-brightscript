sub init()
    m.top.functionName = "getContent"
end sub

sub getContent()
    contentFeedReturn = requestContentFeedByAPI()
    
    contentFeedJson = ParseJson(contentFeedReturn)
    
    if isValid(contentFeedJson)
        rootChildren = parseContentFeedJsonToATreeOfContentNodes(contentFeedJson)

        contentNode = CreateObject("roSGNode", "ContentNode")
        contentNode.Update({
            children: rootChildren
        }, true)
        m.top.content = contentNode
    end if
end sub

function requestContentFeedByAPI()
    URLTransfer = CreateObject("roURLTransfer")
    URLTransfer.SetCertificatesFile(getRequestsParams().DEFAULT_CERTIFICATE)
    URLTransfer.SetURL(getRequestsParams().CONTENT_FEED_URL)
    
    return URLTransfer.GetToString()
end function

function parseContentFeedJsonToATreeOfContentNodes(json as Object)
    rootChildren = []
    
    for each category in json
        value = json.Lookup(category)
        if Type(value) = "roArray"
            if category <> "series"
                row = {}
                row.title = category
                row.children = []
                for each item in value
                    itemData = GetItemData(item)
                    row.children.Push(itemData)
                end for
                rootChildren.Push(row)
            end if
        end if
    end for
    
    return rootChildren
end function

function getItemData(video as Object) as Object
    item = {}
    
    item.description = ifThenElse(isValid(video.longDescription), video.longDescription, video.shortDescription)
    item.hdPosterURL = video.thumbnail
    item.title = video.title
    item.releaseDate = video.releaseDate
    item.id = video.id
    
    if isValid(video.content) then item.length = video.content.duration

    return item
end function
