module NumbersHelper
  # controls navigation limit 
  # per page
  def page_set_limit
    50
  end

  # get total pages in
  # pagination
  def total_pages
    total_pages = Number.total / Number.per_page
    if (Number.total % Number.per_page) > 0
      total_pages += 1
    end
    total_pages
  end

  # calculate total page sets required
  # for navigation
  def total_page_sets
    (total_pages / page_set_limit) + (total_pages % page_set_limit)
  end

  # get the total paginations links for 
  # partially populated set
  def partially_populated_set
    total_pages % page_set_limit
  end

  # true if set doesn't have the full
  # page_set_limit instead has less
  def is_partially_populated?
    partially_populated_set > 0
  end

  # check that we are at the end
  # of sets
  def end_of_sets? iterator
    iterator == total_page_sets
  end

  # build the page sets that hold the 
  # navigation links
  def build_sets
    hold_sets = {}
    (1..total_page_sets).to_a.map do |set|
      if hold_sets.empty?
        hold_sets[set] = (1..page_set_limit).to_a
      elsif end_of_sets?(set) && is_partially_populated?
        prev_set_highest = hold_sets[set - 1].max
        start = prev_set_highest + 1
        ending = start + partially_populated_set
        hold_sets[total_page_sets] = (start..ending).to_a
      else
        prev_set_highest = hold_sets[set - 1].max
        start = prev_set_highest + 1
        ending = start + (page_set_limit - 1)
        hold_sets[set] = (start..ending).to_a
      end
    end
    hold_sets
  end

  # check if params :set is nil?
  def set_param_is_nil?
    params[:set] == nil 
  end

  # params :set gotten from url params
  def get_set_param
    params[:set].to_i
  end

  # is this the first set of pagination
  def is_first_set?
    get_set_param == 1
  end

  # build the link that takes you back to the
  # first set
  def build_first_set_link
    unless is_first_set? || set_param_is_nil?
      concat link_to('First Set', "?page=1&set=1") + " << "
    end
  end

  # build the link that takes you to the
  # last set
  def build_last_set_link
    unless get_set_param == build_sets.count
      concat link_to('Last Set', "?page=#{build_sets[total_page_sets].min}&set=#{total_page_sets}")
    end
  end

  # add pagination to view
  def paginate
    @sets = build_sets

    if set_param_is_nil?
      @set_counter = 1 
      @prev_set_counter = @sets.count
    else
      @set_counter = get_set_param
      @prev_set_counter = get_set_param
    end
    
    capture do
      build_first_set_link

      if is_first_set?
        @prev_set_counter = @sets.count
      else
        @prev_set_counter -= 1 if @prev_set_counter > 1
      end

      unless is_first_set? || set_param_is_nil?
        concat link_to('Prev Set', "?page=#{@prev_set_counter}&set=#{@prev_set_counter}") + " << "
      end

      @sets[@set_counter].each do |num|
        concat link_to(num, "?page=#{num}&set=#{@set_counter}") + " "
      end

      if get_set_param == @sets.count
        @set_counter = 1
      else
        @set_counter += 1 if @set_counter < @sets.count
      end

      unless get_set_param == @sets.count
        concat link_to('Next Set', "?page=#{@set_counter}&set=#{@set_counter}") + " >> "
      end

      build_last_set_link
    end
  end
end
