//
//  LEDMessageDataModel.swift
//  ControlLED
//
//  Created by Supapon Pucknavin on 10/5/2563 BE.
//  Copyright © 2563 Supapon Pucknavin. All rights reserved.
//

import UIKit

class LEDMessageDataModel {

    var r:CGFloat = 0
    var g:CGFloat = 0
    var b:CGFloat = 0
    
    func getDictionary()->[String:Any]{
        
        var myColor:[String:Any] = [String:Any]()
        
        myColor["r"] = self.r
        myColor["g"] = self.g
        myColor["b"] = self.b
        
        return myColor
    }
}
