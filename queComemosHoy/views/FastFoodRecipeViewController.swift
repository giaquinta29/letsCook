//
//  FastFoodRecipeViewController.swift
//  queComemosHoy
//
//  Created by Gianni on 22/6/18.
//  Copyright © 2018 Gianni. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase

class FastFoodRecipeViewController: UIViewController {

    var recipeSelected: Recipe!
    var ref: DatabaseReference?
    var userNow = ""
    
    @IBOutlet weak var nameFood: UILabel!
    @IBOutlet weak var imageFoodRecipe: UIImageView!
    
    @IBOutlet weak var list: UITextView!
    @IBOutlet weak var favouriteButton: UIButton!
    
    @IBOutlet weak var recipeButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameFood.numberOfLines = 2;
        nameFood.text = recipeSelected.name
        self.view.addSubview(nameFood);
        list.text = recipeSelected.ingredients!.joined(separator: ".\n")
        imageFoodRecipe.sd_setImage(with: URL(string: (recipeSelected.image_url)!), placeholderImage: UIImage(named: "placeholder.png"))
        recipeButton.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        recipeButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        let user = Auth.auth().currentUser;
        
        if ((user) != nil) {
            favouriteButton.isHidden=false
            userNow = (user?.email)!
            print (user?.email)
            // User is signed in.
        } else {
            favouriteButton.isHidden=true
            // No user is signed in.
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
    
    @IBAction func favouriteButton(_ sender: Any) {
        
        ref = Database.database().reference().child("favouriteFood").childByAutoId()
        
        //Now set profile node
        ref?.child("Recipe").setValue([
            "label": recipeSelected.name!,
            "ingredientLines": recipeSelected.ingredients!,
            "image": recipeSelected.image_url!,
            "calories": recipeSelected.calories!,
            "totalTime": recipeSelected.time!,
            "url": recipeSelected.url!
            ])
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
