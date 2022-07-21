//
//  CustomContentView.swift
//  Practice
//
//  Created by Harry Yan on 20/07/22.
//

import UIKit

class CustomContentView: UIView, UIContentView {
    
    var configuration: UIContentConfiguration {
        didSet {
            self.configure(configuration: configuration)
        }
    }
    
    let label = UILabel()
    
    init(_ configuration: UIContentConfiguration) {
        self.configuration = configuration
        
        super.init(frame:.zero)
        
        self.addSubview(self.label)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
        ])
        
        self.configure(configuration: configuration)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(configuration: UIContentConfiguration) {
        guard let configuration = configuration as? CustomContentConfig else { return }
        
        self.label.text = configuration.text
    }
}
