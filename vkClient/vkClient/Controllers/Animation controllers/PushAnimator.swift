//
//  PushAnimator.swift
//  vkClient
//
//  Created by MacBook Pro on 24.11.2020.
//

import UIKit

class PushAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    //MARK: - Private Properties

    private let duration: Double = 0.4


    //MARK: - Public Methods

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let source = transitionContext.viewController(forKey: .from) else { return }
        guard let destination = transitionContext.viewController(forKey: .to) else { return }

        transitionContext.containerView.addSubview(destination.view)
        transitionContext.containerView.sendSubviewToBack(destination.view)

        //начальные значения
        destination.view.layer.anchorPoint = CGPoint(x: 1, y: 0)
        destination.view.frame = transitionContext.containerView.frame //source.view.frame
        destination.view.transform = CGAffineTransform(rotationAngle: -.pi * 0.5)

        source.view.layer.anchorPoint = CGPoint(x: 0, y: 0)
        source.view.frame = transitionContext.containerView.frame //source.view.frame

        UIView.animate(withDuration: duration,
                       animations: { () in
                           source.view.transform = CGAffineTransform(rotationAngle: .pi * 0.5)
                           destination.view.transform = .identity
                       },
                       completion: { completed in
                           if completed && !transitionContext.transitionWasCancelled {
                               source.view.transform = .identity
                           }
                           transitionContext.completeTransition(completed && !transitionContext.transitionWasCancelled)
                       })
    }


}
