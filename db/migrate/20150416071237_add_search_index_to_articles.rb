class AddSearchIndexToArticles < ActiveRecord::Migration
  def up
    execute "create index articles_name on articles using gin(to_tsvector('english', title))"
    execute "create index articles_content on articles using gin(to_tsvector('english', text))"
  end

  def down
    execute "drop index articles_title"
    execute "drop index articles_text"
  end
end
