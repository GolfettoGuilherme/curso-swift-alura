//
//  Alerta.swift
//  eggplant-brownie2
//
//  Created by Guilherme Golfetto on 23/02/20.
//  Copyright © 2020 Guilherme Golfetto. All rights reserved.
//

import UIKit

class Alerta{
    
    let controller : UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func exibe(titulo: String = "Atenção",mensagem : String) {
        let alerta = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alerta.addAction(ok)
        controller.present(alerta, animated: true, completion: nil)
    }
}
