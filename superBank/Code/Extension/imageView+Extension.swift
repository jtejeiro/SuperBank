//
//  imageView+Extension.swift
//  superBank
//
//  Created by JTon 11/05/2020.
//  Copyright © 2020 JT. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func loadImageUrlString(_ urlString: String){
        let url =  URLRequest(url: URL(string: urlString)!)
        
        self.image = nil
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            
              DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
           
        }.resume()
    }
    
}
