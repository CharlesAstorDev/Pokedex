//
//  Pokemon.swift
//  Pokedex
//
//  Created by Charles Astor on 6/22/17.
//  Copyright © 2017 Charles Astor. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _pokemonURL: String!
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    
    
    //Getters
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    var nextEvolutionText: String {
        if _nextEvolutionTxt == nil {
            _nextEvolutionTxt = ""
        }
        return _nextEvolutionTxt
    }
    var name: String {
        return _name
    }
    
    var pokedexID: Int {
        return _pokedexId
    }
    
    init(name: String, pokedexID: Int) {
        self._name = name
        self._pokedexId = pokedexID
        
        
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexID)/"
    }
    
    func downloadPokemonDetail(completed: @escaping DownloadComplete) {
        Alamofire.request(_pokemonURL).responseJSON { (response) in
            if let dict = response.result.value as? Dictionary<String,AnyObject> {
                if let move = dict["move"] as? String {
                    
                    self._weight =  move
                    
                }

//                
//                if let weight = dict["weight"] as? String {
//                    
//                    self._weight =  weight
//                    
//                }
                
                if let height = dict["height"] as? String {
                    
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
//                if let description = dict["description"] as? Int {
//                    self._description = "\(description)"
//                }
//                
//                if let type = dict["type"] as? String {
//                    self._type = type
//                }
                
                if let types = dict["types"] as? [Dictionary<String, String>], types.count > 0 {
                    if let name = types[0]["name"] {
                        self._type = name.capitalized
                    }
                    
                    if types.count > 1 {
                        for x in 1..<types.count {
                            if let name = types[x]["name"] {
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                } else {
                    self._type = ""
                }
               
                if let descriptionArray = dict["descriptions"] as? [Dictionary<String,String>], descriptionArray.count > 0 {
                    
                    if let url = descriptionArray[0]["resource_uri"] {
                        let descriptionURL = "\(URL_BASE)\(url)"
                        Alamofire.request(descriptionURL).responseJSON(completionHandler: { (response) in
                            if let descriptionDict = response.result.value as? Dictionary<String, AnyObject> {
                                if let description = descriptionDict["description"] as? String {
                                    let newDescription = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                   // print(newDescription)
                                    self._description = newDescription
                                    
                                }
                            }
                            completed()
                        })
                    }
                } else {
                    self._description = "No description"
                }
            }
            completed()
        }
    
    }
}
