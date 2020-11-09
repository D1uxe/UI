//
//  ShadowView.swift
//  vkClient
//
//  Created by MacBook Pro on 08.11.2020.
//

import UIKit

@IBDesignable class ShadowView: UIView {

    //Mark: - Public Properties
    
    @IBInspectable var cornerRadius: CGFloat = 35 {
        didSet {
            self.updataeRadius()
        }
    }

    @IBInspectable var shadowRadius: CGFloat = 8 {
        didSet {
            self.updataeShadowRadius()
        }
    }

    @IBInspectable var shadowOffset: CGSize = .zero {
        didSet {
            self.updataeShadowOffset()
        }
    }

    @IBInspectable var shadowOpacity: Float = 1.0 {
        didSet {
            self.updataeShadowOpacity()
        }
    }

    @IBInspectable var shadowColor: UIColor = #colorLiteral(red: 0.8752961362, green: 0.7478128967, blue: 1, alpha: 1) {
        didSet {
            self.updataeShadowColor()
        }
    }
    
    
    //Mark: - Initializers
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
   
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//       // setupLayout()
//    }

    
//    //Mark: - Public Methods
   
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        setupLayout()
//    }
    
   
    //Mark: - Private Methods
    
    private func updataeRadius() {
        layer.cornerRadius = self.cornerRadius
    }


    private func updataeShadowColor() {
        layer.shadowColor = self.shadowColor.cgColor
    }


    private func updataeShadowRadius() {
        layer.shadowRadius = self.shadowRadius
    }

    private func updataeShadowOffset() {
        layer.shadowOffset = self.shadowOffset
    }

    private func updataeShadowOpacity() {
        layer.shadowOpacity = self.shadowOpacity
    }
    
    
//    private func setupLayout() {
//        layer.cornerRadius = 35
//        layer.shadowColor = #colorLiteral(red: 0.8752961362, green: 0.7478128967, blue: 1, alpha: 1).cgColor
//        layer.shadowRadius = 8
//        layer.shadowOffset = .zero
//        layer.shadowOpacity = 1.0
//    }
    

}
