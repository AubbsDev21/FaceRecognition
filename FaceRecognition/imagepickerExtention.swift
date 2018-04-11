//
//  imagepickerExtention.swift
//  FaceRecognition
//
//  Created by Aubre Body on 4/7/18.
//  Copyright © 2018 Aubre Body. All rights reserved.
//

import UIKit
import CoreImage

extension ViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
 @objc func SelcethandleView(sender: UITapGestureRecognizer) {
    print("got it ")
    for subview in imageV.subviews {
        subview.removeFromSuperview()
      }
       selectImage()
    }
    
    func  selectImage() {
        let picker = UIImagePickerController()
        //Helps with the UIpicker control
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var TheselectedImage: UIImage?
        
        if let orignalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            TheselectedImage = orignalImage
        }
            
        else if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            TheselectedImage = editedImage
            
        }
        
        dismiss(animated: true, completion: nil)
        
        //attaching selected image to view
        if let selectedImage = TheselectedImage  {
            OperationQueue.main.addOperation {
                self.imageV.contentMode = .scaleAspectFit
                self.imageV.image = selectedImage
            }
           
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
