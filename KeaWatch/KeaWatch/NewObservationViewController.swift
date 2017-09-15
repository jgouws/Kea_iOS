//
//  NewObservationViewController.swift
//  KakaGo
//
//  Created by Nigel Munro on 15/09/17.
//  Copyright © 2017 Kea Takers. All rights reserved.
//

import UIKit

class NewObservationViewController: UIViewController {
    
    
    @IBOutlet weak var observationImageView: UIImageView!
    @IBOutlet weak var observationTextField: UITextField!
    @IBOutlet weak var submitButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //self.submitButton.isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitObservation(_ sender: UIBarButtonItem) {

        print("send");
        
        var request = URLRequest(url: URL(string: "http://localhost:3000/appupload")!)
        request.httpMethod = "POST"
        let postString = "data=" + observationTextField.text!;
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
        }
        task.resume()
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
