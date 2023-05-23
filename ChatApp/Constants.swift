//
//  Constants.swift
//  ChatApp
//
//  Created by Ayca Akman on 22.05.2023.
//

import Foundation

struct K {
    static let registerSegue = "RegisterToChat"
    static let loginSegue =  "LoginToChat"
    static let cellIdentifier = "ChatCell"
    static let cellNibName = "MessageCell"
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
    }
}
