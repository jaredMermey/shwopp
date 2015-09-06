//
//  CardView.swift
//  Emelem
//
//  Created by Jared Mermey on 5/4/15.
//  Copyright (c) 2015 Jared Mermey. All rights reserved.
//

import Foundation
import UIKit

class CardView: UIView {
    
    //product Info
    private let productImageView: UIImageView = UIImageView()
    private let productNameLabel: UILabel = UILabel()
    private let brandImageView: UIImageView = UIImageView()
    private let brandNameLabel: UILabel = UILabel()
    private let productPriceLabel: UILabel = UILabel()
    private let shipPriceLabel: UILabel = UILabel()
    
    //referrer info
    private let referrerImageView: UIImageView = UIImageView()
    private let referrerNameLabel: UILabel = UILabel()
    private let referrerCountLabel: UILabel = UILabel()
    
    //buttons
    private let chatButton: UIButton = UIButton()
    private let shareButton: UIButton = UIButton()
    private let mapButton: UIButton = UIButton()
    private let buyButton: UIButton = UIButton()
    
    //action icons (TBD)
    //ADD ACTION ICONS
    
    
    var productName: String? {
        didSet{
            if let productName = productName {
                productNameLabel.font = UIFont.systemFontOfSize(20)
                productNameLabel.text = productName
            }
        }
    }
    
    var brandName: String? {
        didSet{
            if let brandName = brandName {
                brandNameLabel.font = UIFont.systemFontOfSize(12)
                brandNameLabel.text = brandName
            }
        }
    }
    
    
    var brandImage: UIImage? {
        didSet{
            if let brandImage = brandImage {
                brandImageView.layer.masksToBounds = true
                brandImageView.contentMode = .ScaleAspectFit
                brandImageView.image = brandImage
            }
        }
    }
    
    var productImage: UIImage? {
        didSet{
            if let productImage = productImage{
                productImageView.layer.masksToBounds = true
                productImageView.contentMode = .ScaleAspectFit
                productImageView.image = productImage
            }
        }
    }
    
    var productPrice: Double? {
        didSet{
            if let productPrice = productPrice {
                productNameLabel.font = UIFont.systemFontOfSize(20)
                productPriceLabel.text = "$\(productPrice)"
                
            }
        }
    }
    
    var shipPrice: Double? {
        didSet{
            if let shipPrice = shipPrice {
                shipPriceLabel.font = UIFont.systemFontOfSize(12)
                shipPriceLabel.textColor = UIColor.greenColor()
                shipPriceLabel.text = "+$\(shipPrice) $&H"
            }
        }
    }
  
    
    
    //initializers for CardView
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    
    init(){
        super.init(frame: CGRectZero)
        initialize()
    }
    
    //function to set up all images and labels
    private func initialize(){
        
        //everytime we create a CardView, we immediately create subviews of images and labels
        brandImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        brandImageView.backgroundColor = UIColor.clearColor()
        addSubview(brandImageView)
        
        productImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        productImageView.backgroundColor = UIColor.clearColor()
        addSubview(productImageView)
        
        productNameLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        addSubview(productNameLabel)
        
        brandNameLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        addSubview(brandNameLabel)
        
        productPriceLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        addSubview(productPriceLabel)
        
        shipPriceLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        addSubview(shipPriceLabel)
        
        referrerImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        referrerImageView.backgroundColor = UIColor.redColor()
        addSubview(referrerImageView)
        
        referrerNameLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        addSubview(referrerNameLabel)
        
        referrerCountLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        addSubview(referrerCountLabel)
        
        //buttons
        chatButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        addSubview(chatButton)
        
        mapButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        addSubview(mapButton)
        
        shareButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        addSubview(shareButton)
        
        buyButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        buyButton.layer.borderColor = UIColor.grayColor().CGColor
        buyButton.layer.borderWidth = 1
        buyButton.setTitleColor(UIColor.grayColor(), forState: .Normal)
        buyButton.setTitle("Price", forState: UIControlState.Normal)
        addSubview(buyButton)
        
        chatButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        let chatIcon = UIImage(named: "ChatIcon")
        chatButton.setBackgroundImage(chatIcon, forState: .Normal)
        addSubview(chatButton)
        
        mapButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        let mapIcon = UIImage(named: "MapIcon")
        mapButton.setBackgroundImage(mapIcon, forState: .Normal)
        addSubview(mapButton)
        
        shareButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        let shareIcon = UIImage(named: "ShareIcon")
        shareButton.setBackgroundImage(shareIcon, forState: .Normal)
        addSubview(shareButton)
        
        //design for CardView (colors, outline, rounded edges)
        backgroundColor = UIColor.whiteColor()
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGrayColor().CGColor
        layer.cornerRadius = 5
        layer.masksToBounds = true
        
        setConstraints()
    }
    
    
    private func setConstraints() {
        
        //brandAvatar
        /*addConstraint(NSLayoutConstraint(item: brandImageView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: brandImageView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0))
        brandImageView.frame.size.width = 50.0
        brandImageView.frame.size.height = 50.0*/

        
        //productNameLabel
        addConstraint(NSLayoutConstraint(item: productNameLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: productNameLabel, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 10))
        productNameLabel.frame.size.width = 100.0
        productNameLabel.frame.size.height = 25.0
        
        //brandNameLabel
        addConstraint(NSLayoutConstraint(item: brandNameLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 20.0))
        addConstraint(NSLayoutConstraint(item: brandNameLabel, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 10))
        brandNameLabel.frame.size.width = 100.0
        brandNameLabel.frame.size.height = 25.0
        
        //productImage
        addConstraint(NSLayoutConstraint(item: productImageView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 95))
        addConstraint(NSLayoutConstraint(item: productImageView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: productImageView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Width, multiplier: 1.0, constant: 0))
        productImageView.frame.size.height = productImageView.frame.size.width
        
        //productPrice
        addConstraint(NSLayoutConstraint(item: productPriceLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: productPriceLabel, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 0))
        productPriceLabel.frame.size.width = 30.0
        productPriceLabel.frame.size.height = 25.0
        
        //shippingCost
        addConstraint(NSLayoutConstraint(item: shipPriceLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 20))
        addConstraint(NSLayoutConstraint(item: shipPriceLabel, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 0))
        shipPriceLabel.frame.size.width = 30.0
        shipPriceLabel.frame.size.height = 25.0
        
        //buyButton
        addConstraint(NSLayoutConstraint(item: buyButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 420))
        addConstraint(NSLayoutConstraint(item: buyButton, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 10))
        addConstraint(NSLayoutConstraint(item: buyButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Width, multiplier: 0.3, constant: 0))
        buyButton.frame.size.height = 25
        
        //chatButton
        addConstraint(NSLayoutConstraint(item: chatButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 425))
        addConstraint(NSLayoutConstraint(item: chatButton, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: -70))
        addConstraint(NSLayoutConstraint(item: chatButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 25))
        addConstraint(NSLayoutConstraint(item: chatButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 25))
        
        //mapButton
        addConstraint(NSLayoutConstraint(item: mapButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 425))
        addConstraint(NSLayoutConstraint(item: mapButton, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: -40))
        addConstraint(NSLayoutConstraint(item: mapButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 25))
        addConstraint(NSLayoutConstraint(item: mapButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 25))
        
        //shareButton
        addConstraint(NSLayoutConstraint(item: shareButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 425))
        addConstraint(NSLayoutConstraint(item: shareButton, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: -10))
        addConstraint(NSLayoutConstraint(item: shareButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 25))
        addConstraint(NSLayoutConstraint(item: shareButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 25))


        
    }
}