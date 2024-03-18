class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :sake
      t.string :specific
      t.integer :polishing
      t.integer :prefecture
      t.text :impression
      t.integer :score
      t.integer :recommend
      t.integer :attack
      t.integer :scent
      t.integer :taste
      t.integer :sweet
      t.integer :acidity
      t.integer :bitter
      t.integer :umami
      t.integer :complexity
      t.integer :after_flavor
      t.integer :lingering
      t.integer :label
      t.references :user, null: false, foreign_key: true
      t.integer :amount
      t.integer :price
      t.timestamps
    end
  end
end
