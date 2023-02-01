//
//  AddExpensesController.swift
//  SplitBills
//
//  Created by RajaRajeshwari Gundu on 10/23/22.
//

import UIKit
import Firebase

class AddExpensesController: UIViewController {

    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var expenseDescription: UITextField!
    
    public static var group : String?
    public static var people : String?
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func Splitequally(_ sender: Any) {
    
        let amounttext = amount.text!
        let amount = Double(amounttext)
        let nopeople = Double(AddExpensesController.people!)
        let lentamount : Double? = amount! - (amount!/nopeople!)
       
        let object = [
            "ExpenseName": expenseDescription.text!,
            "ExpenseAmount":  String(lentamount!),
            "ExpenseStatus" : "You lent"
            
        ] as [String: Any]
        
        let username =  UserDefaults.standard.string(forKey: "username")
        let ref = CreateGroupController.refrence1.child("Registered Users").child("User Info").child(username!).child("Groups").child(AddExpensesController.group!).child("Transaction").child(expenseDescription.text!)
        ref.setValue(object)
        print("user transactions saved")
        
        
        
        // reflects in the members transactions
        
        
        let object1 = [
            "ExpenseName": expenseDescription.text!,
            "ExpenseAmount":  String(amount! / nopeople!),
            "ExpenseStatus" : "You owe"
            
        ] as [String: Any]
        
            CreateGroupController.refrence1.child("Registered Users").child("User Info").child(username!).child("Groups").child(AddExpensesController.group!).child("Members").queryOrderedByKey().observe(.value, with: { (snapshot) in
             
                if let snaps = snapshot.value as? NSDictionary
                {
                    let postsIds = snaps.allKeys as! [String]
                   for snap in postsIds
                    {
                     
    let ref = CreateGroupController.refrence1.child("Registered Users").child("User Info").child(snap).child("Groups").child(AddExpensesController.group!).child("Transaction").child(self.expenseDescription.text!)
                       ref.setValue(object1)
                       print("user transactions saved")
                   }
                }
            })
        
            
            
      
           
        
      
        // user activities reflects in the members transactions
      
        let object2 = [
            "ExpenseGroup":AddExpensesController.group!,
            "ExpenseName": expenseDescription.text!,
            "ExpenseAmount": String (amount!/nopeople!),
            "ExpenseStatus": "You owe"
            
            
        ] as [String: Any]
        
        CreateGroupController.refrence1.child("Registered Users").child("User Info").child(username!).child("Groups").child(AddExpensesController.group!).child("Members").queryOrderedByKey().observe(.value, with: { (snapshot) in
         
            if let snaps = snapshot.value as? NSDictionary
            {
                let postsIds = snaps.allKeys as! [String]
               for snap in postsIds
                {
                 
                   
                   let ref2 = CreateGroupController.refrence1.child("Registered Users").child("User Info").child(snap).child("Activities").child(self.expenseDescription.text!)
                   ref2.setValue(object2)
                   print("user activity saved")
                   
                   
               }
            }
        })
   
        
        // user activities
        let object3 = [
            "ExpenseGroup":AddExpensesController.group!,
            "ExpenseName": expenseDescription.text!,
        "ExpenseAmount": String(lentamount!),
            "ExpenseStatus": "You lent"
            
        ] as [String: Any]
        
        
    let ref3 = CreateGroupController.refrence1.child("Registered Users").child("User Info").child(username!).child("Activities").child(expenseDescription.text!)
        ref3.setValue(object3)
        print("user activity saved")
        
        
        let GroupController = self.storyboard?.instantiateViewController(withIdentifier: "GroupController") as! GroupController
     
        self.navigationController?.pushViewController(GroupController, animated: true )
        
        
    }
    
    
    @IBAction func paidbymeonly(_ sender: UIButton)
    {
    
      
       
        let object = [
            "ExpenseName": expenseDescription.text!,
            "ExpenseAmount":  "0",
            "ExpenseStatus" : "You owe"
            
        ] as [String: Any]
        
        let username =  UserDefaults.standard.string(forKey: "username")
        let ref = CreateGroupController.refrence1.child("Registered Users").child("User Info").child(username!).child("Groups").child(AddExpensesController.group!).child("Transaction").child(expenseDescription.text!)
        ref.setValue(object)
        print("user transactions saved")
        
        
        
        // reflects in the members transactions
        
        let amount: Double? = Double(amount.text!)
        
        let nopeople = Double(AddExpensesController.people!)
        
        let oweamount : Double? = amount!/(nopeople!-1)
        
        
    
        
        let object1 = [
            "ExpenseName": expenseDescription.text!,
            "ExpenseAmount": String(oweamount!),
            "ExpenseStatus" : "You owe"
            
        ] as [String: Any]
        
            CreateGroupController.refrence1.child("Registered Users").child("User Info").child(username!).child("Groups").child(AddExpensesController.group!).child("Members").queryOrderedByKey().observe(.value, with: { (snapshot) in
             
                if let snaps = snapshot.value as? NSDictionary
                {
                    let postsIds = snaps.allKeys as! [String]
                   for snap in postsIds
                    {
                     
    let ref = CreateGroupController.refrence1.child("Registered Users").child("User Info").child(snap).child("Groups").child(AddExpensesController.group!).child("Transaction").child(self.expenseDescription.text!)
                       ref.setValue(object1)
                       print("user transactions saved")
                   }
                }
            })
        
            
            
      
           
        
      
        // user activities reflects in the members transactions
      
      
        let object2 = [
            "ExpenseGroup":AddExpensesController.group!,
            "ExpenseName": expenseDescription.text!,
            "ExpenseAmount": String(oweamount!),
            "ExpenseStatus": "You owe"
            
            
        ] as [String: Any]
        
        CreateGroupController.refrence1.child("Registered Users").child("User Info").child(username!).child("Groups").child(AddExpensesController.group!).child("Members").queryOrderedByKey().observe(.value, with: { (snapshot) in
         
            if let snaps = snapshot.value as? NSDictionary
            {
                let postsIds = snaps.allKeys as! [String]
               for snap in postsIds
                {
                 
                   
                   let ref2 = CreateGroupController.refrence1.child("Registered Users").child("User Info").child(snap).child("Activities").child(self.expenseDescription.text!)
                   ref2.setValue(object2)
                   print("user activity saved")
                   
                   
               }
            }
        })
   
        
        // user activities
        let object3 = [
            "ExpenseGroup":AddExpensesController.group!,
            "ExpenseName": expenseDescription.text!,
            "ExpenseAmount": "0",
            "ExpenseStatus": "You owe"
            
        ] as [String: Any]
        
        
    let ref3 = CreateGroupController.refrence1.child("Registered Users").child("User Info").child(username!).child("Activities").child(expenseDescription.text!)
        ref3.setValue(object3)
        print("user activity saved")
        
        
        let GroupController = self.storyboard?.instantiateViewController(withIdentifier: "GroupController") as! GroupController
     
        self.navigationController?.pushViewController(GroupController, animated: true )
        
        
    }
    
    
    
}
