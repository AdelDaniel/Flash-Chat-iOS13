//
//  Constants.swift
//  Flash Chat iOS13
//
//  Created by Adel Nabil on 27/05/2026.
//  Copyright © 2026 Angela Yu. All rights reserved.
//


struct K {
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LoginToChat"
    static let appName = "Flash Chat"
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lightBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "msg"
        static let senderField = "sender"
        static let bodyField = "text"
        static let dateField = "date"
    }
}
