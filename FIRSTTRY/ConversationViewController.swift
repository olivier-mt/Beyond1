//
//  ConversationViewController.swift
//  FIRSTTRY
//
//  Created by Olivier Mountou on 13/10/2019.
//  Copyright © 2019 Olivier Mountou MT. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase


class ConversationViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var messageArray : [Message] = [Message]()
    var db : Firestore!

  
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var ConvertationTableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    
    
    var finalGroup = ""
    var groupName = ""
    
    
    
    var ref: DatabaseReference!
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ConvertationTableView.delegate = self
        ConvertationTableView.dataSource = self
        
        ref = Database.database().reference()
        db = Firestore.firestore()

        
        self.title = groupName

        
       // self.ref?.child("conversation").child(finalGroup).childByAutoId().setValue("premier message")
         print("here Is the final group \(finalGroup)")
         print("the groupe name is \(groupName)")
        
        
        tabBarController?.tabBar.isHidden = true
        
        messageTextField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped)  )
        
        ConvertationTableView.addGestureRecognizer(tapGesture)
        
        ConvertationTableView.register(UINib(nibName: "CustomMessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        
        // scroll to the bottom
        
        // Set up righ bar button
        let button1 = UIBarButtonItem(image: UIImage(named: "favorit"), style: .plain, target: self, action: #selector(tapButton)) // action:#selector(Class.MethodName) for swift 3
            self.navigationItem.rightBarButtonItem = button1
        
        
        configureTableView()
        retrieveMessages()
        
        
    }
    
    let user =  Auth.auth().currentUser?.uid
  
    
    
    @objc func tapButton (){
        
        
        print("you tapped \(finalGroup)")
        print("the user is \(user!)")
        
        let docRef = db.collection("FOLLOWING").document("\(user!)").collection("GROUP FOLLOWED").document("\(finalGroup)")
        
        // follow and unfollow
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
                docRef.delete() { err in
                    if let err = err {
                        print("Error removing document: \(err)")
                    } else {
                        print("Document successfully removed!")
                    }
                }
            }
                
            else {
                print("Document does not exist")
                docRef.setData([
                    "name": self.groupName,
                    "documentID": self.finalGroup,
                    ], merge: true
                ) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
                }
            }
        }
        
       
    }

    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
        
       let message = messageArray[indexPath.row]
        
        
    // CHANGE TEXT ACCORDING TO SENDER
        
        if message.sender == Auth.auth().currentUser?.email{
            
            cell.messageBubble.backgroundColor = UIColor(red:0.53, green:0.68, blue:0.94, alpha:1.0)
            cell.messageBody.textColor = UIColor.white
            cell.messageBody.backgroundColor = cell.messageBubble.backgroundColor
          
            print("\(message.sender) et \(Auth.auth().currentUser?.email)")
        } else {
            cell.messageBubble.backgroundColor = UIColor(red:0.94, green:0.94, blue:0.94, alpha:1.0)
            cell.messageBody.textColor = UIColor.black
            cell.messageBody.backgroundColor = cell.messageBubble.backgroundColor

            print("not the same sender \(message.sender)voila ")
        }
        
       cell.messageBody.text = messageArray[indexPath.row].messageBody
       cell.usernameLabel.text = messageArray[indexPath.row].name
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return messageArray.count
    }
    
    func configureTableView(){
    
        ConvertationTableView.rowHeight = UITableView.automaticDimension
        
        ConvertationTableView.estimatedRowHeight = 120.0
        ConvertationTableView.rowHeight = UITableView.automaticDimension
        
    }

    @objc func tableViewTapped() {

self.messageTextField.endEditing(true)
        
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.5){
     
    self.heightConstraint.constant = 308
        self.view.layoutIfNeeded()
            
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.5){
    
        self.heightConstraint.constant = 50
            self.view.layoutIfNeeded()
        }
        
        
 
    }
    
    func retrieveMessages(){
        
        let messagesDB = self.ref?.child("conversation").child(finalGroup)
        
        messagesDB?.observe(.childAdded, with: { (snapshot) in
            
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            
            let text = snapshotValue["MessageBody"]!
            
            let message = Message()
            message.messageBody = text
            message.name =  snapshotValue["name"]!
            message.sender = snapshotValue["sender"]!
            
            self.messageArray.append(message)
            
            self.configureTableView()
            self.ConvertationTableView.reloadData()
        })
        
    }
    
    
 
    
    @IBAction func send(_ sender: Any) {
        
        
        messageTextField.endEditing(true)
        
        messageTextField.isEnabled = false
        sendButton.isEnabled = false
        
        let messagesDB = self.ref?.child("conversation").child(finalGroup)
        
        var user = Auth.auth().currentUser?.displayName
        
        var sender = Auth.auth().currentUser?.email
        
        
        let messageDictionary = ["MessageBody": messageTextField.text,"name": user, "sender": sender ]
        
        messagesDB?.childByAutoId().setValue(messageDictionary){
            (error, reference) in
            
            if error != nil{
                print("error")
            } else {
                print("message saved successfully")
                
                self.messageTextField.isEnabled = true
                self.sendButton.isEnabled = true
                self.messageTextField.text = ""
            }
            
            
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
}
