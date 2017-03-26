class AddTopicToPosts < ActiveRecord::Migration
  def change
    #We see that the name we gave migration, AddTopicToPosts, is very important
    #we instructed the generator to create a migration that adds a topic_id column to the posts table.
    add_column :posts, :topic_id, :integer
    #we created an index on topic_id with the generator. An index improves the speed of operations on the DB table
    add_index :posts, :topic_id
  end
end
