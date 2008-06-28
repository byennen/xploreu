class Spec < ActiveRecord::Base
  belongs_to :user
  acts_as_ferret
  
  ALL_FIELDS = %w(first_name last_name occupation gender birthdate 
                  city state zip_code)
  STRING_FIELDS = %w(first_name last_name occupation city state)
  VALID_GENDERS = ["Male", "Female"]
  START_YEAR = 1900
  VALID_DATES = DateTime.new(START_YEAR)..DateTime.now
  ZIP_CODE_LENGTH = 5
    
  validates_length_of STRING_FIELDS, 
                      :maximum => DB_STRING_MAX_LENGTH
  
  validates_inclusion_of :gender, 
                         :in => VALID_GENDERS,
                         :allow_nil => true,
                         :message => "must be male or female"
  
  validates_inclusion_of :birthdate, 
                         :in => VALID_DATES,
                         :allow_nil => true,
                         :message => "is invalid"
  
  validates_format_of :zip_code, :with => /(^$|^[0-9]{#{ZIP_CODE_LENGTH}}$)/,
                      :message => "must be a five digit number"
  
  # Return the full name (first plus last)
  def full_name
    [first_name, last_name].join(" ")
  end
  
  # Return a sensibly formatted location string.
  def location
    if not zip_code.blank? and (city.blank? or state.blank?)
      lookup = GeoDatum.find_by_zip_code(zip_code)
      if lookup
        self.city  = lookup.city.capitalize_each if city.blank?
        self.state = lookup.state if state.blank?
      end
    end
    [city, state, zip_code].join(" ")
  end
  
  # Return the age using the birthdate.
  def age
    return if birthdate.nil?
    today = Date.today
    if (today.month > birthdate.month) or 
       (today.month == birthdate.month and today.day >= birthdate.day)
      # Birthday has happened already this year.
      today.year - birthdate.year
    else
      today.year - birthdate.year - 1
    end
  end
  
  # Find by age, sex, location.
  def self.find_by_asl(params)
    where = []
    # Set up the age restrictions as birthdate range limits in SQL.
    unless params[:min_age].blank?
      where << "ADDDATE(birthdate, INTERVAL :min_age YEAR) < CURDATE()"
    end
    unless params[:max_age].blank?
      where << "ADDDATE(birthdate, INTERVAL :max_age+1 YEAR) > CURDATE()"
    end  
    # Set up the gender restriction in SQL.
    where << "gender = :gender" unless params[:gender].blank?
    
    # Set up the distance restriction in SQL.
    zip_code = params[:zip_code]
    unless zip_code.blank? and params[:miles].blank?
      location = GeoDatum.find_by_zip_code(zip_code)
      distance = sql_distance_away(location)
      where << "#{distance} <= :miles"
    end
    
    if where.empty?
      []
    else
      find(:all,
           :joins => "LEFT JOIN geo_data ON geo_data.zip_code = specs.zip_code",
           :conditions => [where.join(" AND "), params],
           :order => "last_name, first_name")
    end 
  end
  
  private

  # Return SQL for the distance between a spec's location and the given point.
  # See http://en.wikipedia.org/wiki/Haversine_formula for more on the formula.
  def self.sql_distance_away(point)
    h = "POWER(SIN((RADIANS(latitude - #{point.latitude}))/2.0),2) + " +
        "COS(RADIANS(#{point.latitude})) * COS(RADIANS(latitude)) * " + 
        "POWER(SIN((RADIANS(longitude - #{point.longitude}))/2.0),2)" 
    r = 3956 # Earth's radius in miles
    "2 * #{r} * ASIN(SQRT(#{h}))"
  end
end