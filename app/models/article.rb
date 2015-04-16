# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  text       :text
#  created_at :datetime
#  updated_at :datetime
#


class Article < ActiveRecord::Base

  include PgSearch
    pg_search_scope :search, against: [:title, :text],
      using: {tsearch: {dictionary: "english", prefix: true, any_word: true}}

    def self.text_search(query)
      if query.present?
        search(query)
        # rank = <<-RANK
        #   ts_rank(to_tsvector(name), plainto_tsquery(#{sanitize(query)}))
        # RANK
        # where("to_tsvector('english', name) @@ :q or to_tsvector('english', content) @@ :q", q: query)#.order("#{rank} desc")
      else
        Article.all
      end
    end
end