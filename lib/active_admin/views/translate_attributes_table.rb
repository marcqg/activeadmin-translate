module ActiveAdmin
  module Translate

    # Adds a builder method `translate_attributes_table_for` to build a
    # table with translations for a model that has been localized with
    # Globalize.
    #
    class TranslateAttributesTable < ::ActiveAdmin::Views::AttributesTable

      builder_method :translate_attributes_table_for

      def row(attr, &block)
        ::I18n.available_locales.each_with_index do |locale, index|
          @table << tr do
            th do
              header_content_for(attr) - locale.to_s
            end
            @collection.each do |record|
              td do
                ::I18n.with_locale locale do
                  content_for(record, block || attr)
                end
              end
            end
          end
        end
      end

      protected

      def default_id_for_prefix
        'attributes_table'
      end

      def default_class_name
        'attributes_table'
      end

    end
  end
end
