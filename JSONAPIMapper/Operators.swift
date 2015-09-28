//
//  Operators.swift
//  GtsiapKit
//
//  Created by Giorgos Tsiapaliokas on 8/29/15.
//  Copyright © 2015 Giorgos Tsiapaliokas. All rights reserved.
//

import UIKit

infix operator <~ {}

public func <~ <T>(inout left: T?, right: Map) {
    if let mapFromJSON = right as? MapFromJSON {
        left = mapFromJSON.resourceValue()
    } else if let mapToJSON = right as? BasicMap {
        mapToJSON.retrieveValue(left as? AnyObject)
    }
}

public func <~ <T: Mappable>(inout left: T?, right: Map) {
    if let mapFromJSON = right as? MapFromJSON {
        left = mapFromJSON.relationshipValue()
    } else if let
        mapToJSON = right as? RelationshipMap,
        left = left
    {
        mapToJSON.retrieveRelationship(left)
    }
}

public func <~ <T: Mappable>(inout left: [T]?, right: Map) {
    if let mapFromJSON = right as? MapFromJSON {
        left = mapFromJSON.relationshipValue()
    } else if let
        mapToJSON = right as? RelationshipMap,
        left = left
    {
        mapToJSON.retrieveRelationships(left)
    }
}