//
//  Device.swift
//  eSale
//
//  Created by Marvin Manzi on 6/8/15.
//  Copyright (c) 2015 Marvin Manzi. All rights reserved.
//

import UIKit

class Device: UIViewController {
    
    
    var name: String = UIDevice.currentDevice().name
    var systemname: String = UIDevice.currentDevice().systemName
    var systemversion: String = UIDevice.currentDevice().systemVersion
    var model: String = UIDevice.currentDevice().model
    var localizedModel: String = UIDevice.currentDevice().localizedModel
    var userinterfaceidiom: UIUserInterfaceIdiom = UIDevice.currentDevice().userInterfaceIdiom
    var identiferforvendor: NSUUID = UIDevice.currentDevice().identifierForVendor
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        println("Name: \(name)")
        println("System Name: \(systemname)")
        println("System Version: \(systemversion)")
        println("Model: \(model)")
        println("Localized Model: \(localizedModel)")
        println("User Interfaceidiom: \(userinterfaceidiom)")
        println("Identifer For Vendor: \(localizedModel)")

        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
