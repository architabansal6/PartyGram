//
//  ToDoViewController.swift
//  Hostess
//
//  Created by Archita Bansal on 16/04/16.
//  Copyright © 2016 Archita Bansal. All rights reserved.
//

import UIKit

class ToDoViewController: UIViewController,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var toDoTableView: UITableView!
    var todoCount : Int = 0
    var activeTextField : UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavBar()
        
        self.toDoTableView.dataSource = self
        self.toDoTableView.delegate = self
        
        self.toDoTableView.hidden = true
        
        let theTap = UITapGestureRecognizer(target: self, action: "scrollViewTapped:")
        self.toDoTableView.addGestureRecognizer(theTap)
        theTap.cancelsTouchesInView = false
        


        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.toDoTableView.reloadData()
    }
    
   
    
    func configureNavBar(){
        
        self.toDoTableView.backgroundColor = UIColor.clearColor()
        self.toDoTableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        self.toDoTableView.separatorColor = UIColor.whiteColor()
        self.toDoTableView.layoutMargins = UIEdgeInsetsZero
        self.toDoTableView.cellLayoutMarginsFollowReadableWidth = false
        self.toDoTableView.tableFooterView = UIView(frame: CGRectZero)
        
        self.navigationItem.title = "To-Do List"
        
        self.view.backgroundColor = UIColor(red: 208/255, green: 0, blue: 70/255, alpha: 0.70)
        
        
        
        let addButton = UIBarButtonItem(title: "+", style: UIBarButtonItemStyle.Plain, target: self, action: "addButtonTapped")
        addButton.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.blueColor(),NSFontAttributeName: UIFont(name: "AvenirNext-Medium", size: 30)!], forState: UIControlState.Normal)
        navigationItem.rightBarButtonItem = addButton
        
        
    }
    
    
    func doneButtonTapped(){
        
        
        
        
    }
    
    func addButtonTapped(){
        
        self.toDoTableView.hidden = false
        self.todoCount = AppSetting.sharedInstance.toDoArray.count + 1
        AppSetting.sharedInstance.toDoArray.append("")
        
        self.toDoTableView.reloadData()
        
        
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todoCount
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ToDoTableViewCell") as! ToDoTableViewCell
        cell.txtToDoName.delegate = self
        self.activeTextField = cell.txtToDoName
        self.activeTextField.becomeFirstResponder()
        
        cell.separatorInset = UIEdgeInsetsZero
        
        cell.txtToDoName.text = AppSetting.sharedInstance.toDoArray[indexPath.row]
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        cell.backgroundColor = UIColor.clearColor()
       
        if AppSetting.sharedInstance.toDoComplArray.contains(cell.txtToDoName.text!){
            cell.txtToDoName.textColor = UIColor.whiteColor()
            if cell.txtToDoName.text != "" {
                
                cell.checkBoxImageView.image = UIImage(named: "checkon")
                
            }
            
        }
        else{
            cell.txtToDoName.textColor = UIColor.whiteColor()
            cell.checkBoxImageView.image = UIImage(named: "checkoff")
        }

        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! ToDoTableViewCell
        if !(AppSetting.sharedInstance.toDoComplArray.contains(cell.txtToDoName.text!)){
            // self.selectedFacilities.removeAll(keepCapacity: false)
            AppSetting.sharedInstance.toDoComplArray.append(cell.txtToDoName.text!)
        }
        else{
            let index = AppSetting.sharedInstance.toDoComplArray.indexOf(cell.txtToDoName.text!)
            AppSetting.sharedInstance.toDoComplArray.removeAtIndex(index!)
        }
        tableView.reloadData()
    }
    
    func scrollViewTapped(recognizer: UIGestureRecognizer) {
        self.toDoTableView.endEditing(true)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        
        
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        AppSetting.sharedInstance.toDoArray.removeLast()
        AppSetting.sharedInstance.toDoArray.append(activeTextField.text!)
        return true
    }
    
    
}
