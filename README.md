# Proyecto iOS - Autenticación y Perfil con Firebase (Clean Architecture)

Este proyecto es una aplicación iOS desarrollada en **Swift** usando **UIKit** que implementa autenticación de usuarios y gestión de perfil con **Firebase**, siguiendo los principios de **Clean Architecture**.

---

## 📱 Características

* Registro e inicio de sesión con correo y contraseña.
* Creación y edición de perfil de usuario (nombre, género, ocupación).
* Visualización de datos del perfil.
* Persistencia en Firebase Firestore.
* Cierre de sesión.

---

## 🧱 Arquitectura

El proyecto está organizado según la arquitectura Clean, dividiendo responsabilidades en 3 capas:

```
├── Presentation
│   ├── ViewControllers
│   ├── ViewModels
│   └── UI
├── Domain
│   ├── Entities
│   ├── UseCases
│   └── Repositories (protocols)
├── Data
│   ├── Firebase Implementations
│   └── Models
```

### Diagrama Simplificado

```
[ViewController]
    ↓
[ViewModel]
    ↓
[UseCase]
    ↓
[Repository Protocol]
    ↓
[Firebase Service / API]
```

---

## 🔧 Requisitos

* Xcode 15+
* iOS 15+
* Swift 5+
* Cuenta de Firebase configurada

---

---

## 🧪 Pruebas Unitarias

El proyecto incluye pruebas unitarias para:

* Casos de uso (Domain):

  * `LoginUseCase`
  * `RegisterUseCase` (Pendiente)
  * `SaveUserProfileUseCase` (Pendiente)

* ViewModels (Presentation):

  * `LoginViewModel` (Pendiente)
  * `ProfileViewModel` (Pendiente)

Usa mocks para aislar la lógica de negocio de Firebase.

---

## 📂 Estructura de carpetas de pruebas

```
Tests/
├── Domain/
│   └── LoginUseCaseTests.swift
├── Presentation/
│   └── ProfileViewModelTests.swift
└── Mocks/
    ├── MockAuthRepository.swift
    └── MockUserProfileRepository.swift
```

---

## 👤 Autor

Daniel R.C. - [danielrc.ime@gmail.com](mailto:danielrc.ime@gmail.com)

---

## 📄 Licencia

Este proyecto está disponible bajo la licencia MIT. Ver `LICENSE` para más detalles.
