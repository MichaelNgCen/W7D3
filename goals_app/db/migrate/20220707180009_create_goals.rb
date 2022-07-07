class CreateGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :goals do |t|
      t.string :title, null: false
      t.string :details, null: false
      t.boolean :private, null: false, default: false
      t.boolean :completed, null: false, default:false

      t.timestamps
    end
  end
end
