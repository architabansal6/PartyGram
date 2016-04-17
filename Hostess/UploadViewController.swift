//
//  UploadViewController.swift
//  Hostess
//
//  Created by Archita Bansal on 17/04/16.
//  Copyright © 2016 Archita Bansal. All rights reserved.
//

import UIKit

class UploadViewController: UIViewController,UIWebViewDelegate{

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var uploadUrl = "http://172.20.172.157:3000/loginpage"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadpage()
        self.webView.delegate = self

        // Do any additional setup after loading the view.
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
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        if navigationType == UIWebViewNavigationType.FormSubmitted{
        
           // self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        return true
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
