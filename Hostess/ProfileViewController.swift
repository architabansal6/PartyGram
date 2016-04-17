//
//  ProfileViewController.swift
//  Hostess
//
//  Created by Archita Bansal on 16/04/16.
//  Copyright © 2016 Archita Bansal. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var outletUpload: UIButton!
    
   
    @IBAction func onUpload(sender: UIButton) {
        
        var verificationVC = UIStoryboard(name: "ProfileStoryboard", bundle: nil).instantiateViewControllerWithIdentifier("upload") as! UploadViewController
            self.navigationController?.presentViewController(verificationVC, animated: true, completion: nil)

    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Profile"
        
        self.configureUI()

        // Do any additional setup after loading the view.
    }

    func configureUI(){
        
        self.textLabel.numberOfLines = 0
        self.textLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.outletUpload.backgroundColor = AppSetting.sharedInstance.fuchsiaColor
        self.outletUpload.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
    }
}
