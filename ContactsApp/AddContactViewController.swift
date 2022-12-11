//
//  AddContactViewController.swift
//  ContactsApp
//
//  Created by Hannan Max on 2022-12-11.
//

import UIKit
import CoreData

class AddContactViewController: UIViewController {

    var selectedContact: Contact? = nil
    
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(selectedContact != nil) {
            nameTextField.text = selectedContact?.name
            phoneNumberTextField.text = selectedContact?.phonenumber
        }
        

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        
        if (nameTextField.text!.count <  1) {
            let alert = CustomAlertController(title: "Pleae enter a name", message: "Name field is empty")
            DispatchQueue.main.async {
                self.present(alert.showAlert(), animated: true, completion: nil)
            }
        } else if (phoneNumberTextField.text!.count < 1) {
            let alert = CustomAlertController(title: "Pleae enter a phone number", message: "Phone Number field is empty")
            DispatchQueue.main.async {
                self.present(alert.showAlert(), animated: true, completion: nil)
            }
        } else {
            warningLabel.text = ""
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            if(selectedContact == nil) {
                let entity = NSEntityDescription.entity(forEntityName: "Contact", in: context)
                let newContact = Contact(entity: entity!, insertInto: context)

                newContact.name = nameTextField.text
                newContact.phonenumber = phoneNumberTextField.text
                
                do {
                    try context.save()
                    Contacts.append(newContact)
                    navigationController?.popViewController(animated: true)
                } catch  {
                    print("Failed to save contact")
                }
            } else {
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Contact")
                
                do {
                    let results:NSArray = try context.fetch(request) as NSArray
                    for result in results {
                        let contact = result as! Contact
                        if(contact == selectedContact) {
                            contact.name = nameTextField.text
                            contact.phonenumber = phoneNumberTextField.text
                            try context.save()
                            navigationController?.popViewController(animated: true)
                        }
                    }
                } catch{
                    print("Didn't get any contact")
                }
            }
        }
    }
    
    
    @IBAction func deleteContact(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Contact")
        do {
            let results:NSArray = try context.fetch(request) as NSArray
            for result in results {
                let contact = result as! Contact
                if(contact == selectedContact) {
                    contact.deletedDate = Date()
                    try context.save()
                    navigationController?.popViewController(animated: true)
                }
            }
        } catch {
            print("Didn't get any contact")
        }
    }
}
