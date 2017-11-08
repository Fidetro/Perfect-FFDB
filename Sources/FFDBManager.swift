//
//  FFDBManager.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2017/9/12.
//  Copyright © 2017年 Fidetro. All rights reserved.
//


public struct FFDBManager {
    
}

// MARK: - Insert
extension FFDBManager {
    public static func insert(_ object:FFObject, _ columns:[String]?,complete:FFDBUpdateComplete = nil)  {
        if let columnsArray = columns {
            var values = Array<Any>()
            for key in columnsArray {
                values.append(object.valueNotNullFrom(key))
            }
            Insert().into(object.subType).columns(columnsArray).values(values).execute(complete: complete)
            
            
        }else{
            Insert().into(object.subType).columns(object.subType).values(object).execute(complete: complete)
        }
    }
    public  static func insert(_ object:FFObject,complete:FFDBUpdateComplete = nil)  {
        insert(object, nil,complete:complete)
    }
    public  static func insert(_ table:FFObject.Type,_ columns:[String],values:[Any],complete:FFDBUpdateComplete = nil) {
        Insert().into(table).columns(columns).values(values).execute(complete: complete)
    }
}


// MARK: - Select
extension FFDBManager {
    public  static func select<T:FFObject,U:Decodable>(_ table:T.Type, _ columns:[String]?, where condition:String?, return type:U.Type) -> Array<Decodable>? {
        
        if let format = condition {
            if let col = columns {
                return Select(col).from(table).whereFormat(format).execute(type)
            }else{
                return Select().from(table).whereFormat(format).execute(type)
            }
        }else{
            
            if let col = columns {
                return Select(col).from(table).execute(type)
            }else{
                return Select().from(table).execute(type)
            }
        }
    }
    
    public   static func select<T:FFObject>(_ table:T.Type,_ columns:[String]?,where condition:String?) -> Array<Decodable>? {
        return select(table, columns, where: condition, return: table)
    }
}

// MARK: - Update
extension FFDBManager {
    public static func update(_ object:FFObject,set columns:[String]?,complete:FFDBUpdateComplete = nil) {
        if let primaryID = object.primaryID  {
            if let col = columns {
                 Update(object).set(col).whereFormat("primaryID = '\(primaryID)'").execute(complete: complete)
            }else{
                 Update(object).set().whereFormat("primaryID = '\(primaryID)'").execute(complete: complete)
            }
        }else{
            assertionFailure("primaryID can't be nil")
        }
    }
    public  static func update(_ table:FFObject.Type,set setFormat:String,where whereFormat:String?,complete:FFDBUpdateComplete = nil) {
        if let format = whereFormat  {
             Update(table).set(setFormat).whereFormat(format).execute(complete: complete)
        }else{
             Update(table).set(setFormat).execute(complete: complete)
        }
    }
}


// MARK: - Delete
extension FFDBManager {
    public  static func delete(_ table:FFObject.Type,where condition:String?,complete:FFDBUpdateComplete = nil){
        if let format = condition {
            Delete().from(table).whereFormat(format).execute(complete: complete)
        }else{
            Delete().from(table).execute(complete: complete)
        }
    }
    public static func delete(_ object:FFObject,complete:FFDBUpdateComplete = nil) {
        guard let primaryID = object.primaryID else {
            assertionFailure("primaryID can't be nil")
            return
        }
        Delete().from(object.subType).whereFormat("primaryID = '\(primaryID)'").execute(complete: complete)
        
    }
}

// MARK: - Create
extension FFDBManager {
    static func create(_ table:FFObject.Type,complete:FFDBUpdateComplete = nil) {
        Create(table).execute(complete: complete)
    }
}

// MARK: - Create
extension FFDBManager {
    static func alter(_ table:FFObject.Type,complete:FFDBUpdateComplete = nil) {
        Alter(table).execute(complete: complete)
    }
}

