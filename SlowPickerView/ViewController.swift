//
//  ViewController.swift
//  SlowPickerView
//
//  Created by 徐开源 on 15/10/14.
//  Copyright © 2015年 徐开源. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // All UIPickerViews
    let pickers:[UIPickerView] = [UIPickerView(),UIPickerView(),UIPickerView(),UIPickerView(),UIPickerView()]
    // Rows Will Be Rolled
    @IBOutlet var rows: UITextField!
    let rowsMax = 100000
    // SegmentContorl
    @IBOutlet var seg: UISegmentedControl!
    
    
    
    // MARK: - Main Func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for var i = 0; i < self.pickers.count; i++ {
            // Create 5 UIPickerViews, Hide N0.0 ~ N0.3, Show N0.4 (The Slowest One)
            self.pickers[i].frame = CGRectMake(
                self.view.frame.width*CGFloat(self.pickers.count-1-i),
                (self.view.frame.height-self.pickers[i].frame.height)/2,
                self.view.frame.width,
                self.pickers[i].frame.height)
            
            // Other Stuff
            self.pickers[i].delegate = self
            self.pickers[i].userInteractionEnabled = false
            self.view.addSubview(self.pickers[i])
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    // MARK: - SegmentControl
    @IBAction func segClicked(sender: AnyObject) {
        if self.seg.selectedSegmentIndex == 0 {
            // Create 5 UIPickerViews, Hide N0.0 ~ N0.3, Show N0.4 (The Slowest One)
            for var i = 0; i < self.pickers.count; i++ {
                self.pickers[i].frame = CGRectMake(
                    self.view.frame.width*CGFloat(self.pickers.count-1-i),
                    (self.view.frame.height-self.pickers[i].frame.height)/2,
                    self.view.frame.width,
                    self.pickers[i].frame.height)
            }
        }else {
            // Create 5 UIPickerViews, Hide NO.0 & N0.2 ~ N0.4, Show N0.1 (The Fastest One)
            for var i = 0; i < self.pickers.count; i++ {
                self.pickers[i].frame = CGRectMake(
                    self.view.frame.width*CGFloat(i-1),
                    (self.view.frame.height-self.pickers[i].frame.height)/2,
                    self.view.frame.width,
                    self.pickers[i].frame.height)
            }
        }
    }
    
    
    
    // MARK: - Begin
    @IBAction func roll(sender: AnyObject) {
        if self.rows.text != nil {
            if let num = Int(self.rows.text!) { // Recognize The Input Number
                if (num >= 0) && (num < self.rowsMax) {
                    
                    // If The User Input A Right Number
                    // The First UIPickerView Can Select The Specific Row At Once (animated: false)
                    self.pickers[0].selectRow(num, inComponent: 0, animated: false)
                
                }
                // Other Stuff
                else {
                    if num < 0 {
                        print("Input A Number > 0")
                    }else{
                        print("Input A Number < \(self.rowsMax)")
                    }
                }
            }else {
                print("Input A Number < \(self.rowsMax)")
            }
        }else {
            print("Input A Number < \(self.rowsMax)")
        }
    }
    
    
    
    // MARK: - UIPickerView
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.rowsMax
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        for var i = 0; i < self.pickers.count-1; i++ {

            if pickerView == self.pickers[i] {
                if self.rows.text != nil {
                    if let num = Int(self.rows.text!) { // Recognize The Input Number
                        // The First PickerView's Scroll Leads The Second's…………
                        // The Fourth PickerView's Scroll Leads The Fifth's
                        // And NO.1 Scroll Speed > NO.2 Scroll Speed > NO.3 Scroll Speed > NO.4 Scroll Speed > NO.5 Scroll Speed
                        // So We Can See A Slower Animation (animated: true)
                        self.pickers[i+1].selectRow(num, inComponent: 0, animated: true)
                    }
                }
            }
            
        }
        return "\(row)"
    }

    
    
    // MARK: - Dismiss The Keyboard
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.rows.resignFirstResponder()
    }
    
    
}