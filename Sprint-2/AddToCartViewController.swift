//
//  AddToCartViewController.swift
//  Sprint-2
//
//  Created by Capgemini-DA184 on 9/27/22.
//

/*import UIKit
import Alamofire
import SwiftyJSON

class productTableView:UITableViewCell{
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var descriptionProduct: UILabel!
   
    @IBOutlet weak var myButton: UIButton!
    
    
}
class AddToCartViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.productTableView.dequeueReusableCell(withIdentifier: "productTableView", for: indexPath) as! productTableView
        cell.productTitle.text = productName[indexPath.row]
        cell.descriptionProduct.text = productDescription[indexPath.row]
        cell.myButton.tag = indexPath.row
        cell.myButton.addTarget(self, action: #selector(addtoButton), for: .touchUpInside)
        return cell
    }
    
    @objc func addtoButton(sender:UIButton){
        let indexpath1 = IndexPath(row:sender.tag,section: 0)
        let cartVc = storyboard?.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController
        cartVc?.proname = productName[indexpath1.row]
        cartVc?.prodes = productDescription[indexpath1.row]
        self.navigationController?.pushViewController(cartVc!, animated: true)
    }
    
    var name: String?
    var productID = [String]()
    var productName = [String]()
    var productDescription = [String]()
    
    
    @IBOutlet weak var productTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func fetchProduct() {
        
        self.productTableView.delegate = self
        self.productTableView.dataSource = self
        let myurl = "https://dummyjson.com/products/category/" + name!
        Alamofire.request(myurl, method: .get).responseJSON{(myresponse) in
            switch myresponse.result{
            case .success:
                
                let myresult = try? JSON(data: myresponse.data!)
                let resultArray = myresult!["products"]
                
                self.productName.removeAll()
                self.productDescription.removeAll()
                //print(myresponse.result)
                
                for i in resultArray.arrayValue{
                    let proID = i["id"].stringValue
                    self.productID.append(proID)
                    let title = i["title"].stringValue
                    self.productName.append(title)
                    let description = i["description"].stringValue
                    self.productDescription.append(description)
                    
                    print(i)
                    
                    
                }
               
                self.productTableView.reloadData()
                break
                
            case .failure:
                
            break
            }
            
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

}*/
