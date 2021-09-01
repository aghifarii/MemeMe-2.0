//
//  MemeCollectionViewController.swift
//  MemeMe 2.0
//
//  Created by Alhamdani Ghifari on 11/08/21.
//

import UIKit

private let reuseIdentifier = "Cell"

class MemeCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var memeFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var navigationBar: UINavigationItem!

    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.collectionView!.reloadData()
        
    }
    
    func reloadData() {
        return collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Add new meme button
        let addMeme = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addMeme(_:)) )
            self.navigationBar.rightBarButtonItem = addMeme

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
//        let space:CGFloat = 3.0
//        let dimension = (view.frame.size.width - (2 * space)) / 3.0
//
//        memeFlowLayout.minimumInteritemSpacing = space
//        memeFlowLayout.minimumLineSpacing = space
//        memeFlowLayout.itemSize = CGSize(width: dimension, height: dimension)
       
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        let memes = self.memes[(indexPath as NSIndexPath).row]
    
        // Configure the cell
        cell.memeImageView?.image = memes.memedImage
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetails") as! MemeDetailsViewController
        detailController.detailMeme = self.memes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
    @objc func addMeme(_ sender: AnyObject) {
        let addMeme = self.storyboard!.instantiateViewController(withIdentifier: "CreateMeme") as! ViewController
        present(addMeme, animated: true, completion: nil)
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
