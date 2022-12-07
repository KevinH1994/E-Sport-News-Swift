import UIKit
import MessageKit
import FirebaseAuth
import FirebaseCore
import Firebase
import FirebaseStorage
import InputBarAccessoryView

struct Message: MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}

struct Sender: SenderType {
    var senderId: String
    var displayName: String
}

class ChatViewController: MessagesViewController {
    
    
    @IBOutlet weak var chatTitle: UINavigationItem!
    var conversationDocument: QueryDocumentSnapshot? = nil
    var messages = [Message]()
    var currentUser: SenderType? = nil
    var otherUser: User? = nil
    var conversation: Any? = nil
    var messagesData: QuerySnapshot? = nil
    var firstId: String? = nil
    var secondId: String? = nil
    var firstVariant: QuerySnapshot? = nil
    var secondVariant: QuerySnapshot? = nil
    
    var noConversation: Bool = false
    
    let db  = Firestore.firestore()

    init(with otherUser: User?, conversationDocument: QueryDocumentSnapshot?){
        self.otherUser = otherUser
        self.conversationDocument = conversationDocument
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentUser = Sender(senderId: Auth.auth().currentUser!.uid, displayName: Auth.auth().currentUser!.email!)
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
        
        print(Auth.auth().currentUser!.email!)
        
        self.db.collection("Conversations").document(conversationDocument!.documentID).collection("Messages").addSnapshotListener { querysnapshot, error in
            if error == nil && querysnapshot != nil {
                
                
                print ("getMessages is called.")
                print("conversation Document ID: ")
                print ("\(self.conversationDocument!.documentID)")
                
                self.convertDocumentIntoMessageType(documentSnapshot: querysnapshot!)
        
            }
                
            
            else{
                print("Something went wrong...")
                print(error?.localizedDescription)
            }
        }
        
        getMessages()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        messageInputBar.inputTextView.becomeFirstResponder()
    }
    
    func getMessages(){
        

    }
    
    func convertDocumentIntoMessageType (documentSnapshot: QuerySnapshot){
        
        for document in documentSnapshot.documents {
            
            let sender  = document.data()["senderId"]
            let type =  document.data()["type"]
            let msgId =  document.data()["msgId"]
            let date =  document.data()["date"]
            let msg = document.data()["msg"]
            var senderType:Sender
            
            let results = messages.filter { $0.messageId == msgId as! String }
            let isEmpty = results.isEmpty
            
            if (isEmpty) {
            
                if sender as! String == currentUser!.senderId {
                    senderType = Sender(senderId: currentUser!.senderId, displayName: currentUser!.displayName)
                }
                else {
                    senderType = Sender(senderId: otherUser!.uid, displayName: "\(otherUser!.firstName) \(otherUser!.lastName)")
                }
        
                let message = Message(sender: senderType,
                                      messageId: msgId as! String,
                                      sentDate: (date as! Timestamp).dateValue(),
                                      kind: .text(msg as! String))
                
                
                self.messages.append(message)
            } else {
                
                continue
                
            }
        }
        self.messagesCollectionView.reloadData()
    }
    
    
    func createConversation(message: String, date: Date, sender: String ){
        
        let db  = Firestore.firestore()
        db.collection("Conversations").document(conversationDocument!.documentID).setData(["users" : [currentUser!.senderId, otherUser!.uid]])
        
        db.collection("Conversations").document(conversationDocument!.documentID).collection("Messages").addDocument(
                data: ["type": "text",
                       "msgId": (date.timeIntervalSince1970 * 1000).rounded().description,
                       "date": date,
                       "msg": message,
                       "senderId": sender]
            )
        
    }

    
}

extension ChatViewController: MessagesDataSource{
    var currentSender: SenderType {
        return currentUser!
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    
}


extension ChatViewController: MessagesDisplayDelegate{
}



extension ChatViewController: MessagesLayoutDelegate{
    
}

extension ChatViewController: InputBarAccessoryViewDelegate{
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
    
      let message = Message(
        sender: currentSender,
        messageId: (Date().timeIntervalSince1970 * 1000).rounded().description,
        sentDate: Date(),
        kind: .text(inputBar.inputTextView.text)
      )
    
        createConversation(message: inputBar.inputTextView.text, date: Date(), sender: currentSender.senderId)
    
        messages.append(message)
        messagesCollectionView.reloadData()
    
        inputBar.inputTextView.text = ""
        
    }
    
}
