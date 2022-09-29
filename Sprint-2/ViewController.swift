//
//  ViewController.swift
//  Sprint-2
//
//  Created by Capgemini-DA184 on 9/27/22.
//

import UIKit
import FirebaseAuth
import CoreData
import LocalAuthentication
import Security


class ViewController: UIViewController {
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var emailID: UITextField!
    // MARK: IBOutlets End
    // MARK: Variables Start
    var authenticationError: NSError?
    let context = LAContext()
    // MARK: Variables End
    override func viewDidLoad() {
        super.viewDidLoad()
        logoImageView.layer.cornerRadius = logoImageView.frame.size.width / 2
        logoImageView.clipsToBounds = true
       // authenticateUserByPasscode()
        authenticateUserByBiometrics()
        self.navigationItem .setHidesBackButton(true, animated: true)
        self.title = "Login"
    }

    // MARK: IBActions Start
    @IBAction func loginActionButton(_ sender: Any) {
        // Passing emailvalue to valid email function
        authenticateUsingFirebase(emailText: emailID.text!, passwordText: password.text!)
    }
    @IBAction func signupActionButton(_ sender: Any) {
        
        let signUpVc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        self.navigationController?.pushViewController(signUpVc, animated: true)
    }
    // MARK: IBActions End
    
    // MARK: Functions Start
    func authenticateUserByBiometrics() {
        let authenticatingMsg = "Face ID is required to access this app."
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authenticationError){
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: authenticatingMsg, reply: { [weak self] success, error in
                DispatchQueue.main.async() {
                    if success {
                        self?.showAlert(popUptitle: "Success", alertMessage: "Authentication Successful")
                    }
                }
            })
        }
        else {
            self.showAlert(popUptitle: "Error", alertMessage: "Authentication Failed")
            exit(0)
            
        }
    }
    func authenticateUserByPasscode() {
        
        let authenticationMsg = "Authentication is required to access this app."
        
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authenticationError) {
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: authenticationMsg, reply: { success, error in
                DispatchQueue.main.async {
                    if success {
                        self.showAlert(popUptitle: "Success", alertMessage: "Authentication Successful")
                    }
                    else {
                        if let error = error {
                        
                let errorMsg = self.errorMsgWithErrorCode(errorCode: error as! Int)
                            print(errorMsg)
                        }
                    }
                }
            })
        }
    }
    func errorMsgWithErrorCode(errorCode: Int) -> String {
        var errorMessage = " "
        switch errorCode {
        case LAError.appCancel.rawValue:
            errorMessage = "Authentication was cancelled by app"
        case LAError.authenticationFailed.rawValue:
            errorMessage = "Authentication failed"
        default:
            errorMessage = "Common Error"
        }
        return errorMessage
    }
    func showAlert(popUptitle: String, alertMessage: String) {
        
        // Dialog box contents
        let alertController = UIAlertController(title: popUptitle, message: alertMessage, preferredStyle: .alert)
        
        // Action Button
        let  okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        
        // Pop up dialog box with contents
        self.present(alertController, animated: true)
    }
    
    func checkEmail(emailText: String) -> Bool {
        
        // Checking if the managed object is not returning exit code zero
        guard let appDelegate = UIApplication.shared
            .delegate as? AppDelegate else { return 0 != 0}
        
        // Creating context to access persistentContainer class
        let context = appDelegate.persistentContainer.viewContext
        
        // Passing fetch request method to request variable
        let request: NSFetchRequest<CustomerData> = CustomerData.fetchRequest()
        
        // Comparing text provided by user with email present in the core data
        request.predicate = NSPredicate(format: "%K == %@", argumentArray: ["emailId", emailText])
        
        // Creating variable of type NSManagedObject
        var result: [NSManagedObject] = []
        do {
            // Storing email value if exist in core data by calling fetch request
            result = try context.fetch(request)
        }
        catch (let error) {
            print(error.localizedDescription)
        }
        return result.count > 0
    }
    func authenticateUsingFirebase(emailText: String, passwordText: String) {
        
        Auth.auth().signIn(withEmail: emailText, password: passwordText, completion: {
            (result, error) -> Void in
            if error != nil {
                self.showAlert(popUptitle: "Invalid", alertMessage: "User does not exist. Please signup.")
            }
            else {
            
                do {
                    // Passing values to Keychainmanager class function to save
                    try KeyChainManager.save(
                        account: self.emailID.text!, password: self.password.text!.data(using: .utf8) ?? Data())
                }
                catch (let error) {
                    print(error.localizedDescription)
                }
                // Pushing or navigating to employee screen
                let tabVc = self.storyboard?.instantiateViewController(withIdentifier: "tab") as! UITabBarController
                self.navigationController?.pushViewController(tabVc, animated: true)
                
            }
        })

    }
    // MARK: Functions End
}

// Creating class for KeyChain
class KeyChainManager {
    
    // Creating enum for different types of error so to access each options
    enum KeyChainError: Error {
        case duplicateEntry
        case unknown(OSStatus)
    }
    // Function to Add email and password in keychain
    static func save(account: String, password: Data) throws {
        
        // keyChain Items
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account as AnyObject,
            kSecValueData as String: password as AnyObject
            ]
        
        // Calling function SecItemAdd to add the values in dictionary
        let status = SecItemAdd(query as CFDictionary, nil)
        
        // Checking if values already added in keychain
        guard status == errSecDuplicateItem else {
            throw KeyChainError.duplicateEntry
        }
        // To check the values added sucessfully
        guard status == errSecSuccess else {
            throw KeyChainError.unknown(status)
        }
    }



}


