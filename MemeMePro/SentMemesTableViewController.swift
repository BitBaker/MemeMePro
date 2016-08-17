//
//  SentMemesTableViewController.swift
//  MemeMePro
//
//  Created by Dean Martindale on 4/11/16.
//  Copyright © 2016 Dean Martindale. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController{
	
	var memes: [Meme] {
		return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.leftBarButtonItem = editButtonItem()
	}
	
	override func viewDidAppear(animated: Bool) {
		tableView.reloadData()
	}
	
	//Setup and handeling of the table view
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return memes.count
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("sentMemeTableViewCell", forIndexPath: indexPath)
		let meme = memes[indexPath.row]
		cell.imageView?.image = meme.memedImage!
		cell.textLabel?.text = meme.topTextField! + "..." + meme.bottomTextField!
		
		return cell
	}
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		let object: AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier("memeDetailViewController")
		let detailViewController = object as! MemeDetailViewController
		detailViewController.meme = self.memes[indexPath.row]
		navigationController!.pushViewController(detailViewController, animated: true)
	}
	
	override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
		if editingStyle == .Delete {
			let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
			appDelegate.memes.removeAtIndex(indexPath.row)
			tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
		}
	}
}