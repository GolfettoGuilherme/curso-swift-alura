//
//  ItemDao.swift
//  eggplant-brownie2
//
//  Created by Guilherme Golfetto on 23/02/20.
//  Copyright © 2020 Guilherme Golfetto. All rights reserved.
//

import Foundation

class ItemDao{
    
    func save(_ listaDeItens: [Item]) {
        do {
           let dados = try NSKeyedArchiver.archivedData(withRootObject: listaDeItens, requiringSecureCoding: false)
           
           guard let caminho = recuperaDiretorio() else {return}
           
           try dados.write(to: caminho)
           
        } catch{
           print(error.localizedDescription)
        }
               
    }
    
    func recuperaDiretorio() -> URL? {
       guard let diretorio = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
              
       let caminho = diretorio.appendingPathComponent("itens")
       
       return caminho
    }
 
    func recupera() -> [Item] {
        guard let caminho = recuperaDiretorio() else {return []}
               
       do {
           let dados = try Data(contentsOf: caminho)
           
           guard let itensSalvos = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(dados) as? [Item] else {return []}
           
           return itensSalvos
       } catch{
           print(error.localizedDescription)
        return []
       }
    }
    
}
