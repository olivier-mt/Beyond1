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
import SPAlert


class ConversationViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var messageArray : [Message] = [Message]()
    var db : Firestore!

  
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var ConvertationTableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    
    
    var finalGroup = ""
    var groupName = ""
    var info = ""
    var language = ""
    var city = ""
    
    var fromNotif = ""
    
    
    var ref: DatabaseReference!
    
    
    
    //keyboard pb

  

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
        
        
        //keyboard
        
       NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
             NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
    
    
        // hide Time Label
        
        
        
        
        
        
        //let messageNumber = self.messageArray.count
               
        
        // Set up righ bar button
        let button1 = UIBarButtonItem(image: UIImage(named: "heart30"), style: .plain, target: self, action: #selector(tapButton)) // action:#selector(Class.MethodName) for swift 3
            self.navigationItem.rightBarButtonItem = button1
        
        
        configureTableView()
        retrieveMessages()
        
        
    }
    
    //keyboard
    
    @objc func keyboardWillShow(notification: NSNotification) {
          if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
              if self.view.frame.origin.y == 0 {
                  self.view.frame.origin.y -= keyboardSize.height
                
        

              }
          }
      }

      @objc func keyboardWillHide(notification: NSNotification) {
         if self.view.frame.origin.y != 0 {
              self.view.frame.origin.y = 0 
            
            
          }
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
                    }
                    else {
                        print("Document successfully removed!")
                        
                        Messaging.messaging().unsubscribe(fromTopic: self.finalGroup) { error in
                            print("unsubscribed from \(self.finalGroup) topic")
                                       }
                        SPAlert.present(message: "You removed this group to your favorit")                    }
                }
            }
                
            else {
                print("Document does not exist")
                
                //TOPIC subscription
                Messaging.messaging().subscribe(toTopic: self.finalGroup) { error in
                    print("Subscribed to \(self.finalGroup) topic")
                }
                
                
                
                docRef.setData([
                    "name": self.groupName,
                    "documentID": self.finalGroup,
                    "city" : self.city,
                    "description" : self.info,
                    "language" : self.language,
                    
                    ], merge: true
                ) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                        SPAlert.present(title: " group successfully saved as favorit!", preset: .done)
                    }
                }
            }
        }
        
       
    }

    
    override func viewDidAppear(_ animated: Bool) {
        
     // Scroll down when view open
        
        let numberOfSections = self.ConvertationTableView.numberOfSections
        
        let numberOfMessages = self.messageArray.count
        
        func numberOfMessageCheck(){
            
            if numberOfMessages < 1 {
                
            }
            else {
                
                let indexPath = IndexPath(row: numberOfMessages-1 , section: numberOfSections-1)
                self.ConvertationTableView.scrollToRow(at: indexPath, at: .middle, animated: false)}
            
        }
        
        numberOfMessageCheck()

        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
        
       let message = messageArray[indexPath.row]
        
        
    
        
        
        
        
        
    // CHANGE TEXT ACCORDING TO SENDER
        
        if message.sender == Auth.auth().currentUser?.email{
            
   
            
            
            
            
            cell.messageBubble.backgroundColor = UIColor(red:0.53, green:0.68, blue:0.94, alpha:1.0)
            cell.messageBody.textColor = UIColor.white
            cell.timeLabel.textColor = UIColor.white
            cell.messageBody.backgroundColor = cell.messageBubble.backgroundColor
            
            print("\(message.sender) et \(Auth.auth().currentUser?.email)")
        } else {
            cell.messageBubble.backgroundColor = UIColor(red:0.94, green:0.94, blue:0.94, alpha:1.0)
            cell.messageBody.textColor = UIColor.black
            cell.timeLabel.textColor = UIColor.black
            cell.messageBody.backgroundColor = cell.messageBubble.backgroundColor

            print("not the same sender \(message.sender)voila ")
            
        }
        
       
        let theTimeStamp = messageArray[indexPath.row].createdAt
        let doubleTime = Double(theTimeStamp)
        let myDate = Date(timeIntervalSince1970: doubleTime )
        let dateToShow = myDate.calenderTimeSinceNow()
        

        
        cell.messageBody.text = messageArray[indexPath.row].messageBody
        cell.usernameLabel.text = messageArray[indexPath.row].name
        cell.timeLabel.text = dateToShow
        
        
      
        
      //  print("\(dateToShow)")
        
        

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
     
    /*self.heightConstraint.constant = 350
        self.view.layoutIfNeeded()*/
            
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.5){
    
       /* self.heightConstraint.constant = 50
            self.view.layoutIfNeeded()*/
        }
        
 
    }
    
    func retrieveMessages(){
        
        let messagesDB = self.ref?.child("conversation").child(finalGroup)
        
        messagesDB?.observe(.childAdded, with: { (snapshot) in
            
            let snapshotValue = snapshot.value as! Dictionary<String,Any>
            
            let text = snapshotValue["MessageBody"]!
            
            
            
            let message = Message()
            
            message.messageBody = text as! String
            message.name =  snapshotValue["name"]! as! String
            message.sender = snapshotValue["sender"]! as! String
            message.createdAt = snapshotValue["createdAt"]! as! Int
            
            print("the timestamp is \(message.createdAt)")
            
            
            
            self.messageArray.append(message)
            
            self.configureTableView()
            self.ConvertationTableView.reloadData()
            
            // Scroll down when receive a message
                  
                      let numberOfSections = self.ConvertationTableView.numberOfSections
                                        
                                        let numberOfMessages = self.messageArray.count
                                 
                             let indexPath = IndexPath(row: numberOfMessages-1 , section: numberOfSections-1)
                                           self.ConvertationTableView.scrollToRow(at: indexPath, at: .middle, animated: false)
                      
                     

                       
        })
        
        
        

    }
    
    
 
    
    @IBAction func send(_ sender: Any) {
        
        
        messageTextField.endEditing(true)
        
        messageTextField.isEnabled = false
        sendButton.isEnabled = false
        
        let messagesDB = self.ref?.child("conversation").child(finalGroup)
        
        var user = Auth.auth().currentUser?.displayName
        
        var sender = Auth.auth().currentUser?.email
        
        let currentDate = Date()
        let timeInterval = currentDate.timeIntervalSince1970
        let timeInt = Int(timeInterval)
        
        
        let messageDictionary = ["MessageBody": messageTextField.text,"name": user, "sender": sender, "groupName": groupName as Any, "createdAt": timeInt as Any ]
        
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
            
     //Scroll down when you send a message
            
    
                
                let numberOfSections = self.ConvertationTableView.numberOfSections
                                  
                                  let numberOfMessages = self.messageArray.count
                           
                       let indexPath = IndexPath(row: numberOfMessages-1 , section: numberOfSections-1)
                                     self.ConvertationTableView.scrollToRow(at: indexPath, at: .middle, animated: true)
                
                
           
            
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


extension Date
{
    func calenderTimeSinceNow() -> String
    {
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self, to: Date())
        
        let years = components.year!
        let months = components.month!
        let days = components.day!
        let hours = components.hour!
        let minutes = components.minute!
        let seconds = components.second!
        
        if years > 0 {
            return years == 1 ? "1 year ago" : "\(years) years ago"
        } else if months > 0 {
            return months == 1 ? "1 month ago" : "\(months) months ago"
        } else if days >= 7 {
            let weeks = days / 7
            return weeks == 1 ? "1 week ago" : "\(weeks) weeks ago"
        } else if days > 0 {
            return days == 1 ? "1 day ago" : "\(days) days ago"
        } else if hours > 0 {
            return hours == 1 ? "1 hour ago" : "\(hours) hours ago"
        } else if minutes > 0 {
            return minutes == 1 ? "1 minute ago" : "\(minutes)min ago"
        } else {
            
            
            
            return seconds == 1 ? "1 second ago" : "\(seconds)s ago"
        }
    }
    
}
