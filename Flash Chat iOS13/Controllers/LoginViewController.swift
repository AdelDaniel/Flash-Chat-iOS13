//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    
    @IBAction func loginPressed(_ sender: UIButton) {
            guard let email = emailTextfield.text,
                  let password = passwordTextfield.text,
                  !email.isEmpty,
                  !password.isEmpty else {
                showAlert(message: "Please enter email and password.")
                return
            }
            
            sender.isEnabled = false
            
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                
                DispatchQueue.main.async {
                    sender.isEnabled = true
                    
                    if let error = error {
                        self?.showAlert(message: error.localizedDescription)
                        return
                    }
                    
                    self?.performSegue(withIdentifier: "LoginToChat", sender: self)
                }
            }
        
        }
    
    
    
    private func showAlert(message: String) {
        let alert = UIAlertController(
            title: "Login Error",
            message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(alert, animated: true)
    }
    
    
}
