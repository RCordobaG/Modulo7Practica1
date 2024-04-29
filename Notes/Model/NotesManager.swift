//
//  NotesManager.swift
//  Notes
//
//  Created by Rodrigo on 28/04/24.
//

import Foundation
import CoreData

class NotesManager {
    
    private var noteList : [Note] = []
    private var context : NSManagedObjectContext
    
    init(context : NSManagedObjectContext){
        self.context = context
    }
    
    func fetch(){
        do{
            self.noteList = try self.context.fetch(Note.fetchRequest())
        }
        catch let error{
            print("Error: ", error)
        }
    }
    
    //CRUD: Create
    func createNoteDB(id: UUID, title: String, body: String, date: Date, fontSize : Int16, fontColor : String) -> Note?{
        
        let newNote = Note(context: context)
        newNote.id = UUID()
        newNote.title = title
        newNote.body = body
        newNote.date = date
        newNote.fontSize = fontSize
        newNote.fontColor = fontColor
        
        do{
            try context.save()
            return newNote
        }
        catch let error{
            print("Error creating note: ", error)
            return nil
        }
        
    }
    
    //CRUD: Read
    func countNoteDB() -> Int{
        return noteList.count
    }
    
    func getNotes() -> [Note]{
        if let noteList = try? self.context.fetch(Note.fetchRequest()){
            return noteList
        }
        else{
            return []
        }
    }
    
    func getNoteByID(uuid: UUID) -> Note?{
        do{
            let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
            fetchRequest.predicate = NSPredicate(format: "id = %@", uuid as CVarArg)
            self.noteList = try self.context.fetch(fetchRequest)
            return noteList.first
        }
        catch let error{
            print("Error retrieving note with ID: ",uuid)
            print("Error: ", error)
            return nil
        }
        
    }
    
    //CRUD: Update
    func updateNoteDB(currentNote : Note, title: String, body: String, date: Date, fontSize : Int16, fontColor : String) -> Note?{
        
        let note = Note(context: context)
        note.id = UUID()
        note.title = title
        note.body = body
        note.date = date
        note.fontSize = fontSize
        note.fontColor = fontColor
        
        do{
            try context.save()
        }
        catch let error{
            print("Error updating note: ", error)
        }
        
        return note
    }
    
    //CRUD: Delete
    func deleteNoteDB(note : Note) -> Bool{
        self.context.delete(note)
        
        do{
            try context.save()
            return true
        }
        catch let error{
            print("Error deleting note: ",error)
            return false
        }
    }
    
    /*
    //JSON operations
    func createNote(note : Note){
        noteList.append(note)
        
    }
    
    func deleteNote(at index : Int) {
        noteList.remove(at: index)
    }
    
    func getNotes() -> [Note] {
        return noteList
    }
    
    func getNote(at index : Int) -> Note {
        return noteList[index]
    }
    
    func countNotes() -> Int {
        return noteList.count
    }
    
    func saveNotes()  {
        //save json file with created notes
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        //v1
        let notesURL = documentsDirectory.appendingPathComponent("notes.json")
        print("notesURL:", notesURL)
        
        //v2
        let notesURL2 = documentsDirectory.appending(path: "notes.json")
        print("notesURL v2", notesURL2)
        
        //Save [Note] as json file
        do {
            let jsonData = try JSONEncoder().encode(noteList)
            fileManager.createFile(atPath: notesURL.path, contents: jsonData)
        }
        catch let error {
            print(error)
        }
    }
    
    
    func loadNotes() {
        //Loads nothe from json file
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let notesURL = documentsDirectory.appendingPathComponent("notes.json")
        
        //Check if file exists
        if fileManager.fileExists(atPath: notesURL.path){
            do {
                let jsonData = fileManager.contents(atPath: notesURL.path)
                //Decode json file into array
                noteList = try JSONDecoder().decode([Note].self, from: jsonData!)
            }
            catch let error {
                print("error: ", error)
            }
        }
        else {
            print("No se localizó el archivo")
        }
        
    }
     */
}
