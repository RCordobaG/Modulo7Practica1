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
    var noteJSON : NoteJSON?
    
    var noteObjectList : [Note] = []
    var noteJSONList : [NoteJSON] = []
    
    var isEdit : Bool = false
    var editIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notesManager = NotesManager(context: context)
        notesManager?.loadNotes()

        if notesManager?.countNotes() == 0 {
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
            destination.newNoteJSON = notesManager?.getNotes()[noteList.indexPathForSelectedRow!.row]
        }
    }

    
}

// MARK: - Table view data source
extension NotesViewController: UITableViewDelegate, UITableViewDataSource{
    //Get the total number of rows for the tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if notesManager?.countNotes() == 0 {
            emptyNotesView.isHidden = false
            noteList.backgroundView = emptyNotesView
        }
        else {
            emptyNotesView.isHidden = true
        }
        return notesManager!.countNotes()
    }
    
    //Set data source for each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        noteJSONList = (notesManager?.getNotes())!
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? NoteCell
        cell?.noteTitle.text = noteJSONList[indexPath.row].title
        cell?.noteBody.text = noteJSONList[indexPath.row].body
        cell?.noteDate.text = noteJSONList[indexPath.row].date.ISO8601Format()
        cell?.notePriority.text = noteJSONList[indexPath.row].priority
        //cell?.noteBody.text = noteJSONList[indexPath.row].body
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        editIndex = indexPath.row
        performSegue(withIdentifier: "showTaskSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //noteJSON = notesManager?.getNotes()[indexPath.row]
            notesManager?.deleteNote(at: indexPath.row)
            
            notesManager?.saveNotes()
        }
        notesManager?.loadNotes()
        noteList.reloadData()
    }
    
    //Unwind segue
    @IBAction func unwindToNotesViewController(segue : UIStoryboardSegue){
        //print("Unwind Segue!")
        let source = segue.source as! AddNoteViewController
        noteJSON = source.newNoteJSON
        isEdit = source.isEditOp
        if (isEdit){
            notesManager?.updateNote(at: editIndex, note: noteJSON!)
            notesManager?.saveNotes()
        }
        else{
            notesManager?.createNote(note: noteJSON!)
            notesManager?.saveNotes()
        }
        
        

        notesManager?.loadNotes()
        //reload table view
        noteList.reloadData()
    }
    
    
}
