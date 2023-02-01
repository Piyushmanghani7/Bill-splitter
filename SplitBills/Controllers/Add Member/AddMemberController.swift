//
//  AddMemberController.swift
//  SplitBills
//
//  Created by RajaRajeshwari Gundu on 10/28/22.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth


class AddMemberController: UIViewController {
    
    @IBOutlet weak var membertableview: UITableView!
    
    let userdefault = UserDefaults.standard
    var groupnaming : String?
    var Membersarray = [MembersStruct]()
  //  public static var people : Int? = 0
    public static var memberrefrence = DatabaseReference.init()
    var peoplearray = [MembersStruct]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AddMemberController.memberrefrence = Database.database().reference()
        
        self.membertableview.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.getpeople()
    }
    
    
    func getpeople()
    {
        CreateGroupController.refrence1.child("AppUsers").queryOrderedByKey().observe(.value) { (snapshot) in
            self.peoplearray.removeAll()
            
            
            if let snaps = snapshot.children.allObjects as? [DataSnapshot]
            {
               
                for snap in snaps
                {
                    if let mainDict = snap.value as? [String: Any]
                    {
                        let name = mainDict["firstname"] as? String
                        let mail = mainDict["email"] as? String
                        let uid = mainDict["uid"] as? String
                        
                       
       if(name != UserDefaults.standard.string(forKey: "username"))
                        {
                            self.peoplearray.append(MembersStruct(membername: name!, membermail: mail!, memberuid: uid!))
                        }
                        
                        self.membertableview.reloadData()
                        // print("name", snap.value(forKey: "firstname") as! String)
                        
                    }
                    
                    
                }
            }
        }
        
        
        
       
    }
    
}
extension AddMemberController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peoplearray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberTableViewCell", for: indexPath) as! MemberTableViewCell
        cell.memberName.text = peoplearray[indexPath.row].membername
        cell.memberEmail.text = peoplearray[indexPath.row].membermail
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let username =  UserDefaults.standard.string(forKey: "username")
       let useremail =  UserDefaults.standard.string(forKey: "useremail")
        
        let object = [
            "MemberName": peoplearray[indexPath.row].membername,
            "email": peoplearray[indexPath.row].membermail
            
        ] as [String: Any]
        
        // add member info
        let ref = CreateGroupController.refrence1.child("Registered Users").child("User Info").child(username!).child("Groups").child(groupnaming!).child("Members").child(peoplearray[indexPath.row].membername)
        
        ref.setValue(object)
        print("user info saved")
        
        
        
        // add the group on the other member app
        
        CreateGroupController.refrence1.child("Registered Users").child("User Info").child(username!).child("Groups").child(DetailedGroupController.groupname!).child("Members").queryOrderedByKey().observe(.value, with: { [self] (snapshot) in
            
            if let snaps = snapshot.value as? NSDictionary
            {
                let postsIds = snaps.allKeys as! [String]
                for snap in postsIds
                {
                    
                    CreateGroupController.refrence1.child("Registered Users").child("User Info").child(snap).child("Groups").child(self.groupnaming!).setValue(self.groupnaming!)
                    
                    
                    
                }
            }
        })
        
        
       
        
        
        
        
        // add member info in the group of that member profile
        
        CreateGroupController.refrence1.child("Registered Users").child("User Info").child(username!).child("Groups").child(DetailedGroupController.groupname!).child("Members").queryOrderedByKey().observe(.value, with: { [self] (snapshot) in
            
            if let snaps = snapshot.value as? NSDictionary
            {
                let postsIds = snaps.allKeys as! [String]
                for snap in postsIds
                {
                    CreateGroupController.refrence1.child("Registered Users").child("User Info").child(username!).child("Groups").child(DetailedGroupController.groupname!).child("Members").queryOrderedByKey().observe(.value, with: { [self] (snapshot) in
                        
                        if let snaps2 = snapshot.value as? NSDictionary
                        {
                            let postsIds2 = snaps2.allKeys as! [String]
                            for snap2 in postsIds2
                            {
                                
                                CreateGroupController.refrence1.child("Registered Users").child("User Info").child(snap).child("Groups").child(groupnaming!).child("Members").child(snap2).setValue(object)
                                
                                
                                print("user other mem saved")
                                
                            }
                            
                            
                            
                        }
                    }
                                  
                    )
                    
                }
            }})
        
        
        CreateGroupController.refrence1.child("Registered Users").child("User Info").child(username!).child("Groups").child(DetailedGroupController.groupname!).child("Members").queryOrderedByKey().observe(.value, with: { [self] (snapshot) in
            
            if let snaps = snapshot.value as? NSDictionary
            {
                let postsIds = snaps.allKeys as! [String]
                for snap in postsIds
                {
                    
                    let object2 = [
                        "MemberName": username!,
                        "email": useremail!
                        
                    ] as [String: Any]
                    // add admin in the members group member
                    CreateGroupController.refrence1.child("Registered Users").child("User Info").child(snap).child("Groups").child(self.groupnaming!).child("Members").child(username!).setValue(object2)
                    
                    
                }
            }
        })
        
        
        // remove when user add the member in group
        self.peoplearray.remove(at: indexPath.row)
        
        self.navigationController?.popViewController(animated: true)
    }
    
}
  
