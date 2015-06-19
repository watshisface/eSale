//
//  insertReport.swift
//  esale2
//
//  Created by Marvin Manzi on 5/27/15.
//  Copyright (c) 2015 Marvin Manzi. All rights reserved.
//

import UIKit
import CoreData

class insertReport: UIViewController {
    @IBOutlet weak var number: UITextField!

    @IBOutlet weak var amount: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func buy(sender: AnyObject) {
        
        var appDel = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context : NSManagedObjectContext = appDel.managedObjectContext!
        
        var newUser = NSEntityDescription.insertNewObjectForEntityForName("Reports", inManagedObjectContext: context) as! NSManagedObject
        newUser.setValue(number.text, forKey: "receiver")
        newUser.setValue(amount.text, forKey: "amount")
        newUser.setValue("Mtn", forKey: "icon")
        //newUser.setValue(amount.text, forKey: "amount")
        
        context.save(nil)
        println(newUser)
        println("object saved")
    }
}
