//
//  CoursesViewController.swift
//  isilAdmin
//
//  Created by kerwin Joel on 2/23/21.
//

import UIKit

class CoursesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func showList(_ sender: Any) {
        self.performSegue(withIdentifier: "ListCoursesViewController", sender: self)
    }
    
    
    @IBAction func showAdd(_ sender: Any) {
        self.performSegue(withIdentifier:
                            "AddCoursesViewController", sender:self)
    }
}
