module RailsAdmin
  module Config
    module Actions
      class BuilderMenu < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)

        # register_instance_option :visible? do
        #   authorized? && %w{MenuBuilder::Menu}.include?(bindings[:abstract_model].model.to_s)
        # end

        register_instance_option :visible? do
          current_model = ::RailsAdmin::Config.model(bindings[:abstract_model])
          authorized? && (current_model.builder_menu_tree || current_model.builder_menu_list)
        end

        register_instance_option :collection? do
          false
        end

        register_instance_option :member? do
          true
        end

        # Render via pjax?
        register_instance_option :pjax? do
          false
        end

        register_instance_option :link_icon do
          'icon-th-list'
        end

        register_instance_option :http_methods do
          [:get, :post]
        end

        # Url fragment
        register_instance_option :route_fragment do
          'builder_menu'
        end

        register_instance_option :controller do
          Proc.new do
            @bm_conf = ::RailsAdminBuilderMenu::Configuration.new @abstract_model
            position_field = @bm_conf.options[:position_field]
            enable_callback = @bm_conf.options[:enable_callback]
            nestable_scope = @bm_conf.options[:scope]


            # Methods
            def update_tree(tree_nodes, position_field, enable_callback, parent_node = nil)
              tree_nodes.each do |key, value|
                model = object.children.find(value['id'])
                model.parent = parent_node.present? ? parent_node : nil

                model.send("#{position_field}=".to_sym, (key.to_i + 1)) if position_field.present?
                model.save!(validate: enable_callback)

                update_tree(value['children'], position_field, enable_callback, model) if value.has_key?('children')
              end
            end

            def update_list(model_list, position_field, enable_callback)
              model_list.each do |key, value|
                model = @abstract_model.model.find(value['id'])
                model.send("#{position_field}=".to_sym, (key.to_i + 1))
                model.save!(validate: enable_callback)
              end
            end

            if request.post? && params['tree_nodes'].present?
              begin
                update_tree(params[:tree_nodes], position_field, enable_callback, @object) if @bm_conf.tree?
                update_list(params[:tree_nodes], position_field, enable_callback) if @bm_conf.list?

                message = "<strong>#{I18n.t('admin.actions.nestable.success')}!</strong>"
              rescue Exception => e
                message = "<strong>#{I18n.t('admin.actions.nestable.error')}</strong>: #{e}"
              end

              render text: message
            end

            if request.get?
              query = @object.children#reorder(nil).merge(scope)

              @tree_nodes = if @bm_conf.tree?
                query.arrange(order: position_field)
              elsif @bm_conf.list?
                query.order_by(position_field => 1)
              end

              render action: @action.template_name
            end
          end
        end
      end
    end
  end
end