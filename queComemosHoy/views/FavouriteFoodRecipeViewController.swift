//
//  FavouriteFoodRecipeViewController.swift
//  queComemosHoy
//
//  Created by Gianni on 28/6/18.
//  Copyright © 2018 Gianni. All rights reserved.
//

import UIKit
import Firebase

class FavouriteFoodRecipeViewController: UIViewController {
    
    var recipeSelected: Recipe!
    var ref: DatabaseReference?
    var userNow = ""
    
    
    @IBOutlet weak var nameFood: UILabel!
    @IBOutlet weak var imageFoodRecipe: UIImageView!
    
    @IBOutlet weak var recipeButton: UIButton!
    
    @IBOutlet weak var list: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameFood.numberOfLines = 2
        nameFood.text = recipeSelected.name
        self.view.addSubview(nameFood);
        list.text = recipeSelected.ingredients!.joined(separator: ".\n")
        imageFoodRecipe.sd_setImage(with: URL(string: (recipeSelected.image_url)!), placeholderImage: UIImage(named: "placeholder.png"))
        recipeButton.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        recipeButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        let user = Auth.auth().currentUser;
        if ((user) != nil) {
            
            userNow = (user?.email)!
            
          
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapRecipe(_ sender: Any) {
        UIApplication.shared.open(NSURL(string: recipeSelected.url!)! as URL)
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
