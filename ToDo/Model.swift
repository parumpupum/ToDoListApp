//
//  Model.swift
//  ToDo
//
//  Created by Kirill Hobyan on 11.12.21.
//

import Foundation
import UserNotifications
import UIKit

var ToDoItems: [[String : Any]] {
    set{
        UserDefaults.standard.set(newValue, forKey: "ToDoDataKey")
        UserDefaults.standard.synchronize()
    }
    
    get{
        if let array = UserDefaults.standard.array(forKey: "ToDoDataKey") as? [[String : Any]]{
            return array
        } else{
            return []
        }
    }
}

func addItem(nameItem: String, isComplited: Bool = false){
    ToDoItems.append(["Name": nameItem, "isCompleted": isComplited])
    setBadge()
}

func removeItem(at index: Int){
    ToDoItems.remove(at: index)
    setBadge()
}

func moveItem(fromIndex: Int, toIndex: Int) {
    let from = ToDoItems[fromIndex]
    ToDoItems.remove(at: fromIndex)
    ToDoItems.insert(from, at: toIndex)
    
}

func changeStatement(at item: Int) -> Bool{
    ToDoItems[item]["isCompleted"] = !(ToDoItems[item]["isCompleted"] as! Bool)
    setBadge()
    return ToDoItems[item]["isCompleted"] as! Bool
}

func requestForNotification(){
    UNUserNotificationCenter.current().requestAuthorization(options: [.badge]) { isEnadled, error in
    }
}

func setBadge(){
    var count = 0
    for item in ToDoItems{
        if (item["isCompleted"] as? Bool) == false{
            count += 1
        }
    }
    UIApplication.shared.applicationIconBadgeNumber = count
}
