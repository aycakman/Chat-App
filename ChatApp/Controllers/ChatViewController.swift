//
//  ChatViewController.swift
//  ChatApp
//
//  Created by Ayca Akman on 22.05.2023.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
class ChatViewController: UIViewController {
    
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var chatTableView: UITableView!
    
    let db = Firestore.firestore()
    
    var messages: [Message] = [
        //Message(sender: "1@hotmail.com", body: "Hey!"),
        //Message(sender: "a@hotmail.com", body: "Hello!"),
        //Message(sender: "1@hotmail.com", body: "What's up?")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatTableView.dataSource = self
        
        title = "Chat"
        navigationItem.hidesBackButton = true
        
        chatTableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        loadMessages()
    }
    
    func loadMessages() {
        messages = [] //clear the dummy messages
        db.collection(K.FStore.collectionName).getDocuments { querySnapshot, error in
            if let error = error {
                print("retrieving data from firestore is not working correctly \(error)")
            }else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        //print(doc.data())
                        let data = doc.data()
                        if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String {
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)
                            
                            DispatchQueue.main.async {
                                self.chatTableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func sendButtonPressed(_ sender: Any) {
        if let messageBody = messageTextField.text, let messageSender = Auth.auth().currentUser?.email{
            db.collection(K.FStore.collectionName).addDocument(data: [K.FStore.senderField: messageSender, K.FStore.bodyField: messageBody]) { error in
                if let error = error {
                    print("saving data to firestore is not working correctly \(error)")
                }else {
                    print("successfully saved data")
                }
            }
            
        }
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    

}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.messageLabel.text = messages[indexPath.row].body
        return cell
        
    }
    
    
}
