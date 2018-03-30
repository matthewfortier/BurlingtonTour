//
//  NoteViewController.swift
//  Burlington Tour
//
//  Created by Matthew Fortier on 3/22/18.
//  Copyright © 2018 Matthew Fortier. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var note: Note!
    
    var itemStore: ItemStore!
    var image: UIImage!
    var imagePath: String = ""
    
    var type: Int = 0
    
    var fav : Bool = false
    var chosenImage: UIImage!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bodyText: UITextView!
    @IBOutlet weak var photoButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    func setFavoriteButton(filled: Bool) {
        var buttonIcon: UIImage!
        
        buttonIcon = filled ? UIImage(named: "fav-filled") : UIImage(named: "fav")
        
        let rightBarButton: UIBarButtonItem = UIBarButtonItem(title: "Favorite", style: UIBarButtonItemStyle.done, target: self, action: #selector(NoteViewController.handleFavorite))
        
        rightBarButton.image = buttonIcon
        
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func handleFavorite() {
        if itemStore.isFavorite(uuid: note.id) {
            itemStore.removeFavorite(uuid: note.id)
            setFavoriteButton(filled: false)
        } else {
            itemStore.addFavorite(uuid: note.id, type: "note")
            setFavoriteButton(filled: true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        
        // If editing a note, fill in the UI elements
        if note != nil {
            setFavoriteButton(filled: itemStore.isFavorite(uuid: note.id))
            titleTextField.text = note.title
            // If there is an image associated, set it
            if note.image != "" {
                imageView.image = itemStore.getImage(filename: note.image)
            }
            imagePath = note.image
            bodyText.text = note.body
            
            type = 1
            self.navigationItem.title = note.title
            photoButton.setTitle("Change Photo", for: UIControlState.normal)
        } else {
            //setFavoriteButton(filled: false)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Allow the opening of the photo gallery
    @IBAction func openPhotoGallery(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(imagePicker, animated: true, completion: nil)
    }
    
    // When the photo has been selected
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any])
    {
        // Get selected image
        image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.contentMode = .scaleAspectFit
        // Set image in UI
        imageView.image = image
        
        // Save image to the documents folder
        imagePath = itemStore.saveImageDocumentDirectory(image: image)
        
        // Change the button to Change Photo
        photoButton.setTitle("Change Photo", for: UIControlState.normal)
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveNote(_ sender: UIButton) {
        if type == 0 {
            itemStore.createNote(title: titleTextField.text!, image: imagePath, body: bodyText.text!)
        } else {
            itemStore.updateNote(original: note, title: titleTextField.text!, image: imagePath, body: bodyText.text!)
        }
        navigationController?.popViewController(animated: true)
    }
}
