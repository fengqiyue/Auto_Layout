//
//  User.swift
//  Auto_Layout
//
//  Created by 张旭 on 16/1/16.
//  Copyright © 2016年 cheri. All rights reserved.
//

import Foundation

struct User {
    let name: String
    let company:String
    let login:String
    let password:String
    
    static func login(login:String, password:String) -> User? {
        if let user = database[login] {
            if user.password == password {
                return user
            }
            
        }
        return nil
 
    }
    
    static let database: Dictionary<String, User> =  {
        var theDatabase = Dictionary<String, User>()
        for user in [
            User(name: "John Appleseed", company: "Apple", login: "japple", password: "foo"),
            User(name: "Octree Liu", company: "TInydust__!@___#@!_____#!____*&^___", login: "octree", password: "foo"),
            User(name: "John Hennseey", company: "Stanford", login: "hennessy", password: "foo"),
            User(name: "Bad Guy", company: "Criminals,Inc", login: "baddie", password: "foo")
            ] {
                theDatabase[user.login] = user
        }
        return theDatabase
    }()

}

