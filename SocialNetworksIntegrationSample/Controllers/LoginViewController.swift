//
//  ViewController.swift
//  SocialNetworksIntegrationSample
//
//  Created by Mykhailo Tys on 9/8/15.
//  Copyright (c) 2015 Mykhailo Tys. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: class members
    let loginHandler: (String!, String?, NSError?) -> Void = {(socialNetwork: String!, accessToken: String?, error: NSError?) -> Void in
        if error != nil {
            print(error)
        } else {
            if accessToken != nil {
                print(socialNetwork + " " + accessToken!)
            } else {
                print("access token is nil")
            }
        }
    }
    
    //MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //MARK: actions
    @IBAction func actionFacebookLogin(sender: UIButton) {
        loginToFacebook(loginHandler)
    }
   
    //MARK: facebook
    func loginToFacebook(loginHandlerBlock: (socialNetwork: String!, accessToken: String?, error: (NSError?)) -> ()) {
        let facebookReadPermissions = ["public_profile", "email"]
        if FBSDKAccessToken.currentAccessToken() != nil {
            //For debugging, when we want to ensure that facebook login always happens
            FBSDKLoginManager().logOut()
        }
        FBSDKLoginManager().logInWithReadPermissions(facebookReadPermissions, handler: {(result:FBSDKLoginManagerLoginResult!, error:NSError!) -> Void in
            if error != nil {
                //According to Facebook:
                //Errors will rarely occur in the typical login flow because the login dialog
                //presented by Facebook via single sign on will guide the users to resolve any errors.
                
                // Process error
                FBSDKLoginManager().logOut()
                loginHandlerBlock(socialNetwork: "facebook", accessToken: nil, error: error)
            } else if result.isCancelled {
                // Handle cancellations
                FBSDKLoginManager().logOut()
                loginHandlerBlock(socialNetwork: "facebook", accessToken: nil, error: nil)
            } else {
                let fbToken = result.token.tokenString
                let fbUserID = result.token.userID
                loginHandlerBlock(socialNetwork: "facebook", accessToken: fbToken, error: error)
            }
        })
    }
}

