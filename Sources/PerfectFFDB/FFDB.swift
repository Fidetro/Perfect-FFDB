//
//  FFDB.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2017/8/20.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

import PerfectLogger
func printDebugLog<T>(_ message: T,
                      file: String = #file,
                      method: String = #function,
                      line: Int = #line)
{
    LogFile.error("\(file)[\(line)], \(method): \(message)", logFile: "FFDBError.txt")
}
public struct FFDB {
    static var connect = PerfectMySQLConnect.self
}



public protocol FIDRuntime {
    init()
    
    /// 获取对象类型
    var subType : Any.Type {get}
    
    /// 相当于Objective-C中的valueForKey:
    ///
    /// - Parameter key: key
    /// - Returns: value
    func valueFrom(_ key: String) -> Any?
}

public protocol FFObject:FIDRuntime,Decodable {
    var primaryID : Int64? {get}
    
    static func registerTable()
    static func select(where condition:String?) -> Array<FFObject>?
    func insert(complete:FFDBUpdateComplete)
    func update(complete:FFDBUpdateComplete)
    func delete(complete:FFDBUpdateComplete)
    static func columnsType() -> [String:String]
    
    /// 相当于Objective-C中的valueForKey: 但返回的值永远不会为空
    ///
    /// - Parameter key: key
    /// - Returns: value
    func valueNotNullFrom(_ key: String) -> String
    static func columnsOfSelf() -> Array<String>
    static func memoryPropertys() -> [String]?
    static func customColumnsType() -> [String:String]?
    static func customColumns() -> [String:String]?
    static  func tableName() -> String
}






