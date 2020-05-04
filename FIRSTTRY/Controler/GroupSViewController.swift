//
//  GroupSViewController.swift
//  FIRSTTRY
//
//  Created by Olivier Mountou on 08/10/2019.
//  Copyright © 2019 Olivier Mountou MT. All rights reserved.
//

import UIKit
import Firebase

class GroupSViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var groupNavigationBar: UINavigationBar!
    @IBOutlet weak var groupTableView: UITableView!
    @IBOutlet weak var groupPicture: UIImageView!
    @IBOutlet weak var groupSmallView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var finalCity = ""
    var groupArray = [Group]()
    var db : Firestore!
    var selectedGroupID = ""
    var selectedGroupName = ""
    var selectedInfo = ""
    var selectedLanguage = ""
    var searchGroup = [Group]()
    var searching = false
    
    var storageRef = Storage.storage()

    
    var inCellGroupId = ""
    var inCellGroupName = ""
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        loadData()
    }
    
    
    
    
    override func viewDidLoad() {        super.viewDidLoad()
        
        let addButton = UIBarButtonItem(barButtonSystemItem:.add, target: self, action: #selector(tapButton) )
        self.navigationItem.rightBarButtonItem = addButton
        
        self.title = finalCity
        
        print(finalCity)

        groupTableView.dataSource = self
        groupTableView.delegate = self
        
        groupTableView.rowHeight = 400

        
        
        db = Firestore.firestore()
        
        
        
        
        
        loadData()
        
       
    }
    
    

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        DismissKeyboard()
    }
    
   
    func openNewConvVC() {
        
        let newConvVC = NewGroupViewController()
performSegue(withIdentifier: "toNewConvVC", sender: Any?.self)    }
    
    @objc func tapButton(){
        
        print("you tapped")
        openNewConvVC()
   }

    
    func loadData() {
        
        
    db.collection("GROUPS").whereField("city", isEqualTo: finalCity )
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("c'est chargé \(document.documentID) => \(document.data())")
                        
                        self.groupArray = querySnapshot!.documents.compactMap({Group(dictionary: $0.data())})
                        DispatchQueue.main.async {
                        
                            self.groupTableView.reloadData()

                        }
                    }
                    print(self.groupArray)
                    self.groupTableView.reloadData()
                }
               
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searching{
            
            return searchGroup.count
            
        }
        else {
            
            return groupArray.count

        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! groupTableViewCell
    
        
        
        if searching{
            
            let group = searchGroup[indexPath.row]
            
            
            let imagePath = self.storageRef.reference(withPath:"\(group.documentID)/resizes/profilImage_150x150.jpg")
                               
                               imagePath.getData(maxSize: 10 * 1024 * 1024) { (data, error) in
                                   if let error = error {
                                       print("Got an error fetching data : \(error.localizedDescription)")
                                       return
                                   }
                                   if let data = data {
                                       
                                       cell.groupImage.image = UIImage(data: data)
                                       
                                       //self.groupPicture.image =
                                   }
                     
                     
                     }
            
            
            
            
                           
                           cell.groupeNameLabel?.text = "\(group.name)"
                           cell.groupDescriptionLabel?.text = "\(group.description)"
                           cell.groupIDLabel?.text = "\(group.documentID)"
                           cell.languageLabel?.text = "\(group.language)"
                
            
            var inCellGroupId = group.documentID
            var inCellGroupName = group.name
            
        }
        else {
            
            
            let group = groupArray[indexPath.row]
            
            let imagePath = self.storageRef.reference(withPath:"\(group.documentID)/resizes/profilImage_150x150.jpg")
                      
                      imagePath.getData(maxSize: 10 * 1024 * 1024) { (data, error) in
                          if let error = error {
                              print("Got an error fetching data : \(error.localizedDescription)")
                              return
                          }
                          if let data = data {
                              
                              cell.groupImage.image = UIImage(data: data)
                              
                          }
            
            
            }
                 
                 cell.groupeNameLabel?.text = "\(group.name)"
                 cell.groupDescriptionLabel?.text = "\(group.description)"
                 cell.groupIDLabel?.text = "\(group.documentID)"
                 cell.languageLabel?.text = "\(group.language)"
            
         
          
         
            
            
            
            

            
            var inCellGroupId = group.documentID
            var inCellGroupName = group.name
            
        }
        
     
        
        return cell
    }
    
    
    
  
    
    
    
    @IBAction func clickToFollow(_ sender: Any) {
        
        
        let userUid = Auth.auth().currentUser?.uid
        let user = userUid!
        let groupId = "\(inCellGroupId)"
        let groupName = "\(inCellGroupName)"
        
        let followGroup = db
            .collection("USERS").document(user)
            .collection("groupFollowed").document(groupId)
        
        followGroup.setData(
            [ "documentID": groupId,
              "name": groupName
            ])
        
      
     
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedGroupID = "\(groupArray[indexPath.row].documentID)"
        self.selectedGroupName = "\(groupArray[indexPath.row].name)"
        self.selectedInfo = "\(groupArray[indexPath.row].description)"
        self.selectedLanguage = "\(groupArray[indexPath.row].language)"
        
       
        performSegue(withIdentifier: "toConversationControler", sender: Any?.self)
        
        print("selected groupe \(self.selectedGroupID)")
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
  
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        guard let identifier = segue.identifier else {
            assertionFailure("Segue had no idientifier")
            return
        }
        
        if identifier == "toConversationControler" {
            
            let vc = segue.destination as! ConversationViewController
            vc.finalGroup = self.selectedGroupID
            vc.groupName = self.selectedGroupName
            vc.city = self.finalCity
            vc.language = self.selectedLanguage
            vc.info = self.selectedInfo
        }
        
        else if identifier == "toNewConvVC" {
            
            let newConvVC = segue.destination as! NewGroupViewController
            newConvVC.city = self.finalCity
            
        }
        
        else {
            
             assertionFailure("Did not recognize storyboard identifier")
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

extension GroupSViewController: UISearchBarDelegate {

    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        
        searchGroup = groupArray.filter ({
                
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
        
        groupTableView.reloadData()
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
           
    searching = false
        searchBar.text = ""
        groupTableView.reloadData()
    
    }
    
    
   
}
