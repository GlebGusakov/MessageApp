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
    
    let titleView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.frame = view.bounds
        view.layer.addSublayer(gradient)
        let label = UILabel(frame: view.bounds)
        label.text = "Sign up"
        label.font = UIFont(name: "Papyrus", size: 70)
        label.textAlignment = .center
        view.addSubview(label)
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
        button.backgroundColor = UIColor(r: 241, g: 106, b: 127)
        button.setTitle("Create your account", for: UIControl.State())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: UIControl.State())
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont(name: "Copperplate", size: 24)
        button.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
        return button
    }()
    
    @objc func handleRegister() {
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text else {
            print("Form is not valid")
            return
        }
        Auth.auth().createUser(withEmail: email, password: password, completion: { (res, error) in
            if let error = error {
                print(error)
                return
            }
            guard let uid = res?.user.uid else {
                return
            }
            let ref = Database.database().reference(fromURL: "https://messageapp-93d74.firebaseio.com/")
            let usersReference = ref.child("users").child(uid)
            let values = ["name": name, "email": email]
            usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                if let err = err {
                    print(err)
                    return
                }
                self.dismiss(animated: true, completion: nil)
                print("Saved user successfully into Firebase db")
            })
            
        })
    }
    
    lazy var loginRegisterSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Login", "Register"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor.white
        sc.selectedSegmentIndex = 1
        sc.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
        return sc
    }()
    
    @objc func handleLoginRegisterChange() {
        let title = loginRegisterSegmentedControl.titleForSegment(at: loginRegisterSegmentedControl.selectedSegmentIndex)
        loginRegisterButton.setTitle(title, for: UIControl.State())
        nameContainerView.isHidden = loginRegisterSegmentedControl.selectedSegmentIndex == 0
    }
    
    @objc func handleLoginRegister() {
        if loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
            handleLogin()
        } else {
            handleRegister()
        }
    }
    
    func handleLogin() {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            print("Form is not valid")
            return
        }
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if let error = error {
                print(error)
                return
            }
            //successfully logged in our user
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    var messagesController: MessagesController?
    
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    let backImage = UIColor(patternImage: UIImage(named: "Background")!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = backImage
        view.addSubview(nameContainerView)
        view.addSubview(emailContainerView)
        view.addSubview(passContainerView)
        view.addSubview(loginRegisterButton)
        view.addSubview(loginRegisterSegmentedControl)
        
        //        view.addSubview(titleView)
        //        view.addSubview(profileImageView)
        
        setupNameContainerView()
        setupEmailContainerView()
        setupPassContainerView()
        setupLoginRegisterButton()
        setupLoginRegisterSegmentedControl()
        //        setupGradintLabelView()
        //        setupProfileImageView()
    }
    
    //    func setupProfileImageView() {
    //        //need x, y, width, height constraints
    //        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    //        profileImageView.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -12).isActive = true
    //        profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
    //        profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    //    }
    
    func setupGradintLabelView() {
        titleView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleView.bottomAnchor.constraint(equalTo: nameContainerView.topAnchor, constant: 93).isActive = true
        titleView.widthAnchor.constraint(equalToConstant: 0).isActive = true
        titleView.heightAnchor.constraint(equalToConstant: 0).isActive = true
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
    
    func setupLoginRegisterSegmentedControl() {
        loginRegisterSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterSegmentedControl.bottomAnchor.constraint(equalTo: nameContainerView.topAnchor, constant: -12).isActive = true
        loginRegisterSegmentedControl.widthAnchor.constraint(equalTo: nameContainerView.widthAnchor, multiplier: 1).isActive = true
        loginRegisterSegmentedControl.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
}
