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
    @IBOutlet var loginButton: UIButton! {
        didSet {
            loginButton.isEnabled = true
            loginButton.alpha = 1.0
        }
    }
    

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
        guard login == "" && password == "" else {
            //showMessage(message: "Не верный логин или пароль")
            self.showAlert(title: "Ошибка", message: "Не верный логин или пароль")
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

    @IBAction func vkAPIRequest() {

//        QueryFriends.get(fields: [.photo_100, .city, .country] ,completion: { friends in
//            print("++++++++ FRIENDS ++++++++")
//            print(friends)
//        })
//
//        QueryGroups.get(completion: {groups in
//            print("======== GROUPS ========")
//            print(groups)
//        })
//
//        QueryGroups.search(group: "Swift", completion: { searchedGroups in
//            print("-------- SEARCHED GROUPS --------")
//            print(searchedGroups)
//    })
//
//        QueryGroups.leave(groupId: 32295218, completion: { result in
//            print("****** GROUP 32295218 LEAVE")
//            print(result)
//        })
//
//        QueryPhotos.getAll(for: Session.shared.userId ?? 0, completion: { photos in
//            print("******** PHOTOS ********")
//            print(photos)
//        })

        QueryNews.get(completion: { news in
            print("‼️‼️‼️ NEWS ‼️‼️‼️")
            print(news)
        })

    }

}


