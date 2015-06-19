//
//  placesCell.swift
//  timeline
//
//  Created by Marvin Manzi on 3/31/15.
//  Copyright (c) 2015 Marvin Manzi. All rights reserved.
//


import UIKit

class reportCell: UITableViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var receiver: UILabel!
    @IBOutlet weak var time: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setCell(receiver : String, amount : Int, time : String, icon : UIImage){
        self.amount.text = String(amount)
        self.receiver.text = String(receiver)
        self.time.text = time
        self.icon.image = icon
        
        
    }
    
    
}