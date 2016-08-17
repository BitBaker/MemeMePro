//
//  FontPicker.swift
//  MemeMePro
//
//  Created by Dean Martindale on 4/20/16.
//  Copyright © 2016 Dean Martindale. All rights reserved.
//

import UIKit

class FontPicker: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
	
	
	@IBOutlet weak var fontPicker: UIPickerView!
	var fontsDictionary = [String:Array<String>]()
	

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
	
	func fontDictionaryInit() {
		
		for family: String in UIFont.familyNames(){
			for names: String in UIFont.fontNamesForFamilyName(family){
				fontsDictionary[family]?.append(names)
			}
		}
	}
	
	func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
		return fontsDictionary.count
	}
	
	func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return fontsDictionary.keys.count
	}
	
	func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return "Hi"
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
