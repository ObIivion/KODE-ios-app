//
//  ImageResizer.swift
//  NoStoryboard
//
//  Created by Павел Виноградов on 15.06.2022.
//

import UIKit

class ImageResizer{
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage{
        
        let currentSize = image.size
        
        let widthRatio = targetSize.width / currentSize.width
        let heightRatio = targetSize.height / currentSize.height
        
        let newSize = CGSize(width: currentSize.width * widthRatio, height: currentSize.height * heightRatio)
        
        let rect = CGRect(origin: .zero, size: newSize)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
}
