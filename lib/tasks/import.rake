require 'csv'

namespace :import do
  desc "import csv file"
  task import_csv: :environment do

    fields_to_insert = %w{ chain name latitude longitude address city zip phone country_code }
    row_stripped={}

    CSV.foreach("#{Rails.root}/data_csv/shops_shopmium.csv", headers: true) do |row|
      row.each do |key, value|
        if fields_to_insert.include?(key.strip)
          if value.nil?
            row_stripped[key.strip] = nil
          else
            row_stripped[key.strip] = value.strip
          end
        end
      end
      Shop.create!(row_stripped.to_hash)
    end
  end

end
