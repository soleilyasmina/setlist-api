class AddProjectToSetlist < ActiveRecord::Migration[6.0]
  def change
    add_reference :setlists, :project, null: false, foreign_key: true
  end
end
