//
//  FirstViewController.swift
//  isutoriGame
//
//  Created by 片平駿介 on 2019/06/29.
//  Copyright © 2019 ShunsukeKatahira. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 50%まで縮小
        UIView.animate(
            withDuration: 0.5,
            delay: 0.5,
            options: UIView.AnimationOptions.curveEaseOut,
            animations: { () in
                self.imageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        },
            completion: { (Bool) in})
        
        // 8倍にする
        UIView.animate(
            withDuration: 0.6,
            delay: 1.0,
            options: UIView.AnimationOptions.curveEaseOut,
            animations: { () in
                self.imageView.transform = CGAffineTransform(scaleX: 8.0, y: 8.0)
                self.imageView.alpha = 0
        },
            completion: { (Bool) in
                self.imageView.removeFromSuperview()
                self.performSegue(withIdentifier: "toNext", sender: nil)
        })
        
    }
    

}
