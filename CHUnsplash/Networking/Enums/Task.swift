//
//  Task.swift
//  CHUnsplash
//
//  Created by user on 06/04/21.
//

typealias Parameters = [String: Any]

enum Task {
    case requestPlain
    case requestParameters(Parameters)
}
