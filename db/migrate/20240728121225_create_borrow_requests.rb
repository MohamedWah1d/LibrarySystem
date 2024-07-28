class CreateBorrowRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :borrow_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.datetime :borrow_date
      t.datetime :return_date
      t.datetime :intended_return_date
      t.integer :status

      t.timestamps
    end
  end
end
