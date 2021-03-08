//
//  LikeControl.swift
//  vkClient
//
//  Created by MacBook Pro on 06.11.2020.
//

import UIKit

class LikeControl: UIControl {
    
    
    // MARK: - Private Properties

    private let imageView = UIImageView()
    private let counterLabel = UILabel()

    private var isLike: Bool = false


    //MARK: - Public Properties

    var likeCounter: Float = 0 {
        didSet {
            updateCounterLabel()
        }
    }
    
    

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
        // imageView.frame = bounds
    }
    
    

    // MARK: - Private Methods

    private func setupImageView() {
        addSubview(imageView)

        imageView.image = UIImage(systemName: "heart")
        imageView.tintColor = #colorLiteral(red: 0.2887516618, green: 0.5174338222, blue: 0.7922994494, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([self.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -5),
                                     self.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
                                     self.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0),
                                     imageView.widthAnchor.constraint(equalToConstant: 25),
        ])

        addTarget(self, action: #selector(tapControl), for: .touchUpInside)

        setupLabel()
    }

    private func setupLabel() {
        addSubview(counterLabel)

        counterLabel.textColor = #colorLiteral(red: 0.2887516618, green: 0.5174338222, blue: 0.7922994494, alpha: 1)
        counterLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([counterLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 5),
                                     counterLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
                                     counterLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -10),
                                     counterLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 40),
        ])

        updateCounterLabel()
    }

    private func updateCounterLabel() {
        var str: String = ""
        // let formatter = NumberFormatter()
        // formatter.minimumFractionDigits = 0
        // formatter.maximumFractionDigits = 1

        switch likeCounter {
        case 0:
            str = ""
        case 1 ... 999:
            str = String(Int(likeCounter))
        case 1000 ..< 1_000_000:
            //  str = (formatter.string(from: NSNumber(value: likeCounter / 1000)) ?? "-") + "k"

            if likeCounter.truncatingRemainder(dividingBy: 1000) < 100 {
                str = String(format: "%0.0f", likeCounter / 1000) + "k"
            } else {
                str = String(format: "%0.1f", likeCounter / 1000) + "k"
            }

        case 1_000_000 ..< 1_000_000_000:
            if likeCounter.truncatingRemainder(dividingBy: 1000_000) < 100_000 {
            str = String(format: "%0.0f", likeCounter / 1_000_000) + "M"
            } else {
                str = String(format: "%0.1f", likeCounter / 1000_000) + "M"
            }
        default:
            str = "-"
        }

        UIView.transition(with: counterLabel,
                          duration: 0.3,
                          options: .transitionFlipFromBottom,
                          animations: { 
                              self.counterLabel.text = str
                          })
        counterLabel.textColor = isLike ? #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1) : #colorLiteral(red: 0.2536475658, green: 0.4901949167, blue: 0.8384085298, alpha: 1)
    }

    
    private func animateImage() {
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       usingSpringWithDamping: 0.3,
                       initialSpringVelocity: 0,
                       options: [.curveEaseInOut],
                       animations: {
                           self.imageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                           UIView.animate(withDuration: 0.5,
                                          delay: 0.3,
                                          usingSpringWithDamping: 0.3,
                                          initialSpringVelocity: 0.5,
                                          options: [.curveEaseInOut],
                                          animations: {
                                              self.imageView.transform = .identity
                                          },
                                          completion: nil)
                       },
                       completion: nil)

        /*
                 let animation = CASpringAnimation(keyPath: "transform.scale")
                 animation.fromValue = 1
                 animation.toValue = 1.1
                 animation.stiffness = 300
                 animation.mass = 2
                 animation.duration = 0.5
                 //animation.beginTime = CACurrentMediaTime() + 0.2
                 //animation.fillMode = .forwards
                 imageView.layer.add(animation, forKey: nil)
             */
    }
    
    @objc private func tapControl() {
        isLike.toggle()
        if isLike {
            imageView.image = UIImage(systemName: "heart.fill")
            imageView.tintColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            //likeCounter += 1
            animateImage()
            updateCounterLabel()
        } else {
            imageView.image = UIImage(systemName: "heart")
            imageView.tintColor = #colorLiteral(red: 0.2887516618, green: 0.5174338222, blue: 0.7922994494, alpha: 1)
            //likeCounter -= 1
            updateCounterLabel()
        }
    }
}
