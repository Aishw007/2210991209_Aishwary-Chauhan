//
//  RecipeListTableViewController.swift
//  2210991209_test2
//
//  Created by Aishwary Chauhan on 23/11/24.
//

import UIKit

class RecipeListTableViewController: UITableViewController {
    
    var meals: Meal = Meal(
        breakfast: [
            Recipe(
                name: "Pancakes",
                ingredients: "Flour, Eggs, Milk, Sugar",
                instructions: "Mix ingredients, cook on skillet until golden brown.",
                category: "Vegetarian",
                nutritionInfo: "Calories: 300, Protein: 6g, Carbs: 45g",
                thumbnail: "pancakes_thumbnail"
            ),
            Recipe(
                name: "Oatmeal with Fruits",
                ingredients: "Oats, Milk, Honey, Mixed Fruits",
                instructions: "Cook oats with milk, top with fruits and honey.",
                category: "Vegetarian",
                nutritionInfo: "Calories: 250, Protein: 8g, Carbs: 40g",
                thumbnail: "oatmeal_thumbnail"
            )
        ],
        lunch: [
            Recipe(
                name: "Rosted Chicken Salad",
                ingredients: "Chicken, Lettuce, Tomatoes, Cucumber, Dressing",
                instructions: "Roast chicken, mix with chopped veggies and dressing.",
                category: "Non-Vegetarian",
                nutritionInfo: "Calories: 350, Protein: 30g, Carbs: 15g",
                thumbnail: "chicken_salad_thumbnail"
            ),
            Recipe(
                name: "Vegetable Stir-fry",
                ingredients: "Broccoli, Bell Peppers, Carrots, Soy Sauce",
                instructions: "Stir-fry vegetables with soy sauce and spices.",
                category: "Vegan",
                nutritionInfo: "Calories: 200, Protein: 5g, Carbs: 30g",
                thumbnail: "stir_fry_thumbnail"
            )
        ],
        dinner: [
            Recipe(
                name: "Spaghetti Bolognese",
                ingredients: "Spaghetti, Ground Beef, Tomato Sauce, Herbs",
                instructions: "Cook spaghetti, prepare Bolognese sauce, combine.",
                category: "Non-Vegetarian",
                nutritionInfo: "Calories: 450, Protein: 20g, Carbs: 60g",
                thumbnail: "spaghetti_thumbnail"
            ),
            Recipe(
                name: "Vegetable Soup",
                ingredients: "Carrots, Potatoes, Peas, Onions, Spices",
                instructions: "Boil vegetables with spices, blend for a creamy texture.",
                category: "Vegan",
                nutritionInfo: "Calories: 150, Protein: 4g, Carbs: 25g",
                thumbnail: "soup_thumbnail"
            )
        ],
        snacks: [
            Recipe(
                name: "Fruit Smoothie",
                ingredients: "Banana, Berries, Yogurt, Honey",
                instructions: "Blend all ingredients until smooth.",
                category: "Vegetarian",
                nutritionInfo: "Calories: 180, Protein: 5g, Carbs: 25g",
                thumbnail: "smoothie_thumbnail"
            ),
            Recipe(
                name: "Granola Bars",
                ingredients: "Oats, Honey, Nuts, Dried Fruits",
                instructions: "Mix ingredients, bake until firm, cut into bars.",
                category: "Vegetarian",
                nutritionInfo: "Calories: 200, Protein: 6g, Carbs: 30g",
                thumbnail: "granola_thumbnail"
            )
        ]
    )


    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0: return meals.breakfast.count
            case 1: return meals.lunch.count
            case 2: return meals.snacks.count
            case 3: return meals.dinner.count
            default: return 0
        }
    
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mealCell", for: indexPath) as! RecipeListTableViewCell
        
        var recipe: Recipe
        
        switch indexPath.section {
            case 0: recipe = meals.breakfast[indexPath.row]
            case 1: recipe = meals.lunch[indexPath.row]
            case 2: recipe = meals.snacks[indexPath.row]
            case 3: recipe = meals.dinner[indexPath.row]
            default: recipe = Recipe(name: "", ingredients: "", instructions: "", category: "", nutritionInfo: "",thumbnail: "r1")
        }
        
        cell.update(using : recipe)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Breakfast"
        case 1: return "Lunch"
        case 2: return "Snacks"
        case 3: return "Dinner"
        default: return ""
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard  segue.identifier == "editSegue" else { return }
        let destinationVC = segue.destination as? RecipeAddEditTableViewController
        
        let indexPath = tableView.indexPathForSelectedRow!
        var selectedRecipe: Recipe?
        switch indexPath.section {
        case 0:
            selectedRecipe = meals.breakfast[indexPath.row]
        case 1:
            selectedRecipe = meals.lunch[indexPath.row]
        case 2:
            selectedRecipe = meals.snacks[indexPath.row]
        case 3:
            selectedRecipe = meals.dinner[indexPath.row]
        default:
            break
        }
        destinationVC?.recipe = selectedRecipe
        
    }
    
    
    @IBAction func unwindSegue(segue : UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind" else { return }
        if let sourceVC = segue.source as? RecipeAddEditTableViewController {
            if let recipe = sourceVC.recipe, let mealType = sourceVC.type {
                    if let indexPath = tableView.indexPathForSelectedRow {
                        switch indexPath.section {
                        case 0: meals.breakfast[indexPath.row] = recipe
                        case 1: meals.lunch[indexPath.row] = recipe
                        case 2: meals.snacks[indexPath.row] = recipe
                        case 3: meals.dinner[indexPath.row] = recipe
                        default: break
                        }
                        tableView.reloadData()
                    }
                    else {
                        switch mealType {
                        case "breakfast":
                            meals.breakfast.append(recipe)
                            let newIndexPath = IndexPath(row: meals.breakfast.count - 1, section: 0)
                            tableView.insertRows(at: [newIndexPath], with: .automatic)
                            
                        case "lunch":
                            meals.lunch.append(recipe)
                            let newIndexPath = IndexPath(row: meals.lunch.count - 1, section: 1)
                            tableView.insertRows(at: [newIndexPath], with: .automatic)
                            
                        case "snacks":
                            meals.snacks.append(recipe)
                            let newIndexPath = IndexPath(row: meals.snacks.count - 1, section: 2)
                            tableView.insertRows(at: [newIndexPath], with: .automatic)
                            
                        case "dinner":
                            meals.dinner.append(recipe)
                            let newIndexPath = IndexPath(row: meals.dinner.count - 1, section: 3)
                            tableView.insertRows(at: [newIndexPath], with: .automatic)
                            
                        default:
                            break
                        }
                    }
                }
            }
    }

}
