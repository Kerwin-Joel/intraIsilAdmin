

import UIKit

class LocationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func showListVenues(_ sender: UIButton) {
        self.performSegue(withIdentifier: "ListVenuesViewController", sender: self)
    }
    
    
    @IBAction func showFromVenues(_ sender: UIButton) {
        self.performSegue(withIdentifier: "FormVenuesViewController", sender: self)
    }
    

}
