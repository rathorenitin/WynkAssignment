//
//  String+Extension.swift
//  WynkAssignment
//
//  Created by Admin on 16/05/20.
//  Copyright © 2020 Nitin Singh Rathore. All rights reserved.
//

import UIKit

extension String {
    
    ///Removes leading and trailing white spaces from the string
    var byRemovingLeadingTrailingWhiteSpaces:String {
        
        let spaceSet = CharacterSet.whitespacesAndNewlines
        return self.trimmingCharacters(in: spaceSet)
    }

}
