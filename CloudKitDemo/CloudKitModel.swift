//
//  CloudKitModel.swift
//  CloudKitDemo
//
//  Created by Kaua Miguel on 25/08/23.
//

import Foundation
import CloudKit

//Class with CRUD functions
class CloudKitModel : ObservableObject{
    
    private var db = CKContainer.default().privateCloudDatabase
    @Published var arrayOfItens : [TaskItem] = []
    
    func addTask (task : TaskItem) async throws{
        let result = try await db.save(task.record)
    }
    
    func fetchTask() async throws{
    
        //Create a query to send to iCloud passing the record
        let query = CKQuery(recordType: TaskRecordKeys.type.rawValue, predicate: NSPredicate(value: true))

        //Get the results with record functions that fetches in async way
        let (fetechResult, _) = try await db.records(matching: query)
        
        //Iterate over each record
        try fetechResult.forEach { _, result in
            //Get the CKresult of the record in form of dictionary
            let ckRecord = try result.get()
            
            //get the value of the dictionary with the respective key
            let newItem = ckRecord[TaskRecordKeys.title.rawValue]
            if let value = newItem{
                //Append the item fetched in the array
                let newObject = TaskItem(title: value as! String, dataAssigned: Date())
                arrayOfItens.append(newObject)
            }
        }
    }
}
