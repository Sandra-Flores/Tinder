//
//  CardsViewController.swift
//  Tinder
//
//  Created by Diego Medina on 3/15/18.
//  Copyright © 2018 Diego Medina. All rights reserved.
//

// TODO: KEEP ADDING THE TAPGESTURERECOGNIZER TO THE ACTIONBUTTONS
// https://www.youtube.com/watch?v=F5Rh4kDongo
// https://stackoverflow.com/questions/27880607/how-to-assign-an-action-for-uiimageview-object-in-swift

import UIKit

class CardsViewController: UIViewController {

    var cardInitialCenter: CGPoint!
    var imageOffset: CGFloat!
    var imageLeft: CGPoint!
    var imageRight: CGPoint!
    
    var positiveDivisor: CGFloat!
    var negativeDivisor: CGFloat!
    
    @IBOutlet weak var candidateImageView: UIImageView!
    @IBOutlet weak var actionButtonsImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        positiveDivisor = (view.frame.width / 2) / 0.61 // 0.61 = 35 degrees
        negativeDivisor = (view.frame.width / 2) / -0.61 // 0.61 = 35 degrees
        
        imageOffset = 350
        cardInitialCenter = candidateImageView.center
        imageRight = CGPoint(x: candidateImageView.center.x + imageOffset ,y: candidateImageView.center.y)
        imageLeft = CGPoint(x: candidateImageView.center.x - imageOffset ,y: candidateImageView.center.y)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(resetCard(sender:)))

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPanImage(_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        let cardView = sender.view!
        let xFromCenter = cardView.center.x - view.center.x
        let velocity = sender.velocity(in: view)
        
        
        if sender.state == .began {
            cardInitialCenter = candidateImageView.center
            
        } else if sender.state == .changed {
            
            if velocity.y < 0{
                candidateImageView.center = CGPoint(x: cardInitialCenter.x + translation.x, y: cardInitialCenter.y)
                cardView.center = CGPoint(x: view.center.x + translation.x , y: cardView.center.y + translation.y)
                cardView.transform = CGAffineTransform(rotationAngle: xFromCenter/positiveDivisor)
            }else{
                candidateImageView.center = CGPoint(x: cardInitialCenter.x + translation.x, y: cardInitialCenter.y)
                cardView.center = CGPoint(x: view.center.x + translation.x , y: cardView.center.y + translation.y)
                cardView.transform = CGAffineTransform(rotationAngle: xFromCenter/negativeDivisor)
            }
            
        } else if sender.state == .ended {
            
            
            
            if( velocity.x > 0 ){ // moving right
                
                UIView.animate(withDuration: 0.3) {
                    self.candidateImageView.center = self.imageRight
                }
                cardView.removeFromSuperview()

                
            }else{ // moving left
                UIView.animate(withDuration: 0.3) {
                    self.candidateImageView.center = self.imageLeft
                }
                cardView.removeFromSuperview()
                
            }
            
        } // else if
        
    } // didPanImage
    
    @objc func resetCard(sender: UITapGestureRecognizer){
        UIView.animate(withDuration: 0.2, animations: {
            self.candidateImageView.center = self.view.center
            self.candidateImageView.transform = CGAffineTransform.identity
        })
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
