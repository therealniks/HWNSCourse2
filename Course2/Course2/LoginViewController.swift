//
//  LoginViewController.swift
//  Course2
//
//  Created by N!kS on 02.12.2020.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var loginTField: UITextField!
    @IBOutlet weak var passLabel: UILabel!
    @IBOutlet weak var passTField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBAction func loginButton(_ sender: Any) {
        let login = loginTField.text!
        let password = passTField.text!
        login == "admin" && password == "root" ?  print("успешная авторизация") : print("неуспешная авторизация")
    }

    override func viewDidLoad() {
            super.viewDidLoad()
            let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
            scrollView?.addGestureRecognizer(hideKeyboardGesture)
            navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        }
    

    @objc func keyboardWasShown(notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
    }
    
    @objc func hideKeyboard() {
            self.scrollView?.endEditing(true)
        }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
            if !checkUserData() {
                showLoginError()
            }
            return checkUserData()
        }
        
        func checkUserData() -> Bool {
            guard let login = loginTField.text,let password = passTField.text else { return false }
            return login == "1" && password == "1"
        }
        func showLoginError() {
            // Создаем контроллер
            let alert = UIAlertController(title: "Error", message: "Login or password isn't correct", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
