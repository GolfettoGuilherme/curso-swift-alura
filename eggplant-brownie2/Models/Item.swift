//
//  Item.swift
//  eggplant-brownie2
//
//  Created by Guilherme Golfetto on 17/10/19.
//  Copyright © 2019 Guilherme Golfetto. All rights reserved.
//

import UIKit

class Item: NSObject, NSCoding {

    
    let nome: String
    let calorias: Double
    
    init(nome:String, calorias:Double){
        self.nome = nome
        self.calorias = calorias
    }
    
    //MARK: - NsCoding
    
    func encode(with coder: NSCoder) {
        coder.encode(nome, forKey: "nome")
        coder.encode(calorias, forKey: "calorias")
    }
    
    required init?(coder: NSCoder) {
        nome = coder.decodeObject(forKey: "nome") as! String
        calorias = coder.decodeDouble(forKey: "calorias")
    }

}
