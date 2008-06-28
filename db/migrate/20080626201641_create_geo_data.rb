class CreateGeoData < ActiveRecord::Migration
  def self.up
    create_table :geo_data do |t|
      t.string :zip_code
      t.float :latitude
      t.float :longitude
      t.string :city, :state, :county, :type
    end
    add_index "geo_data", ["zip_code"], :name => "zip_code_optimization"

    csv_file = "#{RAILS_ROOT}/db/migrate/geo_data.csv"
    fields = '(zip_code, latitude, longitude, city, state, county)'

    execute "LOAD DATA INFILE '#{csv_file}' INTO TABLE geo_data FIELDS " +
            "TERMINATED BY ',' OPTIONALLY ENCLOSED BY \"\"\"\" " +
            "LINES TERMINATED BY '\n' " + fields
  end

  def self.down
    drop_table :geo_data
  end
end