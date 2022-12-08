//
//  SelectUserViewController.swift


import UIKit
import Firebase
import FirebaseStorage

struct User {
    var firstName: String
    var lastName: String
    var uid: String
}

class SelectUserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "userCell")
        
        var content = cell!.defaultContentConfiguration()
        content.text = "\(users[indexPath.row].firstName) \(users[indexPath.row].lastName)"
        
        cell!.contentConfiguration = content

        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("hallo123")
        let uiConfig = ATCChatUIConfiguration(primaryColor: UIColor(hexString: "#0084ff"),
                                                      secondaryColor: UIColor(hexString: "#f0f0f0"),
                                                      inputTextViewBgColor: UIColor(hexString: "#f4f4f6"),
                                                      inputTextViewTextColor: .black,
                                                      inputPlaceholderTextColor: UIColor(hexString: "#979797"))
        let user = users[indexPath.row]
        let channel = ATCChatChannel(id: user.uid , name: user.firstName)
        let viewer = ATCUser(firstName: user.firstName, lastName: user.lastName)
        let chatVC = ATCChatThreadViewController(user: viewer, channel: channel, uiConfig: uiConfig)
        self.navigationController?.pushViewController(chatVC, animated: true)
        
//        let chatVC = ChatViewController(with: user, conversationDocument: nil)
//        chatVC.title = "\(user.firstName) \(user.lastName)"
//        navigationController?.pushViewController(chatVC, animated: true)
    }
    

    @IBOutlet weak var usersTableView: UITableView!
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let db  = Firestore.firestore()
        db.collection("Users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                for document in querySnapshot!.documents {
                    
                    var user = User(
                        firstName: document.data()["firstName"] as! String,
                        lastName: document.data()["lastName"] as! String,
                        uid: document.data()["uid"] as! String
                        )
                    print("hallo")
                    if user.uid != Auth.auth().currentUser?.uid{
                        
                        self.users.append(user)
                    }
                }
                
                self.usersTableView.reloadData()
            }
        }
        
        usersTableView.dataSource = self
        usersTableView.delegate = self
    }
    

}
