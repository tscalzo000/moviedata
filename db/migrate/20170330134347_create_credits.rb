class CreateCredits < ActiveRecord::Migration[5.0]
  def change
    create_table :credits do |t|
      t.belongs_to :movie
      t.belongs_to :director
    end
  end
end
