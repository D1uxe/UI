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
        layer.borderColor = #colorLiteral(red: 0.382525444, green: 0.6620827317, blue: 0.9676174521, alpha: 1).cgColor
        layer.cornerRadius = self.frame.size.height * 0.5
    }
}
