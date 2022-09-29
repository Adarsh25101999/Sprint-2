//
//  CategoryViewController.swift
//  Sprint-2
//
//  Created by Capgemini-DA184 on 9/27/22.
//

import UIKit
import Alamofire
import SwiftyJSON

class CategoryViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "myCell")
        cell?.textLabel?.text = categoryName[indexPath.row]
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowVc = storyboard?.instantiateViewController(withIdentifier: "ProductViewController") as? ProductViewController
        let selectedCategory = categoryName[indexPath.row]
        print(selectedCategory)
        rowVc?.name = selectedCategory
        self.navigationController?.pushViewController(rowVc!, animated: true)
        
    }
    

    @IBOutlet weak var myTableView: UITableView!
    
    var categoryName = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
        catefetch()
    }
    func catefetch(){
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        let myurl = "https://dummyjson.com/products/categories"
        Alamofire.request(myurl, method: .get).responseJSON{(myresponse) in
            switch myresponse.result{
            case .success:
                
                let myresult = try? JSON(data: myresponse.data!)
                let resultArray = myresult![]
                
                self.categoryName.removeAll()
                //print(myresponse.result)
                
                for i in resultArray.arrayValue{
                    let cateValue = i[].stringValue
                    self.categoryName.append(cateValue)
                }
                for i in self.categoryName{
                    print(i)
                }
                self.myTableView.reloadData()
                break
                
            case .failure:
                
            break
            }
            
        }

    }
}
