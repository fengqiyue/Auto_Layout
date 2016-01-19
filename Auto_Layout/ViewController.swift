//
//  ViewController.swift
//  Auto_Layout
//
//  Created by 张旭 on 16/1/15.
//  Copyright © 2016年 cheri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loginFiled: UITextField!

    @IBOutlet weak var passwordField: UITextField!

    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var companyLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    var loggedInUser: User? { didSet {updateUI()}}
    var secure: Bool = false { didSet {updateUI()}}
    
    private func updateUI() {
        passwordField.secureTextEntry = secure
        passwordLabel.text = secure ? "Secured Password" : "Password"
        nameLabel.text = loggedInUser?.name
        companyLabel.text = loggedInUser?.company
        image = loggedInUser?.image
    }
    
    @IBAction func toggleSecurity() {
        secure  = !secure
    }
    
    @IBAction func login() {
        loggedInUser = User.login(loginFiled.text ?? "", password: passwordField.text ?? "")
    }
    
    
    var image:UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            if let constrainedView = imageView {
                if let newImage = newValue {
                    aspectRatioConstraint = NSLayoutConstraint (
                        item: constrainedView,
                        attribute: .Width,     //宽 = 高 * 宽高比
                        relatedBy: .Equal,
                        toItem: constrainedView,  //选择相对于那个视图
                        attribute: .Height,
                        multiplier: newImage.aspectRatio, //这个属性的内容是『宽高比』
                        constant: 0)
                } else {
                    aspectRatioConstraint = nil
                }
            }
        }
    }
    
    var aspectRatioConstraint: NSLayoutConstraint? {
        willSet{
            if let existContraint = aspectRatioConstraint {
                view.removeConstraint(existContraint)
            }
            
        }
        didSet{
            if let newContraint = aspectRatioConstraint {
                view.addConstraint(newContraint)
            }
        }
    }

}



extension User {
    var image: UIImage? {
        if let image = UIImage(named:login){
            return image
        } else {
            return UIImage(named:"unknown_user")
        }
    }
}

extension UIImage {
    var aspectRatio :CGFloat {
        return size.height != 0 ? size.width / size.height : 0
    }
}
