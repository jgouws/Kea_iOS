//
//  NewObservationViewController.swift
//  KakaGo
//
//  Created by Nigel Munro on 15/09/17.
//  Copyright © 2017 Kea Takers. All rights reserved.
//

import UIKit

class NewObservationViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Outlets
    @IBOutlet weak var observationImageView: UIImageView!
    @IBOutlet weak var observationTextField: UITextField!
    @IBOutlet weak var submitButton: UIBarButtonItem!
    
    // Selected image from previous screen
    var observationPhoto: UIImage!

    // MARK: App states
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the text field's delegate
        observationTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Set image to image view
        observationImageView.image = observationPhoto
        
        // receive notifications for when keyboard appears
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // unsubscribe when done
        unsubscribeToKeyboardNotifications()
    }

    /**
     Method to submit text from the text field to the server.
     */
    @IBAction func submitObservation(_ sender: UIBarButtonItem) {
        
        var request = URLRequest(url: URL(string: "http://localhost:3000/appupload")!)
        request.httpMethod = "POST"
        let postString = "data=" + observationTextField.text!;
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // check for fundamental networking error
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                return
            }
            // check for http errors
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
        }
        task.resume()
        
    }
    
    // MARK: Text Field Delegate methods
    
    /**
    Method used when the return button is used.
    */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder() // close on screen keyboard
    }
    
    // MARK: Keyboard handling methods
    
    /**
     Method that subscribes to keyboard nottifications and the functions that will be called
     when the notification occurs.
     */
    func subscribeToKeyboardNotifications() {
        // "keyboard will show" notification
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: .UIKeyboardWillShow,
                                               object: nil)
        // "keyboard will hide" notification
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: .UIKeyboardWillHide,
                                               object: nil)
    }
    
    /**
     Clean up method to unsubscribe from notifications when done.
     */
    func unsubscribeToKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self,
                                                  name: .UIKeyboardWillShow,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: .UIKeyboardWillHide,
                                                  object: nil)
        
    }
    
    // MARK: Keyboard call methods
    
    /// Method used when keyboard is about to show.
    func keyboardWillShow(_ notification: Notification) {
//        if observationTextField.isFirstResponder {
//            view.frame.origin.y -= getKeyboardHeight(notification)
//        }
    }
    
    /// Method used when keyboard is about to hide.
    func keyboardWillHide(_ notification: Notification) {
//        if observationTextField.isFirstResponder {
//            view.frame.origin.y += getKeyboardHeight(notification)
//        }
    }
    
    /// Method to get the keyboard height from the Notification class
    func getKeyboardHeight(_ notification: Notification) -> CGFloat{
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
}
