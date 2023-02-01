//
//  CreateGroupController.swift
//  SplitBills
//
//  Created by RajaRajeshwari Gundu on 10/23/22.
//

import UIKit
import FirebaseDatabase


class CreateGroupController: UIViewController {

    @IBOutlet weak var fgrfg: UITextField!
    public static var refrence1 = DatabaseReference.init()
    @IBOutlet weak var GroupName: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        CreateGroupController.refrence1 = Database.database().reference()

       
    }
    
    @IBAction func SaveGroup(_ sender: UIButton) {
      
        if(GroupName.text == "")
            
        {
            let alert = UIAlertController(title: "Alert", message:"Please add the group name", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        else
        {
            SaveGroup()
        }
        
    }
    func SaveGroup()
    {
        
       // CreateGroupController.refrence1.child("Groups").childByAutoId().setValue(GroupName.text)
        let object = [
            "GroupName": GroupName.text!
            
        ] as [String: Any]
        
            let username =  UserDefaults.standard.string(forKey: "username")
        CreateGroupController.refrence1.child("Registered Users").child("User Info").child(username!).child("Groups").child(GroupName.text!).setValue(GroupName.text!)
      
    
     
        
        self.navigationController?.popViewController(animated: true)
    }

    

    
    
}
