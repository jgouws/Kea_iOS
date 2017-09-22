//
//  SelectPhotoViewController.swift
//  KakaGo
//
//  Created by Mikey Kane on 15/09/17.
//  Copyright © 2017 Kea Takers. All rights reserved.
//

import UIKit

/*
 Everything in this class represents code for the select photo screen. It inherits UIViewController which
 provide varies on call methods which are call depending on the app's state. States/methods like viewDidLoad,
 viewWillAppear, viewDidAppear.
 
 Other classes stated after that are protocols. Protocols are simalar to interfaces where certain functions require
 certain methods to be called, or you can override the optional methods. The most common protocols used (like in this
 code) are delegates.
 
 Delegates allow us to give different characteristics for the same type of UI object. Like a text field delegate
 can provide font details, or what to do when the return button is pressed.
 */

/**
 This View controller consists of 2 buttons to select photos from either the camera or the phone's photo gallery.
 This uses the built in Image Picker Controller and requires the use of the UIImagePickerControllerDelegate and
 UINavigationControllerDelegate
 */
class SelectPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
/* MARK: Initialise variables */
 
    // IBOutlets are references to a UI view on the screen.
    // weak means it's possible it won't be referenced, I think...
    // var is for variables that can have it's value changes ie. not a constant
    // (! or ?) is hard to explain, loosely it can be described that variable may or may not be nil
    @IBOutlet weak var cameraButton: UIButton!
    

/* MARK: ViewController override methods */
    
    /*
     Overridden on call method. This calls just before the view appears on screen.
     'super' need to be called to refer back to its parent.
     */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Check to see if camera is available. If not disable button.
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    /* MARK: Button actions */
    
    /**
     Method executes when "gallery" button is touched. All it does is display the gallery.
     Actions used when selecting pictures or cancelling selection are done on seperate on
     call methods.
     */
    @IBAction func pickAnImageFromGallery(_ sender: Any) {
        
        /* Create an image picker */
        // UIImagePickerController use to display a built in view for selecting images.
        // We use 'let' instead of 'var' because it's a constant and the refered class
        // is unlikely to change. Typically used inside functions.
        let imagePicker = UIImagePickerController()
        
        /* Set up the delegate */
        // This view controller implements the UIImagePickerControllerDelegate protocol
        // so it can set the delegate to itself
        imagePicker.delegate = self
        
        // Set the source type to photo album (as opposed to camera)
        imagePicker.sourceType = .savedPhotosAlbum
        
        // Finally present the image picker. Actions related to the image picker
        // are done from the methods called from the delegate
        present(imagePicker, animated: true, completion: nil)
    }
    
    /**
     Method executes when "camera" button is touched. It presents the camera interface
     from UIImagePickerController. Refer to pickAnImageFromGallery() method for more in depth
     detail on how this works.
     */
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        
        // Create image picker
        let imagePicker = UIImagePickerController()
        
        // Set delegate
        imagePicker.delegate = self
        
        // Set image picker source to camera
        imagePicker.sourceType = .camera
        
        // present image picker
        present(imagePicker, animated: true, completion: nil)
    }
    
    /* MARK: Image Picker Controller Delegate methods */
    
    /**
     This method is called when an image is selected on the image picker controller.
     It's also called when a photo is taken and confirmed.
     */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        print("image selected") // I was debugging, I should probably delete this.
        
        /* get selected image */
        // guard is like an if statement but if the conditions are not met
        // this can be combined with let statements so if assigning the value is unsuccessful,
        // say the value is actually nil, then the code can deal with it.
        // guard statements are a great way to avoid nested if statements and makes the code more readable.
        
        // (as! or as?) is a cast. In this case the variable 'observationPic' contains an image, the UIImage class/
        guard let observationPic = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            print("Failed to select image")
            return
        }
        /* send selected image to display on the next screen */
        // create a reference to the next screen.
        // the next screen has been given a storyboard ID on main.storyboard
        // instantiateViewController gives reference to the new screen based on the ID, returns UIViewController class
        // (as! or as?) is a cast, in this the View controller class that handles the variables and methods for the next screen.
        let observationController = self.storyboard!.instantiateViewController(withIdentifier: "NewObservationViewController") as! NewObservationViewController
        
        // NewObservationViewController has a global variable 'observationPhoto' to store the image to be processed
        // assign image to that
        observationController.observationPhoto = observationPic
        
        // A navigation controller is what powers the back button at the top of the screen
        // Think of it like a stack. You add to the stack with 'push' method and pressing the back button
        // takes away from the stack (pop)
        // This line of code opens up the next screen.
        self.navigationController?.pushViewController(observationController, animated: true)
        
        // Finally, just to tidy up, dismiss the image picker since we're not using it anymore.
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    /**
     This method is called when the cancel button is pressed on the image picker
     */
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // We want the image picker to disappear and not do anything so just dismiss it.
        picker.dismiss(animated: true, completion: nil)
    }

}
