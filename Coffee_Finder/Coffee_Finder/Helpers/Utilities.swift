//
//  Utilities.swift
//  Coffee_Finder
//
//  Created by Steven Worrall on 6/8/20.
//  Copyright © 2020 Steven Worrall. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    var imageUrlString: String?
    func loadImageUsingUrlString(_ urlString: String) {
        let url = URL(string: urlString)
        imageUrlString = urlString
        image = nil

        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data!)
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
            }
        }.resume()
    }
}

extension UIViewController {
    func presentAlert(
        title: String,
        message: String,
        completion: ((UIAlertAction) -> Void)? = nil
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(
                title: "Okay",
                style: .default,
                handler: completion)
        )
        
        present(alert, animated: true, completion: nil)
    }
}
