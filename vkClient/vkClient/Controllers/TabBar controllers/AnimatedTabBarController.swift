//
//  AnimatedTabBarController.swift
//  vkClient
//
//  Created by MacBook Pro on 28.11.2020.
//

import UIKit

class AnimatedTabBarController: UITabBarController {

    // MARK: - Public Methods

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let orderedTabBarItemViews: [UIView] = {
            let views = tabBar.subviews.filter({ $0 is UIControl })
            return views.sorted(by: { $0.frame.minX < $1.frame.minX })
        }()

        if let index = tabBar.items?.firstIndex(of: item) {
            let subView = orderedTabBarItemViews[index]
            performAnimation(for: subView)
        }

        /* вариант 2. Через tag'и
         var tabBarView: [UIView] = []

         for i in tabBar.subviews {
         if i.isKind(of: NSClassFromString("UITabBarButton")! ) {
         tabBarView.append(i)
         }
         }

         if !tabBarView.isEmpty {
         UIView.animate(withDuration: 0.15, animations: {
         tabBarView[item.tag].transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
         }, completion: { _ in
         UIView.animate(withDuration: 0.15) {
         tabBarView[item.tag].transform = CGAffineTransform.identity
         }
         })
         }
         */
    }



    // MARK: - Private Methods

    private func performAnimation(for view: UIView) {
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.5,
                       options: [.curveEaseInOut],
                       animations: {
                           view.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
                           UIView.animate(withDuration: 0.5,
                                          delay: 0.2,
                                          usingSpringWithDamping: 0.5,
                                          initialSpringVelocity: 0.5,
                                          options: [.curveEaseInOut],
                                          animations: {
                                              view.transform = .identity
                                          }, completion: nil)
                       }, completion: nil)


        view.transform = CGAffineTransform(rotationAngle: .pi)

        UIView.animate(withDuration: 0.7,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.5,
                       options: [.curveEaseInOut],
                       animations: { () -> Void in
                           view.transform = .identity
                       },
                       completion: nil)

    }

}
