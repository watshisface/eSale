//
//  ViewController.swift
//  TableDemo
//
//  Created by Simon Allardice on 10/13/14.
//  Copyright (c) 2014 Simon Allardice. All rights reserved.
//

import UIKit
import CoreData

class ReportsViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var accountBal: UILabel!
    @IBOutlet weak var accountName: UILabel!

    @IBOutlet weak var accountNumber: UILabel!
    @IBOutlet weak var reportTable: UITableView!
        var result: [ReportRecord] = []

    @IBAction func sync(sender: AnyObject) {
        
        result = fetch() as [ReportRecord]
        reportTable.reloadData()
        self.refreshControl.endRefreshing()
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! reportCell


        let user = result[indexPath.row]
        cell.receiver?.text=user.receiver
        cell.amount?.text = String(user.amount)
        cell.time?.text = String(user.time)
        println("id: \(user.objectID)")
        
        // Retrieve an image
        var icon : String = user.icon
        var myImage = UIImage(named: icon)
        cell.imageView?.image = myImage
        
        
        return cell
    }
    
    
    func dataOfJson(url: String) -> NSArray {
        var data = NSData(contentsOfURL: NSURL(string: url)!)
        return (NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as! NSArray)
    }
    
    var refreshControl:UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // result = fetch() as [ReportRecord]
     //   result = result.reverse();
     //   println("reports: \(result)")
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let name = defaults.stringForKey("accountName"){
            self.accountName.text="\(name) :"
            println(name)
        }
        if let balance = defaults.stringForKey("accountBalance"){
            self.accountBal.text=balance
            println(balance)
        }
        if let number = defaults.stringForKey("accountNumber"){
            self.accountNumber.text="(# \(number))"
            println(number)
        }
        
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Refreshing Reports")
        self.refreshControl.addTarget(self, action: "sync:", forControlEvents: UIControlEvents.ValueChanged)
        self.reportTable.addSubview(refreshControl)
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        println("viewWillAppear")
        result = fetch() as [ReportRecord]
        reportTable.reloadData()
    }
    
    func fetch()->[ReportRecord]{
        var appDel = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context : NSManagedObjectContext = appDel.managedObjectContext!
        var request = NSFetchRequest(entityName: "Reports")
        request.returnsObjectsAsFaults = false
     //   request.sortDescriptors = NSSortDescriptor(key: "time", ascending: false)
        var results = context.executeFetchRequest(request, error: nil) as? [ReportRecord]
        println(results)
        return results!
    }


    
    
}

