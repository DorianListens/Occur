//
//  EditThingViewController.swift
//  Occur
//
//  Created by Dorian Scheidt on 2016-09-18.
//  Copyright © 2016 Dorian Listens. All rights reserved.
//

import UIKit
import AVFoundation

class EditThingViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!

    var thing: Thing = Thing()
    var image: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameInput.delegate = self
        nameInput.text = thing.name
        nameInput.becomeFirstResponder()

        finishButton.addTarget(self, action: #selector(finishEditing), for: .touchUpInside)

        addImageButton.addTarget(self, action: #selector(addImage), for: .touchUpInside)
    }

    // MARK: - UITextFieldDelegate

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {

    }

    // MARK: - Actions

    func addImage() {
        confirmCameraStatusAndThenTakePhoto()
    }

    private func confirmCameraStatusAndThenTakePhoto() {
        let status = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
        switch status {
        case .authorized:
            self.showCameraOnMainThread()
        case .notDetermined:
            AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: cameraAccessCallback)
        default:
            NSLog("Default")
        }
    }

    private func cameraAccessCallback(granted: Bool) {
        if granted {
            self.showCameraOnMainThread()
        } else {
            let alert = UIAlertController()
            alert.title = "NOT GRANTED"
            alert.show(self, sender: self)
        }
    }

    private func showCameraOnMainThread() {
        DispatchQueue.main.async {
            self.displayCamera()
        }
    }

    private func displayCamera() {
        let imageController = UIImagePickerController()
        imageController.delegate = self
        let cameraAvailable = UIImagePickerController.isSourceTypeAvailable(.camera)

        if cameraAvailable {
            imageController.mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera)!
        }

        imageController.sourceType = .camera
        imageController.allowsEditing = true

        present(imageController, animated: true, completion: nil)
    }

    func finishEditing() {
        guard let controller = navigationController?.viewControllers[0] as? MasterViewController else {
            return
        }

        controller.insertNewThing(thing.setName(name: nameInput.text!).setImage(image: image))
        let _ = navigationController?.popViewController(animated: true)
    }

    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.image = image
        dismiss(animated: true, completion: nil)
    }

    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {

    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! MasterViewController
        controller.insertNewThing(Thing(name: nameInput.text!))
    }
}
