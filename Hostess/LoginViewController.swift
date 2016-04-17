//
//  LoginViewController.swift
//  Hostess
//
//  Created by Archita Bansal on 16/04/16.
//  Copyright © 2016 Archita Bansal. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    
    @IBOutlet weak var googleSignInButton: UIButton!
    @IBOutlet weak var outletSignIn: UIButton!
   
    @IBAction func OnSignIn(sender: UIButton) {
        
        let tabBarController = UITabBarController()
        var explore: UINavigationController
        var guests: UINavigationController
        var profile: UINavigationController
        var toDo: UINavigationController
        
        var exploreScreen = UIStoryboard(name: "ExploreStoryboard", bundle: nil).instantiateViewControllerWithIdentifier("explore") as? ExploreViewController
        var guestsScreen = UIStoryboard(name: "GuestsStoryboard", bundle: nil).instantiateViewControllerWithIdentifier("Guests") as? GuestsViewController
        var profileScreen = UIStoryboard(name: "ProfileStoryboard", bundle: nil).instantiateInitialViewController() as? ProfileViewController
        var toDoScreen = UIStoryboard(name: "ToDoStoryboard", bundle: nil).instantiateInitialViewController() as? ToDoViewController
        
        explore = UINavigationController(rootViewController: exploreScreen!)
        guests = UINavigationController(rootViewController: guestsScreen!)
        profile = UINavigationController(rootViewController: profileScreen!)
        toDo = UINavigationController(rootViewController: toDoScreen!)

        let controllers = [explore,guests,toDo,profile]
        tabBarController.viewControllers = controllers
        
        let theTap = UITapGestureRecognizer(target: self, action: "scrollViewTapped:")
        self.imageView.addGestureRecognizer(theTap)
        

        
        
        
        (UIApplication.sharedApplication().delegate as! AppDelegate).window?.rootViewController = tabBarController
        let firstImage = UIImage(named: "ExploreTabIcon")
        let secondImage = UIImage(named: "GuestsTabIcon")
        let thirdImage = UIImage(named: "toDo")
        let fourthImage = UIImage(named: "ProfileTabIcon")
//        let searchTabItem = UITabBarItem(title: "Search", image: UIImage(named: "SearchU"), selectedImage: UIImage(named: "SearchS"))
        explore.tabBarItem = UITabBarItem(
            title: "Explore",
            image: firstImage,
            tag: 1)
        guests.tabBarItem = UITabBarItem(
            title: "Guests",
            image: secondImage,
            tag:2)
        toDo.tabBarItem = UITabBarItem(
            title: "ToDo",
            image: thirdImage,
            tag:3)
        profile.tabBarItem = UITabBarItem(
            title: "Profile",
            image: fourthImage,
            tag:4)
        
        
    }
    
    
    
    
    @IBAction func onGoogleSignIn(sender: UIButton) {
        
        self.googleAuthenticate()
        
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureUI()

        // Do any additional setup after loading the view.
        
        self.checkAuthentication()
    }
    
    func scrollViewTapped(recognizer: UIGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    func configureUI(){
        
        self.outletSignIn.backgroundColor = AppSetting.sharedInstance.fuchsiaColor
        
        self.outletSignIn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
        txtPassword.attributedPlaceholder = NSAttributedString(string:"Password",
            attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        txtUserName.attributedPlaceholder = NSAttributedString(string:"Username",
            attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
       // self.outletSignIn.setTitleColor(AppSetting.sharedInstance.fuchsiaColor, forState: UIControlState.Normal)
        
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    
    func checkAuthentication(){
        
        var request = NSMutableURLRequest(URL: NSURL(string: "http://172.20.172.157:3000/user/login")!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 5)
        var response: NSURLResponse?
        var error: NSError?
        
        // create some JSON data and configure the request
        let jsonString = "json=[{\"Username\":\"shrutitanwar93@gmail.com\",\"PAssword\":\"asdfghjkl\",\"Name\":\"Shruti\"}]"
        request.HTTPBody = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // send the request
        
        var queue = NSOperationQueue()
        
        NSURLConnection.sendAsynchronousRequest(request, queue: queue) { (response, data, error) -> Void in
            
            if let httpResponse = response as? NSHTTPURLResponse {
                print("HTTP response: \(httpResponse.statusCode)")
            } else {
                print("No HTTP response")
            }
            
        }
        
        

        
    }
    
    
    
    func googleAuthenticate(){
        let url = "http://172.20.172.157:3000/logingoogle"
        
        
        //  let urlStr : NSString = url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        let requestUrl = NSURL(string: url)
        let request = NSMutableURLRequest(URL: requestUrl!)// Creating Http Request
        request.HTTPMethod="GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        // Creating NSOperationQueue to which the handler block is dispatched when the request completes or failed
        let queue: NSOperationQueue = NSOperationQueue()
        
        // Sending Asynchronous request using NSURLConnection
        
        
        
        NSURLConnection.sendAsynchronousRequest(request, queue: queue) { (response : NSURLResponse?, responseData:NSData?, error:NSError?) -> Void in
            if error != nil
            {
                print(error!.description)
                //                self.removeActivityIndicator()
            }
            else
            {
                //var json : NSArray = NSArray()
                do{
                    let res = response as! NSHTTPURLResponse!
                    print("response is \(res)")
                    let jsonString = try NSString(data: responseData!, encoding: NSUTF8StringEncoding)
                    print("response is \(jsonString)")
                    let json = try NSJSONSerialization.JSONObjectWithData(responseData!, options: [.AllowFragments,.MutableContainers]) as? NSArray
                    
                    
                    
                    dispatch_async(dispatch_get_main_queue(), {
                       
                        
                    })
                }
                catch{
                    
                }
                
            }
        }
        
        
        
    }

    
    
}
