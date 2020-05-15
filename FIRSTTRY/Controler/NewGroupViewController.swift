//
//  NewGroupViewController.swift
//  FIRSTTRY
//
//  Created by Olivier Mountou on 05/11/2019.
//  Copyright © 2019 Olivier Mountou MT. All rights reserved.
//

import UIKit
import Firebase
import SPAlert
import FirebaseStorage
import SVProgressHUD

extension UIViewController{
    
    func HideKeyboard(){
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func DismissKeyboard() {
        
        view.endEditing(true)
    }
    
}




class NewGroupViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var groupNameTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var cityLabel: UILabel!
    
    
    @IBOutlet weak var languageTextField: UITextField!
    
    @IBOutlet weak var creationButton: UIButton!
    
    @IBOutlet weak var groupPicture: UIImageView!
    
    @IBOutlet weak var tapToChangePicture: UIButton!
    
    var city = ""
    var db : Firestore!
    
    var imageString = ""
    
    var fromNGVC: Bool?
    
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Creat a new group"
       
        cityLabel.text = city
        
    descriptionTextView.delegate = self
    groupNameTextField.delegate = self
        
    descriptionTextView.text = "Describ the group purpose in few words"
    descriptionTextView.textColor = UIColor.lightGray
        
    self.HideKeyboard()
        
        db = Firestore.firestore()
        
        
        groupPicture.isUserInteractionEnabled = true
        groupPicture.layer.cornerRadius = groupPicture.bounds.height / 2
        groupPicture.clipsToBounds = true
        
     
        
        creationButton.layer.cornerRadius = 5
        creationButton.layer.borderWidth = 2
        creationButton.layer.borderColor = UIColor.lightGray.cgColor
        
    
    }
    
    
    @IBAction func changeImage(_ sender: Any) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
      
        
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
            
        }))
        
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil ))
        
        self.present(actionSheet, animated: true, completion: nil)
        
        
        
    }
    
    

    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.originalImage] as! UIImage
        
        groupPicture.image = image
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if descriptionTextView.textColor == UIColor.lightGray {
            descriptionTextView.text = nil
            descriptionTextView.textColor = UIColor.black
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if descriptionTextView.text.isEmpty {
                descriptionTextView.text = "Describ the group purpose in few words"
                descriptionTextView.textColor = UIColor.lightGray
            }
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            groupNameTextField.resignFirstResponder()
            return true
        }
        
        
        
        
    }
    
    @IBAction func languageChosenTextField(_ sender: Any) {
    }
    
    @IBAction func creatGroupTapped(_ sender: Any) {
        
        creationButton.isEnabled = false
        
        SVProgressHUD.show(withStatus: "Wait few seconds ... ")

        
         let descritption = descriptionTextView.text
        let name = groupNameTextField.text
        let language = languageTextField.text
        
        let newGroupRef = db.collection("GROUPS").document()
        let documentID = newGroupRef.documentID
   //     let image = "\(documentID)/profilImage.jpg"

       
        
        if name == "" ||
           descritption == "" ||
            language == ""
             { //let err = err
                print("Error adding document")
                SPAlert.present(message: "All field have to be fullfielded")
        } else {
            newGroupRef.setData([
                       "city" : city,
                       "description" : descritption as Any,
                       "language" : language as Any,
                       "name" : name as Any,
                       "documentID" : documentID,
                       
                   ])
            
            
            
            //send image
            
            
            if groupPicture == UIImage(named: "GIO"){
                

                
            SVProgressHUD.dismiss()
       // goToConvVC()
            self.navigationController?.popViewController(animated: true)
            SPAlert.present(title: "Your group is created!", preset: .done)

            print("Document added with ID: \(newGroupRef.documentID)")
            self.creationButton.isEnabled = true
                
                
            } else {
                
                
                let uploadRef = Storage.storage().reference().child("\(documentID)").child("profilImage.jpg")
                             
                             
                             guard let imageData = groupPicture.image?.jpegData(compressionQuality: 0.75) else {
                                 
                           return  }
                             
                           
                             let uploadMetadata = StorageMetadata.init()
                             uploadMetadata.contentType = "image/jpeg"
                             uploadRef.putData(imageData, metadata: uploadMetadata) {(downloadMetadata, error) in
                               

                               
                                 if let error = error {
                                     print("Oh noo got an error! \(error.localizedDescription)")
                                     return
                                 }
                              
                           
                               print("Put is completed and got this back \(String(describing: downloadMetadata))",
                               
                                
                               SVProgressHUD.dismiss()

                               )

                              //  self.goToConvVC()
                              self.navigationController?.popViewController(animated: true)
                                               SPAlert.present(title: "Your group is created!", preset: .done)

                                                         print("Document added with ID: \(newGroupRef.documentID)")
                                               self.creationButton.isEnabled = true
                
                
                
                
            }
            
            
            
            
            
           
                
                
               
              }
            
            
            
            
            
        
            
        }

        
        // send picture
        
        
        
        
        
    }
    
    
    func goToConvVC(){
        
        
        
         let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
         let newViewController = storyBoard.instantiateViewController(withIdentifier: "conversationVC") as! ConversationViewController
                 self.present(newViewController, animated: true, completion: nil)
        
        
        
        
        
    }
    
    
    
    
    func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        
        
            
            print("YEAH ITS TRUE")
            
            let groupsVC = segue.destination as! GroupSViewController
            groupsVC.fromNGVC = self.fromNGVC
            
        
        
        
        
    }
    
    
    

}




    
    /*// MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



