//
//  FastFoodViewController.swift
//  queComemosHoy
//
//  Created by Gianni on 20/6/18.
//  Copyright © 2018 Gianni. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import SDWebImage

class FastFoodViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    let url = "https://api.edamam.com/search?q=fast%20food&app_id=c43d9a65&app_key=726cd7db10ed41c374ec479a44db021f"
    var hits: [Recipes] = []
    var recipeSelected: Recipe!
    var filteredRecipes = [Recipes]()
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var recipesTable: UITableView!
    @IBOutlet weak var waitConnectIndicator: UIActivityIndicatorView!
    
    
//    let generalParams = ["app_id": "c43d9a65",
//                         "app_key": "726cd7db10ed41c374ec479a44db021f"]
//
//    func search(category: String, completion: ([ListRecipes]?) -> ()) {
//        var params = generalParams
//        params["q"] = category
//        request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil) { response in
    
//
//
//        }
//
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipesTable.delegate = self
        recipesTable.dataSource = self
        
        waitConnectIndicator.startAnimating()
        
//        search(category: "") { (list) in
//
//        }
        
        request(url).responseJSON{ response in
            
            self.waitConnectIndicator.stopAnimating()
            if let listRecipesJSON = response.result.value {
                
                if let listRecipes: ListRecipes = Mapper<ListRecipes>().map(JSON: listRecipesJSON as! [String : Any]){
                    
                    self.hits = listRecipes.hits!
                    self.filteredRecipes = self.hits
                    self.searchController.searchResultsUpdater = self as? UISearchResultsUpdating
                    self.searchController.dimsBackgroundDuringPresentation = false
                    self.definesPresentationContext = true
                    self.recipesTable.tableHeaderView = self.searchController.searchBar
                    self.recipesTable.reloadData()
                    
                }
                    
                
            }else{
                self.viewAlert()
            }
            
        }
        
        
        
        
        
    }
    
    
    func viewAlert(){
        let alertController = UIAlertController(title: "Error Connection", message: "The app don't have internet", preferredStyle: UIAlertControllerStyle.alert)
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
        let cellFood = self.recipesTable.dequeueReusableCell(withIdentifier: "listRecipesIdentifier") as! ListRecipesTableViewCell
        let recipeFood: Recipes
        recipeFood = filteredRecipes[indexPath.row]
        cellFood.nameFood.text = recipeFood.recipe?.name
        cellFood.photoFood.sd_setImage(with: URL(string: (recipeFood.recipe?.image_url)!), placeholderImage: UIImage(named: "placeholder.png"))
        cellFood.caloriesFood.text = recipeFood.recipe?.calories.map(String.init)
        cellFood.timeFood.text = recipeFood.recipe?.time.map(String.init)
        return cellFood
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        recipeSelected = hits[indexPath.row].recipe
        performSegue(withIdentifier: "showFastFoodRecipe", sender: nil)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text! == "" || searchController.searchBar.text! == nil{
             filteredRecipes = hits
        }else{
            filteredRecipes = hits.filter( {($0.recipe?.name?.lowercased().contains(searchController.searchBar.text!.lowercased()))!} )
        }
        self.recipesTable.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if let foodRecipe = segue.destination as? FastFoodRecipeViewController {
         foodRecipe.recipeSelected = recipeSelected
         }
    }
    
    

}
