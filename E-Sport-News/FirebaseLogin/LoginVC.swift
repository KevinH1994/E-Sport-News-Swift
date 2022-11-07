//
//  LoginVC.swift
//  E-Sport-News
//
//  Created by Kevin Hering on 04.11.22.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController {

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool){
        guard let uid = Auth.auth().currentUser?.uid else {
            print("Kein USer aktuell")
            return
        }
        if !uid.isEmpty{
            print("\(uid)")
            performSegue(withIdentifier: "loginSuccessful", sender: nil)
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        let email = loginName.text!
        let password = password.text!
        
        if !email.isEmpty && !password.isEmpty {
            Auth.auth().signIn(withEmail: email, password: password){
                authResult, error in
                
                if error != nil {
                    print("Etwas ist schiefgelaufen beim Login")
                }else{
                    self.performSegue(withIdentifier: "loginSuccessful", sender: nil)
                }
            }
        }
    }
    
    

}
