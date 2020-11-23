//
//  ScaledHeightImageView.swift
//  vkClient
//
//  Created by MacBook Pro on 17.11.2020.
//  Класс для расчета высоты картинки в новостях

import UIKit

class ScaledHeightImageView: UIImageView {

    override var intrinsicContentSize: CGSize {
        get {
            if let myImage = self.image {
                let myImageWidth = myImage.size.width
                let myImageHeight = myImage.size.height
                let myViewWidth = self.bounds.size.width
                
                let ratio = myViewWidth / myImageWidth
                let scaledHeigh = ceil(myImageHeight * ratio)
                
                return CGSize(width: myViewWidth, height: scaledHeigh)
            }
            return CGSize(width: -1.0, height: -1.0)
        }
        
    }

}
