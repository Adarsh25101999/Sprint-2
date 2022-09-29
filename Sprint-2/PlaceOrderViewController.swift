//
//  PlaceOrderViewController.swift
//  Sprint-2
//
//  Created by Capgemini-DA184 on 9/27/22.
//

import UIKit
import NotficationFramework

class PlaceOrderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        // Do any additional setup after loading the view.
    }
    
    @IBAction func notificationButton(_ sender: Any) {
        let getNotification = localNotice()
        getNotification.localNotification(title: "Order Confirmation", body: "Your Order Has been placed SUCCESSFULLY")
        exit(0)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
