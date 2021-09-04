//
//  ViewController.swift
//  MemeMe 2.0 reference to MemeMe 1.0
//
//  Created by Alhamdani Ghifari on 22/07/21.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var actionButton: UIBarButtonItem!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    let textDelegate = MyTextFieldDelegate()
    
    let memeTextAtribute: [NSAttributedString.Key: Any] = [
        .strokeColor: UIColor.black,
        .foregroundColor : UIColor.white,
        .strokeWidth : -2.0,
        .font : UIFont(name: "HelveticaNeue-CondensedBlack", size: 28) as Any
    ]
    
    func setupTextField() {
        topText.defaultTextAttributes = memeTextAtribute
        bottomText.defaultTextAttributes = memeTextAtribute
        self.topText.delegate = textDelegate
        self.bottomText.delegate = textDelegate
        topText.textAlignment = .center
        bottomText.textAlignment = .center
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        imageView.sizeToFit()
    }
    
    func pickImage(source: UIImagePickerController.SourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = source
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pickImageFromAlbum(_ sender: Any){
        pickImage(source: .photoLibrary)
    }
    
    @IBAction func pickImageFromCamera(_ sender: Any){
        pickImage(source: .camera)
    }
    
    @IBAction func shareImage(_ sender: Any) {
        let image = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        controller.completionWithItemsHandler = {
                    _, completed, _, _ in
                    if completed {
                        //save
                        self.save()
                    }
                }
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
        
    override func viewWillAppear(_ animated: Bool) {
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        actionButton.isEnabled = imageView.image != nil
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewWillDisappear(animated)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imageView.image = image
            imageView.sizeToFit()
        }
        dismiss(animated: true, completion: nil)
        actionButton.isEnabled = imageView.image != nil
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imageView.image = nil
        dismiss(animated: true, completion: nil)
        actionButton.isEnabled = imageView.image != nil
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
//        if bottomText.isEditing == true {
//            view.frame.origin.y = -getKeyboardHeight(notification)
//        }
        if bottomText.isFirstResponder {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification){
        view.frame.origin.y = 0
    }
    
    // MARK: Start Over
    func startOver() {
        if let navigationController = self.navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }

    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func hideShow(_ isHidden: Bool) {
        navigationBar.isHidden = isHidden
        toolBar.isHidden = isHidden
    }
    
    func generateMemedImage() -> UIImage {
        //Hide Toolbar and navbar
        hideShow(true)
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        //Show tollbar and navbar
        hideShow(false)
        
        return memedImage
    }
    
    func save(){
        let meme = Meme(topTextMeme: topText.text!, bottomTextMeme: bottomText.text!, originalImage: imageView.image!, memedImage: generateMemedImage())
        // Add it to the memes array in the Application Delegate
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        dismiss(animated: true, completion: nil)
        
    }
    
    
}

