//
//  MymembersController.swift
//  SplitBills
//
//  Created by RajaRajeshwari Gundu on 12/3/22.


import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class MymembersController: UIViewController {

    @IBOutlet weak var groupmemberstableview: UITableView!
    
    var Membersarray = [MyMembersStruct]()
    
    public var groupname : String?
    
    let userdefault = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        getmymembers()
        
    }
   
    func getmymembers()
    {
        let username =  UserDefaults.standard.string(forKey: "username")
        
        
        CreateGroupController.refrence1.child("Registered Users").child("User Info").child(username!).child("Groups").child(groupname!).child("Members").queryOrderedByKey().observe(.value) { (snapshot) in
            self.Membersarray.removeAll()
            
            if let snaps = snapshot.children.allObjects as? [DataSnapshot]
            {
                for snap in snaps
                {
                    if let mainDict = snap.value as? [String: Any]
                    {
                        let name = mainDict["MemberName"] as? String
                        let mail = mainDict["email"] as? String
                       
                        self.Membersarray.append(MyMembersStruct(membername: name!, membermail: mail!))
            
                        self.groupmemberstableview.reloadData()
                      
                        
                    }
                    
                    
                }
            }
        }
        
        
        
        
    }
   
}
extension MymembersController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Membersarray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mymemberCell", for: indexPath) as! mymemberCell
        cell.membername.text = Membersarray[indexPath.row].membername
        cell.memberemial.text = Membersarray[indexPath.row].membermail
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
    }
    
}
  
