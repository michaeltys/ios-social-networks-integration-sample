//
//  User+Info.swift
//  SampleProject
//
//  Created by Alex Kunitsa on 9/8/15.
//  Copyright (c) 2015 Techmagic. All rights reserved.
//

import Foundation

extension User {

    func fullname() -> String {
        return "\(firstName) \(lastName)"
    }
}