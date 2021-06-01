function movie()
    this = {}
    
    this.title = invalid
    this.duration = invalid
    this.url = invalid
    
    this.setMovie = sub(metada as Dynamic)
        m.title = metada.title
        m.duration = metada.duration
        m.url = metada.url
    end sub
    
    return this
end function