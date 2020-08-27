//
//  BaseTableViewCell.swift
//  EuropeanCapitals
//
//  Created by Adrian Kaczmarek on 18/08/2020.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    private let bottomSeparatorView = UIView(frame: .zero)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupBottomSeparator()
        
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBottomSeparator() {
        contentView.addSubview(bottomSeparatorView)
        bottomSeparatorView.backgroundColor = AppStyling.colorSeparator

        bottomSeparatorView.translatesAutoresizingMaskIntoConstraints = false
        bottomSeparatorView.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 0.0).isActive = true
        bottomSeparatorView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0.0).isActive = true
        bottomSeparatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -0.5).isActive = true
        bottomSeparatorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }
}
