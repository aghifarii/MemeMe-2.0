//
//  MemeDetailsViewController.swift
//  MemeMe 2.0
//
//  Created by Alhamdani Ghifari on 19/08/21.
//

import UIKit

class MemeDetailsViewController: UIViewController {

    @IBOutlet weak var cancelButton: UINavigationBar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var memeImageDisplay: UIImageView!
        
    var detailMeme : Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memeImageDisplay.sizeToFit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.memeImageDisplay!.image = detailMeme.memedImage
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
