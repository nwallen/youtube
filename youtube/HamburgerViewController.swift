//
//  HamburgerViewController.swift
//  youtube
//
//  Created by Nicholas Wallen on 6/9/16.
//  Copyright © 2016 Nicholas Wallen. All rights reserved.
//

import UIKit

class HamburgerViewController: UIViewController {

    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var feedView: UIView!
    
    var menuViewController: UIViewController!
    var feedViewController: UIViewController!
    
    var feedViewOriginalPosition: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        var feedViewController = storyboard.instantiateViewControllerWithIdentifier("feed") as! FeedViewController
        
        var menuViewController = storyboard.instantiateViewControllerWithIdentifier("menu") as! MenuViewController
        
        setAnchorPoint(CGPoint(x: 1.0, y: 0.5), forView: feedView)
        
        addChildViewController(feedViewController)
        addChildViewController(menuViewController)
        
        menuView.addSubview(menuViewController.view)
        feedView.addSubview(feedViewController.view)
        
        menuViewController.didMoveToParentViewController(self)
        feedViewController.didMoveToParentViewController(self)

    }
    
    @IBAction func didPan(sender: AnyObject) {
        let velocity = sender.velocityInView(view)
        let translation = sender.translationInView(view)
        
        var transform = CATransform3DIdentity;
        transform.m34 = 1.0 / 400.0;
        
        if sender.state == UIGestureRecognizerState.Began {
            feedViewOriginalPosition = feedView.center
        }
        else if sender.state == UIGestureRecognizerState.Changed {
            feedView.center = CGPoint(x: feedViewOriginalPosition.x + translation.x, y: feedViewOriginalPosition.y)
            var newScale = convertValue(feedView.frame.origin.x, r1Min: 0, r1Max: 270, r2Min: 0.9, r2Max: 1.0)
            menuView.transform = CGAffineTransformMakeScale(newScale, newScale)
            
            
//            var rotation = convertValue(feedView.frame.origin.x, r1Min: 0, r1Max: 240, r2Min: 0, r2Max: 20)
//            transform = CATransform3DRotate(transform, CGFloat(Double(rotation) * M_PI / Double(180)), 0, 1, 0)
//            feedView.layer.transform = transform
        }
        else if sender.state == UIGestureRecognizerState.Ended {
            
            if velocity.x > 0 {
                transform = CATransform3DRotate(transform, CGFloat(Double(20) * M_PI / Double(180)), 0, 1, 0)
                UIView.animateWithDuration(0.3){
                    self.feedView.frame.origin = CGPoint(x: 270, y:0)
                    self.menuView.transform = CGAffineTransformMakeScale(1, 1)
                    //self.feedView.layer.transform = transform
                }
                
            }
            else {
                transform = CATransform3DRotate(transform, CGFloat(Double(0) * M_PI / Double(180)), 0, 1, 0)
                
                UIView.animateWithDuration(0.3){
                    self.feedView.frame.origin = CGPoint(x: 0, y:0)
                    self.menuView.transform = CGAffineTransformMakeScale(0.9, 0.9)
                    //self.feedView.layer.transform = transform
                }
            }
            
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
