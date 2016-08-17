//
//  MemeDetailViewController.swift
//  MemeMePro
//
//  Created by Dean Martindale on 4/12/16.
//  Copyright © 2016 Dean Martindale. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
	
	var meme: Meme?
	@IBOutlet weak var memeView: UIImageView!
	
	//Set the image for the detail view
	override func viewWillAppear(animated: Bool) {
		memeView.image = meme?.memedImage
	}

}