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
                                                       animations: { [unowned self] in
                                                        self.rightDot.alpha = 1
                                                        self.leftDot.alpha = 0
                                                       })
                                    UIView.addKeyframe(withRelativeStartTime: 1/3,
                                                       relativeDuration: 1/3,
                                                       animations: { [unowned self] in
                                                        self.leftDot.alpha = 1
                                                        self.middleDot.alpha = 0
                                                       })
                                    UIView.addKeyframe(withRelativeStartTime: 2/3,
                                                       relativeDuration: 1/3,
                                                       animations: {[unowned self] in
                                                        self.middleDot.alpha = 1
                                                        self.rightDot.alpha = 0
                                                       })
                                },
                                completion: { [unowned self] _ in
                                    if self.repeatCount != 0 {
                                        self.repeatCount += 1
                                        self.animateDot()
                                    } else {
                                        self.presentLoginViewController()
                                    }
                                })

    }


    private func presentLoginViewController() {

        let storyBoard: UIStoryboard = UIStoryboard(name: "LoginScreen", bundle: nil)
        let loginViewController: LoginScreenController = storyBoard.instantiateViewController(withIdentifier: "LoginView") as! LoginScreenController
        self.present(loginViewController, animated: true, completion: nil)
    }

    private func setupDots() {
        self.leftDot.layer.cornerRadius = self.leftDot.bounds.height * 0.5
        self.middleDot.layer.cornerRadius = self.middleDot.bounds.height * 0.5
        self.rightDot.layer.cornerRadius = self.rightDot.bounds.height * 0.5
    }


}
