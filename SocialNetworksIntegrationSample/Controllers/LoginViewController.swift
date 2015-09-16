//
//  ViewController.swift
//  SocialNetworksIntegrationSample
//
//  Created by Mykhailo Tys on 9/8/15.
//  Copyright (c) 2015 Mykhailo Tys. All rights reserved.
//

import UIKit
import CoreMotion


class LoginViewController: UIViewController {
    
    //MARK: class members
    let loginHandler: (String!, String?, NSError?) -> Void = {(socialNetwork: String!, accessToken: String?, error: NSError?) -> Void in
        if error != nil {
            println(error)
        } else {
            if accessToken != nil {
                println(socialNetwork + " " + accessToken!)
            } else {
                println("access token is nil")
            }
        }
    }
    var gppSampleDelegate: GPSampleDelegate?
    
    //MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //MARK: actions
    @IBAction func actionFacebookLogin(sender: UIButton) {
        SocialNetworksSignInManager.loginToFacebook(loginHandler)
    }
   
    @IBAction func actionLoginGooglePlus(sender: UIButton) {
        gppSampleDelegate = GPSampleDelegate(loginHandler: loginHandler)
        SocialNetworksSignInManager.loginToGooglePlus(gppSampleDelegate!)
    }
    
    @IBAction func actionLoginTwitter(sender: UIButton) {
        SocialNetworksSignInManager.loginToTwitter(loginHandler)
    }
    
    @IBAction func actionLoginToLinkedIn(sender: UIButton) {
        SocialNetworksSignInManager.loginToLinkedIn(self, loginHandlerBlock: loginHandler)
    }
}


