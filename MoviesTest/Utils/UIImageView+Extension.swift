//
//  UIImage+Extension.swift
//  MoviesTest
//
//  Created by Camilo López on 5/16/19.
//  Copyright © 2019 Camilo López. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

extension UIImageView {
    
    func setImageAndCacheIt(withURL url: String) {
        if let imageUrl = URL(string: (url)) {
            self.af_setImage(withURL: imageUrl)
        }
    }
}
