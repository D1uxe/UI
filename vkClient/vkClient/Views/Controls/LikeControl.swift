//
//  LikeControl.swift
//  vkClient
//
//  Created by MacBook Pro on 06.11.2020.
//

import UIKit

class LikeControl: UIControl {
    
    // MARK: - Public Properties

    // MARK: - Private Properties

    private let imageView = UIImageView()
    private let counterLabel = UILabel()

    private var isLike: Bool = false
    private var likeCounter: Int = 0
    

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupImageView()
    }
    

    // MARK: - Public Methods

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }

    // MARK: - Private Methods

    private func setupImageView() {
        
        addSubview(imageView)

        imageView.image = UIImage(systemName: "heart")
        imageView.tintColor = #colorLiteral(red: 0.2887516618, green: 0.5174338222, blue: 0.7922994494, alpha: 1)

        addTarget(self, action: #selector(tapControl), for: .touchUpInside)

        setupLabel()
    }

    private func setupLabel() {
        
        addSubview(counterLabel)

        counterLabel.textColor = #colorLiteral(red: 0.2887516618, green: 0.5174338222, blue: 0.7922994494, alpha: 1)
        counterLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([counterLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -5),
                                     counterLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
        ])

        updateCounterLabel()
    }

    private func updateCounterLabel() {
        var str: String = ""

        switch likeCounter {
        case 0 ... 999:
            str = String(likeCounter)
        case 1000 ..< 1_000_000:
            str = String(likeCounter / 1000) + "k"
        default:
            str = "-"
        }

        UIView.transition(with: counterLabel,
                          duration: 0.3,
                          options: .transitionFlipFromBottom,
                          animations: { [unowned self] in
                              self.counterLabel.text = str
                          })
        counterLabel.textColor = isLike ? #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1) : #colorLiteral(red: 0.2536475658, green: 0.4901949167, blue: 0.8384085298, alpha: 1)
    }

    @objc private func tapControl() {

        isLike.toggle()
        if isLike {
            imageView.image = UIImage(systemName: "heart.fill")
            imageView.tintColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            likeCounter += 1
            updateCounterLabel()
        } else {
            imageView.image = UIImage(systemName: "heart")
            imageView.tintColor = #colorLiteral(red: 0.2887516618, green: 0.5174338222, blue: 0.7922994494, alpha: 1)
            likeCounter -= 1
            updateCounterLabel()
        }
    }
}
