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
  
    
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var ConvertationTableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    @IBOutlet weak var sendButton: UIButton!
    
    
    var finalGroup = ""
    
    var ref: DatabaseReference!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ConvertationTableView.delegate = self
        ConvertationTableView.dataSource = self
        
        ref = Database.database().reference()
        
       // self.ref?.child("conversation").child(finalGroup).childByAutoId().setValue("premier message")

        
        
         print("here Is the final group \(finalGroup)")
        
        
        tabBarController?.tabBar.isHidden = true
        
        messageTextField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped)  )
        
        ConvertationTableView.addGestureRecognizer(tapGesture)
        
        ConvertationTableView.register(UINib(nibName: "CustomMessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        
        // scroll to the bottom 
        
        
        configureTableView()
        retrieveMessages()
        
    }
    
    
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
        
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
        
        
        
        let messageDictionary = ["MessageBody": messageTextField.text,"name": user ]
        
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
