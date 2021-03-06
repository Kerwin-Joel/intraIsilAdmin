//
//  CareersViewController.swift
//  isilAdmin
//
//  Created by kerwin Joel on 2/23/21.
//

import UIKit

class CareersViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func showListCareers(_ sender: UIButton) {
        self.performSegue(withIdentifier: "ListCareersViewController", sender: self)
    }
    
    @IBAction func showFormCareers(_ sender: UIButton) {
        self.performSegue(withIdentifier: "FormCareersViewController", sender: self)
    }
}
