//
//  ContactsViewController.swift
//  ContactsApp
//
//  Created by Hannan Max on 2022-12-14.
//

import UIKit

class ContactsViewController: UIViewController {

    var selectedContact: Contact? = nil
    var index: Int!

    var newSelectedContact: Contact? = nil

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {

        if selectedContact != nil {
            nameLabel.text = selectedContact?.name
            numberLabel.text = selectedContact?.phonenumber
            newSelectedContact = selectedContact
        }
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "editContact") {
            print(selectedContact!)
            let dst = segue.destination as! AddContactViewController
            dst.selectedContact = newSelectedContact
        }
    }
}
