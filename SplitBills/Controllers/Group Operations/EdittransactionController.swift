//
//  EdittransactionController.swift
//  SplitBills
//
//  Created by RajaRajeshwari Gundu on 12/6/22.
//

import UIKit
import Firebase

class EdittransactionController: UIViewController {

    @IBOutlet weak var transactionname: UILabel!
    
    @IBOutlet weak var transactionamount: UITextField!
    var name : String?
    var amount : String?
    public var people : String?
    public var group : String?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        transactionname.text = name
        transactionamount.text = amount
        
    }
    
    
    @IBAction func splitequallysaved(_ sender: Any) {
        
        let amounttext = transactionamount.text!
        let amount = Double(amounttext)
        let nopeople = Double(people!)
        let lentamount : Double? = amount! - (amount!/nopeople!)
       
        let object = [
            "ExpenseName": transactionname.text!,
            "ExpenseAmount":  String(lentamount!),
            "ExpenseStatus" : "You lent"
            
        ] as [String: Any]
        
        let username =  UserDefaults.standard.string(forKey: "username")
        let ref = CreateGroupController.refrence1.child("Registered Users").child("User Info").child(username!).child("Groups").child(group!).child("Transaction").child(transactionname.text!)
        ref.setValue(object)
        print("user transactions saved")
        
        
        
        // reflects in the members transactions
        
        
        let object1 = [
            "ExpenseName": transactionname.text!,
            "ExpenseAmount":  String(amount! / nopeople!),
            "ExpenseStatus" : "You owe"
            
        ] as [String: Any]
        
            CreateGroupController.refrence1.child("Registered Users").child("User Info").child(username!).child("Groups").child(group!).child("Members").queryOrderedByKey().observe(.value, with: { (snapshot) in
             
                if let snaps = snapshot.value as? NSDictionary
                {
                    let postsIds = snaps.allKeys as! [String]
                   for snap in postsIds
                    {
                     
                       let ref = CreateGroupController.refrence1.child("Registered Users").child("User Info").child(snap).child("Groups").child(self.group!).child("Transaction").child(self.transactionname.text!)
                       ref.setValue(object1)
                       print("user transactions saved")
                   }
                }
            })
        
            
            
      
           
        
      
        // user activities reflects in the members transactions
      
        let object2 = [
            "ExpenseGroup":group!,
            "ExpenseName": transactionname.text!,
            "ExpenseAmount": String (amount!/nopeople!),
            "ExpenseStatus": "You owe"
            
            
        ] as [String: Any]
        
        CreateGroupController.refrence1.child("Registered Users").child("User Info").child(username!).child("Groups").child(group!).child("Members").queryOrderedByKey().observe(.value, with: { (snapshot) in
         
            if let snaps = snapshot.value as? NSDictionary
            {
                let postsIds = snaps.allKeys as! [String]
               for snap in postsIds
                {
                 
                   
                   let ref2 = CreateGroupController.refrence1.child("Registered Users").child("User Info").child(snap).child("Activities").child(self.transactionname.text!)
                   ref2.setValue(object2)
                   print("user activity saved")
                   
                   
               }
            }
        })
   
        
        // user activities
        let object3 = [
            "ExpenseGroup": group!,
            "ExpenseName": transactionname.text!,
        "ExpenseAmount": String(lentamount!),
            "ExpenseStatus": "You lent"
            
        ] as [String: Any]
        
        
    let ref3 = CreateGroupController.refrence1.child("Registered Users").child("User Info").child(username!).child("Activities").child(transactionname.text!)
        ref3.setValue(object3)
        print("user activity saved")
        
        
        let GroupController = self.storyboard?.instantiateViewController(withIdentifier: "GroupController") as! GroupController
     
        self.navigationController?.pushViewController(GroupController, animated: true )
        
        
    }
    @IBAction func onlypaysaved(_ sender: Any) {
        
        
        
        let object = [
            "ExpenseName": transactionname.text!,
            "ExpenseAmount":  "0",
            "ExpenseStatus" : "You owe"
            
        ] as [String: Any]
        
        let username =  UserDefaults.standard.string(forKey: "username")
        let ref = CreateGroupController.refrence1.child("Registered Users").child("User Info").child(username!).child("Groups").child(AddExpensesController.group!).child("Transaction").child(transactionname.text!)
        ref.setValue(object)
        print("user transactions saved")
        
        
        
        // reflects in the members transactions
        
        let amount: Double? = Double(transactionamount.text!)
        
        let nopeople = Double(people!)
        
        let oweamount : Double? = amount!/(nopeople!-1)
        
       
        let object1 = [
            "ExpenseName": transactionname.text!,
            "ExpenseAmount": String(oweamount!),
            "ExpenseStatus" : "You owe"
            
        ] as [String: Any]
        
            CreateGroupController.refrence1.child("Registered Users").child("User Info").child(username!).child("Groups").child(group!).child("Members").queryOrderedByKey().observe(.value, with: { (snapshot) in
             
                if let snaps = snapshot.value as? NSDictionary
                {
                    let postsIds = snaps.allKeys as! [String]
                   for snap in postsIds
                    {
                     
                       let ref = CreateGroupController.refrence1.child("Registered Users").child("User Info").child(snap).child("Groups").child(self.group!).child("Transaction").child(self.transactionname.text!)
                       ref.setValue(object1)
                       print("user transactions saved")
                   }
                }
            })
        
            
            
      
           
        
      
        // user activities reflects in the members transactions
      
      
        let object2 = [
            "ExpenseGroup":group!,
            "ExpenseName": transactionname.text!,
            "ExpenseAmount": String(oweamount!),
            "ExpenseStatus": "You owe"
            
            
        ] as [String: Any]
        
        CreateGroupController.refrence1.child("Registered Users").child("User Info").child(username!).child("Groups").child(AddExpensesController.group!).child("Members").queryOrderedByKey().observe(.value, with: { (snapshot) in
         
            if let snaps = snapshot.value as? NSDictionary
            {
                let postsIds = snaps.allKeys as! [String]
               for snap in postsIds
                {
                 
                   
                   let ref2 = CreateGroupController.refrence1.child("Registered Users").child("User Info").child(snap).child("Activities").child(self.transactionname.text!)
                   ref2.setValue(object2)
                   print("user activity saved")
                   
                   
               }
            }
        })
   
        
        // user activities
        let object3 = [
            "ExpenseGroup":group!,
            "ExpenseName": transactionname.text!,
            "ExpenseAmount": "0",
            "ExpenseStatus": "You owe"
            
        ] as [String: Any]
        
        
    let ref3 = CreateGroupController.refrence1.child("Registered Users").child("User Info").child(username!).child("Activities").child(transactionname.text!)
        ref3.setValue(object3)
        print("user activity saved")
        
        
        let GroupController = self.storyboard?.instantiateViewController(withIdentifier: "GroupController") as! GroupController
     
        self.navigationController?.pushViewController(GroupController, animated: true )
        
        
    }
    
    

}
