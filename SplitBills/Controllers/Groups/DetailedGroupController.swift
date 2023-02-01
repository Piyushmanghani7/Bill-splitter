//
//  DetailedGroupController.swift
//  SplitBills
//
//  Created by RajaRajeshwari Gundu on 10/23/22.
//

import UIKit
import Firebase

class DetailedGroupController: UIViewController {
    
    @IBOutlet weak var youlent: UILabel!
    
    
    @IBOutlet weak var youowe: UILabel!
    
    @IBOutlet weak var balance: UILabel!
    
    @IBOutlet weak var groupName: UILabel!
    public static var groupname : String?
    
    @IBOutlet weak var transactionTableview: UITableView!
    
    var TransactionArray = [TransactionStruct]()
    @IBOutlet weak var numberofpeople: UILabel!
    public var counter : Int = 1
    public var balanceamount: Double = 0.0
    public var balancelent: Double = 0.0
    public var balanceowe: Double = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        balanceamount = 0
        balancelent = 0
        balanceowe = 0
        getalltransaction()
        self.youlent.text = "$ 0.0"
        self.youowe.text = "$ 0.0"
        self.balance.text = "$ 0.0"
        
        
        self.gettransaction()
        groupName.text = DetailedGroupController.groupname
        
        
        self.transactionTableview.reloadData()
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        
        
        
        counter = 1
        getnoofPeople()
        
