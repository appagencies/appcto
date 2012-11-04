module CompaniesHelper

  BUDGETS = [{:id => 0, :string => "Below $5,000", :shortstring => "< $5K"},{:id => 1, :string => "$5,000 - $15,000", :shortstring => "$5K-$15K"}, {:id => 2, :string => "$15,000 - $50,000", :shortstring => "$15K-$50K"}, {:id => 3, :string => "Over $50,000", :shortstring => "> $50K"}]

  PLATFORMS = %w[ios android blackberry windows]

  SIZE = %w[normal large]

  def budget_to_string(int)
    BUDGETS[int][:string]
  end

  def budget_to_shortstring(int)
    BUDGETS[int][:shortstring]
  end

  def pf_active?(platform)
    return 'active' if @platform.include?(platform)
  end

end
