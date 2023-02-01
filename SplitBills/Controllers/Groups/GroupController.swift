//
//  GroupController.swift
//  SplitBills
//
//  Created by RajaRajeshwari Gundu on 10/23/22.
//

import UIKit
import Firebase
import FirebaseDatabase
class GroupController: UIViewController
{

    
    @IBOutlet weak var GroupList: UITableView!
   
    public var balance: Double = 0.0
    var Grouparray = [Splitmodel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        CreateGroupController.refrence1 = Database.database().reference()
        self.getAllGroupNames()
        self.GroupList.reloadData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        balance = 0
       
        
    }
    
    
    func getAllGroupNames()
    {
        let username =  UserDefaults.standard.string(forKey: "username")
        CreateGroupController.refrence1.child("Registered Users").child("User Info").child(username!).child("Groups").queryOrderedByKey().observe(.value, with: { (snapshot) in
      self.Grouparray.removeAll()
            
            if let snaps = snapshot.value as? NSDictionary
            {
                let postsIds = snaps.allKeys as! [String]
               for snap in postsIds
                {
                   self.Grouparray.append(Splitmodel(groupname: snap))
                   print("name of group",snap)
                      self.GroupList.reloadData()
                   
               }
            }
        })
    }
    
    @IBAction func CreateGroup(_ sender: UIBarButtonItem) {
        let creategroup = self.storyboard?.instantiateViewController(withIdentifier: "CreateGroupController") as! CreateGroupController
        self.navigationController?.pushViewController(creategroup, animated: true )
    }
    
    
    

}
extension GroupController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Grouparray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsCell", for: indexPath) as! GroupsCell
        cell.groupName.text = Grouparray[indexPath.row].groupname
       // cell.overallbalance.text = String(balanceamounts!)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            let id = Grouparray[indexPath.row].groupname
            let username =  UserDefaults.standard.string(forKey: "username")
            
            
            // delete activities section
            CreateGroupController.refrence1.child("Registered Users").child("User Info").child(username!).child("Groups").child(Grouparray[indexPath.row].groupname!).child("Members").queryOrderedByKey().observe(.value, with: { (snapshot) in
         
                
                if let snaps = snapshot.value as? NSDictionary
                {
                    let postsIds = snaps.allKeys as! [String]
                   for snap in postsIds
                    {
                       
                    CreateGroupController.refrence1.child("Registered Users").child("User Info").child(snap).child("Activities").child(id!).removeValue()
                       
                
                       
                   }
                }
            })
            
            
            
            // delete groups in all members
            CreateGroupController.refrence1.child("Registered Users").child("User Info").child(username!).child("Groups").child(Grouparray[indexPath.row].groupname!).child("Members").queryOrderedByKey().observe(.value, with: { (snapshot) in
         
                
                if let snaps = snapshot.value as? NSDictionary
                {
                    let postsIds = snaps.allKeys as! [String]
                   for snap in postsIds
                    {
                       
                let ref = CreateGroupController.refrence1.child("Registered Users").child("User Info").child(snap).child("Groups").child(id!)
                                  ref.removeValue()
                       
                
                       
                   }
                }
            })
            
           
            
           
           
            CreateGroupController.refrence1.child("Registered Users").child("User Info").child(username!).child("Groups").child(Grouparray[indexPath.row].groupname!).removeValue()

            
            
            Grouparray.remove(at: indexPath.row)
            self.GroupList.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // push navigation segue code
        let detailedgroup = self.storyboard?.instantiateViewController(withIdentifier: "DetailedGroupController") as! DetailedGroupController
        DetailedGroupController.groupname = Grouparray[indexPath.row].groupname
        self.navigationController?.pushViewController(detailedgroup, animated: true )
    }

    
}
