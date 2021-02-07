//
//  Alert.swift
//  vkClient
//
//  Created by MacBook Pro on 10.01.2021.
//

import UIKit

extension UIViewController {

    func showAlert(title: String, message: String, buttonTitle: String = "OK" ) {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))

        self.present(alert, animated: true, completion: nil)

        
    }

}
