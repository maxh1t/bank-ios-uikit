//
//  LoginViewController.swift
//  bank-ios-uikit
//
//  Created by RYAZANTSEV Maksim on 30.05.2024.
//

import UIKit

protocol LoginViewControllerProtocol {
    var presenter: LoginPresenter? { get set }
}

final class LoginViewController: UIViewController, LoginViewControllerProtocol {
    var presenter: LoginPresenter?
    
    
    private lazy var textField: AuthTextField = {
        let textField = AuthTextField()
        
        textField.placeholder = "Логин"
        
        return textField
    }()
    
    private lazy var authButton: UIButton = {
        let button = AuthButton()
        
        return button
    }()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configeViewComponents()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func configeViewComponents() {
        view.addSubview(textField)
        view.addSubview(authButton)
        
        textField.addTarget(self, action: #selector(editingChangedTextField), for: .editingChanged)
        authButton.addTarget(self, action: #selector(touchUpInsideAuthButton), for: .touchUpInside)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        authButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textField.leftAnchor.constraint(equalTo: view.leftAnchor),
            textField.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            authButton.leftAnchor.constraint(equalTo: view.leftAnchor),
            authButton.rightAnchor.constraint(equalTo: view.rightAnchor),
            authButton.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -24)
        ])
    }
    
    @objc func editingChangedTextField() {
        if textField.text?.count ?? 0 > 5 {
            authButton.isEnabled = true
        } else {
            authButton.isEnabled = false
        }
    }
    
    @objc func touchUpInsideAuthButton() {
        presenter?.router?.goToPassword()
    }
    
    
}
