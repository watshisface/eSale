//
//  restAPIManager.swift
//  eSale
//
//  Created by Marvin Manzi on 6/11/15.
//  Copyright (c) 2015 Marvin Manzi. All rights reserved.
//

import Foundation

let accountReference: String = "00020000525986"
let deviceUID: String = "00020000525986-01"

class RestAPIManager {
    
    
    
    
    
    class func auth(ak : String, key: String)-> AnyObject{
        
        let json : AnyObject = [
            "rq": [
                "in": "esale-3rdparty-integrator",
                "iv": "1.2.0",
                "mt": "CL01",
                "mi": "b011b73b-d257-47f5-b6c1-db09d6dcb958",
                "ak": ak,
                "as": key,
                "ar": accountReference,
                "di": deviceUID,
                "it": "DEVICE_UID",
                "du": "00020000525986-01",
                "dt": "THIRD_PARTY_INTEGRATOR",
                "ul": "rw",
                "rp": [
                    [
                        "p0": "THIRD_PARTY_INTEGRATOR",
                        "p1": "00020000525986-01",
                        "p2": "DEVICE_UID",
                        "p3": "",
                        "p4": "",
                        "p5": "",
                        "p6": "",
                        "p7": "",
                        "p8": "",
                        "p9": "",
                        "p10": "",
                        "p11": "",
                        "p12": ""
                    ]
                ]
            ]
        ]
        
        
        return json
        
        
    }
    
    class func paymentConfirmation(type: String, cusomterref: String, amount: Int)-> AnyObject{
        
        
        let json: AnyObject = [
            "rq": [
                "in": "esale-3rdparty-integrator",
                "iv": "1.2.0",
                "mt": "PC06",
                "mi": "626518",
                "ak": "pmobile",
                "as": "6a80r3l",
                "ar": accountReference,
                "di": deviceUID,
                "it": "DEVICE_UID",
                "du": "00020000525986-01",
                "dt": "THIRD_PARTY_INTEGRATOR",
                "ul": "rw",
                "rp": [
                    [
                        "p0": type,
                        "p1": cusomterref,
                        "p2": "0788460106",
                        "p3": amount,
                        "p4": "0788460106"
                    ]
                ]
            ]
            
            
        ]
        
        return json
        
    }

    
    
    
    
    
}