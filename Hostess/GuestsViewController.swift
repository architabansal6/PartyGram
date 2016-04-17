//
//  GuestsViewController.swift
//  Hostess
//
//  Created by Archita Bansal on 16/04/16.
//  Copyright © 2016 Archita Bansal. All rights reserved.
//

import UIKit


class GuestsViewController: UIViewController,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate{
        
   
        @IBOutlet weak var GuestsTableView: UITableView!
        var guestsCount : Int = 0
        var activeTextField : UITextField!
        override func viewDidLoad() {
            super.viewDidLoad()
            self.configureNavBar()
            
            self.GuestsTableView.dataSource = self
            self.GuestsTableView.delegate = self
            
            self.GuestsTableView.hidden = true
            
            let theTap = UITapGestureRecognizer(target: self, action: "scrollViewTapped:")
            self.GuestsTableView.addGestureRecognizer(theTap)
            self.view.addGestureRecognizer(theTap)
            theTap.cancelsTouchesInView = false
            
            
            
            // Do any additional setup after loading the view.
        }
        
        override func viewWillAppear(animated: Bool) {
            self.GuestsTableView.reloadData()
        }
        
        
        
        func configureNavBar(){
            
            self.GuestsTableView.backgroundColor = UIColor.clearColor()
            self.GuestsTableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
            self.GuestsTableView.separatorColor = UIColor.whiteColor()
            self.GuestsTableView.layoutMargins = UIEdgeInsetsZero
            self.GuestsTableView.cellLayoutMarginsFollowReadableWidth = false
            self.GuestsTableView.tableFooterView = UIView(frame: CGRectZero)
            
            self.navigationItem.title = "Guests List"
            
            
            
            let addButton = UIBarButtonItem(title: "+", style: UIBarButtonItemStyle.Plain, target: self, action: "addButtonTapped")
            addButton.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.blueColor(),NSFontAttributeName: UIFont(name: "AvenirNext-Medium", size: 30)!], forState: UIControlState.Normal)
            navigationItem.rightBarButtonItem = addButton
            
            
        }
        
        
        func doneButtonTapped(){
            
            
            
            
        }
        
        func addButtonTapped(){
            
            self.GuestsTableView.hidden = false
            self.guestsCount = AppSetting.sharedInstance.guestsArray.count + 1
            AppSetting.sharedInstance.guestsArray.append("")
            
            self.GuestsTableView.reloadData()
            
            
        }
        
        func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.guestsCount
        }
        
        
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("GuestTableViewCell") as! GuestsTableViewCell
            cell.txtToDoName.delegate = self
            self.activeTextField = cell.txtToDoName
            self.activeTextField.becomeFirstResponder()
            
            cell.separatorInset = UIEdgeInsetsZero
            
            cell.txtToDoName.text = AppSetting.sharedInstance.guestsArray[indexPath.row]
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            cell.backgroundColor = UIColor(red: 208/255, green: 0, blue: 70/255, alpha: 0.70)
            cell.txtToDoName.textColor = UIColor.whiteColor()
            
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
        
//        func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//            let cell = tableView.cellForRowAtIndexPath(indexPath) as! GuestsTableViewCell
//            if !(AppSetting.sharedInstance.toDoComplArray.contains(cell.txtToDoName.text!)){
//                // self.selectedFacilities.removeAll(keepCapacity: false)
//                AppSetting.sharedInstance.toDoComplArray.append(cell.txtToDoName.text!)
//            }
//            else{
//                let index = AppSetting.sharedInstance.toDoComplArray.indexOf(cell.txtToDoName.text!)
//                AppSetting.sharedInstance.toDoComplArray.removeAtIndex(index!)
//            }
//            tableView.reloadData()
//        }
    
        func scrollViewTapped(recognizer: UIGestureRecognizer) {
            self.GuestsTableView.endEditing(true)
        }
        
        func textFieldDidEndEditing(textField: UITextField) {
            
            
            
        }
        
        func textFieldShouldEndEditing(textField: UITextField) -> Bool {
            AppSetting.sharedInstance.guestsArray.removeLast()
            AppSetting.sharedInstance.guestsArray.append(activeTextField.text!)
            return true
        }
        
        
    
}
