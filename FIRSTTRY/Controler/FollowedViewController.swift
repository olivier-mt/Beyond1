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


    var storageRef = Storage.storage()

    
    
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
            
            
            // GET IMAGE
            
            let imagePath = self.storageRef.reference(withPath:"\(schedule.documentID)/resizes/profilImage_150x150.jpg")
                                                
            imagePath.getData(maxSize: 10 * 1024 * 1024) { (data, error) in
                    
                if let error = error {
                                                        
                                                        
             print("Got an error fetching data : \(error.localizedDescription)")
                                                        
            cell.groupImage.image = UIImage(named: "GIO")
                                                        
                        return
                                }
                                                   
                if let data = data {
                                                        
                cell.groupImage.image = UIImage(data: data)
                                                        
                }
                
            }
                
                
            return cell
                
               
                
                
            
                
                
            }
        
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(125)
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

           
           searchGroup = scheduleIDarray.filter({
            
            var filterDescription = $0.description
            
            var filterName = $0.name
            
            
            return
            
           
                (filterDescription.range(of: searchText, options: [.diacriticInsensitive, .caseInsensitive]) != nil) ||
                (filterName.range(of: searchText, options: [.diacriticInsensitive, .caseInsensitive]) != nil)
        
            
        })
        

        
        
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



