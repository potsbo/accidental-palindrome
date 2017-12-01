class CreatePalindromes < ActiveRecord::Migration[5.1]
  def change
    create_table :palindromes do |t|
      t.string :body
      t.string :text
      t.integer :size

      t.timestamps
    end
  end
end
