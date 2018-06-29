//
//  SIngUpViewController.swift
//  queComemosHoy
//
//  Created by Gianni on 27/6/18.
//  Copyright © 2018 Gianni. All rights reserved.
//

import UIKit
import Firebase

class SIngUpViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var confirmPasswordText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewAlert(error: String){
        let alertController = UIAlertController(title: "Error", message: error, preferredStyle: UIAlertControllerStyle.alert)
        let retryAction = UIAlertAction(title: "Retry", style: UIAlertActionStyle.default) {
            UIAlertAction in self.viewDidLoad()
        }
        alertController.addAction(retryAction)
        self.present(alertController, animated:true)
    }
    
    func viewAlertSuccess (success: String){
        let alertController = UIAlertController(title: "User registred", message: success, preferredStyle: UIAlertControllerStyle.alert)
        let retryAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            UIAlertAction in self.performSegue(withIdentifier: "SingUp", sender: nil)
        }
        alertController.addAction(retryAction)
        self.present(alertController, animated:true)
    }
    
    @IBAction func acceptButton(_ sender: Any) {
        if self.passwordText.text == self.confirmPasswordText.text {
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (user, error) in
                if error != nil {
                    self.viewAlert(error: "Impossible to register user")
                }else{
                    print("usuario registrado")
                    self.viewAlertSuccess(success: "registered user")
                }
            }
        }else{
            self.viewAlert(error: "Not match passwords")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let favouriteSignUp = segue.destination as? FavouriteFoodViewController
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
