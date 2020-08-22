//
//  MoreInfoViewController.swift
//  EuropeanCapitals
//
//  Created by Adrian Kaczmarek on 21/08/2020.
//

import UIKit

final class MoreInfoViewController: NiblessViewController {
    private let scrollView: UIScrollView = UIScrollView()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.font = AppStyling.fontRegular(size: 16)
        label.textColor = AppStyling.colorDarkGray
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.text = info?.about
        return label
    }()
    
    let info: CityInfo?
    
    init(with cityInfo: CityInfo?) {
        info = cityInfo
        super.init()
    }
    
    override func loadView() {
      super.loadView()
        
        title = AppStrings.details
        view.backgroundColor = AppStyling.colorWhite
        
        setupCloseButton()
        setupScrollView()
        setupLabel()
    }
        
    private func setupCloseButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: AppStrings.close, style: .plain, target: self, action: #selector(close))
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    private func setupLabel() {
        scrollView.addSubview(infoLabel)

        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 8.0).isActive = true
        infoLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor,constant: 10.0).isActive = true
        infoLabel.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -10.0).isActive = true
        infoLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -20.0).isActive = true
    }
    
    @objc private func close() {
        dismiss(animated: true)
    }
}
