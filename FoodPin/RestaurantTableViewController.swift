//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Katherine Dexter on 4/4/2017.
//  
//

import UIKit
import CoreData

class RestaurantTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating {

    @IBAction func unwindToHomeScreen(segue: UIStoryboardSegue){
        
    }
    var restaurants:[RestaurantMO] = []
    var fetchResultController: NSFetchedResultsController<RestaurantMO>!
    var searchController: UISearchController!
    var searchResults:[RestaurantMO] = []
    
    /*
        RestaurantMO[.addObject([)name: "Dylan's Oyster Cellar", type: "Oysters", location: "3601 Chestnut Ave, Baltimore, MD 21211", image: "petiteoyster.jpg", isVisited: false])
    
    
    
        Restaurant(name: "Rocket to Venus", type: "Pub Fare", location: "3360 Chestnut Ave, Baltimore, MD 21211", image: "homei.jpg", phone: "444-444-4444", isVisited: false),
        Restaurant(name: "Golden West", type: "Vegetarian", location: "1105 W 36th St, Baltimore, MD 21211", image: "teakha.jpg", phone: "444-444-4444", isVisited: false),
        Restaurant(name: "Blue Pit", type: "BBQ", location: "1601 Union Ave, Baltimore, MD 21211", image: "royaloak.jpg", phone: "444-444-4444", isVisited: false),
        Restaurant(name: "Paulie Gee's", type: "Pizza", location: "3535 Chestnut Ave, Baltimore, MD 21211", image: "cafedeadend.jpg", phone: "444-444-4444", isVisited: false),
        Restaurant(name: "Wicked Sisters", type: "Eclectic", location: "3845 Falls Rd, Baltimore, MD 21211", image: "forkeerestaurant.jpg", phone: "444-444-4444", isVisited: false),
        Restaurant(name: "City Cafe", type: "Cafe / American", location: "1001 Cathedral St, Baltimore, MD 21201", image: "posatelier.jpg", phone: "444-444-4444", isVisited: false),
        Restaurant(name: "The Stable", type: "Pub Fare", location: "929 N Charles St, Baltimore, MD 21202", image: "bourkestreetbakery.jpg", phone: "444-444-4444", isVisited: false),
        Restaurant(name: "Parts & Labor", type: "Butcher", location: "2600 N Howard St, Baltimore, MD 21218", image: "haighschocolate.jpg", phone: "444-444-4444", isVisited: false),
        Restaurant(name: "Woodberry Kitchen", type: "Locally Sourced", location: "2010 Clipper Park Rd, Baltimore, MD 21211", image: "palominoespresso.jpg", phone: "444-444-4444", isVisited: false),
        Restaurant(name: "Corner Chacuterie", type: "Butcher", location: "850 W 36th St, Baltimore, MD 21211", image: "upstate.jpg", phone: "444-444-4444", isVisited: false),
        Restaurant(name: "Namaste", type: "Indian", location: "413 W Cold Spring Ln, Baltimore, MD 21210", image: "traif.jpg", phone: "444-444-4444", isVisited: false),
        Restaurant(name: "Arthouse", type: "Pizza", location: "1115 W 36th St, Baltimore, MD 21211", image: "grahamavenuemeats.jpg", phone: "444-444-4444", isVisited: false),
        Restaurant(name: "Ekiben", type: "Asian", location: "1622 Eastern Ave, Baltimore, MD 21231", image: "wafflewolf.jpg", phone: "444-444-4444",  isVisited: false),
        Restaurant(name: "Le Garage", type: "French", location: "911 W 36th St, Baltimore, MD 21211", image: "fiveleaves.jpg", phone: "444-444-4444", isVisited: false),
        Restaurant(name: "Ryliegh's Oyster", type: "Oyster", location: "36 E Cross St, Baltimore, MD 21230", image: "cafelore.jpg", phone: "444-444-4444", isVisited: false),
        Restaurant(name: "Brewer's Art", type: "Brewery", location: "1106 N Charles St, Baltimore, MD 21201", image: "confessional.jpg", phone: "444-444-4444", isVisited: false),
        Restaurant(name: "Turps", type: "Sports Bar", location: "1317 N Charles St, Baltimore, MD 21201", image: "barrafina.jpg", phone: "444-444-4444", isVisited: false),
        Restaurant(name: "Holy Frijoles", type: "Mexican", location: "908 W 36th St, Baltimore, MD 21211", image: "donostia.jpg", phone: "444-444-4444", isVisited: false),
        Restaurant(name: "Fraizers", type: "Pub Food", location: "919 W 36th St, Baltimore, MD 21211", image: "cafeloisl.jpg", phone: "444-444-4444", isVisited: false),
        Restaurant(name: "Tapas Teatro", type: "Tapas", location: "1711 N Charles St, Baltimore, MD 21201", image: "caskpubkitchen.jpg", phone: "444-444-4444", isVisited: false),]
 
    */
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if UserDefaults.standard.bool(forKey: "hasViewedWalkthrough") {
            return
        }
        if let pageViewController = storyboard?.instantiateViewController(withIdentifier: "WalkthroughController")
            as? WalkthroughPageViewController{
                present(pageViewController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Remove the title of the back button
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        navigationController?.hidesBarsOnSwipe = true
        tableView.estimatedRowHeight = 60.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController.searchBar
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        
        searchController.searchBar.placeholder = "Search restaurants...."
        searchController.searchBar.isTranslucent = true
        searchController.searchBar.tintColor = UIColor.white
        searchController.searchBar.barTintColor = UIColor(red: 51.0/255.0, green: 110.0/255.0, blue: 123.0/255.0, alpha: 1.0)
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = false
        
        // Fetch data from data store
        let fetchRequest: NSFetchRequest<RestaurantMO> = RestaurantMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate){
            let context = appDelegate.persistentContainer.viewContext
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            
            do {
                try fetchResultController.performFetch()
                if let fetchedObjects = fetchResultController.fetchedObjects {
                    restaurants = fetchedObjects
                }
                } catch {
                    print(error)
                }
            }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive{
            return searchResults.count
        } else {
        return restaurants.count
    }
}
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if searchController.isActive  {
            return false
        } else {
            return true
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
        
        // Determine if we get the restaurant from search result or the original array
        let restaurant = (searchController.isActive) ? searchResults[indexPath.row] : restaurants[indexPath.row]
        
       
        // Configure the cell...
        cell.nameLabel.text = restaurant.name
        cell.thumbnailImageView.image = UIImage(data: restaurant.image as! Data) 
        cell.locationLabel.text = restaurant.location
        cell.typeLabel.text = restaurant.type
        
        
        cell.accessoryType = restaurant.isVisited ? .checkmark : .none
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // Delete the row from the data source
            restaurants.remove(at: indexPath.row)
        }
        
