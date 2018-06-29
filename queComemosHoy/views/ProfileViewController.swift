//
//  ViewController.swift
//  queComemosHoy
//
//  Created by Gianni on 9/6/18.
//  Copyright © 2018 Gianni. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    //Sign In - Sign Up
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var acceptButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = Auth.auth().currentUser;
        if ((user) != nil) {
            emailText.isHidden = true
            passwordText.isHidden = true
            emailLabel.isHidden=false
            passwordLabel.isHidden=true
            logoImage.isHidden=true
            acceptButton.isHidden = true
            
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        acceptButton.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        acceptButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
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
    
    func viewAlertSucces (succes: String){
        let alertController = UIAlertController(title: "OK", message: succes, preferredStyle: UIAlertControllerStyle.alert)
        let retryAction = UIAlertAction(title: "Continue", style: UIAlertActionStyle.default) {
            UIAlertAction in self.performSegue(withIdentifier: "FavouriteIdentifier", sender: nil)
        }
        alertController.addAction(retryAction)
        self.present(alertController, animated:true)
    }
    
    
    @IBAction func acceptButton(_ sender: Any) {
        
        
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { (user, error) in
                if error != nil {
                    self.viewAlert(error: "Impossible to authenticate user")
                }else{
                    print("usuario logeado")
                    self.performSegue(withIdentifier: "authenticate", sender: nil)
                }
            }

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let favouriteLogIn = segue.destination as? FavouriteFoodViewController
    }
    
    
}

