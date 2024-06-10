//
//  PasswordViewController.swift
//  bank-ios-uikit
//
//  Created by RYAZANTSEV Maksim on 31.05.2024.
//

import UIKit

protocol PasswordViewControllerInput: AnyObject {
    
}

protocol PasswordViewControllerOutput: AnyObject {
    func submit(password: String)
}

final class PasswordViewController: UIViewController {
    
    var output: PasswordViewControllerOutput?

    private lazy var textField: AuthTextField = {
        let textField = AuthTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Пароль"
        textField.secureField()
        textField.addTarget(self, action: #selector(editingChangedTextField), for: .editingChanged)
        
        return textField
    }()
    
    private lazy var authButton: UIButton = {
        let button = AuthButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(touchUpInsideAuthButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var titleLalbel: AuthTitleLabel = {
        let label = AuthTitleLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Остался пароль"
        
        return label
    }()
    
    private lazy var captioLabel: AuthCaptionLabel = {
        let label = AuthCaptionLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Убедимся, что это точно вы"
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .prymaryBackground
    
        configeViewComponents()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        textField.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textField.resignFirstResponder()
    }
    
    private func configeViewComponents() {
        view.addSubview(titleLalbel)
        view.addSubview(captioLabel)
        view.addSubview(textField)
        view.addSubview(authButton)
        
        NSLayoutConstraint.activate([
            titleLalbel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .mainPadding * 1.5),
            titleLalbel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            titleLalbel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),

            captioLabel.topAnchor.constraint(equalTo: titleLalbel.bottomAnchor, constant: .mainPadding / 2),
            captioLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            captioLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            
            textField.topAnchor.constraint(equalTo: captioLabel.bottomAnchor, constant: .mainPadding * 2),
            textField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: .mainPadding),
            textField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -.mainPadding),
            
            authButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: .mainPadding),
            authButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -.mainPadding),
            authButton.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -.mainPadding * 1.5),
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
        output?.submit(password: textField.text ?? "")
    }
}

extension PasswordViewController: PasswordViewControllerInput {}
