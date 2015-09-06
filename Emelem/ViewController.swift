//
//  ViewController.swift
//  Emelem
//
//  Created by Jared Mermey on 5/4/15.
//  Copyright (c) 2015 Jared Mermey. All rights reserved.
//

import UIKit

let pageController = ViewController(transitionStyle: UIPageViewControllerTransitionStyle.Scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options: nil)

class ViewController: UIPageViewController, UIPageViewControllerDataSource {

    let cardsVC: UIViewController! = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("CardsNavController") as! UIViewController
    let profileVC: UIViewController! = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ProfileNavController") as! UIViewController
    let networkVC: UIViewController! = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("NetworkTableNavController") as! UIViewController
    let friendVC: UIViewController! = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("FriendTableNavController") as! UIViewController


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor.whiteColor()
        dataSource = self
        self.setViewControllers([cardsVC], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //helper functions to switch VCs by button
    func goToNextVC() {
        let nextVC = pageViewController(self, viewControllerAfterViewController: viewControllers[0] as! UIViewController)!
        setViewControllers([nextVC], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
    }
    
    func goToPreviousVC() {
        let previousVC = pageViewController(self, viewControllerBeforeViewController: viewControllers[0] as! UIViewController)!
        setViewControllers([previousVC], direction: UIPageViewControllerNavigationDirection.Reverse, animated: true, completion: nil)
    }
    
 
    
    
    
    //UIPageViewController Data Source functions
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
            switch viewController {
                case friendVC: return networkVC
                case networkVC: return cardsVC
                case cardsVC: return profileVC
                case profileVC: return nil
                default: return nil
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
            switch viewController {
                case friendVC: return nil
                case networkVC: return friendVC
                case cardsVC: return networkVC
                case profileVC: return cardsVC
                default: return nil
        }
    }
}

