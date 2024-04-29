//
//  NotesViewController.swift
//  Notes
//
//  Created by Rodrigo on 28/04/24.
//

import UIKit

class NotesViewController: UIViewController {
    
    @IBOutlet var emptyNotesView: UIView!
    @IBOutlet var noteList: UITableView!
    
    let context = (UIApplication.shared .delegate as! AppDelegate).persistentContainer.viewContext
    var notesManager : NotesManager?
    var note : Note?
    
    var noteObjectList : [Note] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notesManager = NotesManager(context: context)
        notesManager?.fetch()
        notesManager?.createNoteDB(id: UUID.init(), title: "Minnesota", body: "My dog is walking towards me please help he is trying to kill me and is speaking in perfect Latvian and walking on one leg", date: Date.init(), fontSize: 256, fontColor: "Green marvek")
        noteObjectList = (notesManager?.getNotes())!
        print("Notes objects: ",noteObjectList)
        if notesManager?.countNoteDB() == 0 {
            emptyNotesView.isHidden = false
            noteList.backgroundView = emptyNotesView
        }
        else {
            emptyNotesView.isHidden = true
        }
    }
}

// MARK: - Table view data source
extension NotesViewController: UITableViewDelegate, UITableViewDataSource{
    //Get the total number of rows for the tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
    
    //Unwind segue
    @IBAction func unwindToNotesViewController(_ segue : UIStoryboardSegue){
        //print("Unwind Segue!")
        let source = segue.source as! AddNoteViewController
        note = source.newNote
        //reload table view
        noteList.reloadData()
    }
}
