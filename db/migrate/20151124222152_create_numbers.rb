class CreateNumbers < ActiveRecord::Migration
  def change
    create_table :numbers do |t|
      t.integer :num
      t.string :word

      t.timestamps null: false
    end
  end
end
