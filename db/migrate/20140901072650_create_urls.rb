class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :shorturl
      t.string :originalurl

      t.timestamps
    end
  end
end
