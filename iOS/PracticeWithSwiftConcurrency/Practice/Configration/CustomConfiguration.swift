//
//  CustomConfiguration.swift
//  Practice
//
//  Created by Harry Yan on 20/07/22.
//

import UIKit

struct CustomContentConfig: UIContentConfiguration {
    var text = ""
    
    func makeContentView() -> UIView & UIContentView {
        CustomContentView(self)
    }
    
    func updated(for state: UIConfigurationState) -> CustomContentConfig {
        self
    }
}
