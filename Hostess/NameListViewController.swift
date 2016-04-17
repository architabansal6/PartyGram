//
//  GuestsViewController.swift
//  Hostess
//
//  Created by Archita Bansal on 16/04/16.
//  Copyright © 2016 Archita Bansal. All rights reserved.
//

import UIKit


class NameListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var exploreTableView: UITableView!
    
    var feedArray = [String]()
    var selFeed = [String]()
    var type = "Birthday"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavBar()
        
        self.exploreTableView.dataSource = self
        self.exploreTableView.delegate = self
        
        
        self.getAllFeeds()
        
        
        
        
        
        let theTap = UITapGestureRecognizer(target: self, action: "scrollViewTapped:")
        self.exploreTableView.addGestureRecognizer(theTap)
        self.view.addGestureRecognizer(theTap)
        theTap.cancelsTouchesInView = false
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.exploreTableView.reloadData()
        self.getAllFeeds()
        if self.type == "Birthday"{
         self.imageView.image = UIImage(named: "Birthday")
        }
        if self.type == "Anniversary"{
            self.imageView.image = UIImage(named: "Anniversary")
        }
        if self.type == "Cocktail"{
            self.imageView.image = UIImage(named: "CockTail")
        }
        if self.type == "Farewell"{
            self.imageView.image = UIImage(named: "Farewell")
        }
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
        let url = "http://172.20.172.157:3000/upload/getPartyByType/\(type)"
        
        
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
                    
                    print(json)
                    
                    for(var i=0;i<json!.count;i++){
                        
                        let place : NSDictionary = json![i] as! NSDictionary
                        let name : String = place.valueForKey("Name") as! String
                        
                        
                        self.feedArray.append(name)
                        
                        
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        //  self.plotTouristSpots(json!)
                        self.feedArray = self.giveUniqueArray(self.feedArray)
                        
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
        
        let cell = tableView.dequeueReusableCellWithIdentifier("NameTableViewCell") as! NameTableViewCell
        
        
        cell.separatorInset = UIEdgeInsetsZero
        
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        if self.type == "Anniversary"{
        cell.backgroundColor = UIColor(red: 245/255, green: 0, blue: 70/255, alpha: 0.70)
        }
        else{
           cell.backgroundColor = AppSetting.sharedInstance.fuchsiaColor
        }
        
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
        var verificationVC = UIStoryboard(name: "ExploreStoryboard", bundle: nil).instantiateViewControllerWithIdentifier("detail") as! DetailViewController
        
        self.navigationController?.pushViewController(verificationVC, animated: true)
    }
    
    func scrollViewTapped(recognizer: UIGestureRecognizer) {
        self.exploreTableView.endEditing(true)
    }
    
    
    
}
