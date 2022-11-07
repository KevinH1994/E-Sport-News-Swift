//
//  SignUpVC.swift
//  E-Sport-News
//
//  Created by Kevin Hering on 04.11.22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
class SignUpVC: UIViewController {
    
    @IBOutlet weak var passwordTFzwei: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var benutzernameTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signIsTapped(_ sender: UIButton) {
        
    }
    
    func signUp() {
        var validated = false
        
        let name = benutzernameTF.text!
        let email = emailTF.text!
        let password = passwordTF.text!
        let pwValidation = passwordTFzwei.text!
        
        if !name.isEmpty && !email.isEmpty && !password.isEmpty{
            
            if !email.contains("@"){
                createAlert(withTitle: "Email", andMessage: "Bitte gib eine korrekte Email an")
            }else if password.count < 6 {
                createAlert(withTitle:"Passwort", andMessage:"Das Passwort muss mind. 6 Zeichen beinhalten" )
            }else if password != pwValidation {
                createAlert(withTitle: "Passwort", andMessage: "Passwörter stimmen nicht überein.")
            }else {
                validated = true
                }
        }else{
            createAlert(withTitle: "Fehler", andMessage: "Bitte fülle alle Felder aus.")
        }
        //MARK: - User erstellen , wenn Validation erfolgreich
        if validated{
            Auth.auth().createUser(withEmail: email, password: password){
                authResult, error in
                if error != nil{
                    self.createAlert(withTitle: "Fehler", andMessage: "Es ist ein Unbekannter Fehler auf getretten")
                }else{
                    let db = Firestore.firestore()
                    db.collection("Users").addDocument(data: [
                        "userName":name,
                        "email":email,
                        "uid": authResult?.user.uid as Any
                    ]) { error in
                        
                        if error != nil{
                            self.createAlert(withTitle: "Fehler", andMessage: "Es ist ein Fehler aufgetreten")
                        }else{
                            self.performSegue(withIdentifier: "signupSuccessful", sender: nil)
                        }
                    }
                }
            }
        }
    }
    
    
    
    func createAlert(withTitle: String, andMessage: String){
        let alertcontroler = UIAlertController(title: withTitle, message: andMessage, preferredStyle: .alert)
        alertcontroler.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertcontroler, animated: true)
        
        
    }
    

}
