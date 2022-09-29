//
//  CartProductViewController.swift
//  Sprint-2
//
//  Created by Capgemini-DA184 on 9/27/22.
//

import UIKit
import CoreData

class cartProdTableViewCell:UITableViewCell{
    @IBOutlet weak var nameTitletxt: UILabel!
    @IBOutlet weak var valueDescriptiontxt: UILabel!
    @IBOutlet weak var placeOrderButton: UIButton!
    
}

class CartProductViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storedDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartProdTableViewCell", for: indexPath) as! cartProdTableViewCell
        let result = storedDetails[indexPath.row]
        cell.nameTitletxt?.text = result.titles
        cell.valueDescriptiontxt?.text = result.prodDescription
        cell.placeOrderButton.tag = indexPath.row
        cell.placeOrderButton.addTarget(self, action: #selector(placeOrderBtn), for: .touchUpInside)
        
        return cell
    }
    
    @objc func placeOrderBtn(sender:UIButton){
        let indexpath1 = IndexPath(row:sender.tag,section: 0)
        let orderVc = storyboard?.instantiateViewController(withIdentifier: "PlaceOrderViewController") as? PlaceOrderViewController
        self.navigationController?.pushViewController(orderVc!, animated: true)
            }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "") { _, _, _ in
            self.context.delete(self.storedDetails[indexPath.row])
            self.saveContext()
            self.fetchCart()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let swipe = UISwipeActionsConfiguration(actions: [delete])
        
        return swipe
    }
    

    let context = ((UIApplication.shared.delegate) as! AppDelegate).persistentContainer.viewContext
    
    var storedDetails:[DataStored] = []
    
    var prodName: String?
    var prodDes: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.navigationItem.hidesBackButton = true
        saveCart()
        self.cartProdTableView.delegate = self
        self.cartProdTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchCart()
        cartProdTableView.reloadData()
    }
    
    @IBOutlet weak var cartProdTableView: UITableView!
    
    
    func saveContext(){
        if context.hasChanges{
            do{
                try context.save()
            }catch{
                print(error)
            }
        }
    }
    
    func saveCart(){
        let cartItem = NSEntityDescription.insertNewObject(forEntityName: "DataStored", into: context) as! DataStored
        cartItem.titles = prodName
        cartItem.prodDescription = prodDes
        saveContext()
    }
    
    
    func fetchCart(){
        let request = NSFetchRequest<DataStored>(entityName: "DataStored")
        do{
            storedDetails = try context.fetch(request)
            
        }catch{
            print(error)
        }
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
