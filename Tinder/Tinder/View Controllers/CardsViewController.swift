//
//  CardsViewController.swift
//  Tinder
//
//  Created by Diego Medina on 3/15/18.
//  Copyright © 2018 Diego Medina. All rights reserved.
//

// TODO:

import UIKit

class CardsViewController: UIViewController {

    var cardInitialCenter: CGPoint!
    var imageOffset: CGFloat!
    var imageLeft: CGPoint!
    var imageRight: CGPoint!
    
    var positiveDivisor: CGFloat!
    var negativeDivisor: CGFloat!
    var trueDivisor: CGFloat!
    
    var swippingRight = false
    var swippingLeft = false

    var onTapGesture = UITapGestureRecognizer()
    
    @IBOutlet weak var candidateImageView: UIImageView!
    @IBOutlet weak var actionButtonsImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        positiveDivisor = (view.frame.width / 2) / 0.61 // 0.61 = 35 degrees
        negativeDivisor = (view.frame.width / 2) / -0.61 // 0.61 = 35 degrees
        
        imageOffset = 600 // how far to disappear the image off the screen
        cardInitialCenter = candidateImageView.center
        imageRight = CGPoint(x: candidateImageView.center.x + imageOffset ,y: candidateImageView.center.y)
        imageLeft = CGPoint(x: candidateImageView.center.x - imageOffset ,y: candidateImageView.center.y)
        
        onTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.goToProfile(sender:)))
        candidateImageView.addGestureRecognizer(onTapGesture)
        candidateImageView.isUserInteractionEnabled = true
    }
    
    @IBAction func didPanImage(_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        let cardView = sender.view!
        let xFromCenter = cardView.center.x - view.center.x
        let velocity = sender.velocity(in: view)
        
        if sender.state == .began {
            cardInitialCenter = candidateImageView.center
            
            // set the direction the card with rotate towards
            if velocity.y < 0 {
                trueDivisor = positiveDivisor
            }
            else{
                trueDivisor = negativeDivisor
            }
            
        } else if sender.state == .changed {
            
            if velocity.y < 0 && velocity.x < 0{ // move left
                candidateImageView.center = CGPoint(x: cardInitialCenter.x + translation.x, y: cardInitialCenter.y)
                cardView.center = CGPoint(x: view.center.x + translation.x , y: cardView.center.y + translation.y)
                cardView.transform = CGAffineTransform(rotationAngle: xFromCenter/trueDivisor)
                
                swippingRight = false
                swippingLeft = true
                
            }else{ // move right
                candidateImageView.center = CGPoint(x: cardInitialCenter.x + translation.x, y: cardInitialCenter.y)
                cardView.center = CGPoint(x: view.center.x + translation.x , y: cardView.center.y + translation.y)
                cardView.transform = CGAffineTransform(rotationAngle: xFromCenter/trueDivisor)
                
                swippingRight = true
                swippingLeft = false
            }
            
        } else if sender.state == .ended {
            
            if( translation.x > 110 && swippingRight ){ // move right
                UIView.animate(withDuration: 0.3) {
                    self.candidateImageView.center = self.imageRight
                }
            }
            else if (translation.x < -100 && swippingLeft) { // move left
                UIView.animate(withDuration: 0.3) {
                    self.candidateImageView.center = self.imageLeft
                }
            }
            else{ // set card back to initial state
                self.candidateImageView.transform = CGAffineTransform.identity
                self.candidateImageView.center = cardInitialCenter
            }
            
        } // else if
        
    } // didPanImage
    
    @objc func goToProfile(sender: UITapGestureRecognizer){
        performSegue(withIdentifier: "segueToProfile", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("going to segue")
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
