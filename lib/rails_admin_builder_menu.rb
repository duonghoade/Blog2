require 'rails_admin_builder_menu/engine'
require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'

module RailsAdminBuilderMenu
end

require 'rails_admin_builder_menu/configuration'
require 'rails_admin_builder_menu/builder_menu'
require 'rails_admin_builder_menu/model'
# require 'rails_admin_builder_menu/helper'

def bm_tree_nodes(tree_nodes = [])
  tree_nodes.map do |tree_node, sub_tree_nodes|
    li_classes = 'dd-item dd3-item'
    content_tag :li, class: li_classes, :'data-id' => tree_node.id do

      output = content_tag :div, 'drag', class: 'dd-handle dd3-handle'
      output += content_tag :div, class: 'dd3-content' do
        content = link_to @model_config.with(object: tree_node).object_label, edit_path(tree_node.class, tree_node.id)
        content += content_tag :div, bm_action_links(tree_node), class: 'pull-right links'
      end

      output += content_tag :ol, bm_tree_nodes(sub_tree_nodes), class: 'dd-list' if sub_tree_nodes && sub_tree_nodes.any?
      output
    end
  end.join.html_safe
end

def bm_action_links(model)
  content_tag :ul, class: 'inline actions' do
    # menu_for :member, @abstract_model, model, true
  end
end

def bm_tree_max_depth
  @bm_conf.options[:max_depth] || 'false'
end