//
//  ConversationViewController.swift
//  FIRSTTRY
//
//  Created by Olivier Mountou on 13/10/2019.
//  Copyright © 2019 Olivier Mountou MT. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ConversationViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate {
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var ConvertationTableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    @IBOutlet weak var sendButton: UIButton!
    
    
    var finalGroup = ""
    
    var ref: DatabaseReference!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
       // self.ref?.child("conversation").child(finalGroup).childByAutoId().setValue("premier message")

        
        
         print("here Is the final group \(finalGroup)")
        
        tabBarController?.tabBar.isHidden = true
        
        messageTextField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped)  )
        
        ConvertationTableView.addGestureRecognizer(tapGesture)
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
    
    
    
    @IBAction func send(_ sender: Any) {
        
        
        messageTextField.endEditing(true)
        
        messageTextField.isEnabled = false
        sendButton.isEnabled = false
        
        let messagesDB = self.ref?.child("conversation").child(finalGroup)
        
        let messageDictionary = [  "MessageBody": messageTextField.text]
        
        messagesDB?.childByAutoId().setValue(messageDictionary){
            (error, reference) in
            
            if error != nil{
                print(error)
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
