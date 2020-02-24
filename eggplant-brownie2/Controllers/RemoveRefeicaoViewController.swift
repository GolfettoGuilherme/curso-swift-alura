//
//  RemoveRefeicaoViewController.swift
//  eggplant-brownie2
//
//  Created by Guilherme Golfetto on 23/02/20.
//  Copyright © 2020 Guilherme Golfetto. All rights reserved.
//

import UIKit

class RemoveRefeicaoViewController{
    
    let controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    //esse escaping vai ser uma funcao que quem chamar ele precisa implementar (tipo arrow function)
    func exibe(_ refeicao: Refeicao, handler: @escaping (UIAlertAction)-> Void){
        let alerta = UIAlertController(title: refeicao.nome, message: refeicao.detalhes(), preferredStyle: .alert)
        
        let botaoCancelar = UIAlertAction(title: "Ok", style: .cancel)
        alerta.addAction(botaoCancelar)
        
        let botaoRemover = UIAlertAction(title:"Remover", style: .destructive, handler: handler)
        
        alerta.addAction(botaoRemover)
        
        controller.present(alerta, animated: true, completion: nil)
    }
}
