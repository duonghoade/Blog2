class CreateArticleL10ns < ActiveRecord::Migration
  def change
    create_table :article_l10ns do |t|
      t.string :title
      t.text :content
      t.string :language_code
      t.string :display_name
      t.integer :article_id

      t.timestamps
    end
  end
end
