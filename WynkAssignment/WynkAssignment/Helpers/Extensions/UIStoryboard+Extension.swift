//
//  UIStoryboard+Extension.swift
//  WynkAssignment
//
//  Created by Admin on 16/05/20.
//  Copyright © 2020 Nitin Singh Rathore. All rights reserved.
//

import UIKit


extension UIStoryboard {
    
    private static var storyboardName : String {
        return "Main"
    }
    
    static var instance : UIStoryboard {
        
        return UIStoryboard(name: storyboardName, bundle: Bundle.main)
    }
    
    func viewController<T : UIViewController>(_ viewControllerClass : T.Type,
                                              function : String = #function, // debugging purposes
        line : Int = #line,
        file : String = #file) -> T {
        
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        
        guard let scene = UIStoryboard.instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
            
            fatalError("ViewController with identifier \(storyboardID), not found in \(UIStoryboard.storyboardName) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
        }
        
        return scene
    }
    
}

