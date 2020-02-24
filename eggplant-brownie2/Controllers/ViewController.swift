import UIKit

//interface
protocol AdicionaRefeicaoDelegate {
    func add(_ refeicao: Refeicao)
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AdicionarItemDelegate {


    
    //! force unwrap -> dizendo pro swift que essa variavel tera um valor
    //? -> dizendo que essa variavel pode ser opcional e não ter um valor (melhor)
    
    //MARK: - Attributos
    
    var delegate: AdicionaRefeicaoDelegate?
    
    var itens: [Item] = []
    
    var itensSelcionados: [Item] = []
    
    //MARK: - IBOutlets
    
    @IBOutlet var nomeTextField: UITextField?
    @IBOutlet var felicidadeTextField: UITextField?
    @IBOutlet weak var itensTableView: UITableView?
    
    //MARK: - View life cyle
    
    override func viewDidLoad(){
        
        //title: texto do botao
        //style: estilo dele (dahh)
        //target: qual classe esta o metodo que o botao vai chamar
        //action: qual metodo o botao vai chamar (usar dessa forma)
        let botaoAdicionaItem = UIBarButtonItem(title: "Adicionar", style: .plain, target: self, action: #selector(adicionarItem))
        
        navigationItem.rightBarButtonItem = botaoAdicionaItem
        
        itens = ItemDao().recupera()
       
        
    }
    
    //informando que essa funcao esta apta para ser usada (pq vem do objective-C
    @objc func adicionarItem(){
        let adicionarItensViewController = AdicionarItensViewController(delegate: self)
        navigationController?.pushViewController(adicionarItensViewController, animated: true)
    }
    
    
    func add(_ item: Item) {
        itens.append(item)
        
        ItemDao().save(itens)
        
        // itensTableView?.reloadData() é igual, mas colocando o if te lembra de tratar o erro no else caso a variavel esteja de fato nula
        if let tableView = itensTableView {
            tableView.reloadData()
        } else{
            Alerta(controller: self).exibe(mensagem: "Não foi possivel atualizar a tabela")
        }
        
        
       

    }
    
    
   
    
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        celula.textLabel?.text = itens[indexPath.row].nome
        
        return celula
    }
    
    
    //MARK: - UITableViewDelegate
    
    //click na celula
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //verificando se ela existe
        guard let celula = tableView.cellForRow(at: indexPath) else { return }
        
        
        if(celula.accessoryType == .none) {
            celula.accessoryType = .checkmark

            itensSelcionados.append(itens[indexPath.row])
            
        } else{
            celula.accessoryType = .none
            
            if let posicaoItenNaLista = itensSelcionados.firstIndex(of: itens[indexPath.row]){
                itensSelcionados.remove(at: posicaoItenNaLista)
            }
            
        }
        
    }
    
    func recuperaRefeicaoDoFormulario() -> Refeicao? {
        //isso aqui é para verificar se as variaveis estao nulas
        guard let nomeDaRefeicao = nomeTextField?.text else {
            return nil
        }
        guard let felicidadeDaRefeicao = felicidadeTextField?.text, let felicidade = Int(felicidadeDaRefeicao) else {
            return nil
        }
        
        let refeicao = Refeicao(nome: nomeDaRefeicao, felicidade:felicidade, itens: itensSelcionados)
        
        return refeicao
    }
    
    
    //MARK: - IBAction
    
    @IBAction func adicionar(_ sender: Any) {
        
        if let refeicao = recuperaRefeicaoDoFormulario() {
            delegate?.add(refeicao)
                   
            navigationController?.popViewController(animated: true) //voltando para aprimeira tela
        } else{
            Alerta(controller: self).exibe(mensagem: "Erro ao ler dados do formulario")
        }
        
    }
    
}
