//
//  CloudKitModel.swift
//  CloudKitDemo
//
//  Created by Kaua Miguel on 25/08/23.
//

import Foundation
import CloudKit

enum TaskRecordKeys : String {
    case type = "TaskItem"
    case title
    case dataAssigned
    case isComplited
}

struct TaskItem{
    var recordId : CKRecord.ID?
    let title : String
    let dataAssigned : Date
    var isCompleted : Bool = false
}

extension TaskItem{
    var record : CKRecord {
        let record = CKRecord(recordType: TaskRecordKeys.type.rawValue)
        record[TaskRecordKeys.title.rawValue] = self.title
        record[TaskRecordKeys.dataAssigned.rawValue] = self.dataAssigned
        record[TaskRecordKeys.isComplited.rawValue] = self.isCompleted
        return record
    }
}

