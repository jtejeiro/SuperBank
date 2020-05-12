//
//  CharactersDetailsViewModel.swift
//  superBank
//
//  Created by Jaime Tejeiro on 10/05/2020.
//  Copyright © 2020 Jaime Tejeiro. All rights reserved.
//

import Foundation


struct CharactersDetailsViewModel {
    let charactersDetails: CharactersListResponse
    let urlImg:String
    let listLink:[URLElement]
    
    
    
    static func mapperToCharactersDetailsResponse(charactersList:[CharactersListResponse]) -> CharactersDetailsViewModel {
        let characters = charactersList.first
        let url:String = (characters?.thumbnail.path ?? "") + "." + (characters?.thumbnail.thumbnailExtension ?? "jpg")
        let listUrl:[URLElement] = characters?.urls ?? [URLElement]()
        return CharactersDetailsViewModel(charactersDetails: characters!, urlImg: url,listLink: listUrl )
    }
    
}