        print(balanceamount,"sdvfdsv")
        
        
        self.transactionTableview.reloadData()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
        counter = 1
        getnoofPeople()
        
        
        self.transactionTableview.reloadData()
        
    }
    
    
    
    func getalltransaction()
    {
        let username =  UserDefaults.standard.string(forKey: "username")
        
        
        CreateGroupController.refrence1.child("Registered Users").child("User Info").child(username!).child("Groups").child(DetailedGroupController.groupname!).child("Transaction").queryOrderedByKey().observe(.value) { (snapshot) in
            
            if let snaps = snapshot.children.allObjects as? [DataSnapshot]
            {
                
                for snap in snaps
                {
                    if let mainDict = snap.value as? [String: Any]
                    {
                        if(mainDict.count>0)
                        {
                            let ExpenseAmount = mainDict["ExpenseAmount"] as? String
                            let ExpenseStatus = mainDict["ExpenseStatus"] as? String
                            
                            if(ExpenseStatus == "You lent")
                            {
                                self.balanceamount = self.balanceamount + Double(ExpenseAmount!)!
                                self.balancelent = self.balancelent + Double(ExpenseAmount!)!
                            }
                            else
                            {
                                self.balanceamount = self.balanceamount - Double(ExpenseAmount!)!
                                self.balanceowe = self.balanceowe + Double(ExpenseAmount!)!
                            }
//                            self.youlent.textColor = UIColor.green
//                            self.youowe.textColor = UIColor.red
//
                    let balancelentamount: Double? = Double(self.balancelent)
                    let balancelentamountamounts : Double? = round(balancelentamount!*1000)/1000.0
            self.youlent.text = "$" + String(balancelentamountamounts!)
                        
                            
                            let balanceoweamount: Double? = Double(self.balanceowe)
                            let balanceoweamounts : Double? = round(balanceoweamount!*1000)/1000.0
                            
            self.youowe.text = "$" + String(balanceoweamounts!)
                            
                            
                            
                            let balanceamount: Double? = Double(self.balanceamount)
                            let balanceamounts : Double? = round(balanceamount!*1000)/1000.0
                            
            self.balance.text = "$" + String(balanceamounts!)
                            
                            print(self.balanceamount,"efeuwExpenseAmount")
                            
                        }
                        else
                        {
                            
                            self.youlent.text = "0.0"
                            self.youowe.text = "0.0"
                            self.balance.text = "0.0"
                            
                            
                        }
                        
                    }
                    
                    
                    
                    
                    
                }
            }
        }
        
        
        
        
        
        
    }
    
    
    func getnoofPeople()
    {
        let username =  UserDefaults.standard.string(forKey: "username")
        
        
        CreateGroupController.refrence1.child("Registered Users").child("User Info").child(username!).child("Groups").child(DetailedGroupController.groupname!).child("Members").queryOrderedByKey().observe(.value) { (snapshot) in
            
            
            if let snaps = snapshot.children.allObjects as? [DataSnapshot]
            {
                for snap in snaps
                {
                    self.counter += 1
                    print("counter",self.counter)
                    
                }
                self.numberofpeople.text  = "\(self.counter )"
            }
        }
        
    }
    
    
    func gettransaction()
    {
        let username =  UserDefaults.standard.string(forKey: "username")
        
        
        CreateGroupController.refrence1.child("Registered Users").child("User Info").child(username!).child("Groups").child(DetailedGroupController.groupname!).child("Transaction").queryOrderedByKey().observe(.value) { (snapshot) in
            self.TransactionArray.removeAll()
            
            if let snaps = snapshot.children.allObjects as? [DataSnapshot]
            {
                for snap in snaps
                {
                    if let mainDict = snap.value as? [String: Any]
                    {
                        let ExpenseName = mainDict["ExpenseName"] as? String
                        let ExpenseAmount = mainDict["ExpenseAmount"] as? String
                        let Expensestatus = mainDict["ExpenseStatus"] as? String
                        
                        self.TransactionArray.append(TransactionStruct(TransactionName: ExpenseName!, TransactionAmount: ExpenseAmount!, Transactionstatus: Expensestatus!))
                        self.transactionTableview.reloadData()
                        // print("name", snap.value(forKey: "firstname") as! String)
                        
                    }
                    
                    
                }
            }
        }
        
        
        
        
    }
    
    
    
    
    @IBAction func AddPeople(_ sender: UIButton) {
        
        
        let AddPeople = self.storyboard?.instantiateViewController(withIdentifier: "AddMemberController") as! AddMemberController
        AddPeople.groupnaming = DetailedGroupController.groupname
        self.navigationController?.pushViewController(AddPeople, animated: true )
    }
    @IBAction func SettleUp(_ sender: UIButton) {
        let SettleUp = self.storyboard?.instantiateViewController(withIdentifier: "MymembersController") as! MymembersController
        SettleUp.groupname = DetailedGroupController.groupname
        self.navigationController?.pushViewController(SettleUp, animated: true )
    }
    
    
    @IBAction func AddExpenses(_ sender: UIButton) {
        if(self.counter > 1)
        {
            let AddExpenses = self.storyboard?.instantiateViewController(withIdentifier: "AddExpensesController") as! AddExpensesController
            AddExpensesController.group = DetailedGroupController.groupname
            AddExpensesController.people = self.numberofpeople.text
            
            self.navigationController?.pushViewController(AddExpenses, animated: true )
        }
        else
        {
            
            let alert = UIAlertController(title: "Alert", message:"Please First add the members in this group", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            
        }
        
    }
    
}
extension DetailedGroupController : UITableViewDelegate, UITableViewDataSource
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailedGroupCell", for: indexPath) as! DetailedGroupCell
        let amount: Double? = Double(TransactionArray[indexPath.row].TransactionAmount)
        let amounts : Double? = round(amount!*1000)/1000.0
        cell.expensesName.text = TransactionArray[indexPath.row].TransactionName
        cell.Amount.text = "$" + String(amounts!)
cell.statuslbl.text = TransactionArray[indexPath.row].Transactionstatus
        if(TransactionArray[indexPath.row].Transactionstatus == "You lent")
        {
            cell.statuslbl.textColor = UIColor.green
            
        }
        else
        {
            cell.statuslbl.textColor = UIColor.red
            
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let details = self.storyboard?.instantiateViewController(withIdentifier: "detailTransactionController") as! detailTransactionController
        detailTransactionController.name = TransactionArray[indexPath.row].TransactionName
        detailTransactionController.amount = TransactionArray[indexPath.row].TransactionAmount
        details.stats = TransactionArray[indexPath.row].Transactionstatus
        
        
        detailTransactionController.people = self.numberofpeople.text
        detailTransactionController.group = DetailedGroupController.groupname
        
        let username =  UserDefaults.standard.string(forKey: "username")
        
        details.paidbyname = username!
        
        
        
        self.navigationController?.pushViewController(details, animated: true )
    }
    
    
    
}


