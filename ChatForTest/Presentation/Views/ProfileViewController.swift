//
//  ProfileViewController.swift
//  ChatForTest
//
//  Created by Daniel Alberto Rodriguez Cielo on 05/06/25.
//


import UIKit

class ProfileViewController: UIViewController {
    private var viewModel: ProfileViewModel!

    private let nameField = UITextField()
    private let genderField = UITextField()
    private let occupationField = UITextField()

    private let editButton = UIButton(type: .system)
    private let saveButton = UIButton(type: .system)
    private let logoutButton = UIButton(type: .system)


    private let emailLabel = UILabel()
    private let uidLabel = UILabel()

    private var isEditingProfile = false {
        didSet {
            updateEditingState()
        }
    }

    convenience init(viewModel: ProfileViewModel) {
        self.init()
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.loadProfile()
    }

    private func setupUI() {
        view.backgroundColor = .white
        title = "Perfil"

        emailLabel.text = "Correo: \(viewModel.user?.email ?? "")"
        uidLabel.text = "UID: \(viewModel.user?.uid ?? "")"

        [nameField, genderField, occupationField].forEach {
            $0.borderStyle = .roundedRect
            $0.isEnabled = false
        }

        nameField.placeholder = "Nombre"
        genderField.placeholder = "Género"
        occupationField.placeholder = "Ocupación"

        editButton.setTitle("Editar", for: .normal)
        saveButton.setTitle("Guardar", for: .normal)
        saveButton.isEnabled = false
        
        logoutButton.setTitle("Cerrar sesión", for: .normal)
        logoutButton.setTitleColor(.red, for: .normal)

        let stack = UIStackView(arrangedSubviews: [
            emailLabel,
            uidLabel,
            nameField,
            genderField,
            occupationField,
            editButton,
            saveButton,
            logoutButton
        ])
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        editButton.addTarget(self, action: #selector(editTapped), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
    }

    private func bindViewModel() {
        viewModel.onSuccess = {
            self.showAlert(title: "Éxito", message: "Perfil guardado correctamente.")
            self.isEditingProfile = false
        }

        viewModel.onError = { error in
            self.showAlert(title: "Error", message: error)
        }

        viewModel.onProfileLoaded = { profile in
            self.nameField.text = profile.name
            self.genderField.text = profile.gender
            self.occupationField.text = profile.occupation
        }
        
        viewModel.onLoggedOut = {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }

    @objc private func editTapped() {
        isEditingProfile = true
    }

    @objc private func saveTapped() {
        viewModel.saveProfile(
            name: nameField.text ?? "",
            gender: genderField.text ?? "",
            occupation: occupationField.text ?? ""
        )
    }
    
    @objc private func logoutTapped() {
        viewModel.signOut()
    }


    private func updateEditingState() {
        let enabled = isEditingProfile
        [nameField, genderField, occupationField].forEach { $0.isEnabled = enabled }
        saveButton.isEnabled = enabled
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
}
