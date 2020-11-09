//
//  AvtarView.swift
//  vkClient
//
//  Created by MacBook Pro on 08.11.2020.
//

import UIKit

class AvtarView: UIImageView {
    
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
        layer.cornerRadius = 35
        //layer.masksToBounds = true // свойство закоментировано, но почему-то все работает. Почему?Ћ
    }
}
