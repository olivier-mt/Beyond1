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
    

    @IBOutlet weak var tableView: UITableView!
    var scheduleIDarray = [fGroup]()
    var db: Firestore!
    var selectedGroupID = ""
    
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
         
            return scheduleIDarray.count
            
        }
        
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "fCell", for: indexPath) as! fCell
            
            let schedule = scheduleIDarray[indexPath.row]
            
            cell.name?.text = "\(schedule.name)"
            cell.id?.text = "\(schedule.documentID)"
            
            print("Array is populated \(scheduleIDarray)")
            
            return cell
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedGroupID = "\(scheduleIDarray[indexPath.row].documentID)"
       
        performSegue(withIdentifier: "fToConvers", sender: Any?.self)
        
        print("selected groupe \(self.selectedGroupID)")
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            let vc = segue.destination as! ConversationViewController
        
            vc.finalGroup = self.selectedGroupID
     
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



