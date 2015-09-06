//
//  CardsViewController.swift
//  Emelem
//
//  Created by Jared Mermey on 5/4/15.
//  Copyright (c) 2015 Jared Mermey. All rights reserved.
//

import UIKit
import MapKit

class CardsViewController: UIViewController, SwipeViewDelegate, CLLocationManagerDelegate {

    struct Card {
        let cardView: CardView
        let swipeView: SwipeView
        let product: Product
    }
    
    let frontCardTopMargin: CGFloat = 0
    let backCardTopMargin: CGFloat = 10
    
    @IBOutlet weak var cardStackView: UIView!

    
    var backCard: Card?
    var frontCard: Card?
    
    @IBOutlet weak var commissionTracker: UIBarButtonItem!
    
    var commissionTotal: Double?
    
    var products: [Product]?
    
    var tracking = GPSTrackingManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tracking.startTracking()

        cardStackView.backgroundColor = UIColor.clearColor()
        
        fetchUnviewedProducts({
            returnedProducts in
            self.products = returnedProducts
            
            if let card = self.popCard() {
                self.frontCard = card
                self.cardStackView.addSubview(self.frontCard!.swipeView)
            }
            
            if let card = self.popCard() {
                self.backCard = card
                self.backCard!.swipeView.frame = self.createCardFrame(self.backCardTopMargin)
                self.cardStackView.insertSubview(self.backCard!.swipeView, belowSubview: self.frontCard!.swipeView)
            }
        })
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
       
        navigationItem.titleView = UIImageView(image: UIImage(named: "nav-header"))
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.commissionTotal = appDelegate.commissionTotal
        
        
        self.commissionTracker.title = "$\(self.commissionTotal!)"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //function to create card. The Y is the slight offset for the backCard
    private func createCardFrame(topMargin: CGFloat) -> CGRect{
        return CGRect(x: 0, y: topMargin, width: cardStackView.frame.width, height: cardStackView.frame.height)
    }
    
    //helper function create cards
    private func createCard(product: Product) -> Card{
        let cardView = CardView()
       
        cardView.productName = product.productName
        cardView.brandName = product.brandName
        cardView.productPrice = product.price
        cardView.shipPrice = product.shippingCost
        
        product.getProductPhoto({
            productImage in
            cardView.productImage = productImage
        })
       
        product.getBrandPhoto({
            brandImage in
            cardView.brandImage = brandImage
        })
        
       
        
        let swipeView = SwipeView(frame: createCardFrame(0))
        swipeView.delegate = self
        swipeView.innerView = cardView
        return Card(cardView: cardView, swipeView: swipeView, product: product)
    }
    
    //takes last Product in products array and sends it through createCard
    private func popCard() -> Card? {
        if products != nil && products?.count > 0 {
            return createCard(products!.removeLast())
        }
        return nil
    }
    
    //switch back card to front card
    private func switchCards() {
        if let card = backCard {
            frontCard = card
            UIView.animateWithDuration(0.2, animations: {
            self.frontCard!.swipeView.frame = self.createCardFrame(self.frontCardTopMargin)
            })
        }
        if let card = self.popCard() {
            self.backCard = card
            self.backCard!.swipeView.frame = self.createCardFrame(self.backCardTopMargin)
            self.cardStackView.insertSubview(self.backCard!.swipeView, belowSubview: self.frontCard!.swipeView)
        }
    }
    
    //navigation functions to go to other VC
    func goToProfile(button: UIBarButtonItem) {
        pageController.goToPreviousVC()
    }
    
    //SwipeViewDelegate functions
    
    func swipedLeft() {
        println("left")
        if let frontCard = frontCard {
            frontCard.swipeView.removeFromSuperview()
            saveSkip(frontCard.product)
            switchCards()
        }
    }
    
    func swipedRight() {
        println("right")
        if let frontCard = frontCard {
            frontCard.swipeView.removeFromSuperview()
            saveKept(frontCard.product)
            switchCards()
        }
    }
    
    
    //commission transition
    
   
    
    
}
