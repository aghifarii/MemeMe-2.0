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
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