        tableView.deleteRows(at: [indexPath], with: .fade)
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        // Social Sharing Button
        let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Share", handler: { (action, indexPath) -> Void in
            
            let defaultText = "Just checking in at " + self.restaurants[indexPath.row].name!
            
            if let restaurantImage = self.restaurants[indexPath.row].image,
                let imageToShare = UIImage(data: restaurantImage as Data) {
                let activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
                self.present(activityController, animated: true, completion: nil)
            }
        })
        
        // Delete button
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Delete",handler: { (action, indexPath) -> Void in
            
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                let context = appDelegate.persistentContainer.viewContext
                let restaurantToDelete = self.fetchResultController.object(at: indexPath)
                context.delete(restaurantToDelete)
                
                appDelegate.saveContext()
            }
            
        })
        
        shareAction.backgroundColor = UIColor(red: 48.0/255.0, green: 173.0/255.0, blue: 99.0/255.0, alpha: 1.0)
        deleteAction.backgroundColor = UIColor(red: 202.0/255.0, green: 202.0/255.0, blue: 203.0/255.0, alpha: 1.0)
        
        return [deleteAction, shareAction]
    }

    
    // MARK: -
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRestaurantDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! RestaurantDetailViewController
                destinationController.restaurant = (searchController.isActive) ?
                    searchResults[indexPath.row] : restaurants[indexPath.row]
            }
        }
    }
    
    //MARK: Content Filtering Method
    
    func filterContent(for searchText: String) {
        searchResults = restaurants.filter ({ (restaurant) -> Bool in
            if let name = restaurant.name, let location = restaurant.location {
                let isMatch = name.localizedCaseInsensitiveContains(searchText) || location.localizedCaseInsensitiveContains(searchText)
                return isMatch
            }
            return false
        })
    }
    
    //MARK: Updating Search Results
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text{
            filterContent(for: searchText)
            tableView.reloadData()
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject:
        Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .fade)
            } default:
                tableView.reloadData()
        }
        if let fetchedObjects = controller.fetchedObjects {
            restaurants = fetchedObjects as! [RestaurantMO]
        } }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}

