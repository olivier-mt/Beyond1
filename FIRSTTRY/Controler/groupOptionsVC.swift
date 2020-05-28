//
//  groupOptionsVC.swift
//  FIRSTTRY
//
//  Created by Olivier Mountou on 07/05/2020.
//  Copyright © 2020 Olivier Mountou MT. All rights reserved.
//

import UIKit
import Firebase
import SPAlert


class groupOptionsVC: UIViewController {

    
    @IBOutlet weak var groupImage: UIImageView!
    
    
    @IBOutlet weak var groupNameLabel: UILabel!
    
    
    @IBOutlet weak var notifButton: UIButton!
    
    
    
    var groupName = ""
    var groupID = ""
    var storageRef = Storage.storage()
    var theNotif = ""
    let user = Auth.auth().currentUser?.uid
    var Thelistener : ListenerRegistration?
    var buttonImage: UIImage?

    @IBOutlet weak var labelButton: UILabel!
    
    
    var db : Firestore!

    
    
    

    
                                        
                                        
                                        
                                        
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        if #available(iOS 13.0, *) {
               // Always adopt a light interface style.
               overrideUserInterfaceStyle = .light
           }
        
        
        // Do any additional setup after loading the view.
        db = Firestore.firestore()


        self.loadData()

        
        groupImage.layer.cornerRadius = groupImage.bounds.height / 2
              groupImage.clipsToBounds = true
        
        
        groupNameLabel.text = groupName
        
        
        notifButton.contentMode = .center
        notifButton.imageView?.contentMode = .scaleAspectFit
        notifButton.layer.cornerRadius = notifButton.bounds.height / 2
        
     
        
        
        

        
        let imagePath = storageRef.reference(withPath:"\(groupID)/resizes/profilImage_300x300.jpg")
         
        let image =  imagePath.getData(maxSize: 10 * 1024 * 1024) { (data, error) in
            if let error = error {
                print("Got an error fetching data : \(error.localizedDescription)")
                        return
                                          }
                    if let data = data {
                                              
                self.groupImage.image = UIImage(data: data)
    
        
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
    
    @IBAction func notifButtonTap(_ sender: Any) {
        

        
       
        
        if theNotif == "YES"{
            
            
            Messaging.messaging().unsubscribe(fromTopic: self.groupID) { err in
                if let err = err {
                    
                    SPAlert.present(message: "error")
                }
                
                else {
                    self.db.collection("FOLLOWING").document("\(self.user!)").collection("GROUP FOLLOWED").document("\(self.groupID)").setData([ "notif": "NO" ], merge: true)
                    
                  if #available(iOS 13.0, *) {
                    self.notifButton.backgroundColor = .systemBlue }
                                            else {   self.notifButton.backgroundColor = .blue   }
                    
                      print("unsubscribed from \(self.groupID) topic")
                }
                
                
            }
            
        }
        
        else {
            
        
            
            Messaging.messaging().subscribe(toTopic: self.groupID) { err in
                        if let err = err {
                            
                            SPAlert.present(message: "error")
                            
                        }
                        
                        else {
                            

                            
                            self.db.collection("FOLLOWING").document("\(self.user!)").collection("GROUP FOLLOWED").document("\(self.groupID)").setData([ "notif": "YES" ], merge: true)
                            
                           // SPAlert.present(message: "subscribe")
                            
                            
                            if #available(iOS 13.0, *) {
                    self.notifButton.backgroundColor = .systemGray5 }
                            else {   self.notifButton.backgroundColor = .lightGray   }
                            
                            
                              print("unsubscribed from \(self.groupID) topic")
                        }
                    }
            
            
            
        }
        
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    
    func buttonAspect(){
           
           if theNotif == "YES"{
               
               if #available(iOS 13.0, *) {
                   notifButton.backgroundColor = .systemGray5
                   
                self.buttonImage = UIImage(systemName:"bell.fill" )
                self.notifButton.setImage(buttonImage, for: .normal)
                notifButton.backgroundColor = .systemGray5

                
               } else {
                let image = UIImage(named:"iconBell")
                self.notifButton.setBackgroundImage(image, for: .normal)
                notifButton.backgroundColor = .lightGray

               }
               

            self.labelButton.text = "mute notifications"
          
              //  self.buttonImage = UIImage(systemName: "hear30" )
              //  self.notifButton.setImage(buttonImage, for: .normal)
                
               
                
                self.notifButton.tintColor = .black


            
            
           }
               
           else {
               
            
            self.labelButton.text = "activate notifications"

            
            if #available(iOS 13.0, *) {
                
                self.buttonImage = UIImage(systemName: "bell.slash.fill" )
                self.notifButton.setImage(buttonImage, for: .normal)
                notifButton.backgroundColor = .systemBlue

               

            } else {
                

                let image = UIImage(named:"iconBellSlash")
                self.notifButton.setBackgroundImage(image, for: .normal)
                notifButton.backgroundColor = .magenta

                
            }
            
                           
                           self.notifButton.tintColor = .black
            

           }
           
       }
    
    
    
    
    
    func loadData() {
        
        
        self.Thelistener =  db.collection("FOLLOWING").document("\(user!)").collection("GROUP FOLLOWED").document("\(self.groupID)").addSnapshotListener(includeMetadataChanges: true) { documentSnapshot, error in

            print("on est la")
            
           guard let document = documentSnapshot else {
                   print("Error fetching document: \(error!)")
                   return
                 }
                 guard let data = document.data() else {
                   print("Document data was empty.")
                   return
                 }
                 print("Current data: \(data)")
            
            self.theNotif = data["notif"] as! String
            
            self.buttonAspect()

            
            print("the notif \(self.theNotif)")
            
        }
    
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {

        self.Thelistener!.remove()
        
        print("listener removed")
    }
    
    
}
