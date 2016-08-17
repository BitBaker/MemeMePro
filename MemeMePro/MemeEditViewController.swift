//
//  MemeEditViewController.swift
//  MemeMe_ND
//
//  Created by Dean Martindale on 4/7/16.
//  Copyright © 2016 Dean Martindale. All rights reserved.
//

import UIKit

class MemeEditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
	
	@IBOutlet weak var topTextField: UITextField!
	@IBOutlet weak var bottomTextField: UITextField!
	@IBOutlet weak var memeImage: UIImageView!
	@IBOutlet weak var cameraButton: UIBarButtonItem!
	@IBOutlet weak var shareButton: UIBarButtonItem!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		shareButton.enabled = false
		memeImage.image = nil
		cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
		setupTextField(topTextField, defaultText: "TOP")
		setupTextField(bottomTextField, defaultText: "BOTTOM")
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		subscribeToKeyboardNotifications()
		navigationController?.setToolbarHidden(false, animated: true)
	}
	
	override func viewWillDisappear(animated: Bool) {
		super.viewWillDisappear(animated)
		unsubscribeFromKeyboardNotifications()
	}
	
	override func prefersStatusBarHidden() -> Bool {
		return true
	}
	
	// Set default values for the meme text.
	func setupTextField(textField: UITextField, defaultText: String){
		textField.delegate = self
		let memeTextAttributes = [
			NSStrokeColorAttributeName : UIColor.blackColor(),
			NSForegroundColorAttributeName : UIColor.whiteColor(),
			NSFontAttributeName : UIFont(name: "Impact", size: 40)!,
			NSStrokeWidthAttributeName : -5
		]
		textField.defaultTextAttributes = memeTextAttributes
		textField.text = defaultText
		textField.textAlignment = NSTextAlignment.Center
	}
	
	// Handle the editing of the textfields.
	func textFieldDidBeginEditing(textField: UITextField) {
		if textField.text == "TOP" || textField.text == "BOTTOM"{
			textField.text?.removeAll()
		}
	}
	
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		topTextField.resignFirstResponder()
		bottomTextField.resignFirstResponder()
		return true
	}
	
	func textFieldDidEndEditing(textField: UITextField) {
		topTextField.text = topTextField.text
		bottomTextField.text = bottomTextField.text
	}
	
	func keyboardWillShow(notification: NSNotification){
		if bottomTextField.isFirstResponder(){
			view.frame.origin.y = getKeyboardHeight(notification) * -1
		}
	}
	
	func keyboardWillHide(notification: NSNotification){
		if bottomTextField.isFirstResponder(){
			view.frame.origin.y = 0
		}
	}
	
	func getKeyboardHeight(notfication: NSNotification) -> CGFloat{
		let userInfo = notfication.userInfo!
		let keyboardSize = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue
		return keyboardSize.CGRectValue().height
	}
	
	func subscribeToKeyboardNotifications(){
		NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(MemeEditViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
		NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(MemeEditViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
	}
	
	func unsubscribeFromKeyboardNotifications(){
		NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
		NSNotificationCenter.defaultCenter().removeObserver(self,name:UIKeyboardWillHideNotification, object: nil)
	}
	// Allow the user to pick or take a photo.
	
	func selectAnImage(source: UIImagePickerControllerSourceType){
		let imagePickerController = UIImagePickerController()
		imagePickerController.allowsEditing = true
		imagePickerController.delegate = self
		imagePickerController.sourceType = source
		presentViewController(imagePickerController, animated: true, completion: nil)
	}
	
	@IBAction func cameraButtonPressed(sender: AnyObject) {
		selectAnImage(.Camera)
	}
	
	@IBAction func albumButtonPressed(sender: AnyObject) {
		selectAnImage(.PhotoLibrary)
	}
	
	func imagePickerControllerDidCancel(picker: UIImagePickerController) {
		dismissViewControllerAnimated(true, completion: nil)
	}
	
	func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
		if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
			memeImage.contentMode = UIViewContentMode.ScaleAspectFit
			memeImage.image = image
		}
		shareButton.enabled = true
		dismissViewControllerAnimated(true, completion: nil)
	}
	
	func generateMemeImage() -> UIImage {
		
		// Hide toolbar.
		navigationController?.setToolbarHidden(true, animated: true)
		
		// Generate the meme.
		UIGraphicsBeginImageContext(self.view.frame.size)
		view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
		let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		// Show toolbar.
		navigationController?.setToolbarHidden(false, animated: true)
		
		return memedImage
	}
	
	func saveMeme(){
		// Create a meme object to be saved.
		let meme = Meme( topTextField: topTextField.text!, bottomTextField: bottomTextField.text!, image: memeImage.image, memedImage: generateMemeImage())
		
		let object = UIApplication.sharedApplication().delegate
		let appDelegate = object as! AppDelegate
		appDelegate.memes.append(meme)
	}
	
	// Present and dismiss the activity controller.
	@IBAction func actionButtonPressed(sender: AnyObject) {
		resignFirstResponder()
		let memedImage = generateMemeImage()
		let activityController = UIActivityViewController(activityItems: [memedImage] , applicationActivities: nil)
		presentViewController(activityController, animated: true, completion: nil)
		activityController.completionWithItemsHandler = {(activity, completed, items, error) in
			if completed {
				self.saveMeme()
			}
			self.dismissViewControllerAnimated(true, completion: nil)
		}
	}
	
	@IBAction func cancelButtonPressed(sender: AnyObject) {
		dismissViewControllerAnimated(true, completion: nil)
	}
	
}

