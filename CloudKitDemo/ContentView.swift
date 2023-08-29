//
//  ContentView.swift
//  CloudKitDemo
//
//  Created by Kaua Miguel on 15/08/23.
//

import SwiftUI
import CloudKit

struct ContentView: View {
    
    @State private var taskTitle : String = ""
    @StateObject private var model = CloudKitModel()
    
    var body: some View {
        VStack {
            TextField("Enter a task", text: $taskTitle)
                .textFieldStyle(.roundedBorder)
                .onSubmit {
                    let taskItem = TaskItem(title: taskTitle, dataAssigned: Date())
                    
                    Task{
                        try await model.addTask(task: taskItem)
                    }
                }
            
            List {
                ForEach(model.arrayOfItens, id: \.title){ obj in
                    Text(obj.title)
                }
            }
            
            Spacer()
        }
        .task {
            do{
                try await model.fetchTask()
            }catch{
                print("Error on saving in async way")
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


