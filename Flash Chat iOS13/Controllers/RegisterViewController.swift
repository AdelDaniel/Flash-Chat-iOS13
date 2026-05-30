//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

import FirebaseCore
import FirebaseFirestore
import FirebaseAuth


class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func registerPressed(_ sender: UIButton) {
        
        guard let email = emailTextfield.text,
              let password = passwordTextfield.text,
              !email.isEmpty,
              !password.isEmpty else {
            showAlert(message: "Please enter email and password.")
            return
        }
        
        guard password.count >= 6 else {
            showAlert(message: "Password must be at least 6 characters.")
            return
        }
        
        sender.isEnabled = false
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            
            DispatchQueue.main.async {
                sender.isEnabled = true
                
                if let error = error {
                    self?.showAlert(message: error.localizedDescription)
                    return
                }
                
                self?.performSegue(withIdentifier: "RegisterToChat", sender: self)
            }
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(
            title: "Registration Error",
            message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(alert, animated: true)
    }
}
