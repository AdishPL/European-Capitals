//
//  UIImageView+Extensions.swift
//  EuropeanCapitals
//
//  Created by Adrian Kaczmarek on 18/08/2020.
//

import UIKit

extension UIImageView {
    func loadImage(withKey key: String) {
        if let cachedImage = ImageCache.shared.image(forKey: key) {
            self.image = cachedImage
            return
        }
        
        APIClient().request(
            target: .getImage(key: key),
            type: Image.self
        ) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self?.image = image.image
                    
                    ImageCache.shared.save(image: image.image, forKey: key)
                    
                case .failure(_):
                    /// FIXME: add placeholder image in case of error
                    self?.image = UIImage()
                }
            }
        }
    }
}
