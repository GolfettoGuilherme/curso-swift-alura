//
//  AdicionarItensViewController.swift
//  eggplant-brownie2
//
//  Created by Guilherme Golfetto on 23/02/20.
//  Copyright © 2020 Guilherme Golfetto. All rights reserved.
//

import UIKit

protocol AdicionarItemDelegate {
    func add(_ item: Item)
}

class AdicionarItensViewController: UIViewController {

    
    //MARK: IbOutlets
    
    @IBOutlet weak var nomeTextField: UITextField!
    
    @IBOutlet weak var caloriasTextField: UITextField!
    
    //MARK: - Atributos
    
    var delegate: AdicionarItemDelegate?
    
    
    init(delegate: AdicionarItemDelegate){
        super.init(nibName: "AdicionarItensViewController", bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    //MARK: - IBAction
    
    @IBAction func adicionarItem(_ sender: Any) {
        
        //os dois guard juntos
        guard let nome = nomeTextField.text, let calorias = caloriasTextField.text else { return }
        
        if let numeroDeCalorias = Double(calorias){
            let item = Item(nome: nome, calorias: numeroDeCalorias)
            
            delegate?.add(item)
            
            navigationController?.popViewController(animated: true)
        }

    }
    


}
