class Article < ActiveRecord::Base

  belongs_to :user
  has_many :article_l10ns
  accepts_nested_attributes_for :article_l10ns
	#validates :title, presence: true, length: {minimum: 5}



  def published?
    published_at.present?
  end

  def owned_by?(owner)
    return false unless owner.is_a? User
    user == owner
  end

  def article_l10n(locale)
    self.article_l10ns.where(language_code: locale).first
  end

end
