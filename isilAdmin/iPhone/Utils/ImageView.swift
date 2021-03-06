//
//  ImageView.swift
//  isilAdmin
//
//  Created by Stalin Huallullo on 5/03/21.
//


import UIKit

typealias DownloadImage = (_ image: UIImage?, _ urlImage: String) -> Void

extension UIImageView {
    
    func downloadImageInURLString(_ urlString: String, placeHolderImage: UIImage?, success: @escaping DownloadImage) {
    
        self.image = placeHolderImage
        
        guard let urlImage = URL(string: urlString) else {
            print("La url no es válida")
            return
        }
    
        DispatchQueue.global(qos: .default).async {
            
            var imageData: Data!
            
            do {
                imageData = try Data(contentsOf: urlImage)
            }catch {
                print("Se produjo un error")
            }
            
            guard let imageDataSaved = imageData else { return }
            
            let imagenDownloaded = UIImage(data: imageDataSaved)
            
            DispatchQueue.main.async {
                success(imagenDownloaded, urlString)
            }
        }
    }
}
