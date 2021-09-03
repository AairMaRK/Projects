//
//  ImageSaver.swift
//  Instafilter
//
//  Created by Egor Gryadunov on 14.08.2021.
//

import UIKit

class ImageSaver: NSObject
{
    var successHAndler: (() -> Void)?
    var errorHAndler: ((Error) -> Void)?
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }
    
    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            errorHAndler?(error)
        } else {
            successHAndler?()
        }
    }
}
