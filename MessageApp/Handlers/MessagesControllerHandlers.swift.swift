////
////  Handlers.swift
////  MessageApp
////
////  Created by Глеб Гусаков on 26/05/2019.
////  Copyright © 2019 Глеб Гусаков. All rights reserved.
////
//
//import UIKit
//import Firebase
//
//extension MessagesController: UINavigationControllerDelegate {
//    
//    @objc func handleReloadTable() {
//        DispatchQueue.main.async(execute: {
//            print("reloaded the table")
//            self.tableView.reloadData()
//        })
//    }
//    
//    @objc func handleNewMessage() {
//        let newMessageController = NewMessageController()
//        newMessageController.messagesController = self
//        let navController = UINavigationController(rootViewController: newMessageController)
//        present(navController, animated: true, completion: nil)
//    }
//    
//    @objc func handleLogout() {
//        do {
//            try Auth.auth().signOut()
//        } catch let logoutError {
//            print(logoutError)
//        }
//        let loginController = LoginController()
//        loginController.messagesController = self
//        present(loginController, animated: true, completion: nil)
//    }
//}
