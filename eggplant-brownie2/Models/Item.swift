//
//  Item.swift
//  eggplant-brownie2
//
//  Created by Guilherme Golfetto on 17/10/19.
//  Copyright © 2019 Guilherme Golfetto. All rights reserved.
//

import UIKit

class Item: NSObject {
    
    var nome: String
    var calorias: Double
    
    init(nome:String, calorias:Double){
        self.nome = nome
        self.calorias = calorias
    }

}
