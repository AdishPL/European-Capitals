//
//  ImageCache.swift
//  EuropeanCapitals
//
//  Created by Adrian Kaczmarek on 15/08/2020.
//

import UIKit

class ImageCache {
    private let cache = NSCache<NSString,UIImage>()
    private var observer: NSObjectProtocol?
    
    static let shared = ImageCache()
    
    init() {
        // make sure to purge cache on memory warning
        observer = NotificationCenter
            .default
            .addObserver(forName: UIApplication.didReceiveMemoryWarningNotification, object: nil, queue: nil) { [weak self] notification in
                self?.cache.removeAllObjects()
            }
    }
    
    deinit {
        observer = nil
    }
    
    func image(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    func save(image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}
