module RailsAdminBuilderMenu
  class Engine < ::Rails::Engine

    initializer "RailsAdminBuilderMenu precompile hook", group: :all do |app|
      app.config.assets.precompile += %w(rails_admin/rails_admin_nestable.js rails_admin/jquery.nestable.js rails_admin/rails_admin_nestable.css)
    end

    initializer 'Include RailsAdminBuilderMenu::Helper' do |app|
      ActionView::Base.send :include, RailsAdminBuilderMenu::Helper
    end

  end
end