//
//  LoginViewController.swift
//  ChatForTest
//
//  Created by Daniel Alberto Rodriguez Cielo on 05/06/25.
//


import UIKit

class LoginViewController: UIViewController {

    private let emailField = UITextField()
    private let passwordField = UITextField()
    private let loginButton = UIButton(type: .system)
    private let registerButton = UIButton(type: .system)


    private lazy var viewModel: AuthViewModel = {
        let repository = FirebaseAuthRepository()
        let loginUseCase = LoginUseCase(repository: repository)
        let registerUseCase = RegisterUseCase(repository: repository)
        return AuthViewModel(loginUseCase: loginUseCase, registerUseCase: registerUseCase)
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }

    private func setupUI() {
        view.backgroundColor = .white
        emailField.placeholder = "Correo"
        emailField.borderStyle = .roundedRect
        emailField.keyboardType = .emailAddress
        passwordField.placeholder = "Contraseña"
        passwordField.isSecureTextEntry = true
        passwordField.borderStyle = .roundedRect
        loginButton.setTitle("Iniciar Sesión", for: .normal)
        registerButton.setTitle("Registrarse", for: .normal)

        let stack = UIStackView(arrangedSubviews: [emailField, passwordField, loginButton, registerButton])
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
        ])

        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
    }

    private func bindViewModel() {
        viewModel.onSuccess = { user in
            let repo = FirebaseUserProfileRepository()
            let useCase = SaveUserProfileUseCase(repository: repo)
            let logOutUseCase = LogOutUseCase(repository: FirebaseAuthRepository())
            let profileVM = ProfileViewModel(saveUseCase: useCase, logOutUseCase: logOutUseCase, user: user, repository: repo)
            let profileVC = ProfileViewController(viewModel: profileVM)
            self.navigationController?.pushViewController(profileVC, animated: true)
        }

        viewModel.onError = { message in
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }

    @objc private func loginTapped() {
        guard let email = emailField.text, let password = passwordField.text else { return }
        viewModel.login(email: email, password: password)
    }
    
    @objc private func registerTapped() {
        guard let email = emailField.text, let password = passwordField.text else { return }
        viewModel.register(email: email, password: password)
    }

}
