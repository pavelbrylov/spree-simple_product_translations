# Do not forget to set accepts_nested_attributes_for :translations in the translated model.

module ActionView
  module Helpers
    class FormBuilder
      def globalize_fields_for(locale, *args, &proc)
        raise ArgumentError, "Missing block" unless block_given?
        @index = @index ? @index + 1 : 1
        object_name = "#{@object_name}[translations_attributes][#{@index}]"
        form_object = @object || @object_name.to_s.capitalize.constantize.new
        object = form_object.translations.select{|t| t.locale.to_s == locale}.first || form_object.translations.find_by_locale(locale.to_s)
        @template.concat @template.hidden_field_tag("#{object_name}[id]", object ? object.id : "")
        @template.concat @template.hidden_field_tag("#{object_name}[locale]", locale)
        @template.fields_for(object_name, object, *args, &proc)
      end
    end
  end
end
