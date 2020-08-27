//
//  DetailsTableViewCell.swift
//  EuropeanCapitals
//
//  Created by Adrian Kaczmarek on 21/08/2020.
//

import UIKit

final class DetailsTableViewCell: BaseTableViewCell {
    private let leftLabel = UILabel()
    private let rightLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLeftLabel()
        setupRightLabel()
        
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLeftLabel() {
        contentView.addSubview(leftLabel)

        leftLabel.font = AppStyling.fontRegular(size: 16)
        leftLabel.textColor = AppStyling.colorLightGray
        rightLabel.textAlignment = .left

        leftLabel.translatesAutoresizingMaskIntoConstraints = false
        leftLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0.0).isActive = true
        leftLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10.0).isActive = true
        leftLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0.0).isActive = true
    }

    private func setupRightLabel() {
        contentView.addSubview(rightLabel)
        
        rightLabel.font = AppStyling.fontRegular(size: 16)
        rightLabel.textColor = AppStyling.colorDarkGray
        rightLabel.textAlignment = .right

        rightLabel.translatesAutoresizingMaskIntoConstraints = false
        rightLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0.0).isActive = true
        rightLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0.0).isActive = true
        rightLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10.0).isActive = true
        
        leftLabel.rightAnchor.constraint(equalTo: rightLabel.leftAnchor, constant: -10.0).isActive = true
        leftLabel.setContentHuggingPriority(.required, for: .horizontal)
    }
    
    func configureWith(leftText: String, rightText: String) {
        leftLabel.text = leftText
        rightLabel.text = rightText
    }
}
