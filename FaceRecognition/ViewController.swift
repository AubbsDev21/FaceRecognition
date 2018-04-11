//
//  ViewController.swift
//  FaceRecognition
//
//  Created by Aubre Body on 4/7/18.
//  Copyright © 2018 Aubre Body. All rights reserved.
//

import UIKit
import CoreImage
class ViewController: UIViewController {

    let imageV: UIImageView = {
        let view = UIImageView()
            view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        
        let tapview = UITapGestureRecognizer(target: self, action: #selector(SelcethandleView(sender:)))
        view.addGestureRecognizer(tapview)
        return view
    }()
    let imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(imageV)
        setup()
    }

    
    override func viewDidAppear(_ animated: Bool) {
        if imageV.image == nil {
            selectImage()
        }
    }
    
    func Recognition() {
        
    }

    func setup() {
        imageV.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        imageV.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    
    }
}

