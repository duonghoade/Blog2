module RailsAdminBuilderMenu
  class Configuration

    TREE_DEFAULT_OPTIONS = { enable_callback: false, scope: nil }
    LIST_DEFAULT_OPTIONS = { position_field: :position, max_depth: 1, enable_callback: false, scope: nil }

    def initialize(abstract_model)
      @abstract_model = abstract_model
    end

    def tree?
      tree.present?
    end

    def list?
      list.present? && !tree?
    end

    def options
      if tree?
        @builder_menu_options ||= self.tree_options
      elsif list?
        @builder_menu_options ||= self.list_options
      end

      @builder_menu_options || {}
    end

    protected
    def tree_options
      tree.class == Hash ? TREE_DEFAULT_OPTIONS.merge(tree) : TREE_DEFAULT_OPTIONS
    end

    def list_options
      LIST_DEFAULT_OPTIONS.merge(list.class == Hash ? list : {})
    end

    def tree
      @builder_menu_tree ||= ::RailsAdmin::Config.model(@abstract_model.model).builder_menu_tree
    end

    def list
      @builder_menu_list ||= ::RailsAdmin::Config.model(@abstract_model.model).builder_menu_list
    end

  end
end