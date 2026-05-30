//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Assign the message nib
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        /// Table View
        tableView.dataSource = self
        tableView.delegate = self
        
        /// Navigation Controller
        navigationItem.hidesBackButton = true
        title = K.appName
        
        /// Listeners
        dataListener()
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        let currentUser = Auth.auth().currentUser
        if let message = messageTextfield.text, let senderEmail: String = currentUser?.email, !message.isEmpty {
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField : senderEmail,
                K.FStore.bodyField : message,
                K.FStore.dateField : Date().timeIntervalSince1970
            ]) { error in
                if let error = error {
                    print("Error adding document: \(error.localizedDescription)")
                    return 
                }
            }
            print("done")
            DispatchQueue.main.async {
                self.messageTextfield.text = ""
            }
        }
    }
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    
    func dataListener() {
        db.collection(K.FStore.collectionName).order(by: "date", descending: false)
            .addSnapshotListener { querySnapshot, error in
                guard let query = querySnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }
                let documents = query.documents
                self.messages = documents.map { document in
                    return Message(
                        sender: document.data()[K.FStore.senderField] as! String,
                        body: document.data()[K.FStore.bodyField] as! String
                    )
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    let lastIndexPath = IndexPath(row: self.messages.count - 1, section: 0)
                    self.tableView.scrollToRow(at: lastIndexPath , at: .top, animated: true)
                }
            }
        
    }
}

extension ChatViewController: UITextViewDelegate {
    
}
extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: K.cellIdentifier,
            for: indexPath
        ) as! MessageCell
        
        let message = messages[indexPath.row]
        cell.messageLabel.text = message.body
        
        let currentUserEmail = Auth.auth().currentUser?.email
        let isCurrentUser = message.sender == currentUserEmail
        
        print("Current user:", currentUserEmail ?? "nil")
        print("Message sender:", message.sender)
        
        if isCurrentUser {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.messageLabel.textColor = .white
            
        } else {
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.messageLabel.textColor = .black
        }
        
        return cell
    }
}
