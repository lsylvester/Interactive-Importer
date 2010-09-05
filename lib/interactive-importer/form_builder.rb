require 'action_view'

module InteractiveImporter
  module FormBuilder
    def column_select column, options={}
      @template.select_tag "#{object_name}[columns][]", @template.options_for_select([""] + @object.importable_columns.map{|s| [s.titleize, s]},column) 
    end
    
    def cell_text_field index, options={}
      @template.text_field_tag "#{object_name}[content][]", object.content[index], options
    end
  end
end

ActionView::Helpers::FormBuilder.send(:include, InteractiveImporter::FormBuilder)