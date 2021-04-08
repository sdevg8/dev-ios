//
//  CHAPIManager.swift
//  CHUnsplash
//
//  Created by user on 14/03/21.
//

import Foundation

public class CHAPIManager {
    class public var sessionProvider: URLSessionProvider? {
        if Reachability.isConnectedToNetwork(){
            return URLSessionProvider(URLSession.shared)
        }else{
            NotificationCenter.default.post(name: Notification.Name("reachabilityIdentifier"), object: nil)
            return nil
        }
    }
}
