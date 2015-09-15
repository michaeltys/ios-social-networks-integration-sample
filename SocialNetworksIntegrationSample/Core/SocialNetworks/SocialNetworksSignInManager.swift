//
//  SocialNetworksSignInManager.swift
//  SocialNetworksIntegrationSample
//
//  Created by Mykhailo Tys on 9/11/15.
//  Copyright (c) 2015 Mykhailo Tys. All rights reserved.
//

import Foundation
import TwitterKit

class SocialNetworksSignInManager {
    static let socialNetworkFacebook = "facebook"
    static let socialNetworkGooglePlus = "googlePlus"
    static let socialNetworkTwitter = "twitter"
    static let socialNetworkLinkedIn = "linkedIn"
    
    static func loginToFacebook(loginHandlerBlock: (socialNetwork: String!, accessToken: String?, error: (NSError?)) -> ()) {
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
                loginHandlerBlock(socialNetwork: SocialNetworksSignInManager.socialNetworkFacebook, accessToken: nil, error: error)
            } else if result.isCancelled {
                // Handle cancellations
                FBSDKLoginManager().logOut()
                loginHandlerBlock(socialNetwork: SocialNetworksSignInManager.socialNetworkFacebook, accessToken: nil, error: nil)
            } else {
                let fbToken = result.token.tokenString
                let fbUserID = result.token.userID
                loginHandlerBlock(socialNetwork: SocialNetworksSignInManager.socialNetworkFacebook, accessToken: fbToken, error: error)
            }
        })
    }
    
    static func loginToGooglePlus(gppSignInDelegate: GPPSignInDelegate) {
        let googlePlusSignIn = setupGooglePlus(gppSignInDelegate)
        googlePlusSignIn.signOut()//for testing
        googlePlusSignIn.authenticate()
    }
    
    static func loginToTwitter(loginHandlerBlock: (socialNetwork: String!, accessToken: String?, error: (NSError?))-> ()) {
        Twitter.sharedInstance().logInWithCompletion { session, error in
            if session != nil {
                loginHandlerBlock(socialNetwork: SocialNetworksSignInManager.socialNetworkTwitter, accessToken: session!.authToken, error: nil)
            } else {
                loginHandlerBlock(socialNetwork: SocialNetworksSignInManager.socialNetworkTwitter, accessToken: nil, error: error)
            }
        }
    }
    
    static func loginToLinkedIn() {
        
    }
    
    private static func setupGooglePlus(gppSignInDelegate: GPPSignInDelegate) -> GPPSignIn {
        let googlePlusSignIn = GPPSignIn.sharedInstance()
        googlePlusSignIn?.shouldFetchGooglePlusUser = true
        googlePlusSignIn?.clientID = "676492270000-4m6j30fqa42egh9g87bcpp5pmcoqamcp.apps.googleusercontent.com"
        googlePlusSignIn?.scopes = [kGTLAuthScopePlusLogin]
        googlePlusSignIn?.delegate = gppSignInDelegate
        return googlePlusSignIn
    }

}