//
//  BaseViewController.swift
//  superBank
//
//  Created by JT on 08/05/2020.
//  Copyright © 2020 JT. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func ShowAlert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
    
    
    
}
