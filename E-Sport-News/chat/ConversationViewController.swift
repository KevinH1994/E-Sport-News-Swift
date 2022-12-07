//
//  ConversationViewController.swift
//  E-Sport-News
//
//  Created by Kevin Hering on 05.12.22.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import Firebase
import FirebaseStorage


struct Conversation {
    var otherParticipant: User
    //var lastMessage: String
}


class ConversationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{


    @IBOutlet weak var conversationsTableView: UITableView!
    var conversationsList = [Conversation]()
    var conversationsDocumentQuerySnapshots = [QueryDocumentSnapshot]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        conversationsTableView.dataSource = self
        
        getAllConversations()
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "toChatUserSelection", sender: nil)
    }
    
    
    
    func getAllConversations(){
        
       let currentUser = Auth.auth().currentUser!.uid
        
        let db  = Firestore.firestore()
        db.collection("Conversations").getDocuments {
            
            (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
               
                print( querySnapshot!.isEmpty )
                for doc in querySnapshot!.documents{
                    if doc.documentID.contains(currentUser){
                        var otherUser: String
                        let usersInConversation = (doc.documentID.split(separator: "+"))
                        if usersInConversation[0] == currentUser{
                            otherUser = String(usersInConversation[1])
                        }
                        else {
                            otherUser = String(usersInConversation[0])
                        }
                        
                        print("DOC ID: ")
                        print(doc.documentID)
                        self.conversationsDocumentQuerySnapshots.append(doc)
                        
                        let otherUserData = db.collection("Users").whereField("uid", isEqualTo: otherUser)
                        otherUserData.getDocuments { querySnapshot, err in
                            if err != nil {
                                print ("Something went Wrong! User not found.")
                            }else {
                                for doc in querySnapshot!.documents{
                                    
                                    self.conversationsList.append(Conversation(otherParticipant: User (firstName: doc.data()["firstName"] as! String,
                                          lastName: doc.data()["lastName"] as! String,
                                          uid: doc.data()["uid"] as! String)))
                                    self.conversationsTableView.reloadData()
                                }
                            }
                        }

                        
                    }
                }
                 
            }

        }
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversationsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatcell") as! ConversationTableViewCell
        cell.userLabel.text = conversationsList[indexPath.row].otherParticipant.firstName + " " + conversationsList[indexPath.row].otherParticipant.lastName
        //cell.lastMessageLabel.text = conversationsList[indexPath.row].lastMessage
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        print("Kevin")
        
        return indexPath
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("hallo2")
        let conversation = conversationsList[indexPath.row]
        let conversationDocument = conversationsDocumentQuerySnapshots[indexPath.row]
        let user = conversation.otherParticipant
        let chatVC = ChatViewController(with: user, conversationDocument: conversationDocument)
        chatVC.title = "\(user.firstName) \(user.lastName)"
        navigationController?.pushViewController(chatVC, animated: true)
    }
    


}

