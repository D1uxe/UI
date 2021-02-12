//
//  LoadingViewController.swift
//  vkClient
//
//  Created by MacBook Pro on 19.11.2020.
//

import UIKit

class LoadingViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var leftDot: UIView!
    @IBOutlet weak var middleDot: UIView!
    @IBOutlet weak var rightDot: UIView!


    //MARK: - Private Properties

    private var repeatCount: Int = 0
    private let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupDots()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateDot()
    }



    // MARK: - Private Methods

    private func animateDot() {

        UIView.animateKeyframes(withDuration: 1.5,
                                delay: 0,
                                options: [],
                                animations: {
                                    UIView.addKeyframe(withRelativeStartTime: 0.0,
                                                       relativeDuration: 1/3,
                                                       animations: {
                                                        self.rightDot.alpha = 1
                                                        self.rightDot.transform = .identity
                                                        self.leftDot.alpha = 0
                                                        self.leftDot.transform = self.scale
                                                       })
                                    UIView.addKeyframe(withRelativeStartTime: 1/3,
                                                       relativeDuration: 1/3,
                                                       animations: {
                                                        self.leftDot.alpha = 1
                                                        self.leftDot.transform = .identity
                                                        self.middleDot.alpha = 0
                                                        self.middleDot.transform = self.scale
                                                       })
                                    UIView.addKeyframe(withRelativeStartTime: 2/3,
                                                       relativeDuration: 1/3,
                                                       animations: {
                                                        self.middleDot.alpha = 1
                                                        self.middleDot.transform = .identity
                                                        self.rightDot.alpha = 0
                                                        self.rightDot.transform = self.scale
                                                       })
                                },
                                completion: { _ in
                                    if self.repeatCount != 0 {
                                        self.repeatCount += 1
                                        self.animateDot()
                                    } else {
                                        self.presentLoginViewController()
                                    }
                                })

    }


    private func presentLoginViewController() {

        let vc = LoginWebViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)

        /*
        let storyBoard: UIStoryboard = UIStoryboard(name: "LoginScreen", bundle: nil)
        let loginViewController: LoginScreenController = storyBoard.instantiateViewController(withIdentifier: "LoginView") as! LoginScreenController
        self.present(loginViewController, animated: true, completion: nil)
         */
    }

    private func setupDots() {
        self.leftDot.layer.cornerRadius = self.leftDot.bounds.height * 0.5
        self.middleDot.layer.cornerRadius = self.middleDot.bounds.height * 0.5
        self.rightDot.layer.cornerRadius = self.rightDot.bounds.height * 0.5
    }


}
