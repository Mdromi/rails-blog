class AddSlugToBlogPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :blog_posts, :slug, :string
  end
end
