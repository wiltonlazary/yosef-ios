//
//  DynamicComponent.swift
//  Yosef
//
//  Created by Guilherme Bayma on 3/5/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import UIKit

public class DynamicComponent {

    // MARK: Constants
    
    fileprivate static let kType = "type"
    fileprivate static let kChildren = "children"
    fileprivate static let kProperties = "properties"
    
    // MARK: Properties
    
    var type: String
    var children: [DynamicComponent]
    var properties: [DynamicProperty]
    
    // MARK: Initializers
    
    public init(type: String, children: [DynamicComponent], properties: [DynamicProperty]) {
        self.type = type
        self.children = children
        self.properties = properties
    }
    
    public convenience init(dictionary: [String: Any]) {
        let childrens = DynamicComponent.parseChildrenArray(dictionary: dictionary)
        let properties = DynamicComponent.parsePropertiesArray(dictionary: dictionary)
        let type = dictionary[DynamicComponent.kType] as? String ?? ""
        
        self.init(type: type, children: childrens, properties: properties)
    }
    
    static private func parseChildrenArray(dictionary: [String: Any]) -> [DynamicComponent] {
        var childrenArray = [DynamicComponent]()
        if let childrenDictionary = dictionary[kChildren] as? [[String : Any]] {
            for item in childrenDictionary {
                childrenArray.append(DynamicComponent(dictionary: item))
            }
        }
        return childrenArray
    }
    
    static private func parsePropertiesArray(dictionary: [String: Any]) -> [DynamicProperty] {
        if let propertiesDictionary = dictionary[kProperties] as? [[String : Any]] {
           return propertiesDictionary.compactMap({
                return try! DynamicProperty(dictionary: $0)
            })
        }
        return []
    }
    
}
