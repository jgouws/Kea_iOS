//
//  SelectPhotoViewController.swift
//  KakaGo
//
//  Created by Mikey Kane on 15/09/17.
//  Copyright © 2017 Kea Takers. All rights reserved.
//

import UIKit

class SelectPhotoViewController: UIViewController {

    @IBOutlet weak var cameraButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pickAnImageFromGallery(_ sender: Any) {
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
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
