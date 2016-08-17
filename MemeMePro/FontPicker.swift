//
//  FontPicker.swift
//  MemeMePro
//
//  Created by Dean Martindale on 4/20/16.
//  Copyright © 2016 Dean Martindale. All rights reserved.
//

import UIKit

class FontPicker: UIViewController, UIPickerViewDataSource{
	
	@IBOutlet weak var fontPicker: UIPickerView!
	let fontPickerDate: NSArray = [String]()
	
	func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
		fontPickerDate.count
	}
	
	func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		<#code#>
	}
}
