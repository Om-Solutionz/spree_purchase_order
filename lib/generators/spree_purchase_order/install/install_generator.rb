module SpreePurchaseOrder
  module Generators
    class InstallGenerator < Rails::Generators::Base

      def add_javascripts
        append_file 'app/assets/javascripts/store/all.js', "//= require store/spree_purchase_order\n"
        append_file 'app/assets/javascripts/admin/all.js', "//= require admin/spree_purchase_order\n"
      end

      def add_stylesheets
        inject_into_file 'app/assets/stylesheets/store/all.css', " *= require store/spree_purchase_order\n", before: /\*\//, verbose: true
        inject_into_file 'app/assets/stylesheets/admin/all.css', " *= require admin/spree_purchase_order\n", before: /\*\//, verbose: true
      end

      def add_source_attributes
        append_file 'config/initializers/spree.rb', "Spree::PermittedAttributes.source_attributes.push :po_number, :organization_name"
      end

      def add_migrations
        run 'bundle exec rake railties:install:migrations FROM=spree_purchase_order'
      end

      def run_migrations
         res = ask 'Would you like to run the migrations now? [Y/n]'
         if res == '' || res.downcase == 'y'
           run 'bundle exec rake db:migrate'
         else
           puts "Skiping rake db:migrate, don't forget to run it!"
         end
      end
    end
  end
end
