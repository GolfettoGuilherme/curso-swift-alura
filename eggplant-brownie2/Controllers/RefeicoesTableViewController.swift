
//
//  RefeicoesTableViewController.swift
//  eggplant-brownie2
//
//  Created by Guilherme Golfetto on 22/02/20.
//  Copyright © 2020 Guilherme Golfetto. All rights reserved.
//

import UIKit


class RefeicoesTableViewController : UITableViewController, AdicionaRefeicaoDelegate {
    
    var refeicoes : [Refeicao] = []
    
    override func viewDidLoad() {
         
        refeicoes = RefeicaoDao().recupera()
        
    }
    
   
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return refeicoes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        let refeicao = refeicoes[indexPath.row]
        celula.textLabel?.text = refeicao.nome
        
        //criando o evento e dizendo para celula ouvir esse evento
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(mostraDetalhes(_ :)))
        
        celula.addGestureRecognizer(longPress)
        
        return celula
    }
    
    // esse underline serve para ajudar a legibilidade
    //sem o _ quando esse método é chamado fica assim: add(refeicao: refeicao)
    //com o _ quando esse metodo é chamado fica assim: add(refeicao)
    //geralmente é bom apenas no primeiro parametro, no segundo fica meio mal escrito, mas funciona
    func add(_ refeicao: Refeicao){
        refeicoes.append(refeicao)
        
        tableView.reloadData()
        
        RefeicaoDao().save(refeicoes)
       
    }
    
    @objc func mostraDetalhes(_ gesture: UILongPressGestureRecognizer){
        //para esse evento valer somente no inicio do click longo e nao sempre
        if(gesture.state == .began){
            
            let celula = gesture.view as! UITableViewCell
            
            guard let indexPath = tableView.indexPath(for: celula) else { return }
            
            let refeicao = refeicoes[indexPath.row]
            
            RemoveRefeicaoViewController(controller: self).exibe(refeicao, handler: { alerta in
                //o self é necessario dentro da funcao anomina (clojure
                self.refeicoes.remove(at: indexPath.row)
                self.tableView.reloadData()
            })
            
            
        }
    }
    
    

    //o que eu posso fazer antes de ir para o proximo viewController via segue
    //o for ajuda também a legibilidade o for precisa ser escrito em quem vai chamar
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //informando para a proxima tela que a variable tableViewController é essa propria classe
        //assim eu posso interagir com essa listagem la naquele controller
        //mas lembre que esse método é chamado para cada segue que tiver no role,
        //então, verificar qual segue que é antes de performar a acao para não explodir um erro muit`loco
        
        if(segue.identifier == "adicionar"){
            if let viewController =  segue.destination as? ViewController {
                //eu preciso mandar para alguem que implemente o protocolo que tenha o metodo add, a propria classe tem
                viewController.delegate = self //self -> propria classe
                
            }
        }

    }
    
}
