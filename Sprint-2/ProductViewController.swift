//
//  ProductViewController.swift
//  Sprint-2
//
//  Created by Capgemini-DA184 on 9/27/22.
//

import UIKit
import Alamofire
import SwiftyJSON
class ProtTableViewCell:UITableViewCell{
    @IBOutlet weak var titleTxt: UILabel!
    @IBOutlet weak var descriptionTxt: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    
}
class ProductViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.ProTableView.dequeueReusableCell(withIdentifier: "ProtTableViewCell", for: indexPath) as! ProtTableViewCell
        cell.titleTxt?.text = productName[indexPath.row]
        cell.descriptionTxt?.text = productDescription[indexPath.row]
        cell.addBtn.tag = indexPath.row
        cell.addBtn.addTarget(self, action: #selector(appendtoButton), for: .touchUpInside)
        return cell
    }
    @objc func appendtoButton(sender:UIButton){
        let indexpath1 = IndexPath(row:sender.tag,section: 0)
        let cartVc = storyboard?.instantiateViewController(withIdentifier: "CartProductViewController") as? CartProductViewController
        cartVc?.prodName = productName[indexpath1.row]
        cartVc?.prodDes = productDescription[indexpath1.row]
        self.navigationController?.pushViewController(cartVc!, animated: true)
    }
    
    var name: String?
    var productID = [String]()
    var productName = [String]()
    var productDescription = [String]()
    
    @IBOutlet weak var ProTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
        fetchProduct()
    }
    
    func fetchProduct() {
        
        self.ProTableView.delegate = self
        self.ProTableView.dataSource = self
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
               
                self.ProTableView.reloadData()
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

}
