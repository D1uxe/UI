//
//  LoginFormController.swift
//  vkClient
//
//  Created by MacBook Pro on 25.10.2020.
//

import UIKit

class LoginScreenController: UIViewController {
    
    // MARK: - IBOutlets

    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO: Разобраться и сделать логику с появлением и скрытием клавиатуры.
    }

    
    // MARK: - Private Methods

    private func showMessage(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    
    // MARK: - Public Methods
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let login = loginTextField.text!
        let password = passwordTextField.text!
        guard login == "1" && password == "1" else {
            showMessage(message: "Не верный логин или пароль")
            return false
        }
        return true
    }

    
    // MARK: - IBActions


    @IBAction func logOut(unwindSegue: UIStoryboardSegue) {

    }

    @IBAction func TextField_EditingChanged(_ sender: UITextField) {
        if loginTextField.text != "" && passwordTextField.text != "" {
            loginButton.isEnabled = true
            loginButton.alpha = 1.0

        } else {
            loginButton.isEnabled = false
            loginButton.alpha = 0.6
        }
    }

}


