//
//  CharactersListViewModel.swift
//  superBank
//
//  Created by Jaime Tejeiro on 10/05/2020.
//  Copyright © 2020 Jaime Tejeiro. All rights reserved.
//

import Foundation

enum pagerParamerterKey: String, CodingKey  {
       case limit
       case offset
}

enum OrdenByType: String, CodingKey {
     case nameAZ = "name"
     case nameZA = "-name"
     case modifiedTop = "modified"
     case modifiedBottom = "-modified"
}

struct CharactersListViewModel {
    var charactersList:[CharactersListResponse]
    let pagerTotal:Int
    
    
    static func mapperToCharactersListResponse(basesPager:BasesPagerModel) -> CharactersListViewModel {
        let list = basesPager.results
        let total = basesPager.total
        return CharactersListViewModel(charactersList:list,pagerTotal: total)
    }
    
    mutating func charactersListMore(list:[CharactersListResponse]){
        if  self.charactersList.count < 0 {
            self.charactersList = list
        }else {
            var newList = [CharactersListResponse]()
            newList.append(contentsOf: self.charactersList)
            newList.append(contentsOf: list)
            self.charactersList = newList
        }
        
    }
}

