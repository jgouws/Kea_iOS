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
        self.submitButton.isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitObservation(_ sender: UIBarButtonItem) {
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
