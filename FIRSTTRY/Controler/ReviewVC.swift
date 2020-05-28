//
//  ReviewVC.swift
//  FIRSTTRY
//
//  Created by Olivier Mountou on 24/03/2020.
//  Copyright © 2020 Olivier Mountou MT. All rights reserved.
//

import UIKit
import Firebase
import SPAlert

class ReviewVC: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var Textview: UITextView!
    
    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        if #available(iOS 13.0, *) {
               // Always adopt a light interface style.
               overrideUserInterfaceStyle = .light
           }
        
        
        // Do any additional setup after loading the view.
        
        HideKeyboard()

        
        Textview.delegate = self
      
        Textview.text = "Feel free to write your message"
        
        Textview.textColor = UIColor.lightGray
        
        ref = Database.database().reference()

    }
    
    
    @IBAction func sendPress(_ sender: Any) {
        
        
        let messagesDB = self.ref?.child("Review")
             
             var user = Auth.auth().currentUser?.displayName
             
             var sender = Auth.auth().currentUser?.email
             
             
             let messageDictionary = ["MessageBody": Textview.text,"name": user, "sender": sender ]
             
             messagesDB?.childByAutoId().setValue(messageDictionary){
                 (error, reference) in
                 
                 if error != nil{
                     print("error")
                 } else {
                     print("message saved successfully")
                    SPAlert.present(message: "Message sent")
                    self.navigationController?.popViewController(animated: true)
                     }
                
      }
        
        
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
           
    if self.Textview.text != nil {
        self.Textview.text = nil
        self.Textview.textColor = UIColor.black
           }
           
           func textViewDidEndEditing(_ textView: UITextView) {
            if self.Textview.text.isEmpty {
                self.Textview.text = "Feel free to write your message"
                self.Textview.textColor = UIColor.lightGray
               }
           }
}
}
