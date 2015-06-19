//
//  Login.swift
//  esale
//
//  Created by Marvin Manzi on 5/8/15.
//  Copyright (c) 2015 Marvin Manzi. All rights reserved.
//

import UIKit

class Login: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    @IBAction func login(sender: AnyObject) {
        
      /*  let userName = username.text;
        let userPassword = password.text;
        println(userName);
        println(userPassword);
        
        let loginUrl = NSURL(string: "http://kamagram.com/api/esale/auth/login.php");
        
        let request = NSMutableURLRequest(URL: loginUrl!);
        request.HTTPMethod = "POST";
        
        let postString = "userName=\(userName)&password=\(userPassword)";
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request){
            data, response, error in
            if error != nil{
                println("error=\(error)");
                return
            }
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: &err) as? NSDictionary
            if let parseJSON = json {
                var resultValue: String =  parseJSON["status"] as String!;
                var status: String = parseJSON["message"] as String!;
                println("result: \(status) : \(resultValue)");
                
                if (resultValue == "Success"){
                    //login is successfull
                    NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedIn");
                    NSUserDefaults.standardUserDefaults().synchronize();
                    
                    self.dismissViewControllerAnimated(true, completion: nil);
                }
            }
            
        }
        task.resume()
        */
        
        let userName = username.text;
        let userPassword = password.text;
        
        APIRequest(RestAPIManager.auth(userName, key: userPassword))
    }
    
    
    
    func APIRequest(json : AnyObject){
        //set request params
        let myUrl = NSURL(string: "https://mswitch.pivotaccess.com/esale/esalewebservice");
        let request = NSMutableURLRequest(URL:myUrl!);
        request.HTTPMethod = "POST";
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("iOS", forHTTPHeaderField: "User-Agent")
        
        // Compose a query string
        let requestJson = JSONStringify(json)
        println(json)
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
            if let result = json["rs"]["rm"].string {
                if (result == "SUCCESS"){
                    //login is successfull
                    NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedIn");
                    if let accountName = json["rs"]["rp"][0]["p1"].string{
                        println("account Name: \(accountName)")
                        NSUserDefaults.standardUserDefaults().setObject(accountName, forKey: "accountName")
                    }
                    if let accountBal = json["rs"]["rp"][0]["p4"].string{
                        println("account balance: \(accountBal)")
                        NSUserDefaults.standardUserDefaults().setObject(accountBal, forKey: "accountBalance") 
                    }
                    if let accountNo = json["rs"]["rp"][0]["p0"].string{
                        println("account Number: \(accountNo)")
                        NSUserDefaults.standardUserDefaults().setObject(accountNo, forKey: "accountNumber")
                    }
                    
                    
                    //NSUserDefaults.standardUserDefaults().synchronize();
                    
                    self.dismissViewControllerAnimated(true, completion: nil);
                }else{
                    
                    var myAlertView = UIAlertView()
                    myAlertView.title = "invalid login"
                    myAlertView.message = "Invalid Login, Please try again"
                    myAlertView.addButtonWithTitle("OK")
                    
                    myAlertView.show()

                    
                    
                }
            }
            
            
        }
        
        task.resume()
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

    
    
    
    
    func displayMessage( alertTitle : String, userMessage : String) {
        
        var alert = UIAlertController(title: alertTitle, message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:nil)
        
        alert.addAction(okAction)
        
        self.presentViewController(alert, animated: true) {
            // ...
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
