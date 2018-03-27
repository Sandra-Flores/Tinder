//
//  ProfileViewController.swift
//  Tinder
//
//  Created by Diego Medina on 3/15/18.
//  Copyright © 2018 Diego Medina. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var navBar: UIImageView!
    @IBOutlet weak var candidateImageView: UIImageView!
    
    var imageURL: URL!
    var onTapGesture = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        onTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.goToHomePage(sender:)))
        navBar.addGestureRecognizer(onTapGesture)
        navBar.isUserInteractionEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func goToHomePage(sender: UITapGestureRecognizer){
        performSegue(withIdentifier: "segueToHomePage", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("going to segue")
        
        if segue.identifier == "goToHomePage"{
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
