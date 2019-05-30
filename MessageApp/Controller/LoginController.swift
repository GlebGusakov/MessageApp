//
//  LoginController.swift
//  MessageApp
//
//  Created by Глеб Гусаков on 14/05/2019.
//  Copyright © 2019 Глеб Гусаков. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {
    
    var nameContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1, alpha: 0.35)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    let emailContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1, alpha: 0.35)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var passContainerView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 140, width: view.frame.width, height: 50)
        view.backgroundColor = UIColor(white: 1, alpha: 0.35)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Full name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = UIFont(name: "Marker Felt", size: 20)
        return tf
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = UIFont(name: "Marker Felt", size: 20)
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        tf.font = UIFont(name: "Marker Felt", size: 20)
        return tf
    }()
    
    lazy var loginRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(white: 1, alpha: 0.125)
        button.setTitle("Register", for: UIControl.State())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: UIControl.State())
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont(name: "Copperplate", size: 24)
        button.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
        return button
    }()
    
    lazy var loginRegisterSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Login", "Register"])
        sc.backgroundColor = UIColor(white: 1, alpha: 0.2)
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.selectedSegmentIndex = 1
        sc.tintColor = UIColor(white: 1, alpha: 0.7)
        sc.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
        return sc
    }()
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ProfilePhoto")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView)))
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    var messagesController: MessagesController?
    let backImage = UIColor(patternImage: UIImage(named: "Background")!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = backImage
        view.addSubview(nameContainerView)
        view.addSubview(emailContainerView)
        view.addSubview(passContainerView)
        view.addSubview(loginRegisterButton)
        view.addSubview(loginRegisterSegmentedControl)
        view.addSubview(profileImageView)
        
        setupNameContainerView()
        setupEmailContainerView()
        setupPassContainerView()
        setupLoginRegisterButton()
        setupLoginRegisterSegmentedControl()
        setupProfileImageView()
        setupKeyboardObservers()
    }
    
    var containerViewBottomAnchor: NSLayoutConstraint?
    
    func setupLoginRegisterSegmentedControl() {
        loginRegisterSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterSegmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        loginRegisterSegmentedControl.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -160).isActive = true
        loginRegisterSegmentedControl.setHeightConstraint(height: 40)
    }
    
    func setupProfileImageView() {
        //need x, y, width, height constraints
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: nameContainerView.topAnchor, constant: -12).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    func setupNameContainerView() {
        nameContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        nameContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20).isActive = true
        nameContainerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nameContainerView.addSubview(nameTextField)
        nameTextField.leftAnchor.constraint(equalTo: nameContainerView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: nameContainerView.topAnchor, constant: 17).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: nameContainerView.widthAnchor).isActive = true
        nameTextField.heightAnchor.constraint(equalTo: nameContainerView.heightAnchor, multiplier: 1/3).isActive = true
    }
    
    func setupEmailContainerView() {
        emailContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailContainerView.topAnchor.constraint(equalTo: nameContainerView.bottomAnchor, constant: 12).isActive = true
        emailContainerView.widthAnchor.constraint(equalTo: nameContainerView.widthAnchor).isActive = true
        emailContainerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        emailContainerView.addSubview(emailTextField)
        emailTextField.leftAnchor.constraint(equalTo: emailContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: emailContainerView.topAnchor, constant: 17).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: emailContainerView.widthAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: emailContainerView.heightAnchor, multiplier: 1/3).isActive = true
    }
    
    func setupPassContainerView() {
        passContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passContainerView.topAnchor.constraint(equalTo: emailContainerView.bottomAnchor, constant: 12).isActive = true
        passContainerView.widthAnchor.constraint(equalTo: emailContainerView.widthAnchor).isActive = true
        passContainerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        passContainerView.addSubview(passwordTextField)
        passwordTextField.leftAnchor.constraint(equalTo: passContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: passContainerView.topAnchor, constant: 17).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: passContainerView.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: passContainerView.heightAnchor, multiplier: 1/3).isActive = true
    }
    
    
    func setupLoginRegisterButton() {
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        loginRegisterButton.topAnchor.constraint(equalTo: passContainerView.bottomAnchor, constant: 50).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: passContainerView.widthAnchor).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    @objc func handleKeyboardWillShow(_ notification: Notification) {
        let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        let keyboardDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
        view.frame.origin.y = -keyboardFrame!.height
        UIView.animate(withDuration: keyboardDuration!, animations: {
            self.profileImageView.alpha = 0
            self.view.layoutIfNeeded()
        })
    }
    
    @objc func handleKeyboardWillHide(_ notification: Notification) {
        let keyboardDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
        view.frame.origin.y = 0
        UIView.animate(withDuration: keyboardDuration!, animations: {
            self.profileImageView.alpha = 1
            self.view.layoutIfNeeded()
        })
    }
    
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
