//
//  CharactersDetailsViewModel.swift
//  superBank
//
//  Created by JT on 10/05/2020.
//  Copyright © 2020 JT. All rights reserved.
//

import Foundation


struct CharactersDetailsViewModel {
    let charactersDetails: CharactersListResponse
    var urlImg:String = String()
    var listLink:[URLElement] = []
    
    
    
    static func mapperToCharactersDetailsResponse(charactersList:[CharactersListResponse]) -> CharactersDetailsViewModel {
        let characters = charactersList.first
        let url:String = (characters?.thumbnail.path ?? "") + "." + (characters?.thumbnail.thumbnailExtension ?? "jpg")
        let listUrl:[URLElement] = characters?.urls ?? [URLElement]()
        return CharactersDetailsViewModel(charactersDetails: characters!, urlImg: url,listLink: listUrl )
    }
    
}

