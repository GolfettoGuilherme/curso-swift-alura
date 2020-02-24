//
//  RefeicaoDao.swift
//  eggplant-brownie2
//
//  Created by Guilherme Golfetto on 23/02/20.
//  Copyright © 2020 Guilherme Golfetto. All rights reserved.
//

import Foundation


class RefeicaoDao{
    
    func save(_ refeicoes: [Refeicao]){
        guard let caminho = recuperaCaminho() else { return }
        
        do{
            let dados = try NSKeyedArchiver.archivedData(withRootObject: refeicoes, requiringSecureCoding: false) //convertendo a lista em  bytes
            try dados.write(to: caminho)
        } catch{
            print(error.localizedDescription)
        }
        
    }
    
    func recuperaCaminho() -> URL? {
       guard let diretorio = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
                     
       let caminho = diretorio.appendingPathComponent("refeicao")
       
       return caminho
    }
    
    func recupera() -> [Refeicao] {
        guard let caminho = recuperaCaminho() else { return [] }
        
        do{
            let dados = try Data(contentsOf: caminho)
            
            guard let refeicoesSalvar = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(dados) as? Array<Refeicao> else { return [] }
            
            return refeicoesSalvar
            
        } catch {
            print(error.localizedDescription)
            return []
        }
        
    }
}
