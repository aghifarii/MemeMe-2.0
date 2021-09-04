//
//  MemeTableViewController.swift
//  MemeMe 2.0
//
//  Created by Alhamdani Ghifari on 11/08/21.
//

import UIKit

class MemeTableViewController: UITableViewController {
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let addMeme = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addMeme(_:)) )
            self.navigationBar.rightBarButtonItem  = addMeme
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell")!
        let memes = self.memes[(indexPath as NSIndexPath).row]
        cell.imageView?.image = memes.memedImage
        cell.textLabel?.text = memes.topTextMeme + "..." + memes.bottomTextMeme

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetails") as! MemeDetailsViewController
        detailController.detailMeme = self.memes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
    @objc func addMeme(_ sender: AnyObject) {
        let addMeme = self.storyboard!.instantiateViewController(withIdentifier: "CreateMeme") as! ViewController
        present(addMeme, animated: true, completion: nil)
    }
}
