//
//  SplashScreenViewController.swift
//  SportsApp
//
//  Created by Mina Ezzat on 7/27/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import UIKit
import Lottie

class SplashScreenViewController: UIViewController {

    var animationView: AnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        animationView = .init(name: "splash")
        animationView?.frame = view.bounds
        animationView?.loopMode = .loop
        view.addSubview(animationView!)
        animationView?.play()
        navigationToNextView()
    }
    
    func navigationToNextView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainVC")
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    

}
