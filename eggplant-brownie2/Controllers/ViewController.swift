import UIKit

class ViewController: UIViewController {
    //! force unwrap -> dizendo pro swift que essa variavel tera um valor
    //? -> dizendo que essa variavel pode ser opcional e não ter um valor
    @IBOutlet var nomeTextField: UITextField!
    
    @IBOutlet var felicidadeTextField: UITextField!
    
    @IBAction func adicionar(_ sender: Any) {
        let nome = nomeTextField.text!
        let felicidade = felicidadeTextField.text!
        
        print("comi \(nome) e fiquei com felicidade \(felicidade)")
    }
    
}
