//
//  CustomAlertController.swift
//  ContactsApp
//
//  Created by Hannan Max on 2022-12-11.
//

import UIKit

class CustomAlertController: NSObject {
    
    let message:String?
    let title:String?
    
    init(title:String, message:String) {
        self.message = message
        self.title = title
    }
    

    func showAlert()->UIAlertController {
        let alertController = UIAlertController(title: self.title, message: self.message, preferredStyle: .alert)
        // you can further customize your buttons, buttons' title etc
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
        }))
        return alertController
    }
    
}
