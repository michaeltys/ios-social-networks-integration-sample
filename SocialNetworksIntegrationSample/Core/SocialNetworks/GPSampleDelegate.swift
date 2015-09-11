//
//  GPSampleDelegate.swift
//  SocialNetworksIntegrationSample
//
//  Created by Mykhailo Tys on 9/11/15.
//  Copyright (c) 2015 Mykhailo Tys. All rights reserved.
//

import Foundation

class GPSampleDelegate: NSObject, GPPSignInDelegate {
    var loginHandler: (String!, String?, NSError?) -> Void
    
    init (loginHandler: (String!, String?, NSError?) -> Void) {
        self.loginHandler = loginHandler
    }
    
    func finishedWithAuth(auth: GTMOAuth2Authentication!, error: NSError!) {
        if error == nil {
            loginHandler(SocialNetworksSignInManager.socialNetworkGooglePlus, auth.accessToken, nil)
        } else {
            loginHandler(SocialNetworksSignInManager.socialNetworkGooglePlus, nil, error)
        }
    }
    
    func didDisconnectWithError(error: NSError!) {
        loginHandler(SocialNetworksSignInManager.socialNetworkGooglePlus, nil, error)
    }
    
}
