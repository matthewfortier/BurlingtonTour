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
    
    var type: Int = 0
    var orignialTitle: String = ""
    
    var chosenImage: UIImage!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bodyText: UITextView!
    @IBOutlet weak var photoButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setFavoriteButton(filled: false)
    }
    
    func setFavoriteButton(filled: Bool) {
        var buttonIcon: UIImage!
        
        buttonIcon = filled ? UIImage(named: "fav-filled") : UIImage(named: "fav")
        
        let rightBarButton = UIBarButtonItem(title: "Favorite", style: UIBarButtonItemStyle.done, target: self, action: #selector(PlaceViewController.addFavorite2))
        rightBarButton.image = buttonIcon
        
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func addFavorite2() {
//        if (fav){
//            fav = false
//            //sender.setTitle("Unfavorite", for: .normal)
//            setFavoriteButton(filled: false)
//        }
//        else {
//            fav = true
//            //sender.setTitle("Favorite", for: .normal)
//            setFavoriteButton(filled: true)
//            
//        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        
        if note != nil {
            
            titleTextField.text = note.title
            imageView.image = note.image
            bodyText.text = note.body
            
            type = 1
            self.navigationItem.title = note.title
            orignialTitle = note.title
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
        image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        photoButton.setTitle("Change Photo", for: UIControlState.normal)
        dismiss(animated:true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveNote(_ sender: UIButton) {
        if type == 0 {
            itemStore.createNote(title: titleTextField.text!, image: image, body: bodyText.text!)
        } else {
            itemStore.updateNote(original: note, title: titleTextField.text!, image: image, body: bodyText.text!)
        }
        //performSegue(withIdentifier: "unwindToTableView", sender: self)
        navigationController?.popViewController(animated: true)
    }
}
