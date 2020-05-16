//
//  UIImageView+Extension.swift
//  WynkAssignment
//
//  Created by Admin on 16/05/20.
//  Copyright © 2020 Nitin Singh Rathore. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setImage(url:String, placeholderImage: UIImage){
        ImageDownloader.shared.downloadImage(with: url, completionHandler: {[weak self]  (image, cached) in
                self?.image = image
        }, placeholderImage: placeholderImage)
    }
}
