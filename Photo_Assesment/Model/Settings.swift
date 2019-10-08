//
//  Settings.swift
//  Photo_Assesment
//
//  Created by EricM on 10/8/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import Foundation
import UIKit

class Setting{
    let name: String
    let color: UIColor
    
    private init(name: String, color: UIColor){
        self.name = name
        self.color = color

    }
    
    static let Colors = [Setting(name: "White" , color: .white),Setting(name: "Red" ,color: .red),Setting(name: "Blue" , color: .blue),Setting(name: "Yellow" , color: .yellow)]
    
}
