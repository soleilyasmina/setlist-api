class CreateSetlists < ActiveRecord::Migration[6.0]
  def change
    create_table :setlists do |t|
      t.string :title
      t.string :location
      t.datetime :time

      t.timestamps
    end
  end
end
