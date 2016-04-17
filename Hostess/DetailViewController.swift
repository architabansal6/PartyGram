//
//  DetailViewController.swift
//  Hostess
//
//  Created by Archita Bansal on 17/04/16.
//  Copyright © 2016 Archita Bansal. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var webView: UIWebView!
    var uploadUrl = "http://172.20.172.157:3000/searchResult"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadpage()
        
        
        
        let addButton = UIBarButtonItem(title: "DONE", style: UIBarButtonItemStyle.Plain, target: self, action: "addButtonTapped")
        addButton.setTitleTextAttributes([NSForegroundColorAttributeName:AppSetting.sharedInstance.fuchsiaColor,NSFontAttributeName: UIFont(name: "AvenirNext-Medium", size: 14)!], forState: UIControlState.Normal)
        navigationItem.rightBarButtonItem = addButton

        
        
        // Do any additional setup after loading the view.
    }
    
    func addButtonTapped(){
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    func loadpage(){
        self.activityIndicator.hidden = false
        self.activityIndicator.startAnimating()
        let url = NSURL (string: uploadUrl);
        let requestObj = NSURLRequest(URL: url!);
        
        webView.loadRequest(requestObj);
    }
    
    
    func webViewDidFinishLoad(webView: UIWebView) {
        self.activityIndicator.hidden = true
        self.activityIndicator.stopAnimating()
        //   var result = self.webView.stringByEvaluatingJavaScriptFromString.("")
        //self.webView.hidden = true
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
