//
//  ViewController.swift
//  KeaWatch
//
//  Created by Mikey Kane on 28/07/17.
//  Copyright © 2017 Kea Takers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Adding camera view
        let cameraView : CameraView = CameraView(nibName: "CameraView", bundle: nil)
        
        self.addChildViewController(cameraView)
        self.scrollView.addSubview(cameraView.view)
        cameraView.didMove(toParentViewController: self)
        
        // Adding gallery view
        let galleryView : GalleryView = GalleryView(nibName: "GalleryView", bundle: nil)
        
        self.addChildViewController(galleryView)
        self.scrollView.addSubview(galleryView.view)
        galleryView.didMove(toParentViewController: self)
        
        // moving gallery view to the right
        var galleryFrame : CGRect = galleryView.view.frame
        galleryFrame.origin.x = self.view.frame.width
        galleryView.view.frame = galleryFrame
        
        // Set width of scroll space
        self.scrollView.contentSize = CGSize(width: self.view.frame.width * 2, height: self.view.frame.height)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

