//
//  BaseViewController.swift
//  superBank
//
//  Created by Jaime Tejeiro on 08/05/2020.
//  Copyright © 2020 Jaime Tejeiro. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func ShowAlert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
    
}
