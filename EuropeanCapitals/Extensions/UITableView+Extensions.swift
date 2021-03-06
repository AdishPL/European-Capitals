//
//  UITableView.swift
//  EuropeanCapitals
//
//  Created by Adrian Kaczmarek on 18/08/2020.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) {
        self.register(T.self, forCellReuseIdentifier: String(describing: T.self))
    }
    
    func dequeueCell<T:UITableViewCell>(_: T.Type, forIndexPath indexPath:IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as! T
    }
}
