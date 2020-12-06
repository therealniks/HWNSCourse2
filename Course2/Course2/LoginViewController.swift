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
        
        // Получаем текст логина
        let login = loginTField.text!
        // Получаем текст-пароль
        let password = passTField.text!
        // Проверяем, верны ли они
        login == "admin" && password == "root" ?  print("успешная авторизация") : print("неуспешная авторизация")

    }

    override func viewDidLoad() {
            super.viewDidLoad()
         
            // Жест нажатия
            let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
            // Присваиваем его UIScrollVIew
            scrollView?.addGestureRecognizer(hideKeyboardGesture)
            navigationController?.navigationBar.isHidden = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Подписываемся на два уведомления: одно приходит при появлении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        // Второе — когда она пропадает
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        }
    

    // Когда клавиатура появляется
    @objc func keyboardWasShown(notification: Notification) {
        
        // Получаем размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        
        // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    //Когда клавиатура исчезает
    @objc func keyboardWillBeHidden(notification: Notification) {
        // Устанавливаем отступ внизу UIScrollView, равный 0
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
            return login == "admin" && password == "root"
        }
        
        func showLoginError() {
            // Создаем контроллер
            let alter = UIAlertController(title: "Erro", message: "Login or password isn't correct", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alter.addAction(action)
            present(alter, animated: true, completion: nil)
        }
    }
