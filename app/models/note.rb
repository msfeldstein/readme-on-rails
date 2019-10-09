class Note < ApplicationRecord
  enum note_type: {note: 0, quote: 1}
  belongs_to :posting
end
