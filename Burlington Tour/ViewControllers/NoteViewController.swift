//
//  NoteViewController.swift
//  Burlington Tour
//
//  Created by Matthew Fortier on 3/22/18.
//  Copyright © 2018 Matthew Fortier. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var noteTitle: String!
    var image: UIImage!
    var body: String!
    
    var itemStore: ItemStore!
    
    var type: Int = 0
    var orignialTitle: String = ""
    
    var chosenImage: UIImage!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bodyText: UITextView!
    @IBOutlet weak var photoButton: UIButton!
    
    var imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        
        if noteTitle != nil {
            
            titleTextField.text = noteTitle
            imageView.image = image
            bodyText.text = body
            
            type = 1
            orignialTitle = noteTitle
            photoButton.setTitle("Change Photo", for: UIControlState.normal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openPhotoGallery(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any])
    {
        print("Picked!")
        image = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        imageView.contentMode = .scaleAspectFit //3
        imageView.image = image //4
        dismiss(animated:true, completion: nil) //5
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveNote(_ sender: UIButton) {
        if type == 0 {
            itemStore.createNote(title: titleTextField.text!, image: chosenImage, body: bodyText.text!)
        } else {
            itemStore.updateNote(original: orignialTitle, title: titleTextField.text!, image: image, body: bodyText.text!)
        }
        //performSegue(withIdentifier: "unwindToTableView", sender: self)
        navigationController?.popViewController(animated: true)
    }
}
