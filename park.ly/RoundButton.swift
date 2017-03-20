//
//  RoundButton.swift
//  park.ly
//
//  Created by Terrell Robinson on 2/27/17.
//  Copyright © 2017 TKYO. All rights reserved.
//

import UIKit

class RoundButton: UIButton {

    override func awakeFromNib() {
        
        // Rounded Button
        
        self.layer.cornerRadius = self.frame.height / 2
        
        // Drop Shadow
        
        self.layer.shadowRadius = 6
        self.layer.shadowOffset = CGSize(width: 0, height: 8)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowColor = UIColor.black.cgColor
    }

}
