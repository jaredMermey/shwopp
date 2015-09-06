//
//  Message.swift
//  Emelem
//
//  Created by Jared Mermey on 5/25/15.
//  Copyright (c) 2015 Jared Mermey. All rights reserved.
//

import Foundation

struct Message {
    let message: String
    let senderID: String
    let date: NSDate
}

class MessageListener {
    var currentHandle: UInt?
    
    init (keptProductSKU: String, startDate: NSDate, callback: (Message)->())  {
        
        let handle = ref.childByAppendingPath(keptProductSKU).queryOrderedByKey().queryStartingAtValue(dateFormatter().stringFromDate(startDate)).observeEventType(FEventType.ChildAdded, withBlock: {
            snapshot in
            let message = snapshotToMessage(snapshot)
            callback(message)
        })
        self.currentHandle = handle
    }
    func stop() {
        if let handle = currentHandle{
            ref.removeObserverWithHandle(handle)
            currentHandle = nil
        }
    }
}

private let ref = Firebase(url: "https://emelem.firebaseio.com/messages")
private let dateFormat = "yyyyMMddHHmmss"

private func dateFormatter() -> NSDateFormatter {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = dateFormat
    return dateFormatter
}

func saveMessage(productSKU: String, message: Message) {
    ref.childByAppendingPath(productSKU).updateChildValues([dateFormatter().stringFromDate(message.date) : ["message" : message.message, "sender" : message.senderID]])
}

private func snapshotToMessage(snapshot: FDataSnapshot) -> Message {
    
    let date = dateFormatter().dateFromString(snapshot.key)
    let sender = snapshot.value["sender"] as? String
    let text = snapshot.value["message"] as? String
    return Message(message: text!, senderID: sender!, date: date!)

}

func fetchMessages(keptProductSKU: String, callback: ([Message]) -> ()) {
    
    ref.childByAppendingPath(keptProductSKU).queryLimitedToFirst(25).observeSingleEventOfType(FEventType.Value, withBlock: {
        snapshot in
        
        var messages = Array<Message>()
        let enumerator = snapshot.children
        
        while let data = enumerator.nextObject() as? FDataSnapshot {
            messages.append(snapshotToMessage(data))
        }
            callback(messages)
    })
    
}