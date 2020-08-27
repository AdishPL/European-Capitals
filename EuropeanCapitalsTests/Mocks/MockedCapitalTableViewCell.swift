//
//  MockedCapitalTableViewCell.swift
//  EuropeanCapitalsTests
//
//  Created by Adrian Kaczmarek on 25/08/2020.
//

import Foundation
@testable import EuropeanCapitals

class MockedCapitalTableViewCell: CapitalTableViewCell {
    var onConfigureCallback: ((Capital) -> Void)?
    
    override func configure(with capital: Capital) {
        super.configure(with: capital)
        onConfigureCallback?(capital)
    }
}
