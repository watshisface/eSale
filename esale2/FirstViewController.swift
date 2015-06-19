//
//  FirstViewController.swift
//  esale
//
//  Created by Marvin Manzi on 4/6/15.
//  Copyright (c) 2015 Marvin Manzi. All rights reserved.
//

import UIKit
import CoreData

class FirstViewController: UIViewController {
    
    @IBOutlet weak var accountNumber: UILabel!
    @IBOutlet weak var accountName: UILabel!
    @IBOutlet weak var accountBalance: UILabel!
    var receiver: String = ""
    var amount: Int = 0
    var DateInFormat:String = ""
    
    var receipt: String = ""
    var voucher: String = ""
    var customer: String = ""
    
   // var time: NSDateFormatter = NSDate()
    
    

    @IBAction func airtelAirtime(sender: AnyObject) {
        buy("Airtel Airtime", message: "Please enter the Tigo number and amount to Pay", type: "ARTA");
 
        
    }
    
    @IBAction func tigoAirtime(sender: AnyObject) {
        buy("Tigo Airtime", message: "Please enter the Tigo number and amount to Pay", type: "TGOA");
        
        
    }
    
    
    @IBAction func mtnAirtime(sender: AnyObject) {
        buy("MTN Airtime", message: "Please enter the MTN number and amount to Pay", type: "MTNA");
        
        
    }
    
    @IBAction func starTimes(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isUserLoggedIn");
        NSUserDefaults.standardUserDefaults().synchronize();
        
        self.performSegueWithIdentifier("login", sender: self);
        
    }
    
    
    @IBAction func cashPower(sender: AnyObject) {

        buy("Cash Power", message: "Please enter the Meter number and amount to Pay", type: "ELEC");
        
    }
    
    
    
    func buy( title: String, message: String, type: String ){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Number"
            textField.keyboardType = .NumberPad
        }
        
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Amount"
            textField.keyboardType = .NumberPad
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            // ...
        }
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
           
            var myAlertView = UIAlertView()
            if let textFields = alertController.textFields{
            let theTextFields = textFields as! [UITextField]
                
            //get customer ref and amount from alert
            self.receiver = theTextFields[0].text
            self.amount = theTextFields[1].text.toInt()!
                
            println(self.amount)
            // self.amount = self.amount.doubleValue()
            self.DateInFormat = self.sysDate() as String
            println(self.DateInFormat)
            println("time shoud have shown")
            
            self.validate()
                self.APIPayment(RestAPIManager.paymentConfirmation(type, cusomterref: self.receiver, amount: self.amount), type: type)
            
            }
            println("receipt: \(self.receipt)")
            myAlertView.title = type
            if (type == "ELEC"){
                myAlertView.message = "You have sent \(self.amount) to  \(self.customer): \(self.receiver). Your cash power Voucher: \(self.voucher) your reciept number is: \(self.receipt)"
                
            }else{
            myAlertView.message = "You have sent \(self.amount) to \(self.receiver) your reciept number is: \(self.receipt)"
            }
            myAlertView.addButtonWithTitle("OK")
            
            myAlertView.show()
            
        }
        alertController.addAction(OKAction)
        
        self.presentViewController(alertController, animated: true) {
            // ...
        }
        
    }
    
    
    
    //esale Payment through APi and store to core data
    func APIPayment(json : AnyObject, type: String){
        //set request params
        let myUrl = NSURL(string: "https://mswitch.pivotaccess.com/esale/esalewebservice");
        let request = NSMutableURLRequest(URL:myUrl!);
        request.HTTPMethod = "POST";
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("iOS", forHTTPHeaderField: "User-Agent")
        
        // Compose a query string
        let requestJson = JSONStringify(json)
        println("Json: \(json)")
        request.HTTPBody = requestJson.dataUsingEncoding(NSUTF8StringEncoding);
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil
            {
                println("error=\(error)")
                return
            }
            
            // You can print out response object
            println("response = \(response)")
            
            // Print out response body
            let responseString = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("responseString = \(responseString)")
            
            //Let's convert response sent from a server side script to a NSDictionary object:
            
            var err: NSError?
            let json = JSON(data: data)
            if let status = json["rs"]["rm"].string {
                if (status == "SUCCESS"){
                    if let newBalance = json["rs"]["rp"][0]["p19"].string{
                        NSUserDefaults.standardUserDefaults().setObject(newBalance, forKey: "accountBalance")
                    }
                    if let receipt = json["rs"]["rp"][0]["p14"].string{
                        self.receipt = receipt
                        
                    }
                    if let voucher = json["rs"]["rp"][0]["p16"].string{
                        self.voucher = voucher
                    }
                    if let customer = json["rs"]["rp"][0]["p3"].string{
                        self.customer = customer
                    }

                    var appDel = (UIApplication.sharedApplication().delegate as! AppDelegate)
                    var context : NSManagedObjectContext = appDel.managedObjectContext!
                    
                    var newReport = NSEntityDescription.insertNewObjectForEntityForName("Reports", inManagedObjectContext: context) as! NSManagedObject
                    newReport.setValue(self.receiver, forKey: "receiver")
                    newReport.setValue(self.amount, forKey: "amount")
                    newReport.setValue(self.DateInFormat, forKey: "time")
                    newReport.setValue(type, forKey: "icon")
                    var error: NSError?
                    context.save(&error)
                    println(newReport)
                    println("object saved \(self.receiver)\(self.amount) \(type)")
                }
            }
            
        }
        
        task.resume()
    }

    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //sysDate()
        let defaults = NSUserDefaults.standardUserDefaults()
        if let name = defaults.stringForKey("accountName"){
            self.accountName.text="\(name) :"
            println(name)
        }
        if let balance = defaults.stringForKey("accountBalance"){
            self.accountBalance.text=balance
            println(balance)
        }
        if let number = defaults.stringForKey("accountNumber"){
            self.accountNumber.text="(# \(number))"
            println(number)
        }

    }
    
    override func viewDidAppear(animated: Bool) {
        let isUserLoggedIn = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn");
        if(!isUserLoggedIn){
            self.performSegueWithIdentifier("login", sender: self);
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sysDate()-> String{
       /* let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitMonth | .CalendarUnitYear | .CalendarUnitDay, fromDate: date)
        let hour = components.hour
        let minutes = components.minute
        let month = components.month
        let year = components.year
        let day = components.day
        let sec = components.second
        
        println("\(day)/\(month)/\(year) \(hour):\(minutes):\(sec)")
*/
        
        var todaysDate:NSDate = NSDate()
        var dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
        DateInFormat = dateFormatter.stringFromDate(todaysDate)
        return DateInFormat
        
}
    
    
    func JSONStringify(value: AnyObject, prettyPrinted: Bool = false) -> String {
        var options = prettyPrinted ? NSJSONWritingOptions.PrettyPrinted : nil
        if NSJSONSerialization.isValidJSONObject(value) {
            if let data = NSJSONSerialization.dataWithJSONObject(value, options: options, error: nil) {
                if let string = NSString(data: data, encoding: NSUTF8StringEncoding) {
                    return string as String
                }
            }
        }
        return ""
    }
    
    //validate users entry
    func validate(){
        println("Validate the users Entry")
    }
    
    
    
    


}

