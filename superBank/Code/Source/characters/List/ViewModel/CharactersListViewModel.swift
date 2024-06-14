//
//  CharactersListViewModel.swift
//  superBank
//
//  Created by JT on 10/05/2020.
//  Copyright © 2020 JT. All rights reserved.
//

import Foundation

enum pagerParamerterKey: String, CodingKey  {
    case limit
    case offset
    case orderBy
    case nameStartsWith
}

enum OrdenByType: String, CodingKey {
     case nameAZ = "name"
     case nameZA = "-name"
     case modifiedTop = "modified"
     case modifiedBottom = "-modified"
}

struct CharactersListViewModel {
    var charactersList:[CharactersListResponse]
    var pagerTotal:Int = 0
    var offsetValue:Int = 0
    let limitValue:Int = 20
    var orderByValue:String!
    var nameStartsWithValue:String = ""
    
    
    static func mapperToCharactersListResponse(basesPager:BasesPagerModel) -> CharactersListViewModel {
        let list = basesPager.results
        let total = basesPager.total
        let orderBy = ""
        return CharactersListViewModel(charactersList:list,pagerTotal: total, orderByValue: orderBy)
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
    
    mutating func cleanCharactersList(){
        self.charactersList.removeAll()
    }
    
    mutating func cleanOffsetValue(){
        offsetValue = 0
    }
    
    
    mutating func cleanOrderByValuee(){
        orderByValue = ""
    }
    
    mutating func cleanNameStartsWithValue(){
        nameStartsWithValue = ""
    }
    
    mutating func SetNameStartsWithValue(text:String){
        nameStartsWithValue = text
    }
    
    mutating func setOrdenByName() {
        if orderByValue?.isEmpty ?? true{
            self.orderByValue = OrdenByType.nameZA.rawValue
        }else if orderByValue == OrdenByType.nameZA.rawValue {
            self.orderByValue = OrdenByType.nameAZ.rawValue
        }else {
            self.orderByValue = OrdenByType.nameZA.rawValue
        }
        
    }
    
    mutating func setOrdenByModified() {
        if orderByValue?.isEmpty ?? true{
            self.orderByValue = OrdenByType.modifiedTop.rawValue
        }else if orderByValue == OrdenByType.modifiedTop.rawValue {
            self.orderByValue = OrdenByType.modifiedBottom.rawValue
        }else {
            self.orderByValue = OrdenByType.modifiedTop.rawValue
        }
    }
    
    mutating func moreCharactersList() {
           if  offsetValue < self.pagerTotal {
               offsetValue = offsetValue + limitValue
           }
       }
    
    mutating func getListPagerParameters() -> [String:Any] {
          var listParameter:[String:Any] = [pagerParamerterKey.limit.rawValue:limitValue,
          pagerParamerterKey.offset.rawValue:offsetValue]
          
        if !(orderByValue?.isEmpty ?? false) {
              listParameter[pagerParamerterKey.orderBy.rawValue] = orderByValue
          }
          
          if !nameStartsWithValue.isEmpty {
              listParameter[pagerParamerterKey.nameStartsWith.rawValue] = nameStartsWithValue
          }
          
          return listParameter
      }
}

