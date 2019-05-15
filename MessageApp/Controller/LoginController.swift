//
//  LoginController.swift
//  MessageApp
//
//  Created by Глеб Гусаков on 14/05/2019.
//  Copyright © 2019 Глеб Гусаков. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
//    let titleLabelView: UILabel = {
//        let view = UILabel()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.layer.masksToBounds = true
//        view.text = "Sign up"
//        view.font = UIFont(name: "Snell Roundhand", size: 40)
//        view.textColor = UIColor(r: 116, g: 176, b: 238)
//        return view
//    }()
    
    let gradinetView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
        
        // Gradient from left to right
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.frame = view.bounds
        // add the gradient layer to the views layer for rendering
        view.layer.addSublayer(gradient)
        let label = UILabel(frame: view.bounds)
        label.text = "Sign up"
        label.font = UIFont(name: "Papyrus", size: 70)
        label.textAlignment = .center
        view.addSubview(label)
        
        // Tha magic! Set the label as the views mask
        view.mask = label
        return view
    }()
    
    let nameContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 148, g: 141, b: 182)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 0
        view.layer.masksToBounds = true
        return view
    }()
    
    let emailContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 189, g: 115, b: 152)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 0
        view.layer.masksToBounds = true
        return view
    }()
    
    let passContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 241, g: 116, b: 124)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 0
        view.layer.masksToBounds = true
        return view
    }()
    
    let loginRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 241, g: 106, b: 127)
        button.setTitle("Create your account", for: UIControl.State())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: UIControl.State())
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont(name: "Copperplate", size: 24)
        return button
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
    
    let backImage = UIColor(patternImage: UIImage(named: "Background")!)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = backImage
        
          //  UIColor(r: 99, g: 35, b: 89)
        
        view.addSubview(nameContainerView)
        view.addSubview(emailContainerView)
        view.addSubview(passContainerView)
        view.addSubview(loginRegisterButton)
//        view.addSubview(titleLabelView)
        view.addSubview(gradinetView)
        //        view.addSubview(profileImageView)
        
        setupNameContainerView()
        setupEmailContainerView()
        setupPassContainerView()
        setupLoginRegisterButton()
        setupGradintLabelView()
//        setupTitleLabelView()
        //        setupProfileImageView()
    }
    
    //    func setupProfileImageView() {
    //        //need x, y, width, height constraints
    //        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    //        profileImageView.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -12).isActive = true
    //        profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
    //        profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    //    }
    
//    func setupTitleLabelView() {
//        titleLabelView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        titleLabelView.bottomAnchor.constraint(equalTo: nameContainerView.topAnchor, constant: -15).isActive = true
//        titleLabelView.widthAnchor.constraint(equalToConstant: 130).isActive = true
//        titleLabelView.heightAnchor.constraint(equalToConstant: 150).isActive = true
//    }
    func setupGradintLabelView() {
        gradinetView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        gradinetView.bottomAnchor.constraint(equalTo: nameContainerView.topAnchor, constant: 93).isActive = true
        gradinetView.widthAnchor.constraint(equalToConstant: 0).isActive = true
        gradinetView.heightAnchor.constraint(equalToConstant: 0).isActive = true
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
        loginRegisterButton.topAnchor.constraint(equalTo: passContainerView.bottomAnchor, constant: 12).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: passContainerView.widthAnchor).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
}
