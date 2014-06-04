class Article < ActiveRecord::Base
	has_many :comments, dependent: :destroy
	validates :title, presence: true, length: {minimum: 5}

#search 
def self.search(search)
	if search
		find(:all, :conditions => ['title LIKE ?', "%#{search}%"])
	else
		find(:all)
		end
		end
end
