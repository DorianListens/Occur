//
//  EditThingViewController.swift
//  Occur
//
//  Created by Dorian Scheidt on 2016-09-18.
//  Copyright © 2016 Dorian Listens. All rights reserved.
//

import UIKit

class EditThingViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameInput: UITextField!

    var thing: Thing = Thing()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameInput.delegate = self
        nameInput.text = thing.name
        nameInput.becomeFirstResponder()
    }

    // MARK: - UITextFieldDelegate

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let controller = navigationController?.viewControllers[0] as? MasterViewController else {
            return
        }

        controller.insertNewThing(thing.setName(name: nameInput.text!))
        navigationController?.popViewController(animated: true)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! MasterViewController
        controller.insertNewThing(Thing(name: nameInput.text!))
    }
}
