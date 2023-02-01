//
//  ProfileController.swift
//  SplitBills
//
//  Created by RajaRajeshwari Gundu on 10/23/22.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
class ProfileController: UIViewController {

    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var usermail: UILabel!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        username.text = UserDefaults.standard.string(forKey: "username")
        usermail.text = UserDefaults.standard.string(forKey: "useremail")
        
    }
    
    
    @IBAction func signoutButoon(_ sender: Any) {
        do{
            try
                //Auth.auth().signOut()
            
            //remove the userdefault
            UserDefaults.standard.removeObject(forKey: "Userlogin")
   
            
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let LoginViewController = storyboard.instantiateViewController(identifier: "LoginViewController")
               (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(LoginViewController)
            
              }catch let error as NSError
              {
                  print(error.localizedDescription)
              }
        
        
    }
    @IBAction func DeleteAccount(_ sender: UIButton) {
    
        let alert = UIAlertController(title: "DELETE ACCOUNT", message:"Are you sure you want to delete your account", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { _ in
            
            do{
                try
                
                Auth.auth().signOut()
                let username =  UserDefaults.standard.string(forKey: "username")
                let ref = Database.database().reference().child("AppUsers").child(username!)
            ref.removeValue()
                
                let ref2 = Database.database().reference().child("Registered Users").child("User Info").child(username!)
            ref2.removeValue()
                    
            
            
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let LoginViewController = storyboard.instantiateViewController(identifier: "LoginViewController")
               (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(LoginViewController)
            
              }catch let error as NSError
              {
                  print(error.localizedDescription)
              }
            
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
