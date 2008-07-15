class CommunityController < ApplicationController
  layout  'site'
  helper :profile
  
  def index  
    @title = "Community"
    @letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split("")
    if params[:id] 
      @initial = params[:id]
      # @pages, specs = paginate(:specs, 
      #                          :conditions => ["last_name LIKE ?", @initial+"%"], 
      #                          :order => "last_name, first_name")
      #@users = specs.collect { |spec| spec.user }
    end  
  end

  def browse
    @title = "Browse"
    return if params[:commit].nil?
    if valid_input?
      specs = Spec.find_by_asl(params)
      @pages, @users = paginate(specs.collect { |spec| spec.user })
    end
  end

  def search
    @title = "Search RailsSpace"
    if params[:q]
      query = params[:q]
      begin
        # First find the user hits...
        @users = User.find_by_contents(query, :limit => :all)
        # ...then the subhits.
        specs = Spec.find_by_contents(query, :limit => :all)
        faqs  =  Faq.find_by_contents(query, :limit => :all)
        # Now combine into one list of distinct users sorted by last name.
        hits = specs + faqs
        @users.concat(hits.collect { |hit| hit.user }).uniq!        
        # Sort by last name (requires a spec for each user).
        @users.each { |user| user.spec ||= Spec.new }      
        @users = @users.sort_by { |user| user.spec.last_name }
        
        @pages, @users = paginate(@users)
      rescue Ferret::QueryParser::QueryParseException
        @invalid = true
      end
    end
  end
  
  private

  # Return true if the browse form input is valid, false otherwise.
  def valid_input?
    @spec = Spec.new
    # Spec validation (with @spec.valid? below) will catch invalid zip codes.
    zip_code = params[:zip_code]
    @spec.zip_code = zip_code
    # There are a good number of zip codes for which we have no information.
    location = GeoDatum.find_by_zip_code(zip_code)
    if @spec.valid? and not zip_code.blank? and location.nil?
      @spec.errors.add(:zip_code, "does not exist in our database")
    end
    # The age strings should convert to valid integers.
    unless params[:min_age].valid_int? and params[:max_age].valid_int?
      @spec.errors.add("Age range")
    end
    # The zip code is necessary if miles are provided.
    miles = params[:miles]
    if miles and not zip_code
      @spec.errors.add(:zip_code, "can't be blank")
    end
    # The number of miles should convert to a valid float.
    unless miles.nil? or miles.valid_float?
      @spec.errors.add("Location radius")
    end
    # The input is valid iff the errors object is empty.
    @spec.errors.empty?
  end
end