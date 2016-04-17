//
//  GuestsViewController.swift
//  Hostess
//
//  Created by Archita Bansal on 16/04/16.
//  Copyright © 2016 Archita Bansal. All rights reserved.
//

import UIKit


class ExploreViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var headingLabel: UILabel!
    
    @IBOutlet weak var exploreTableView: UITableView!
    
    var feedArray = [String]()
    var selFeed = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavBar()
        
        self.exploreTableView.dataSource = self
        self.exploreTableView.delegate = self
        
    
        
        self.headingLabel.numberOfLines = 0
        self.headingLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping

        
        
        self.getAllFeeds()
        self.activityIndicator.hidden = false
        self.activityIndicator.startAnimating()
    
        
        
        
        
        
        let theTap = UITapGestureRecognizer(target: self, action: "scrollViewTapped:")
        self.exploreTableView.addGestureRecognizer(theTap)
        self.view.addGestureRecognizer(theTap)
        theTap.cancelsTouchesInView = false
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.exploreTableView.reloadData()
        self.getAllFeeds()
        self.view.bringSubviewToFront(exploreTableView)
    }
    
    
    
    func configureNavBar(){
        
        self.exploreTableView.backgroundColor = UIColor.clearColor()
        self.exploreTableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        self.exploreTableView.separatorColor = UIColor.whiteColor()
        self.exploreTableView.layoutMargins = UIEdgeInsetsZero
        self.exploreTableView.cellLayoutMarginsFollowReadableWidth = false
        self.exploreTableView.tableFooterView = UIView(frame: CGRectZero)
        
        self.navigationItem.title = "Explore"
        
        
        
        
        
    }
    
    // MARK :- SearchBar delegates
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feedArray.count
    }
    func getAllFeeds(){
        let url = "http://172.20.172.157:3000/upload/getAllParties"
        
        
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
                    
                    for(var i=0;i<json!.count;i++){
                        
                        let place : NSDictionary = json![i] as! NSDictionary
                        let name : String = place.valueForKey("Type") as! String
                        
                       
                        self.feedArray.append(name)
                        
                        
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), {
                      //  self.plotTouristSpots(json!)
                        self.feedArray = self.giveUniqueArray(self.feedArray)
                        self.activityIndicator.hidden = true
                        self.activityIndicator.stopAnimating()
                        
                        self.exploreTableView.reloadData()
                        
                    })
                }
                catch{
                    
                }
                
            }
        }
        

        
    }
    
    func giveUniqueArray(array: NSArray) -> [String]{
        var uniqueArray = [String]()
        for item in array{
            
            if !(uniqueArray.contains(item as! String)){
                uniqueArray.append(item as! String)
            }else{
                
            }
            
            
        }
        return uniqueArray
    }

    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ExploreTableViewCell") as! ExploreTableViewCell
        
        
        cell.separatorInset = UIEdgeInsetsZero
        
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        cell.backgroundColor = UIColor(red: 208/255, green: 0, blue: 70/255, alpha: 0.70)
        cell.textLabel?.text = self.feedArray[indexPath.row]
        cell.textLabel?.textColor = UIColor.whiteColor()
        
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        
        //            if AppSetting.sharedInstance.toDoComplArray.contains(cell.txtToDoName.text!){
        //                cell.txtToDoName.textColor = UIColor.whiteColor()
        //
        //            }
        //            else{
        //                cell.txtToDoName.textColor = UIColor.whiteColor()
        //
        //            }
        //
        
        return cell
        
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var verificationVC = UIStoryboard(name: "ExploreStoryboard", bundle: nil).instantiateViewControllerWithIdentifier("nameList") as! NameListViewController
        verificationVC.type = self.feedArray[indexPath.row]
        self.navigationController?.pushViewController(verificationVC, animated: true)
    }
    
    func scrollViewTapped(recognizer: UIGestureRecognizer) {
        self.exploreTableView.endEditing(true)
    }
    
    
    
}
