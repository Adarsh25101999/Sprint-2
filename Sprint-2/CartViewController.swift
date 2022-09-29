
/*
import UIKit
import CoreData
class cartTableViewCell: UITableViewCell{

    
    
}
class CartViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    let context = ((UIApplication.shared.delegate) as! AppDelegate).persistentContainer.viewContext
    
    var proname: String?
    var prodes: String?
    
    var cartDetails:[CartData] = []

    var productname: [String] = []
    var desProduct: [String] = []
    
    func addVal(){
        productname.append(proname!)
        desProduct.append(prodes!)
        }
    
    @IBOutlet weak var cartTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //addVal()
        
        saveInCart()
        
        self.cartTableView.delegate = self
        self.cartTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchDetails()
        cartTableView.reloadData()
    }
    
    func saveContext(){
        if context.hasChanges{
            do{
                try context.save()
            }catch{
                print(error)
            }
        }
    }
    
    func saveInCart(){
        
        let cartItem = NSEntityDescription.insertNewObject(forEntityName: "CartData", into: context) as! CartData
        cartItem.nameofproduct = proname
        cartItem.descripofproduct = prodes
        saveContext()
    }
    
    func fetchDetails(){
        let request = NSFetchRequest<CartData>(entityName: "CartData")
        do{
        cartDetails = try context.fetch(request)
            print("fetched")
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartTableViewCell", for: indexPath) as! cartTableViewCell
        let result = cartDetails[indexPath.row]
        cell.poductnametxt?.text = result.nameofproduct
        print(cell.poductnametxt!)
        cell.productDestxt?.text = result.descripofproduct
        return cell
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "") { _, _, _ in
            self.context.delete(self.cartDetails[indexPath.row])
            self.saveContext()
            self.fetchDetails()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let swipe = UISwipeActionsConfiguration(actions: [delete])
        
        return swipe
    }

}*/

