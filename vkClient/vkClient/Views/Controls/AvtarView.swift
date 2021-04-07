//
//  AvtarView.swift
//  vkClient
//
//  Created by MacBook Pro on 08.11.2020.
//

import UIKit

class AvtarView: UIImageView {
    

    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    

    // MARK: - Public Methods

    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    

    // MARK: - Private Methods

    private func setupLayout() {
        layer.borderWidth = 2
        layer.borderColor = ColorFlyWeight.basicAppColor.cgColor
        layer.cornerRadius = self.frame.size.height * 0.5
    }
}
