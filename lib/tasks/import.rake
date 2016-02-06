require 'csv'

namespace :import do
  desc "import csv file"
  task :import_csv, [:file] => :environment do |task, args|

    fields_to_insert = %w{ chain name address longitude latitude city zip phone country_code }
    row_stripped={}

    CSV.foreach(args[:file], headers: true) do |row|
      row.each do |key, value|
        if fields_to_insert.include?(key.strip)
          if value.nil?
            row_stripped[key.strip] = nil
          else
            row_stripped[key.strip] = value.strip
          end
        end
      end

      shop = Shop.new(row_stripped.to_hash)
      if !(shop.save)
        puts "Error: #{shop.name} not saved : #{shop.errors.full_messages.join(' ')}"
      end
    end

  end
end
