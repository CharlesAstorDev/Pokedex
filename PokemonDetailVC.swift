//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Charles Astor on 6/22/17.
//  Copyright © 2017 Charles Astor. All rights reserved.
//

import UIKit




class PokemonDetailVC: UIViewController {
    var pokemon: Pokemon!

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var evoLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    
    @IBOutlet weak var nextEvoImg: UIImageView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
             nameLbl.text = pokemon.name
        pokemon.downloadPokemonDetail {
            print("I am here")
            self.updateUI()
        }
        
    }
    func updateUI() {
        nameLbl.text = pokemon.name.capitalized
        mainImg.image = UIImage(named: "\(pokemon.pokedexID)")
        descriptionLbl.text = pokemon.description
       typeLbl.text = pokemon.type
        defenseLbl.text = pokemon.defense
        heightLbl.text = pokemon.height
        pokedexLbl.text = "\(self.pokemon.weight)"//
        weightLbl.text = "\(self.pokemon.pokedexID)"
        attackLbl.text = pokemon.attack
        evoLbl.text = pokemon.nextEvolutionText
        currentEvoImg.image = UIImage(named: "\(pokemon.pokedexID)" )
        nextEvoImg.image = UIImage(named: "\(pokemon.pokedexID + 1)")
        
    }


    @IBAction func backBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }








    
    
    
    
    
    
    



}
