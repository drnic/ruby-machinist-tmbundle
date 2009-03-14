class CreateBlogAuthors < ActiveRecord::Migration
  def self.up
    create_table :blog_authors do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :blog_authors
  end
end
