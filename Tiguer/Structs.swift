//
//  Structs.swift
//  Tiguer
//
//  Created by Bruce McTigue on 1/1/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import Foundation

public struct Request {
    public var params: [String: String]
    public init(_ params: [String: String] = [:]) {
        self.params = params
    }
}

public struct Response<Model> {
    public let models: [Model]
}
