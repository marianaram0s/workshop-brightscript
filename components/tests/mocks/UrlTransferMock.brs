function getUrlTransferMock()
    this = {}

    this.SetCertificatesFile = sub(params)
    end sub

    this.setURL = sub(params)
    end sub

    this.GetToString = function()
        return {"menu":[{"name":"Lançamentos","path":"/cinelist/lancamentos-de-filmes"},{"name":"Franquias","path":"/franquias"},{"name":"Cinelists","path":"/cinelists"}],"account":{"children":[{"name":"Minha Lista","path":"/account/profiles/mylist"},{"name":"Histórico","path":"/account/profiles/watched"},{"name":"Trocar Perfil","path":"/account/profiles"}]}}
    end function

    return this
end function