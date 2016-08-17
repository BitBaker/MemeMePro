//
//  SentMemesCollectionViewController.swift
//  MemeMePro
//
//  Created by Dean Martindale on 4/11/16.
//  Copyright © 2016 Dean Martindale. All rights reserved.
//

import UIKit

class SentMemesCollectionView: UICollectionViewController{
	
	@IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
	
	var memes: [Meme] {
		return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let space: CGFloat = 3.0
		let dimension = (view.frame.size.width - (2*space))/3.0
		
		flowLayout.minimumInteritemSpacing = space
		flowLayout.itemSize = CGSizeMake(dimension, dimension)
	}
	
	override func viewWillAppear(animated: Bool) {
		collectionView!.reloadData()
	}
	
	// Setup and handeling of collection view.
	override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
		return 1
	}
	
	override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return memes.count
	}
	
	override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier("memeCollectionCell", forIndexPath: indexPath) as! CustomMemeCell
		let meme = memes[indexPath.item]
		cell.topText = meme.topTextField
		cell.bottomText = meme.bottomTextField
		cell.imageView.image = meme.memedImage
		
		return cell
	}
	
	override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
		let object: AnyObject = storyboard!.instantiateViewControllerWithIdentifier("memeDetailViewController")
		let detailViewController = object as! MemeDetailViewController
		detailViewController.meme = memes[indexPath.row]
		navigationController?.pushViewController(detailViewController, animated: true)
	}

}