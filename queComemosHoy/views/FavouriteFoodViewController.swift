//
//  FavouriteFoodViewController.swift
//  queComemosHoy
//
//  Created by Gianni on 27/6/18.
//  Copyright © 2018 Gianni. All rights reserved.
//

import UIKit
import Firebase
import ObjectMapper
import SDWebImage

class FavouriteFoodViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var hits: [Recipe] = []
    var recipeSelected: Recipe!
    var filteredRecipes = [Recipe]()
    var ref: DatabaseReference?
    var handle: DatabaseHandle?
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    @IBOutlet weak var favouriteFoodTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favouriteFoodTable.delegate = self
        favouriteFoodTable.dataSource = self
        let user = Auth.auth().currentUser;
        if ((user) != nil) {
            
            ref = Database.database().reference()
            handle = ref?.child("favouriteFood").observe(.childAdded, with: { (snapshot) in
                
                guard let value = snapshot.value as? [String : [String : Any]] else {
                    return
                }
                if let recipe: Recipe = Mapper<Recipe>().map(JSON: value["Recipe"] ?? [:]){
                    self.hits.append(recipe)
                    self.filteredRecipes = self.hits
                    self.searchController.searchResultsUpdater = self as? UISearchResultsUpdating
                    self.searchController.dimsBackgroundDuringPresentation = false
                    self.definesPresentationContext = true
                    self.favouriteFoodTable.tableHeaderView = self.searchController.searchBar
                    self.favouriteFoodTable.reloadData()
                }else{
                    self.viewAlert(error: "Error Connection")
                }
            })
            
        } else {
            performSegue(withIdentifier: "SingIn", sender: nil)
            // No user is signed in.
        }
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredRecipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellFood = self.favouriteFoodTable.dequeueReusableCell(withIdentifier: "listRecipesIdentifier") as! ListRecipesTableViewCell
        let recipeFood: Recipe
        recipeFood = filteredRecipes[indexPath.row]
        cellFood.nameFood.text = recipeFood.name
        cellFood.photoFood.sd_setImage(with: URL(string: (recipeFood.image_url)!), placeholderImage: UIImage(named: "placeholder.png"))
        cellFood.caloriesFood.text = recipeFood.calories.map(String.init)
        cellFood.timeFood.text = recipeFood.time.map(String.init)
        return cellFood
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        recipeSelected = hits[indexPath.row]
        performSegue(withIdentifier: "ShowFavouriteRecipe", sender: nil)
    
    }
    
//    func updateSearchResults(for searchController: UISearchController) {
//        if searchController.searchBar.text! == "" || searchController.searchBar.text! == nil{
//            filteredRecipes = hits
//        }else{
//            filteredRecipes = hits.filter( {($0.name?.lowercased().contains(searchController.searchBar.text!.lowercased()))!} )
//        }
//        self.favouriteFoodTable.reloadData()
//    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text! == "" || searchController.searchBar.text! == nil{
            filteredRecipes = hits
        }else{
            filteredRecipes = hits.filter( {($0.name?.lowercased().contains(searchController.searchBar.text!.lowercased()))!} )
        }
        self.favouriteFoodTable.reloadData()
    }
    
    
    @IBAction func logOutButton(_ sender: Any) {
        do{
            try
                Auth.auth().signOut()
            self.viewDidLoad()
            print ("chau")
        }catch let error {
            print ("\(error)")
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let favouriteFoodRecipe = segue.destination as? FavouriteFoodRecipeViewController{
            favouriteFoodRecipe.recipeSelected = recipeSelected
        }
        if let signIn = segue.destination as? ProfileViewController{
            
        }
        
    }
 

}
