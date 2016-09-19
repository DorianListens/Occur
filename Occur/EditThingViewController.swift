//
//  EditThingViewController.swift
//  Occur
//
//  Created by Dorian Scheidt on 2016-09-18.
//  Copyright © 2016 Dorian Listens. All rights reserved.
//

import UIKit

class EditThingViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var newThingTitleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Made it!")
        newThingTitleTextField.delegate = self
        newThingTitleTextField.becomeFirstResponder()
    }

    // MARK: - UITextFieldDelegate

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        print("You did it! \(newThingTitleTextField.text)")
        let controller = navigationController?.viewControllers[0] as! MasterViewController
        controller.insertNewThing(Thing(name: newThingTitleTextField.text!))
        navigationController?.popViewController(animated: true)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! MasterViewController
        controller.insertNewThing(Thing(name: newThingTitleTextField.text!))
    }
}
