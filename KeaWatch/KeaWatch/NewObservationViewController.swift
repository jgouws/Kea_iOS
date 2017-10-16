//
//  NewObservationViewController.swift
//  KakaGo
//
//  Created by Nigel Munro and Michael Kane on 15/09/17.
//  Copyright © 2017 Kea Takers. All rights reserved.
//

import UIKit

class NewObservationViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Outlets
    @IBOutlet weak var observationImageView: UIImageView!
    @IBOutlet weak var observationTextField: UITextField!
    //@IBOutlet weak var submitButton: UIBarButtonItem!
    
    // Selected image from previous screen
    var observationPhoto: UIImage!
    
    // MARK: App states
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the text field's delegate
        observationTextField.delegate = self
        
        // set up the submit button
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Send Observation", style: .plain, target: self, action: #selector(submitObservation(_:)))
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
    func submitObservation(_ sender: UIBarButtonItem) {
        
        let url = NSURL(string: "http://localhost:8081/uploadedfromapp")
        
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "POST"
        
        let boundary = generateBoundaryString()
        
        //define the multipart request type
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        if (observationImageView.image == nil)
        {
            return
        }
        //UIImagePNGRepresentation(observationImageView.image!)
        let image_data = UIImageJPEGRepresentation(observationImageView.image!, 1)
        
        
        if(image_data == nil)
        {
            return
        }
        
        
        let body = NSMutableData()
        
        let fname = "test.jpg"
        let mimetype = "image/jpg"
        
        //define the data post parameter
        
        
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition: form-data; name=\"filetoupload\"; filename=\"\(fname)\"\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append(image_data!)
        //body.append("imaaggee\r\n".data(using: String.Encoding.utf8)!)
        body.append("\r\n".data(using: String.Encoding.utf8)!)
        
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition: form-data; name=\"fields\"; filename=\"fields.txt\"\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Type: text/plain\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append("Uploaded From IOS\r\n".data(using: String.Encoding.utf8)!)

        
        body.append("--\(boundary)--".data(using: String.Encoding.utf8)!)
        
        
        
        request.httpBody = body as Data
        
        let session = URLSession.shared
        
        
        let task = session.dataTask(with: request as URLRequest) {
            (
            data, response, error) in
            
            guard let _:NSData = data as NSData?, let _:URLResponse = response, error == nil else {
                print("error")
                return
            }
            
            //let dataString = NSString(data: body as Data, encoding: String.Encoding.utf8.rawValue)
            //print(dataString as! String)
            
        }
        
        task.resume()
        
    }
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
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
