class CreateNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :notes do |t|
      t.integer :note_type, null: false, default: 0
      t.text :body
      t.references :posting, null: false, foreign_key: true

      t.timestamps
    end
    reversible do |dir|
      dir.up do
        Posting.where.not(quote: nil).each do |posting|
          posting.notes.create(note_type: Note.note_types["quote"], body: posting.quote) 
        end
        Posting.where.not(note: nil).each do |posting|
          posting.notes.create(note_type: Note.note_types["note"], body: posting.note) 
        end
      end
    end
  end
end
