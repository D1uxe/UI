//
//  CustomNavigationController.swift
//  vkClient
//
//  Created by MacBook Pro on 24.11.2020.
//

import UIKit

class CustomNavigationController: UINavigationController {

    //MARK: - Private Properties

    private let interactiveTransition = CustomInteractiveTransition()


    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    //MARK: - Public Methods

    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {

        return interactiveTransition.hasStarted ? interactiveTransition : nil
    }


}

    //MARK: - UINavigationControllerDelegate

extension CustomNavigationController: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {


//    Можно ведь здесь поставить такую проверку, чтобы определить, что следующий экран будет такой-то и
//    и на этом основании возвращать нужный мне аниматор?
//    Это для того, чтобы для разных экранов показывать разную анимацию... или это делается в другом месте? Я хочу тобы один экран анимировался так, другой под другому, третий еще как-то.

//        if (toVC as? FriendPhotoBrowserViewController) != nil {
//             if operation == .push {
//        self.interactiveTransition.viewController = toVC
//        return PushAnimator2() // моя другая анмация для экрана с фотками..
//        }

        if operation == .push {
            self.interactiveTransition.viewController = toVC
            return PushAnimator()
        } else if operation == .pop {
            if navigationController.viewControllers.first != toVC {
                self.interactiveTransition.viewController = toVC
            }
            return PopAnimator()
        }
        return nil
    }
}




/*
extension CustomNavigationController: UIViewControllerTransitioningDelegate {

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PopAnimator()
    }

    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PushAnimator()
    }
}
*/
