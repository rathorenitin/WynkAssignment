//
//  UIViewController+Extension.swift
//  WynkAssignment
//
//  Created by Admin on 16/05/20.
//  Copyright © 2020 Nitin Singh Rathore. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static func instantiate() -> Self {
        
        return UIStoryboard.instance.viewController(self)
    }
    
    func initialViewController() -> UIViewController? {
        
        return UIStoryboard.instance.instantiateInitialViewController()
    }

    
    class var storyboardID : String {
        return "\(self)"
    }
    
    func showAlert(with title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
