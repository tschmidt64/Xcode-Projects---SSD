//
//  Person.swift
//  TableViewApp
//
//  Created by Taylor Schmidt on 2/3/16.
//  Copyright © 2016 Taylor Schmidt. All rights reserved.
//

import Foundation

class Person {
    var firstName:String = "<not set>"
    var lastName: String = "<not set>"
    var age:Int = 0
    
    init(firstName: String, lastName: String, age: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
}