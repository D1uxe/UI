//
//  FriendPhotoBrowserViewController.swift
//  vkClient
//
//  Created by MacBook Pro on 22.11.2020.
//

import UIKit

class FriendPhotoBrowserViewController: UIViewController {

    //MARK: - Public Properties

    var friendPhotoes: [String] = []
    var selectedPhoto = 0

    var leftImageView: UIImageView!
    var middleImageView: UIImageView!
    var rightImageView: UIImageView!

    var swipeToRight: UIViewPropertyAnimator!
    var swipeToLeft: UIViewPropertyAnimator!


    //MARK: - Private Properties

    lazy private var panGestureRecognizer: UIPanGestureRecognizer = {
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        return recognizer
    }()


    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.addGestureRecognizer(panGestureRecognizer)
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        startAnimate()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.subviews.forEach({$0.removeFromSuperview()})
    }


    //MARK: - Private Methods

    private func setupImage() {


        var indexPhotoLeft = selectedPhoto - 1
        let indexPhotoMid = selectedPhoto
        var indexPhotoRight = selectedPhoto + 1

        // просмотр фото по кругу
        if indexPhotoLeft < 0 {
            indexPhotoLeft = friendPhotoes.count - 1

        }
        if indexPhotoRight > friendPhotoes.count - 1 {
            indexPhotoRight = 0
        }
        view.subviews.forEach({ $0.removeFromSuperview() })
        self.leftImageView = UIImageView()
        self.middleImageView = UIImageView()
        self.rightImageView = UIImageView()

        self.leftImageView.image = UIImage(named: friendPhotoes[indexPhotoLeft])
        self.middleImageView.image = UIImage(named: friendPhotoes[indexPhotoMid])
        self.rightImageView.image = UIImage(named: friendPhotoes[indexPhotoRight])

        self.leftImageView.contentMode = .scaleAspectFit
        self.middleImageView.contentMode = .scaleAspectFit
        self.rightImageView.contentMode = .scaleAspectFit



        let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)

        self.leftImageView.transform = scale
        self.middleImageView.transform = scale
        self.rightImageView.transform = scale

        self.view.addSubview(leftImageView)
        self.view.addSubview(middleImageView)
        self.view.addSubview(rightImageView)

        self.setupimageConstarints()

    }


    private func setupimageConstarints() {

        leftImageView.translatesAutoresizingMaskIntoConstraints = false
        middleImageView.translatesAutoresizingMaskIntoConstraints = false
        rightImageView.translatesAutoresizingMaskIntoConstraints = false


        NSLayoutConstraint.activate([
            middleImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            middleImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            middleImageView.heightAnchor.constraint(equalTo: middleImageView.widthAnchor, multiplier: 4 / 3),
            middleImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            leftImageView.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            leftImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            leftImageView.heightAnchor.constraint(equalTo: middleImageView.heightAnchor),
            leftImageView.widthAnchor.constraint(equalTo: middleImageView.widthAnchor),

            rightImageView.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            rightImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            rightImageView.heightAnchor.constraint(equalTo: middleImageView.heightAnchor),
            rightImageView.widthAnchor.constraint(equalTo: middleImageView.widthAnchor),
        ])
    }


    private func startAnimate() {
        setupImage()
        UIView.animate(withDuration: 0.5,
                       animations: {
                        self.leftImageView.transform = .identity
                        self.middleImageView.transform = .identity
                        self.rightImageView.transform = .identity
                       })
    }


    @objc private func onPan(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            swipeToRight = UIViewPropertyAnimator(
                duration: 1,
                curve: .easeInOut,
                animations: {
                    UIView.animate(
                        withDuration: 0.5,
                        delay: 0,
                        options: [],
                        animations: {
                            let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
                            let translation = CGAffineTransform(translationX: self.view.bounds.maxX - 40, y: 0)
                            let transform = scale.concatenating(translation)
                            self.middleImageView.transform = transform
                            self.rightImageView.transform = transform
                            self.leftImageView.transform = transform
                    }, completion: { _ in
                        self.selectedPhoto -= 1
                        if self.selectedPhoto < 0 {
                            self.selectedPhoto = self.friendPhotoes.count - 1
                        }
                        self.startAnimate()
                    })
            })
            swipeToLeft = UIViewPropertyAnimator(
                duration: 1,
                curve: .easeInOut,
                animations: {
                    UIView.animate(
                        withDuration: 0.5,
                        delay: 0,
                        options: [],
                        animations: {
                            let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
                            let translation = CGAffineTransform(translationX: -self.view.bounds.maxX + 40, y: 0)
                            let transform = scale.concatenating(translation)
                            self.middleImageView.transform = transform
                            self.rightImageView.transform = transform
                            self.leftImageView.transform = transform
                    }, completion: { _ in
                        self.selectedPhoto += 1
                        if self.selectedPhoto > self.friendPhotoes.count - 1 {
                            self.selectedPhoto = 0
                        }
                        self.startAnimate()
                    })
            })

//            swipeToRight.pauseAnimation()
//            swipeToLeft.pauseAnimation()

        case .changed:
            let translationX = recognizer.translation(in: self.view).x
            if translationX > 0 {
                swipeToRight.fractionComplete = abs(translationX)/100
            } else {
                swipeToLeft.fractionComplete = abs(translationX)/100
            }

        case .ended:
            swipeToRight.continueAnimation(withTimingParameters: nil, durationFactor: 0)
            swipeToLeft.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        default:
            return
        }
    }

}
