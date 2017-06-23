//
//  ReviewViewController.swift
//  FoodPin
//
//  Created by Katherine Dexter on 4/6/17.
//  Copyright © 2017 KDexter. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {

    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var containerView: UIView!
    @IBOutlet var restaurantImageView: UIImageView!
    
    
    var restaurant: RestaurantMO?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let restaurant = restaurant,
            let restaurantImage = restaurant.image {
            restaurantImageView.image = UIImage(data: restaurantImage as Data)
        }
        
        // add blur effect to image
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        // set inital state of the container view
        let scaleTransform = CGAffineTransform.init(scaleX: 0, y: 0)
        let translateTransform = CGAffineTransform.init(translationX: 0, y: -100)
        let combineTransform = scaleTransform.concatenating(translateTransform)
        containerView.transform = combineTransform
        
}
    
    override func viewDidAppear(_ animated: Bool) {
        /* SPRING METHOD
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.2, options: .curveEaseOut, animations:{
            self.containerView.transform = CGAffineTransform.identity
        }, completion: nil)
        
        */
        UIView.animate(withDuration: 0.3, animations: {
            self.containerView.transform = CGAffineTransform.identity
        })
        
     }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
