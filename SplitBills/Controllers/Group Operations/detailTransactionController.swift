//
//  detailTransactionController.swift
//  SplitBills
//
//  Created by RajaRajeshwari Gundu on 11/30/22.
//

import UIKit
import Firebase
class detailTransactionController: UIViewController {
    
    @IBAction func edit(_ sender: Any) {
        
        let edittransaction = self.storyboard?.instantiateViewController(withIdentifier: "EdittransactionController") as! EdittransactionController
        edittransaction.name = detailTransactionController.name
        edittransaction.amount = detailTransactionController.amount
        
        edittransaction.people = detailTransactionController.people
        edittransaction.group = detailTransactionController.group
        
        self.navigationController?.pushViewController(edittransaction, animated: true )
        
    }
    
    
    public static var name : String?
    public  static var amount : String?
    public  var stats : String?
    public  var paidbyname : String?
    
    public  static var people : String?
    public static var group : String?
    
   
    @IBOutlet weak var paidby: UILabel!
    @IBOutlet weak var status: UILabel!
    
    
    @IBOutlet weak var transactionName: UILabel!
    
    @IBOutlet weak var transactionamount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        transactionName.text = "Transaction: " + detailTransactionController.name!
        
        status.text = "Transaction Status: " + self.stats!
        
        let amount: Double? = Double(detailTransactionController.amount!)
        let amounts : Double? = round(amount!*1000)/1000.0
        transactionamount.text = "Amount: " +  String(amounts!)
        
        paidby.text = "Username: " + self.paidbyname!
       
    }

    
    @IBAction func Settleup(_ sender: UIButton) {
        
        let username =  UserDefaults.standard.string(forKey: "username")
       
        CreateGroupController.refrence1.child("Registered Users").child("User Info").child(username!).child("Groups").child(DetailedGroupController.groupname!).child("Transaction").child(detailTransactionController.name!).removeValue()
        
        
        // delete the members transactions
CreateGroupController.refrence1.child("Registered Users").child("User Info").child(username!).child("Groups").child(DetailedGroupController.groupname!).child("Members").queryOrderedByKey().observe(.value, with: { (snapshot) in
         
            if let snaps = snapshot.value as? NSDictionary
            {
                let postsIds = snaps.allKeys as! [String]
               for snap in postsIds
                {
                 
                   CreateGroupController.refrence1.child("Registered Users").child("User Info").child(snap).child("Groups").child(DetailedGroupController.groupname!).child("Transaction").child(detailTransactionController.name!).removeValue()
                                   
               }
            }
        })
    
        
        // delete activities
        CreateGroupController.refrence1.child("Registered Users").child("User Info").child(username!).child("Activities").child(detailTransactionController.name!).removeValue()
        
        // delete member activitites
        // user activities reflects in the members transactions
        CreateGroupController.refrence1.child("Registered Users").child("User Info").child(username!).child("Groups").child(DetailedGroupController.groupname!).child("Members").queryOrderedByKey().observe(.value, with: { (snapshot) in
         
            if let snaps = snapshot.value as? NSDictionary
            {
                let postsIds = snaps.allKeys as! [String]
               for snap in postsIds
                {
                   CreateGroupController.refrence1.child("Registered Users").child("User Info").child(snap).child("Activities").child(detailTransactionController.name!).removeValue()
                   print("user activity deleted")
                   
                   
               }
            }
        })
   
        
        self.navigationController?.popViewController(animated: true)
    }
    

}
