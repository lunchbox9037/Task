//
//  TaskController.swift
//  Task
//
//  Created by stanley phillips on 1/13/21.
//

import Foundation

class TaskController {
    //shared instance
    static var shared = TaskController()
    
    //source of truth
    var tasks: [Task] = []
    
    //CRUD
    func createTaskWith(name: String, notes: String?, dueDate: Date?) {
        let newTask = Task(name: name, notes: notes, dueDate: dueDate)
        tasks.append(newTask)
        //save
        saveToPersistentStorage()
    }
    
    func update(task: Task, name: String, notes: String?, dueDate: Date?) {
        task.name = name
        task.notes = notes
        task.dueDate = dueDate
        
        saveToPersistentStorage()
    }
    
    func toggleIsComplete(task: Task) {
        task.isComplete.toggle()
        
        saveToPersistentStorage()
    }
    
    func delete(task: Task) {
        guard let index = tasks.firstIndex(of: task) else {return}
        tasks.remove(at: index)
        
        saveToPersistentStorage()
    }
    
    
    // MARK: - Persistence
    //create a url
    private func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectoryURL = urls[0].appendingPathComponent(
        "Task.json")
        return documentsDirectoryURL
    }
    
    //save data
    func saveToPersistentStorage() {
        do {
            //decode and assign the entries array to the a data variable
            let data = try JSONEncoder().encode(tasks)
            //write the data to a the file url that was created
            try data.write(to: fileURL())
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
    
    //load data
    func loadFromPersistentStorage() {
        do {
            let data = try Data(contentsOf: fileURL())
            tasks = try JSONDecoder().decode([Task].self, from: data)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}
