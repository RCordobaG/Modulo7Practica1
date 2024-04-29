//
//  NotesViewController.swift
//  Notes
//
//  Created by Rodrigo on 28/04/24.
//

import UIKit

class NotesViewController: UIViewController {
    
    @IBOutlet var emptyNotesView: UIView!
    @IBOutlet weak var noteList: UITableView!
    @IBOutlet weak var addNoteButton: UIBarButtonItem!
    
    
    let context = (UIApplication.shared .delegate as! AppDelegate).persistentContainer.viewContext
    var notesManager : NotesManager?
    var note : Note?
    
    var noteObjectList : [Note] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notesManager = NotesManager(context: context)
        notesManager?.fetch()

        if notesManager?.countNoteDB() == 0 {
            emptyNotesView.isHidden = false
            noteList.backgroundView = emptyNotesView
        }
        else {
            emptyNotesView.isHidden = true
        }
    }
    
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        
        if noteList.isEditing{
            noteList.setEditing(false, animated: true)
            sender.title = "Edit"
            addNoteButton.isEnabled = true
        }
        else{
            noteList.setEditing(true, animated: true)
            sender.title = "Done"
            addNoteButton.isEnabled = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTaskSegue"{
            let destination = segue.destination as! AddNoteViewController
            destination.newNote = notesManager?.getNotes()[noteList.indexPathForSelectedRow!.row]
        }
    }

    
}

// MARK: - Table view data source
extension NotesViewController: UITableViewDelegate, UITableViewDataSource{
    //Get the total number of rows for the tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if notesManager?.countNoteDB() == 0 {
            emptyNotesView.isHidden = false
            noteList.backgroundView = emptyNotesView
        }
        else {
            emptyNotesView.isHidden = true
        }
        return notesManager!.countNoteDB()
    }
    
    //Set data source for each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        noteObjectList = (notesManager?.getNotes())!
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? NoteCell
        cell?.noteTitle.text = noteObjectList[indexPath.row].title
        cell?.noteBody.text = noteObjectList[indexPath.row].body
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showTaskSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            note = notesManager?.getNotes()[indexPath.row]
            self.context.delete(note!)
            
            do{
                try self.context.save()
            }
            catch let error {
                print("Error: ", error)
            }
        }
        notesManager?.fetch()
        noteList.reloadData()
    }
    
    //Unwind segue
    @IBAction func unwindToNotesViewController(segue : UIStoryboardSegue){
        //print("Unwind Segue!")
        let source = segue.source as! AddNoteViewController
        note = source.newNote
        
        do{
            try context.save()
        }
        catch let error{
            print("Error: ",error)
        }
        notesManager?.fetch()
        //reload table view
        noteList.reloadData()
    }
    
    
}
