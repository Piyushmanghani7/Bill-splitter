//
//  ActivityController.swift
//  SplitBills
//
//  Created by RajaRajeshwari Gundu on 10/23/22.
//

import UIKit
import Firebase

class ActivityController: UIViewController {

    @IBOutlet weak var Activitytableview: UITableView!
    
    var TransactionArray = [ActivityStruct]()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.getActivities()
        self.Activitytableview.reloadData()
    }
    
  func  getActivities()
    {
        let username =  UserDefaults.standard.string(forKey: "username")
        CreateGroupController.refrence1.child("Registered Users").child("User Info").child(username!).child("Activities").queryOrderedByKey().observe(.value) { (snapshot) in
            self.TransactionArray.removeAll()
            
            if let snaps = snapshot.children.allObjects as? [DataSnapshot]
            {
                for snap in snaps
                {
                    if let mainDict = snap.value as? [String: Any]
                    {
                        let ExpenseGroup = mainDict["ExpenseGroup"] as? String
                        let ExpenseName = mainDict["ExpenseName"] as? String
                        let ExpenseAmount = mainDict["ExpenseAmount"] as? String
                        let Expensestats = mainDict["ExpenseStatus"] as? String
                      
                        self.TransactionArray.append(ActivityStruct(TransactionGroup: ExpenseGroup!, TransactionName: ExpenseName!, TransactionAmount: ExpenseAmount!, TransactionStats: Expensestats!))
                        self.Activitytableview.reloadData()
                        // print("name", snap.value(forKey: "firstname") as! String)
                        
                    }
                    
                    
                }
            }
        }
        
        
        
       
    }



}
extension ActivityController : UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if (TransactionArray.count > 0)
        {
            tableView.separatorStyle = .singleLine
            numOfSections            = 1
            tableView.backgroundView = nil
        }
        else
        {
            let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = "No data available"
            noDataLabel.textColor     = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
        }
        return numOfSections
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return TransactionArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath) as! ActivityCell
        
        cell.Activitytype.text = TransactionArray[indexPath.row].TransactionGroup
        cell.name.text = TransactionArray[indexPath.row].TransactionName
        
        let amount: Double? = Double(TransactionArray[indexPath.row].TransactionAmount)
        let amounts : Double? = round(amount!*1000)/1000.0
        cell.amount.text = "$" + String(amounts!)
        
cell.status.text = TransactionArray[indexPath.row].TransactionStats
        
        if(TransactionArray[indexPath.row].TransactionStats == "You lent")
        {
            cell.status.textColor = UIColor.green
        }
        else
        {
            cell.status.textColor = UIColor.red
        }
        
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
   
    
}
