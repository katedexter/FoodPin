//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Katherine Dexter on 3/23/17.
//  Copyright © 2017 KDexter. All rights reserved.
//
/*
import UIKit

class RestaurantTableViewController: UITableViewController {
    
    var restaurants:[Restaurant] = [
        Restaurant(name: "Dylan's Oyster Cellar", type: "Oysters", location: "Hampden", image: "petiteoyster.jpg", isVisited: false),
        Restaurant(name: "Rocket to Venus", type: "Pub Fare", location: "Hampden", image: "homei.jpg", isVisited: false),
        Restaurant(name: "Golden West", type: "Vegetarian", location: "Hampden", image: "teakha.jpg", isVisited: false),
        Restaurant(name: "Blue Pit", type: "BBQ", location: "Woodberry", image: "royaloak.jpg", isVisited: false),
        Restaurant(name: "Paulie Gee's", type: "Pizza", location: "Hampden", image: "cafedeadend.jpg", isVisited: false),
        Restaurant(name: "Wicked Sisters", type: "Eclectic", location: "Hampden", image: "forkeerestaurant.jpg", isVisited: false),
        Restaurant(name: "City Cafe", type: "Cafe / American", location: "Mt. Vernon", image: "posatelier.jpg", isVisited: false),
        Restaurant(name: "The Stable", type: "Pub Fare", location: "Mt. Vernon", image: "bourkestreetbakery.jpg", isVisited: false),
        Restaurant(name: "Parts & Labor", type: "Butcher", location: "Remington", image: "haighschocolate.jpg", isVisited: false),
        Restaurant(name: "Woodberry Kitchen", type: "Locally Sourced", location: "Woodberry", image: "palominoespresso.jpg", isVisited: false),
        Restaurant(name: "Corner Chacuterie", type: "Butcher", location: "Hampden", image: "upstate.jpg", isVisited: false),
        Restaurant(name: "Namaste", type: "Indian", location: "Coldspring", image: "traif.jpg", isVisited: false),
        Restaurant(name: "Arthouse", type: "Pizza", location: "Hampden", image: "grahamavenuemeats.jpg", isVisited: false),
        Restaurant(name: "Ekiben", type: "Asian", location: "Fells Point", image: "wafflewolf.jpg", isVisited: false),
        Restaurant(name: "Le Garage", type: "French", location: "Hampden", image: "fiveleaves.jpg", isVisited: false),
        Restaurant(name: "Ryliegh's Oyster", type: "Oyster", location: "Federal Hill", image: "cafelore.jpg", isVisited: false),
        Restaurant(name: "Brewer's Art", type: "Brewery", location: "Mt. Vernon", image: "confessional.jpg", isVisited: false),
        Restaurant(name: "Turps", type: "Sports Bar", location: "Midtown", image: "barrafina.jpg", isVisited: false),
        Restaurant(name: "Holy Frijoles", type: "Mexican", location: "Hampden", image: "donostia.jpg", isVisited: false),
        Restaurant(name: "Fraizers", type: "Pub Food", location: "Hampden", image: "cafeloisl.jpg", isVisited: false),
        Restaurant(name: "Tapas Teatro", type: "Tapas", location: "Station North", image: "caskpubkitchen.jpg", isVisited: false),
        
    ]
    /*
    //MARK: Array of restaurant names -- from the original program, prior to creating the Restaurant class
    var restaurantNames = ["Dylan's Oyster Cellar", "Rocket to Venus", "Golden West", "Blue Pit", "Paulie Gee's", "Wicked Sisters", "City Cafe", "The Stable", "Parts & Labor", "Woodberry Kitchen", "Corner Charcuterie", "Namaste", "Arthouse", "Ekiben", "Le Garage", "Ryleigh's Oyster", "Brewer's Art", "Turps", "Holy Frijoles", "Fraizers", "Tapas Teatro"]
    
    var restaurantLocations = ["Hampden", "Hampden", "Hampden", "Woodberry",                               "Hampden", "Hampden", "Mt. Vernon", "Mt. Vernon", "Remington", "Woodberry", "Hampden", "Coldspring", "Hampden", "Fells Point", "Hampden", "Federal Hill", "Mt. Vernon",
        "Midtown", "Hampden", "Hampden", "Station North"]
    
    var restaurantTypes = ["Oysters", "Pub Fare", "Vegetarian", "BBQ", "Pizza", "Eclectic", "Cafe / American", "Bar Food", "Butcher", "Locally Sourced", "Butcher", "Indian", "Pizza", "Asian", "French", "Seafood", "Brewery", "Sports Bar", "Mexican", "Pub Food", "Tapas"]

    //MARK: Array of image thumbnails
    var restaurantImages = ["cafedeadend.jpg", "homei.jpg", "teakha.jpg",
                            "cafeloisl.jpg", "petiteoyster.jpg", "forkeerestaurant.jpg", "posatelier.jpg",
                            "bourkestreetbakery.jpg", "haighschocolate.jpg", "palominoespresso.jpg",
                            "upstate.jpg", "traif.jpg", "grahamavenuemeats.jpg", "wafflewolf.jpg",
                            "fiveleaves.jpg", "cafelore.jpg", "confessional.jpg", "barrafina.jpg",
                            "donostia.jpg", "royaloak.jpg", "caskpubkitchen.jpg"]
    
    var restaurantIsVisited = Array(repeating: false, count: 21)
    
    */
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle:
        UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        // Deletes the current row
        if editingStyle == .delete {
            // Delete row from the source
            restaurants.remove(at: indexPath.row)
        }
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt
        indexPath: IndexPath) -> [UITableViewRowAction]? {
        // Social Sharing Button
        let shareAction = UITableViewRowAction(style:
            UITableViewRowActionStyle.default, title: "Share", handler: { (action,
                indexPath) -> Void in
                let defaultText = "Just checking in at " +
                    self.restaurants[indexPath.row].name
                
                if let imageToShare = UIImage(named:
                    self.restaurants[indexPath.row].image){
                
                let activityController = UIActivityViewController(activityItems:
                    [defaultText, imageToShare], applicationActivities: nil)
                    self.present(activityController, animated: true, completion: nil)
                }
        })
        // Delete button
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Delete",handler: { (action,
            indexPath) -> Void in
            // Delete the row from the data source
            self.restaurants.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        })
        shareAction.backgroundColor = UIColor(red: 89.0/255.0, green: 171.0/255.0,
                                              blue: 227.0/255.0, alpha: 1.0)
        deleteAction.backgroundColor = UIColor(red: 202.0/255.0, green: 202.0/255.0,
                                               blue: 203.0/255.0, alpha: 1.0)
        
        return [deleteAction, shareAction]
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    /*
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Create an option menu
        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
        
        // Add actions to the menu
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        optionMenu.addAction(cancelAction)
        
        
        // Add Call action
        let callActionHandler = { (action:UIAlertAction!) -> Void in
            let alertMessage = UIAlertController(title: "Service Unavailable", message:
                "Sorry, the call feature is not available yet. Please retry later.",
                                                 preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler:
                nil))
            self.present(alertMessage, animated: true, completion: nil)
        }
        let callAction = UIAlertAction(title: "Call " + "123-000-\(indexPath.row)",
            style: .default, handler: callActionHandler)
        optionMenu.addAction(callAction)
        
        // Check-in action
        let checkInTitle = restaurantIsVisited[indexPath.row] ? "Undo Check in" : "Check in"
        let checkInAction = UIAlertAction(title: checkInTitle, style: .default, handler: {
            (action:UIAlertAction!) -> Void in
            
            let cell = tableView.cellForRow(at: indexPath)
            
            // Toggle check-in and undo-check-in
            self.restaurantIsVisited[indexPath.row] = self.restaurantIsVisited[indexPath.row] ? false : true
            cell?.accessoryType = self.restaurantIsVisited[indexPath.row] ? .checkmark : .none
        })
        optionMenu.addAction(checkInAction)
        
        tableView.deselectRow(at: indexPath, animated: false)
        
    
        // Display the menu
        present(optionMenu, animated: true, completion: nil)
        
        
    }
    */
    

    // MARK: - Table view data source
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRestaurantDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as!
                RestaurantDetailViewController
                destinationController.restaurant =
                    restaurants[indexPath.row]
            }
        }
    }
 

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return restaurants.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
        
        // Configure the cell...
        cell.nameLabel.text = restaurants[indexPath.row].name
        cell.thumbnailImageView.image = UIImage(named: restaurants[indexPath.row].image)
        cell.locationLabel.text = restaurants[indexPath.row].location
        cell.typeLabel.text = restaurants[indexPath.row].type
        
        if restaurants[indexPath.row].isVisited{
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
 */
