//
//  FollowedViewController.swift
//  FIRSTTRY
//
//  Created by Olivier Mountou on 21/09/2019.
//  Copyright © 2019 Olivier Mountou MT. All rights reserved.
//

import UIKit
import Firebase

class FollowedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    var scheduleIDarray = [fGroup]()
    var db: Firestore!
    var selectedGroupID = ""
    var groupName =  ""
    var searchGroup = [fGroup]()
    var searching = false
    var groupIdFollowed = [String]()
    var schedule : fGroup!
    
    var ref: DatabaseReference!
    var messageArray : [Message] = [Message]()
    var messageArray2 : [Message] = [Message]()


    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        loadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        db = Firestore.firestore()
        loadData()
        
        self.title = "My groups"
        
    }
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
           
           DismissKeyboard()
       }
    
    
    func loadData() {
        
        let user = Auth.auth().currentUser?.uid
        
        db.collection("FOLLOWING").document("\(user!)").collection("GROUP FOLLOWED").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("Cest chargé \(document.documentID) => \(document.data())")
                    
                    self.scheduleIDarray = querySnapshot!.documents.compactMap({fGroup(dictionary: $0.data())})
                    DispatchQueue.main.async {
                        
                        

                        
                        
                        self.tableView.reloadData()

                }
            }
                
                
                
                
 print("dans l'array \(self.scheduleIDarray)")
 self.tableView.reloadData()

        }
        }
        
       
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         
            if searching{
                
            return searchGroup.count
                
            }
                
            else{
                
                return scheduleIDarray.count

            }
            
        }
        
    
    
  
    
    
    
    
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
   
               let cell = tableView.dequeueReusableCell(withIdentifier: "fCell", for: indexPath) as! fCell
            
             
           
          
            
            
            if searching {
                
            
                    schedule = searchGroup[indexPath.row]
                           
         
                           
                      //     print("Array is populated \(scheduleIDarray)")
                
             
                
            }
            
            else {
                
               
                          schedule = scheduleIDarray[indexPath.row]
                    
                    
                         print("Array is populated \(scheduleIDarray)")
                
              
                
                
                
            }
            
            
            cell.name?.text = "\(schedule.name)"
            cell.id?.text = "\(schedule.documentID)"
            cell.describ?.text = "\(schedule.description)"
            cell.city?.text = "\(schedule.city)"
            cell.language?.text = "\(schedule.language)"
            
            
           groupIdFollowed.append("\(schedule.documentID)")
            
            
            for (index, element) in groupIdFollowed.enumerated() {
                           
                           
                           let messagesDB = self.ref?.child("conversation").child(element)
                                  
                             
                      messagesDB?.observe(.childAdded, with: { (snapshot) in
                              
                              let snapshotValue = snapshot.value as! Dictionary<String,Any>
                              
                              let text = snapshotValue["MessageBody"]!
                              
                              
                              
                              let message = Message()
                              
                              message.messageBody = text as! String
                              message.name =  snapshotValue["name"]! as! String
                              message.sender = snapshotValue["sender"]! as! String
                              message.createdAt = snapshotValue["createdAt"]! as! Int
                              
                              print("the timestamp is \(message.createdAt)")
                              
                              
                              
                             
                                       

                                         
                          })
                          
                                      
                           
                       
                           
                       }
            
            
            
            
            
           print("Appended array : \(groupIdFollowed)")
            
         
            return cell
            
            
        }
    
    
    
    func lastMessage(){
        
        for i in groupIdFollowed{
            
            
            let messagesDB = self.ref?.child("conversation").child(i)

            
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
                    
                   
                                                                                         
                                 
                             

                               
                })
                
            
            
        }
       
        
            
        
        
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedGroupID = "\(scheduleIDarray[indexPath.row].documentID)"
        self.groupName = "\(scheduleIDarray[indexPath.row].name)"
        performSegue(withIdentifier: "fToConvers", sender: Any?.self)
        
        print("selected groupe \(self.selectedGroupID)")
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            let vc = segue.destination as! ConversationViewController
        
            vc.finalGroup = self.selectedGroupID
            vc.groupName = self.groupName
     
    }
}

extension FollowedViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

           
           searchGroup = scheduleIDarray.filter({$0.name.localizedCaseInsensitiveContains(searchText)})
           

           if searchText == "" {
               searching = false

           }
           else {
               searching = true

           }
           
           tableView.reloadData()
           
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



