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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var newImage: UIImage
        
      
        if let possibleImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            newImage = possibleImage
        } else {
            return
        }
        
        OperationQueue.main.addOperation {
            self.imageV.contentMode = .scaleAspectFit
            self.imageV.image = newImage
            self.Recognition()
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
